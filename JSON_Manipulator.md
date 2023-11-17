```ps1
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
```
**Title: PowerShell Script for Manipulating JSON Data**

**Explanation:**
This PowerShell script provides functions for reading, modifying, and writing JSON data. It consists of several functions:

1. **Read-JsonFile:**
   - Takes a file path as input and reads the content of a JSON file, converting it into a PowerShell object.

2. **Write-JsonFile:**
   - Accepts a file path and a JSON array, converting the array to JSON format and writing it back to the specified file.

3. **Add-JsonItem:**
   - Appends a new item to a JSON array.

4. **Edit-JsonItem:**
   - Edits an item in a JSON array based on a specified name or value. It uses ForEach-Object to iterate through the array and locate the item to be edited.

5. **Remove-JsonItem:**
   - Deletes an item from a JSON array based on a specified name or value. It utilizes the Where-Object cmdlet to filter out the item to be removed.

The main script section demonstrates the usage of these functions:

- Reads a JSON file specified by `$filePath`.
- Displays the current JSON array.
- Adds a new item to the JSON array.
- Edits an item in the JSON array based on the name "New Item" to "Edited Item" with an updated value.
- Removes an item from the JSON array based on the name "Some Value."
- Displays the updated JSON array.
- Writes the updated JSON array back to the original file.

The script provides a foundation for interactive manipulation of JSON data, showcasing common operations such as adding, editing, and removing items from a JSON array.
