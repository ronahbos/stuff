# Self-elevate the script if required
if (-Not ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] 'Administrator')) {
    if ([int](Get-CimInstance -Class Win32_OperatingSystem | Select-Object -ExpandProperty BuildNumber) -ge 6000) {
        $CommandLine = "-File `"" + $MyInvocation.MyCommand.Path + "`" " + $MyInvocation.UnboundArguments
        Start-Process -FilePath PowerShell.exe -Verb Runas -ArgumentList $CommandLine
        Exit
    }
}

$filename = "C:\Program Files\Plex\Plex\web-client\index.html"

(Get-Content $fileName) | 
Foreach-Object {
    $_ # send the current line to output
    if ($_ -match "link rel=`"stylesheet`" href=`"main") {
        #Add Lines after the selected pattern 
        "<link rel=`"stylesheet`" href=`"plex_dark_small_static_control_bar.css`">"
    }
} | Set-Content $fileName
