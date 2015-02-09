<powershell>
write-output "Running User Data Script"
write-host "(host) Running User Data Script"
 
cmd.exe /c net user /add vagrant FooBar@123
cmd.exe /c net localgroup administrators vagrant /add
 
Set-ExecutionPolicy -ExecutionPolicy bypass -Force
 
# RDP
#cmd.exe /c netsh advfirewall firewall add rule name="Open Port 3389" dir=in action=allow protocol=TCP localport=3389
#cmd.exe /c reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Terminal Server" /v fDenyTSConnections /t REG_DWORD /d 0 /f
 
# WinRM
write-output "Setting up WinRM"
write-host "(host) setting up WinRM"
# Set-Item WSMan:\localhost\Client\TrustedHosts -Value * -Force
# Restart-Service WinRM
# winrm quickconfig -q
#
# # Need to run this on client and server
# Enable-WSManCredSSP -role client -delegatecomputer * -force
# Enable-WSManCredSSP -role client -delegatecomputer *.seek.int  -force
# Enable-WSManCredSSP -role server -force
# Restart-Service WinRM
 
cmd.exe /c winrm quickconfig -q
cmd.exe /c winrm quickconfig '-transport:http'
cmd.exe /c winrm set "winrm/config" '@{MaxTimeoutms="1800000"}'
cmd.exe /c winrm set "winrm/config/winrs" '@{MaxMemoryPerShellMB="512"}'
cmd.exe /c winrm set "winrm/config/service" '@{AllowUnencrypted="true"}'
cmd.exe /c winrm set "winrm/config/client" '@{AllowUnencrypted="true"}'
cmd.exe /c winrm set "winrm/config/service/auth" '@{Basic="true"}'
cmd.exe /c winrm set "winrm/config/client/auth" '@{Basic="true"}'
cmd.exe /c winrm set "winrm/config/service/auth" '@{CredSSP="true"}'
cmd.exe /c winrm set "winrm/config/listener?Address=*+Transport=HTTP" '@{Port="80"}'
cmd.exe /c netsh advfirewall firewall set rule group="remote administration" new enable=yes
cmd.exe /c netsh firewall add portopening TCP 80 "Port 80"
cmd.exe /c net stop winrm
cmd.exe /c sc config winrm start= auto
cmd.exe /c net start winrm
cmd.exe /c wmic useraccount where "name='vagrant'" set PasswordExpires=FALSE
 
</powershell>