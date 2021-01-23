$ConnectionUri = "http://casserver/powershell/"
$UserCredential = Get-Credential
$sessionOption = New-PSSessionOption -SkipCACheck -SkipCNCheck -SkipRevocationCheck
$Session = New-PSSession -ConfigurationName Microsoft.Exchange -ConnectionUri $ConnectionUri -Credential $UserCredential -SessionOption $sessionOption
Import-PSSession $Session -DisableNameChecking