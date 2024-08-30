function Scan-Network {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory = $false, Position = 0)]
        [ValidatePattern('^\d{1,3}\.\d{1,3}\.\d{1,3}\.$')]
        [string]$Subnet = "192.168.1.",  # Default subnet to scan

        [Parameter(Mandatory = $false, Position = 1)]
        [ValidateRange(1, 254)]
        [int]$StartIP = 1,               # Start of IP range to scan

        [Parameter(Mandatory = $false, Position = 2)]
        [ValidateRange(1, 254)]
        [int]$EndIP = 254,               # End of IP range to scan

        [Parameter(Mandatory = $false, Position = 3)]
        [ValidateRange(1, 10000)]
        [int]$Timeout = 1000,            # Timeout in milliseconds for each ping

        [Parameter(Mandatory = $false, Position = 4)]
        [string]$OutputFile = $null      # Optional output file path
    )

    # Check if the StartIP is less than or equal to EndIP
    if ($StartIP -gt $EndIP) {
        Write-Error "Invalid IP range: StartIP ($StartIP) should be less than or equal to EndIP ($EndIP)."
        return
    }

    # Initialize results array
    $results = @()

    Write-Output "Scanning network from $Subnet$StartIP to $Subnet$EndIP with timeout of $Timeout ms..."

    # Scan the network
    foreach ($i in $StartIP..$EndIP) {
        $ip = "$Subnet$i"
        try {
            $pingResult = Test-Connection -ComputerName $ip -Count 1 -TimeoutMilliseconds $Timeout -Quiet -ErrorAction SilentlyContinue
            if ($pingResult) {
                $responseTime = (Test-Connection -ComputerName $ip -Count 1 -ErrorAction SilentlyContinue).ResponseTime
                Write-Output "Active device found at: $ip (Response time: $responseTime ms)"
                $results += [pscustomobject]@{
                    IP            = $ip
                    ResponseTime  = $responseTime
                    Status        = 'Active'
                }
            } else {
                $results += [pscustomobject]@{
                    IP            = $ip
                    ResponseTime  = $null
                    Status        = 'Inactive'
                }
            }
        } catch {
            Write-Warning "Error pinging $ip: $_"
        }
    }

    Write-Output "Network scan complete."

    # Export results if an output file path is provided
    if ($OutputFile) {
        try {
            $results | Export-Csv -Path $OutputFile -NoTypeInformation -Force
            Write-Output "Results successfully exported to $OutputFile"
        } catch {
            Write-Error "Error exporting results to $OutputFile: $_"
        }
    }
}