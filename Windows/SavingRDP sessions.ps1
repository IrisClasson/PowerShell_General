$target = "111.111.11.11"
$user = "adm"
$computerNameOrDomain = "DESKTOP-1"
# $pwd = "the password"
 
$logon = "$computerNameOrDomain\$user"
 
cmdkey /generic:$target /user:$logon #/pass:$pwd
 
cmdkey /list
 
mstsc /v:$target
 
[Environment]::SetEnvironmentVariable("rdp1", "mstsc /v:$target", "Machine")
#Restart after this
 
# Run RDP session:
iex (gc Env:rdp1)
