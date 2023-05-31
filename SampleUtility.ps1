# This script takes 2 parameters: a number and an operation.
# The operation can be "add", "subtract", "multiply", or "divide".
# The script will perform the specified operation on the number and print the result.
# The default value for the number is 10 and the default value for the operation is "add".

param (
[int]$Number = 10,
[string]$Operation = "add"
)

# Check if the operation is valid.
if ($Operation -notin "add", "subtract", "multiply", "divide") {
Write-Error "Invalid operation."
exit
}

# Perform the operation.
switch ($Operation) {
"add" { $Result = $Number + 1 }
"subtract" { $Result = $Number - 1 }
"multiply" { $Result = $Number * 1 }
"divide" { $Result = $Number / 1 }
}

# Print the result.
Write-Host "$Number $Operation 1 = $Result"

#
# The script will use the default values for the number and the operation.
#./script.ps1
# The script will print the following output:
# 10 add 1 = 11

# The script will use the specified values for the number and the operation.
#./script.ps1 20 subtract
# The script will print the following output:
# 20 subtract 1 = 19

#./script.ps1 -number 20 -operation subtract

