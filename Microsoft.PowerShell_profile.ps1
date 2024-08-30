# Set execution policy
Set-ExecutionPolicy RemoteSigned -Scope CurrentUser

# Get the directory of the current script
$scriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path

# Module scripts
. "$scriptDir\scripts\backgroundJobs.ps1"
. "$scriptDir\scripts\marioAnimation.ps1"
. "$scriptDir\scripts\configureConsole.ps1"
. "$scriptDir\scripts\randomQuotes.ps1"
. "$scriptDir\scripts\customPrompt.ps1"
. "$scriptDir\scripts\themeLoader.ps1"
. "$scriptDir\scripts\passwordGenerator.ps1"

# Configure Encoding
[Console]::OutputEncoding = [System.Text.Encoding]::UTF8

# Set Aliases
Set-Alias projects "C:\Projects\Coding Projects"

# PSReadLine Configuration
Import-Module PSReadLine
Set-PSReadLineOption -EditMode Windows
Set-PSReadLineOption -HistoryNoDuplicates
Set-PSReadLineOption -PredictionSource History

# Play opening Animation
Play-MarioAnimation

# Load configuration script
setUpConfiguration

# Assign the custom prompt function to the PowerShell prompt
$function:prompt = $function:customPrompt

# Load random programming quote
displayRandomQuote

# Start background jobs (can be started individually or all together with the Start-AllMonitors function)
Start-AllMonitors

# Initialize to-do list
Initialize-TodoList

# Initialize theme loader
Load-Theme

# Initialize PSReadline Module
Set-PSReadLineKeyHandler -Chord F2 -Function SwitchPredictionView
Set-PSReadLineOption -EditMode Vi

# Set GitHub completions helper
gh completion -s powershell | Out-String | Invoke-Expression

# Copy file contents to clipboard
function Copy-Content {
    param($Path)
    Get-Content $Path | Set-Clipboard
}

