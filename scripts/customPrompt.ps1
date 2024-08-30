function customPrompt {
    # Displays an emoji based on the time of day
    function Get-TimeOfDayEmoji {
        $curHour = (Get-Date).Hour
        
        switch ($curHour) {
            {$_ -ge 5 -and $_ -lt 12}  { return '🌅' } # Morning (5 AM - 11:59 AM)
            {$_ -ge 12 -and $_ -lt 17} { return '🌞' } # Afternoon (12 PM - 4:59 PM)
            {$_ -ge 17 -and $_ -lt 21} { return '🌇' } # Evening (5 PM - 8:59 PM)
            {$_ -ge 21 -or $_ -lt 5}   { return Get-MoonPhaseEmoji } # Night (9 PM - 4:59 AM)
            default { return '⚡' } # Default emoji if time is not recognized
        }
    }

    # Sets the nighttime emoji to the appropriate moon phase
    function Get-MoonPhaseEmoji {
        $year = (Get-Date).Year
        $month = (Get-Date).Month
        $day = (Get-Date).Day

        if ($month -le 2) {
            $year = $year - 1
            $month = $month + 12
        }

        $A = [math]::Floor($year / 100)
        $B = 2 - $A + [math]::Floor($A / 4)
        $JD = [math]::Floor(365.25 * ($year + 4716)) + [math]::Floor(30.6001 * ($month + 1)) + $day + $B - 1524.5
        $DaysSinceNew = $JD - 2451549.5
        $NewMoons = $DaysSinceNew / 29.53058867
        $Phase = ($NewMoons - [math]::Floor($NewMoons)) * 29.53058867

        switch ($Phase) {
            {$_ -lt 1.84566}  { return '🌑' } # New Moon
            {$_ -lt 5.53699}  { return '🌒' } # Waxing Crescent
            {$_ -lt 9.22831}  { return '🌓' } # First Quarter
            {$_ -lt 12.91963} { return '🌔' } # Waxing Gibbous
            {$_ -lt 16.61096} { return '🌕' } # Full Moon
            {$_ -lt 20.30228} { return '🌖' } # Waning Gibbous
            {$_ -lt 23.99361} { return '🌗' } # Last Quarter
            {$_ -lt 27.68493} { return '🌘' } # Waning Crescent
            default { return '🌑' } # New Moon as default
        }
    }

    # Get current background color
    $currentBackgroundColor = $Host.UI.RawUI.BackgroundColor

    # List of possible colors
    $colors = @("Black", "DarkBlue", "DarkGreen", "DarkCyan", "DarkRed", "DarkMagenta", "DarkYellow", "Gray", "Blue", "Green", "Cyan", "Red", "Magenta", "Yellow", "White")

    # Filter out colors that match the current background
    $availableColors = $colors | Where-Object { $_ -ne $currentBackgroundColor }

    # Select a random color from the filtered list
    $randomColor = Get-Random -InputObject $availableColors

    $timeEmoji = Get-TimeOfDayEmoji

    # Displays at 12AM to 5AM: go to bed
    $skullEmojis = if ((Get-Date).Hour -ge 0 -and (Get-Date).Hour -lt 5) { ' 💀💀💀' } else { '' }
    $promptString = " $timeEmoji$skullEmojis " + (Get-Date -Format 'HH:mm:ss') + ' - ' + (Get-Location).Path + ' :: '

    # Output the dividing line and the prompt string with the selected color
    Write-Host '━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ ⋆⋅☆⋅⋆ ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━' -ForegroundColor $randomColor
    Write-Host $promptString -NoNewline -ForegroundColor $randomColor

    return " "
}

# Set the prompt function
$function:prompt = $function:customPrompt
