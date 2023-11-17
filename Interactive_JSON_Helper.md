# Function to read JSON file
function Read-JsonFile {
    param (
        [string]$filePath
    )

    $content = Get-Content -Path $filePath -Raw
    return $content | ConvertFrom-Json
}

# Function to write JSON array to file
function Write-JsonFile {
    param (
        [string]$filePath,
        [object]$jsonArray
    )

    $jsonArray | ConvertTo-Json | Set-Content -Path $filePath
}

# Function to add an item to JSON array
function Add-JsonItem {
    param (
        [object]$jsonArray,
        [object]$item
    )

    $jsonArray += $item
    return $jsonArray
}

# Function to edit an item in JSON array based on name or value
function Edit-JsonItem {
    param (
        [object]$jsonArray,
        [string]$searchKey,
        [string]$searchValue,
        [object]$newItem
    )

    $jsonArray | ForEach-Object {
        if ($_.($searchKey) -eq $searchValue) {
            $_ = $newItem
        }
    }
    return $jsonArray
}

# Function to delete an item from JSON array based on name or value
function Remove-JsonItem {
    param (
        [object]$jsonArray,
        [string]$searchKey,
        [string]$searchValue
    )

    $jsonArray = $jsonArray | Where-Object { $_.($searchKey) -ne $searchValue }
    return $jsonArray
}

# Main script
$filePath = "your_file_path.json"  # Replace with your file path
$jsonArray = Read-JsonFile -filePath $filePath

# Display current JSON array
Write-Host "Current JSON Array:"
$jsonArray

# Interactive loop
$continue = $true

while ($continue) {
    $operation = Read-Host "Choose operation (add, edit, remove, exit):"

    switch ($operation) {
        "add" {
            $newItem = @{
                "Name"  = Read-Host "Enter Name for new item:"
                "Value" = Read-Host "Enter Value for new item:"
            }
            $jsonArray = Add-JsonItem -jsonArray $jsonArray -item $newItem
        }
        "edit" {
            $searchKey = Read-Host "Enter search key (e.g., Name):"
            $searchValue = Read-Host "Enter search value:"
            $editedItem = @{
                "Name"  = Read-Host "Enter new Name:"
                "Value" = Read-Host "Enter new Value:"
            }
            $jsonArray = Edit-JsonItem -jsonArray $jsonArray -searchKey $searchKey -searchValue $searchValue -newItem $editedItem
        }
        "remove" {
            $searchKey = Read-Host "Enter search key (e.g., Name):"
            $searchValue = Read-Host "Enter search value:"
            $jsonArray = Remove-JsonItem -jsonArray $jsonArray -searchKey $searchKey -searchValue $searchValue
        }
        "exit" {
            $continue = $false
        }
        default {
            Write-Host "Invalid operation. Please enter add, edit, remove, or exit."
        }
    }

    # Display updated JSON array
    Write-Host "Updated JSON Array:"
    $jsonArray
}

# Write the final JSON array back to the file
Write-JsonFile -filePath $filePath -jsonArray $jsonArray
