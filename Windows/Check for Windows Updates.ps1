$msUpdateSession = [activator]::CreateInstance([type]::GetTypeFromProgID("Microsoft.Update.Session",$env:COMPUTERNAME))
$updates = $msUpdateSession.CreateUpdateSearcher().Search("IsInstalled=0").Updates

$silverLightInstalled = Get-WindowsFeature | where { $_.Name.ToLower() -like 'silverlight' }

$pendingUpdates = [System.Collections.ArrayList]@()

$updates | % {

    if ($_.Title.ToLower().Contains("Silverlight" -and $silverLightInstalled)){
        $pendingUpdates.Add($_.Title)
    }
    else{
        $pendingUpdates.Add($_.Title)
    }
}

if($pendingUpdates -gt 0){
    Write-Host "***** $($pendingsUpdates.Count) updates not installed *****" -BackgroundColor Black -ForegroundColor Yellow

    $updates | % { Write-Host $_}
}
else{
    Write-Host "***** No pending updates *****" -BackgroundColor Black -ForegroundColor Green
}



# Installed updates by date (descending
# Doesn't show all updates?
# $msUpdateSession.CreateUpdateSearcher().Search("IsInstalled=1").Updates | Sort-Object -Property LastDeploymentChangeTime -Descending | % {Write-Host "$($_.Title) $($_.LastDeploymentChangeTime)"}