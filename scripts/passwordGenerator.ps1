# Initialize strong default password settings
$global:LastPasswordSettings = @{
    Length = 25
    IncludeLowercase = $true
    IncludeUppercase = $true
    IncludeNumbers = $true
    IncludeSpecialChars = $true
}

function Show-Help {
    @"
Usage: Generate-Password [options]

Options:
  -l <int>           Length of the password (default: 16)
  -lc                Include lowercase letters (default: true)
  -uc                Include uppercase letters (default: true)
  -num               Include numbers (default: true)
  -sc                Include special characters (default: false)
  -x <string>        Characters to exclude from the password
  -i <string>        Characters that must be included in the password
  -cb                Copy the generated password to the clipboard
  -h                 Display this help and exit

Examples:
  Generate-Password -l 20 -sc -cb
  Generate-Password -l 12 -x "l1Io0O" -i "ABC123"
"@
}

function Generate-Password {
    [CmdletBinding()]
    param(
        [Alias('l')]
        [int]$Length = $global:LastPasswordSettings.Length,

        [Alias('lc')]
        [switch]$IncludeLowercase = $global:LastPasswordSettings.IncludeLowercase,

        [Alias('uc')]
        [switch]$IncludeUppercase = $global:LastPasswordSettings.IncludeUppercase,

        [Alias('num')]
        [switch]$IncludeNumbers = $global:LastPasswordSettings.IncludeNumbers,

        [Alias('sc')]
        [switch]$IncludeSpecialChars = $global:LastPasswordSettings.IncludeSpecialChars,

        [Alias('x')]
        [string]$ExcludeChars = "",

        [Alias('i')]
        [string]$MustIncludeChars = "",

        [Alias('cb')]
        [switch]$CopyToClipboard = $false,

        [Alias('h')]
        [switch]$Help
    )

    if ($Help) {
        Show-Help
        return
    }

    # Save the current settings as last used
    $global:LastPasswordSettings = @{
        Length = $Length
        IncludeLowercase = $IncludeLowercase
        IncludeUppercase = $IncludeUppercase
        IncludeNumbers = $IncludeNumbers
        IncludeSpecialChars = $IncludeSpecialChars
    }

    # Character sets
    $lowercase = "abcdefghijklmnopqrstuvwxyz"
    $uppercase = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
    $numbers = "0123456789"
    $specialChars = "!@#$%^&*()-_=+[]{}|;:'`",.<>?/~"

    # Build character pool
    $chars = ""

    if ($IncludeLowercase) {
        $chars += $lowercase
    }
    if ($IncludeUppercase) {
        $chars += $uppercase
    }
    if ($IncludeNumbers) {
        $chars += $numbers
    }
    if ($IncludeSpecialChars) {
        $chars += $specialChars
    }

    # Remove 'exclude' characters
    if ($ExcludeChars) {
        foreach ($char in $ExcludeChars.ToCharArray()) {
            $chars = $chars -replace [RegEx]::Escape($char), ''
        }
    }

    if ([string]::IsNullOrEmpty($chars)) {
        Write-Host "Error: No characters available to generate password. Check your input parameters." -ForegroundColor Red
        return
    }

    $mustIncludeSet = $MustIncludeChars.ToCharArray() | Select-Object -Unique

	# Include 'must include' characters
    if ($mustIncludeSet.Count -gt $Length) {
        Write-Host "Error: The number of 'must include' characters is greater than the desired password length." -ForegroundColor Red
        return
    }

    $passwordArray = @()

    foreach ($char in $mustIncludeSet) {
        $passwordArray += $char
    }

    while ($passwordArray.Count -lt $Length) {
        $passwordArray += $chars[(Get-Random -Maximum $chars.Length)]
    }

    $password = -join ($passwordArray | Sort-Object {Get-Random})

    Write-Host "Generated password: $password" -ForegroundColor Yellow

    if ($CopyToClipboard) {
        try {
            Set-Clipboard -Value $password
            Write-Host "Password copied to clipboard." -ForegroundColor Green
        } catch {
            Write-Host "Error copying to clipboard: $_" -ForegroundColor Red
        }
    }

    return $password
}