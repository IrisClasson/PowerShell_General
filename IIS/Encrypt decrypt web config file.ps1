# Copy web config to temp location so we are working with a copy!

# Example
$path = "C:\Users\$env:USERNAME\Documents\tmp"

$iis =  "C:\Windows\Microsoft.NET\Framework64\v4.0.30319\aspnet_regiis.exe" 

# Decrypt
.$iis -pdf "appSettings" $path

# Encrypt
.$iis -prov "DataProtectionConfigurationProvider" -pef "appSettings" $path

# WARNING! Never copy it back to original location unencrypted!