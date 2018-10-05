$app1Id = "GUID"
$app2Id = "GUID"

$app1Key = "string"
$app2Key = "string"

# EXAMPLE: "X-Api-Key" = "key1:GUID1,key2:GUID2"
$headers = @{ "X-Api-Key" = "${app1Key}:$app1Id,${app2Key}:$app2Id"; "Content-Type" = "application/json" }

# EXAMPLE: "query" = "union app('GUID1').something, app('GUID2').something | limit 5"
$query = @{"query" = "let days=1d;union app('$app1Id').exceptions,app('$app2Id').exceptions | where timestamp > ago(days)"}
$body = ConvertTo-Json $query | % { [regex]::Unescape($_) }

$result = Invoke-RestMethod "https://api.applicationinsights.io/v1/apps/$app1Id/query" -H $headers -Body $body -Method POST