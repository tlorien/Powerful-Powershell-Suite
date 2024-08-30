# Console Setup and Configuration

function setUpConfiguration {
    # Console Setup and Configuration
    [Console]::OutputEncoding = [System.Text.Encoding]::UTF8
    Clear-Host

    # Font Set-up
    function Set-ConsoleFont {
        param(
            [string]$FontName = "Atkinson Monolegible" 
        )

        $regPath = "HKCU:\Console\%SystemRoot%_System32_WindowsPowerShell_v1.0_powershell.exe"

        if (-not (Test-Path $regPath)) {
            New-Item -Path $regPath -Force | Out-Null
        }

        try {
            Set-ItemProperty -Path $regPath -Name "FaceName" -Value $FontName
        } catch {
            Write-Host "Error changing font: $_" -ForegroundColor Red
        }
    }

    # Set Console Font
    Set-ConsoleFont -FontName "Atkinson Monolegible"

    # Set Foreground Color
    $host.UI.RawUI.ForegroundColor = "Green"

    # PSReadLine Configuration
    Import-Module PSReadLine
    Set-PSReadLineOption -EditMode Windows
    Set-PSReadLineOption -HistoryNoDuplicates
    Set-PSReadLineOption -PredictionSource History

    # Set Aliases
}

# Call the setup function
setUpConfiguration