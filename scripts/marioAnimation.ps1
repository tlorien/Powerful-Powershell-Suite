# Mario Animation

function Play-MarioAnimation {
    # Draw-Mario function definition
    function Draw-Mario {
        param (
            [array]$artArray,
            [string]$backgroundColor
        )
    
        $colorMap = @{
            "r" = "Red"
            "b" = "DarkCyan"
            "y" = "Yellow"
            "p" = "Gray"
            "w" = "White"
            "d" = "DarkRed"
            "k" = "Black"
            "x" = $backgroundColor
        }

        foreach ($row in $artArray) {
            foreach ($pixel in $row) {
                $color = $colorMap[$pixel]
                Write-Host -NoNewline "██" -ForegroundColor $color
            }
            Write-Host ""
        }
    }

    $backgroundColor = $Host.UI.RawUI.BackgroundColor.ToString()
    $frame1 = @(
		@("x"),
        @("x", "x", "x", "x", "x", "x", "r", "r", "r", "r", "r"),
        @("x", "x", "x", "x", "x", "x", "r", "r", "r", "r", "r", "r", "r", "r", "r"),
        @("x", "x", "x", "x", "x", "x", "d", "d", "d", "p", "p", "k", "p"),
        @("x", "x", "x", "x", "x", "d", "p", "d", "p", "p", "p", "k", "p", "p", "p"),
        @("x", "x", "x", "x", "x", "d", "p", "d", "d", "p", "p", "p", "d", "p", "p", "p"),
        @("x", "x", "x", "x", "x", "d", "d", "p", "p", "p", "p", "d", "d", "d", "d"),
        @("x", "x", "x", "x", "x", "x", "x", "p", "p", "p", "p", "p", "p", "p"),
        @("x", "x", "x", "x", "x", "x", "r", "r", "b", "r", "r", "r", "r"),
        @("x", "x", "x", "x", "x", "r", "r", "r", "b", "r", "r", "b", "r", "r", "r"),
        @("x", "x", "x", "x", "r", "r", "r", "r", "b", "b", "b", "b", "r", "r", "r", "r"),
        @("x", "x", "x", "x", "p", "p", "r", "b", "y", "b", "b", "y", "b", "r", "p", "p"),
        @("x", "x", "x", "x", "p", "p", "p", "b", "b", "b", "b", "b", "b", "p", "p", "p"),
        @("x", "x", "x", "x", "p", "p", "b", "b", "b", "b", "b", "b", "b", "b", "p", "p"),
        @("x", "x", "x", "x", "x", "x", "b", "b", "b", "x", "x", "b", "b", "b"),
        @("x", "x", "x", "x", "x", "d", "d", "d", "x", "x", "x", "x", "d", "d", "d"),
		@("x", "x", "x", "x", "d", "d", "d", "d", "x", "x", "x", "x", "d", "d", "d", "d")
    )
	
    $frame2 = @(
		@("x"),
        @("x", "x", "x", "x", "x", "x", "r", "r", "r", "r", "r"),
        @("x", "x", "x", "x", "x", "x", "r", "r", "r", "r", "r", "r", "r", "r", "r"),
        @("x", "x", "x", "x", "x", "x", "d", "d", "d", "p", "p", "k", "p"),
        @("x", "x", "x", "x", "x", "d", "p", "d", "p", "p", "p", "k", "p", "p", "p"),
        @("x", "x", "x", "x", "x", "d", "p", "d", "d", "p", "p", "p", "d", "p", "p", "p"),
        @("x", "x", "x", "x", "x", "d", "d", "p", "p", "p", "p", "d", "d", "d", "d"),
        @("x", "x", "x", "x", "x", "x", "x", "p", "p", "p", "p", "p", "p", "p"),
		
        @("x", "x", "x", "x", "x", "x", "r", "r", "r", "b", "r", "r"),
        @("x", "x", "x", "x", "x","r", "r", "r", "r", "b", "b", "r", "r"),
        @("x", "x", "x", "x", "x","r", "r", "r", "b", "b", "y", "b", "b"),
        @("x", "x", "x", "x", "x","r", "r", "r", "r", "b", "b", "b", "b"),
        @("x", "x", "x", "x", "x","b", "r", "r", "p", "p", "b", "b", "b"),
        @("x", "x", "x", "x", "x","x", "b", "r", "p", "p", "b", "b"),
        @("x", "x", "x", "x", "x","x", "x", "b", "b", "b", "d", "d", "d"),
		@("x", "x", "x", "x", "x", "x", "d", "d", "d", "d")
    )
    $frame3 = @(
        @("x", "x", "x", "x", "x", "x", "r", "r", "r", "r", "r"),
        @("x", "x", "x", "x", "x", "x", "r", "r", "r", "r", "r", "r", "r", "r", "r"),
        @("x", "x", "x", "x", "x", "x", "d", "d", "d", "p", "p", "k", "p"),
        @("x", "x", "x", "x", "x", "d", "p", "d", "p", "p", "p", "k", "p", "p", "p"),
        @("x", "x", "x", "x", "x", "d", "p", "d", "d", "p", "p", "p", "d", "p", "p", "p"),
        @("x", "x", "x", "x", "x", "d", "d", "p", "p", "p", "p", "d", "d", "d", "d"),
        @("x", "x", "x", "x", "x", "x", "x", "p", "p", "p", "p", "p", "p", "p"),
		
        @("x", "x", "x", "x", "x", "x", "r", "r", "b", "b", "r"),
        @("x", "x", "x", "x", "x", "r", "r", "r", "r", "b", "r", "p", "p"),
        @("x", "x", "x", "p", "p", "r", "r", "r", "r", "r", "r", "p", "p", "p"),
        @("x", "x", "p", "p", "p", "b", "r", "r", "r", "r", "r", "p", "p"),
        @("x", "x", "x", "d", "d", "b", "b", "b", "b", "b", "b", "b"),
        @("x", "x", "x", "d", "b", "b", "b", "b", "b", "b", "b", "b"),
        @("x", "x", "d", "d", "b", "b", "x", "x", "b", "b", "b"),
		@("x", "x", "d", "x", "x", "x", "x", "d", "d", "d"),
		@("x", "x", "x", "x", "x", "x", "x", "x", "d", "d", "d")
    )
    $frame4 = @(
        @("x", "x", "x", "x", "x", "x", "r", "r", "r", "r", "r"),
        @("x", "x", "x", "x", "x", "x", "r", "r", "r", "r", "r", "r", "r", "r", "r"),
        @("x", "x", "x", "x", "x", "x", "d", "d", "d", "p", "p", "k", "p"),
        @("x", "x", "x", "x", "x", "d", "p", "d", "p", "p", "p", "k", "p", "p", "p"),
        @("x", "x", "x", "x", "x", "d", "p", "d", "d", "p", "p", "p", "d", "p", "p", "p"),
        @("x", "x", "x", "x", "x", "d", "d", "p", "p", "p", "p", "d", "d", "d", "d"),
        @("x", "x", "x", "x", "x", "x", "x", "p", "p", "p", "p", "p", "p", "p"),
		
        @("x", "x", "r", "r", "r", "r", "b", "r", "r", "r", "b"),
        @("p", "p", "r", "r", "r", "r", "b", "b", "r", "r", "r", "b", "r", "p", "p", "p"),
        @("p", "p", "p", "x", "r", "r", "b", "b", "b", "b", "b", "b", "r", "r", "p", "p"),
        @("p", "p", "x", "x", "b", "b", "b", "y", "b", "b", "b", "y", "x", "x", "d"),
        @("x", "x", "x", "b", "b", "b", "b", "b", "b", "b", "b", "b", "b", "d", "d"),
        @("x", "x", "b", "b", "b", "b", "b", "b", "b", "b", "b", "b", "b", "d", "d"),
        @("x", "d", "d", "b", "b", "b", "x", "x", "x", "x", "b", "b", "b", "d", "d"),
		@("x", "d", "d", "d"),
		@("x", "x", "d", "d", "d")
    )

    $frames = @($frame2, $frame3, $frame2, $frame4)
    $frameDelay = 0.15
    $repeatCount = 3

    Clear-Host
    Draw-Mario -artArray $frame1 -backgroundColor $backgroundColor
    Start-Sleep -Seconds $frameDelay

    for ($i = 0; $i -lt $repeatCount; $i++) {
        $frames | ForEach-Object {
            Clear-Host
            Draw-Mario -artArray $_ -backgroundColor $backgroundColor
            Start-Sleep -Seconds $frameDelay
        }
    }

}