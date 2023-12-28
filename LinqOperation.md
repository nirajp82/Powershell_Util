# https://www.red-gate.com/simple-talk/development/dotnet-development/high-performance-powershell-linq/

```ps
$data = 0..10

# Load System.Core assembly for LINQ support
#Add-Type -AssemblyName System.Core

# Use LINQ to filter the data
$filteredData = [System.Linq.Enumerable]::Where($data, [Func[object,bool]]{ param($x) $x -gt 5 })

# Display the filtered result
$filteredData | ForEach-Object {
    Write-Host $_
}

#Because your $data is [object[]], not [int[]], given that PowerShell creates [object[]] arrays by default; you can, however, construct [int[]] instances explicitly:
$intdata = [int[]]$data
$filteredData = [System.Linq.Enumerable]::Where($intdata, [Func[int,bool]]{ param($x) $x -lt 5 })

# Display the filtered result
$filteredData | ForEach-Object {
    Write-Host $_
}
```

##########
```ps
class Person
{
    [string] $SSN;
    [string] $FirstName;
    [string] $Surname;
 
    Person([string]$SSN, [string]$firstname, [string]$surname)
    {
        $this.Surname = $surname
        $this.FirstName = $firstname
        $this.SSN = $ssn
    }
}
 
[Person[]]$peopleList = @(
    [Person]::new("1001", "Bob", "Smith"),
    [Person]::new("2002", "Jane", "Doe"),
    [Person]::new("3003", "Fester", "Adams")
)

$keyDelegate = [Func[Person,string]] { 
  $ssn = $args[0].SSN 
  $ssn #.StartsWith("10") 
}
$dict = [Linq.Enumerable]::ToDictionary($peopleList, $keyDelegate)
$keys = $dict.Keys
foreach ($k in $keys) {	
	$k 
#	$dict[$k]
}
```ps
