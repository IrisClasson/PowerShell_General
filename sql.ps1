$dataSource = ".\SQLEXPRESS"
$user = "user"
$pwd = "1234"
$database = "Test"
$connectionString = "Server=$dataSource;uid=$user; pwd=$pwd;Database=$database;Integrated Security=False;"

$query = "SELECT * FROM Person"


$connection = New-Object System.Data.SqlClient.SqlConnection
$connection.ConnectionString = $connectionString
#$connection.ConnectionString = "Server=$dataSource;Database=$database;Integrated Security=True;"
$connection.Open()
$command = $connection.CreateCommand()
$command.CommandText  = $query

$result = $command.ExecuteReader()

$table = new-object “System.Data.DataTable”
$table.Load($result)

$format = @{Expression={$_.Id};Label="User Id";width=10},@{Expression={$_.Name};Label="Identified Swede"; width=30}

$table | Where-Object {$_.Surname -like "*sson" -and $_.Born -lt 1990} | format-table $format

$table | Where-Object {$_.Surname -like "*sson" -and $_.Born -lt 1990} | format-table $format | Out-File C:\Users\Iris\Documents\swedes.txt

$connection.Close()
