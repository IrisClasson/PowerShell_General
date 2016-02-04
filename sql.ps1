Function Connect-SQLServer
{
[cmdletbinding()]
Param(
    $dataSource = ".\SQLEXPRESS",
    $database = "Test",
    [Parameter(ParameterSetName="UserAutentication")]$user = "user",
    [Parameter(ParameterSetName="UserAutentication")]$pwd = "1234",
    [Parameter(ParameterSetName="IntegratedSecurtity")][switch]$IntegratedSecurtity
    )

    If($IntegratedSecurtity)
    {
        $connectionString = "Server=$dataSource;Database=$database;Integrated Security=True;"
    }
    Else
    {
        $connectionString = "Server=$dataSource;uid=$user; pwd=$pwd;Database=$database;Integrated Security=False;"
    }

    $connection = New-Object System.Data.SqlClient.SqlConnection
    $connection.ConnectionString = $connectionString
    $connection.Open()
    Write-Output $connection
}
<#
.EXAMPLE $SqlSession = Connect-SQLServer
    Uses all the default values to replicate the original script.

    Stores the SQL session in the $SqlSession variable for use later.

.EXAMPLE $SqlSession = Connect-SQLServer -dataSource "localhost" -database "SlickTicket" -IntegratedSecurtity
    Connects to the SlickTicket DB on Localhost using Integrated Security

    Stores the SQL session in the $SqlSession variable for use later.
#>


function Get-SQLTableQuery
{
[cmdletbinding()]
Param(
    $SQLSession,
    $Query = "SELECT * FROM Person"
    )

    $command = $SQLSession.CreateCommand()
    $command.CommandText  = $Query

    $result = $command.ExecuteReader()

    $table = new-object “System.Data.DataTable”
    $table.Load($result)

    Write-Output $table
    
}
<#

.EXAMPLE 

    $results = Get-SQLTableQuery -SQLSession $SqlSession
    $format = @{Expression={$_.Id};Label="User Id";width=10},@{Expression={$_.Name};Label="Identified Swede"; width=30}
    $results | Where-Object {$_.Surname -like "*sson" -and $_.Born -lt 1990} | format-table $format
    $results | Where-Object {$_.Surname -like "*sson" -and $_.Born -lt 1990} | format-table $format | Out-File C:\Users\Iris\Documents\swedes.txt

    Uses all the default values to replicate the original script.

        1) Collects the output of the SQL query in to the $results variable
        2) Sets the formatting parameters for the host stream
        3) Returns the formatted table (a collection of string, not an object) to the host stream
        4) Pipes the fortmatted table (a collection of string, not an object) to C:\Users\Iris\Documents\swedes.txt


.EXAMPLE 

    $results = Get-SQLTableQuery -SQLSession $SqlSession -Query "Select * from faq"
    $results | Export-CSV -Path "Exported-FAQ-Table.csv" -NoTypeInformation


        1) Collects the output of the "Select * from faq" SQL query in to the $results variable
        2) Exports the SQL Table object as a CSV to the "Exported-FAQ-Table.csv" file in the current working directory

#>


Function Disconnect-SQLServer
{
[cmdletbinding()]
Param(
    $SQLSession
    )

    $SQLSession.Close()
}
<# 
.EXAMPLE Disconnect-SQLServer -SQLSession $SqlSession
    
    Cleanly closes the SQL connection
#>