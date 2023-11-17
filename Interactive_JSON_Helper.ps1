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

# Add an item to the JSON array
$newItem = @{
    "Name"  = "New Item";
    "Value" = "Some Value";
}
$jsonArray = Add-JsonItem -jsonArray $jsonArray -item $newItem

# Edit an item in the JSON array based on name or value
$editedItem = @{
    "Name"  = "Edited Item";
    "Value" = "Updated Value";
}
$jsonArray = Edit-JsonItem -jsonArray $jsonArray -searchKey "Name" -searchValue "New Item" -newItem $editedItem

# Remove an item from the JSON array based on name or value
$jsonArray = Remove-JsonItem -jsonArray $jsonArray -searchKey "Name" -searchValue "Some Value"

# Display updated JSON array
Write-Host "Updated JSON Array:"
$jsonArray

# Write the updated JSON array back to the file
Write-JsonFile -filePath $filePath -jsonArray $jsonArray
