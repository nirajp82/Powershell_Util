$server = ""
$userId = ""
$password = ""
$database = ""
$tablequery = "SELECT schemas.name as schemaName, tables.name as tableName from sys.tables inner join sys.schemas ON tables.schema_id = schemas.schema_id ORDER BY tables.name"

#Delcare Connection Variables
$connectionTemplate = "Data Source={0};User ID={1};Password={2};Initial Catalog={3};"
$connectionString = [string]::Format($connectionTemplate, $server, $userId, $password, $database)
$connection = New-Object System.Data.SqlClient.SqlConnection
$connection.ConnectionString = $connectionString

$command = New-Object System.Data.SqlClient.SqlCommand
$command.CommandText = $tablequery
$command.Connection = $connection

#Load up the Tables in a dataset
$SqlAdapter = New-Object System.Data.SqlClient.SqlDataAdapter
$SqlAdapter.SelectCommand = $command
$DataSet = New-Object System.Data.DataSet
$SqlAdapter.Fill($DataSet)
$connection.Close()

# Loop through all tables and export a CSV of the Table Data
foreach ($Row in $DataSet.Tables[0].Rows)
{
    $queryData = "SELECT * FROM [$($Row[0])].[$($Row[1])]"
	
	echo "Exporting [$($Row[0])].[$($Row[1])]"

    #Specify the output location of your dump file
    $extractFile = "C:\mssql\export\$($Row[0])_$($Row[1]).csv"
   
    $command.CommandText = $queryData
    $command.Connection = $connection
   
    $SqlAdapter = New-Object System.Data.SqlClient.SqlDataAdapter
    $SqlAdapter.SelectCommand = $command
    $DataSet = New-Object System.Data.DataSet
    $SqlAdapter.Fill($DataSet)
    $connection.Close()
   
    $DataSet.Tables[0]  | Export-Csv $extractFile -NoTypeInformation
   
   echo "Exported [$($Row[0])].[$($Row[1])]"
}
