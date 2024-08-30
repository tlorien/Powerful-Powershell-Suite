class MonitorJob {
    [string] $Name
    [scriptblock] $Task
    [int] $Interval

    MonitorJob([string] $name, [scriptblock] $task, [int] $interval) {
        $this.Name = $name
        $this.Task = $task
        $this.Interval = $interval
    }

    [PSCustomObject] Start() {
        $jobInfo = [PSCustomObject]@{ JobName = $this.Name; Status = ""; JobId = $null; Interval = $this.Interval; StartTime = $(Get-Date -Format "yyyy-MM-dd HH:mm:ss") }
        
        if (-not (Get-Job -Name $this.Name -ErrorAction SilentlyContinue)) {
            if ($null -eq $this.Task) {
                $jobInfo.Status = "Error: ScriptBlock is null."
            } else {
                $job = Start-Job -Name $this.Name -ScriptBlock $this.Task
                $jobInfo.Status = "Started"
                $jobInfo.JobId = $job.Id
            }
        } else {
            $existingJob = Get-Job -Name $this.Name
            $jobInfo.Status = "Already running"
            $jobInfo.JobId = $existingJob.Id
        }
        
        return $jobInfo
    }
}

	$cpuMonitorTask = {
		while ($true) {
			Start-Sleep -Seconds 300
			try {
				$cpuUsage = Get-WmiObject Win32_Processor | Measure-Object -Property LoadPercentage -Average | Select-Object -ExpandProperty Average
				if ($cpuUsage -gt 80) {
					Write-Host "Alert: CPU usage is above 80%! Current usage: $cpuUsage%" -ForegroundColor Red
				}
			} catch {
				Write-Host "Error retrieving CPU usage: $_" -ForegroundColor Red
			}
		}
	}
	$cpuMonitor = [MonitorJob]::new("Monitor_CPU", $cpuMonitorTask, 300)

$diskSpaceTask = {
    while ($true) {
        Start-Sleep -Seconds 3600
        try {
            $diskSpace = Get-PSDrive -PSProvider FileSystem | Where-Object { $_.Free -lt 20GB }
            foreach ($disk in $diskSpace) {
                Write-Host "Alert: Low disk space on drive $($disk.Name)! Free space: $([math]::round($disk.Free/1GB,2)) GB" -ForegroundColor Red
            }
        } catch {
            Write-Host "Error checking disk space: $_" -ForegroundColor Red
        }
    }
}
$diskMonitor = [MonitorJob]::new("Monitor_DiskSpace", $diskSpaceTask, 3600)

$memoryTask = {
    while ($true) {
        Start-Sleep -Seconds 300
        try {
            $memUsage = Get-WmiObject Win32_OperatingSystem | Select-Object -ExpandProperty FreePhysicalMemory
            $totalMem = Get-WmiObject Win32_ComputerSystem | Select-Object -ExpandProperty TotalPhysicalMemory
            $percentUsed = [math]::Round((1 - $memUsage / $totalMem) * 100, 2)
            if ($percentUsed -gt 80) {
                Write-Host "Alert: Memory usage is above 80%! Current usage: $percentUsed%" -ForegroundColor Red
            }
        } catch {
            Write-Host "Error retrieving memory status: $_" -ForegroundColor Red
        }
    }
}
$memoryMonitor = [MonitorJob]::new("Monitor_Memory", $memoryTask, 300)

    $processWatchTask = {
        $watchList = @("sqlserver", "nginx", "apache")
        while ($true) {
            Start-Sleep -Seconds 300
            try {
                $currentProcesses = Get-Process | Select-Object -ExpandProperty Name
                foreach ($process in $watchList) {
                    if ($process -notin $currentProcesses) {
                        Write-Host "Alert: Critical process missing: $process" -ForegroundColor Red
                    }
                }
            } catch {
                Write-Host "Error checking process status: $_" -ForegroundColor Red
            }
        }
    }
    $processWatchMonitor = [MonitorJob]::new("Monitor_ProcessWatch", $processWatchTask, 300)

    $systemHealthTask = {
        while ($true) {
            Start-Sleep -Seconds 600
            try {
                $criticalServices = @("wuauserv", "bits")
                foreach ($service in $criticalServices) {
                    $status = Get-Service -Name $service | Select-Object -ExpandProperty Status
                    if ($status -ne 'Running') {
                        Write-Host "Alert: Critical service $service is not running." -ForegroundColor Red
                    }
                }
            } catch {
                Write-Host "Error checking system health: $_" -ForegroundColor Red
            }
        }
    }
    $systemHealthMonitor = [MonitorJob]::new("Monitor_SystemHealth", $systemHealthTask, 600)

$temperatureTask = {
    while ($true) {
        Start-Sleep -Seconds 300
        try {
            $cpuTemp = Get-CimInstance MSAcpi_ThermalZoneTemperature -Namespace "root/wmi" | Select-Object CurrentTemperature
            $gpuTemp = Get-WmiObject -Namespace "root\CIMV2" -Class Win32_VideoController | Select-Object CurrentTemperature

            $cpuTempCelsius = ($cpuTemp.CurrentTemperature - 2732) / 10
            $gpuTempCelsius = ($gpuTemp.CurrentTemperature - 2732) / 10

            if ($cpuTempCelsius -gt 80) {
                Write-Host "Alert: CPU temperature is above 80°C! Current: $cpuTempCelsius°C" -ForegroundColor Red
            }

            if ($gpuTempCelsius -gt 80) {
                Write-Host "Alert: GPU temperature is above 80°C! Current: $gpuTempCelsius°C" -ForegroundColor Red
            }
        } catch {
            Write-Host "Error retrieving temperature data: $_" -ForegroundColor Red
        }
    }
}
$temperatureMonitor = [MonitorJob]::new("Monitor_Temperature", $temperatureTask, 300)

# Function to update the user prompt with battery emojis
function Update-PromptWithBatteryEmoji {
    $function:prompt = {
        $batteryEmoji = Get-Variable -Name "BatteryEmoji" -ValueOnly -Scope Global -ErrorAction SilentlyContinue -or '🔋'
        "$batteryEmoji $(Get-Date -Format 'HH:mm:ss') - $(Get-Location) :: "
    }
}

# Defines battery status emojis
function determineBatteryStatusText($batteryLevel, $chargingStatus) {
    if ($chargingStatus -eq 2) { $chargingEmoji = '🔌⚡' } else { $chargingEmoji = '' }
    switch ($batteryLevel) {
        {$_ -ge 90} { return "$chargingEmoji🔋" }
        {$_ -ge 75} { return "$chargingEmoji🟢" }
        {$_ -ge 50} { return "$chargingEmoji🟡" }
        {$_ -ge 25} { return "$chargingEmoji🟠" }
        {$_ -ge 20} { return "$chargingEmoji🔴" }
        default     { return "$chargingEmoji⚠️" }
    }
}

# Defines battery warnings
function issueBatteryWarnings($batteryLevel) {
    $currentTime = Get-Date
    if ($global:lastNotificationTime -eq $null) {
        $global:lastNotificationTime = $currentTime
    }
    if ($batteryLevel -le 5 -and ($currentTime - $global:lastNotificationTime).TotalMinutes -ge 1) {
        Write-Host "CRITICAL BATTERY LEVEL! BATTERY BELOW 5%! PLUG IN CHARGER!" -ForegroundColor Red
        $global:lastNotificationTime = $currentTime
    } elseif ($batteryLevel -le 20 -and ($currentTime - $global:lastNotificationTime).TotalMinutes -ge 5) {
        Write-Host "LOW BATTERY WARNING! BATTERY BELOW 20%! PLUG IN SOON!" -ForegroundColor Red
        $global:lastNotificationTime = $currentTime
    }
}

$cpuMonitor = [MonitorJob]::new("Monitor_CPU", $cpuMonitorTask, 300)
$diskMonitor = [MonitorJob]::new("Monitor_DiskSpace", $diskSpaceTask, 3600)
$memoryMonitor = [MonitorJob]::new("Monitor_Memory", $memoryTask, 300)
$processWatchMonitor = [MonitorJob]::new("Monitor_ProcessWatch", $processWatchTask, 300)
$systemHealthMonitor = [MonitorJob]::new("Monitor_SystemHealth", $systemHealthTask, 600)
$temperatureMonitor = [MonitorJob]::new("Monitor_Temperature", $temperatureTask, 300)

# Start all monitors
function Start-AllMonitors {
	$monitorResults = @()
    $global:monitors = @(
        $cpuMonitor,
        $memoryMonitor,
        $diskMonitor,
        $processWatchMonitor,
        $systemHealthMonitor,
        $temperatureMonitor
    )

    # Check if PC has a battery
    $battery = Get-CimInstance -ClassName Win32_Battery -ErrorAction SilentlyContinue
    if ($battery) {
        $batteryStatusTask = {
            Write-Host "Battery detected. Starting Battery Status Monitor." -ForegroundColor Green
            while ($true) {
                Start-Sleep -Seconds 600
                try {
                    $batteryStatus = Get-CimInstance -ClassName Win32_Battery
                    $batteryLevel = $batteryStatus.EstimatedChargeRemaining
                    $batteryStatusText = determineBatteryStatusText($batteryLevel, $batteryStatus.BatteryStatus)
                    Set-Variable -Name BatteryEmoji -Value $batteryStatusText -Scope Global
                    issueBatteryWarnings($batteryLevel)
                } catch {
                    Write-Host "Error retrieving battery status: $_" -ForegroundColor Red
                }
            }
        }
        $batteryStatusMonitor = [MonitorJob]::new("Monitor_Battery", $batteryStatusTask, 600)
        $global:monitors += $batteryStatusMonitor
        Update-PromptWithBatteryEmoji
    } else {
        Write-Host "No battery detected. Battery monitor will not run." -ForegroundColor Yellow
    }
	
    foreach ($monitor in $global:monitors) {
    $monitorResults += $monitor.Start()
        }

    $monitorResults | Format-Table -AutoSize | Out-String | Write-Host
}