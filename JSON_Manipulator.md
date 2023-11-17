```ps1
# Function to read JSON file
function Read-JsonFile {
    param (
        [string]$filePath  # Specify the file path as a parameter
    )

    $content = Get-Content -Path $filePath -Raw  # Read the content of the file
    return $content | ConvertFrom-Json  # Convert the content to a PowerShell object
}

# Function to write JSON array to file
function Write-JsonFile {
    param (
        [string]$filePath,  # Specify the file path as a parameter
        [object]$jsonArray  # Specify the JSON array as a parameter
    )

    $jsonArray | ConvertTo-Json | Set-Content -Path $filePath  # Convert the array to JSON and write to the file
}

# Function to add an element to JSON array
function Add-JsonElement {
    param (
        [object]$jsonArray,    # JSON array to which the element will be added
        [hashtable]$newElement  # New element to be added to the JSON array
    )

    $jsonArray += $newElement  # Add the new element to the JSON array
    return $jsonArray  # Return the updated JSON array
}

# Function to update an element in JSON array
function Update-JsonElement {
    param (
        [object]$jsonArray,          # JSON array to be updated
        [string]$searchAttribute,    # Attribute to search by for updating
        [string]$searchValue,        # Value to search for
        [hashtable]$updatedElement   # Updated values for the matching element
    )

    $jsonArray | ForEach-Object {
        if ($_.($searchAttribute) -eq $searchValue) {
           # $_ is a special variable that represents the current object in the pipeline. 
            $_ = $updatedElement  # Update the element if it matches the search criteria
        }
    }
    return $jsonArray  # Return the updated JSON array
}

# Function to remove an element from JSON array
function Remove-JsonElement {
    param (
        [object]$jsonArray,          # JSON array from which the element will be removed
        [string]$searchAttribute,    # Attribute to search by for removal
        [string]$searchValue         # Value to search for
    )

    $jsonArray = $jsonArray | Where-Object { $_.($searchAttribute) -ne $searchValue }  # Remove the element based on search criteria
    return $jsonArray  # Return the updated JSON array
}

# Function to list all elements in JSON array
function List-AllElements {
    param (
        [object]$jsonArray  # JSON array to be listed
    )

    $jsonArray  # Output the entire JSON array
}

# Function to search for an element in JSON array by attribute
function Search-JsonElement {
    param (
        [object]$jsonArray,          # JSON array to be searched
        [string]$searchAttribute,    # Attribute to search by
        [string]$searchValue         # Value to search for
    )
   # Where-Object: This cmdlet iterates through each element (represented by $_) in the incoming array and filters the elements based on the condition specified in the script block.
    $jsonArray | Where-Object { $_.($searchAttribute) -eq $searchValue }  # Search for and return the matching element
}

# Main script
$filePath = "your_file_path.json"  # Replace with your file path
$jsonArray = Read-JsonFile -filePath $filePath  # Read the JSON array from the file

# Interactive loop
$continue = $true  # Variable to control the interactive loop

while ($continue) {
    $operation = Read-Host "Choose operation (add, update, remove, list, search, exit):"

    switch ($operation) {
        "add" {
            $newElement = @{
                "Name"     = Read-Host "Enter Name:"
                "Balance"  = Read-Host "Enter Balance:"
                "Tags"     = @((Read-Host "Enter Tags (comma-separated):") -split ',')
                "Friends"  = @(@{ "id" = 0; "name" = Read-Host "Enter Friend's Name:" })
                "Greeting" = Read-Host "Enter Greeting:"
                "FavoriteFruit" = Read-Host "Enter Favorite Fruit:"
            }
            $jsonArray = Add-JsonElement -jsonArray $jsonArray -newElement $newElement
        }
        "update" {
            $searchAttribute = Read-Host "Enter attribute to search by (e.g., Name):"
            $searchValue = Read-Host "Enter value to search:"
            $updatedElement = @{
                "Name"     = Read-Host "Enter Updated Name:"
                "Balance"  = Read-Host "Enter Updated Balance:"
                "Tags"     = @((Read-Host "Enter Updated Tags (comma-separated):") -split ',')
                "Friends"  = @(@{ "id" = 0; "name" = Read-Host "Enter Updated Friend's Name:" })
                "Greeting" = Read-Host "Enter Updated Greeting:"
                "FavoriteFruit" = Read-Host "Enter Updated Favorite Fruit:"
            }
            $jsonArray = Update-JsonElement -jsonArray $jsonArray -searchAttribute $searchAttribute -searchValue $searchValue -updatedElement $updatedElement
        }
        "remove" {
            $searchAttribute = Read-Host "Enter attribute to search by (e.g., Name):"
            $searchValue = Read-Host "Enter value to search:"
            $jsonArray = Remove-JsonElement -jsonArray $jsonArray -searchAttribute $searchAttribute -searchValue $searchValue
        }
        "list" {
            List-AllElements -jsonArray $jsonArray
        }
        "search" {
            $searchAttribute = Read-Host "Enter attribute to search by (e.g., Name):"
            $searchValue = Read-Host "Enter value to search:"
            $result = Search-JsonElement -jsonArray $jsonArray -searchAttribute $searchAttribute -searchValue $searchValue
            if ($result) {
                Write-Host "Search Result:"
                $result
            } else {
                Write-Host "No matching element found."
            }
        }
        "exit" {
            $continue = $false
        }
        default {
            Write-Host "Invalid operation. Please enter add, update, remove, list, search, or exit."
        }
    }
}

# Write the updated JSON array back to the file
Write-JsonFile -filePath $filePath -jsonArray $jsonArray
```

Below are examples of how to use the PowerShell script for each operation:

1. **Add an Element:**
   - Choose "add" as the operation.
   - Enter values for the new element's attributes when prompted.
   ```powershell
   Choose operation (add, update, remove, list, search, exit): add
   Enter Name: John Doe
   Enter Balance: $3,500.00
   Enter Tags (comma-separated): tag1,tag2
   Enter Friend's Name: Jane Doe
   Enter Greeting: Hello, John!
   Enter Favorite Fruit: Apple
   ```

2. **Update an Element:**
   - Choose "update" as the operation.
   - Enter the attribute and value to search for.
   - Enter updated values for the found element when prompted.
   ```powershell
   Choose operation (add, update, remove, list, search, exit): update
   Enter attribute to search by (e.g., Name): Name
   Enter value to search: John Doe
   Enter Updated Name: John Updated
   Enter Updated Balance: $4,000.00
   Enter Updated Tags (comma-separated): tag1,tag3
   Enter Updated Friend's Name: Jane Updated
   Enter Updated Greeting: Hello, John Updated!
   Enter Updated Favorite Fruit: Orange
   ```

3. **Remove an Element:**
   - Choose "remove" as the operation.
   - Enter the attribute and value to search for.
   ```powershell
   Choose operation (add, update, remove, list, search, exit): remove
   Enter attribute to search by (e.g., Name): Name
   Enter value to search: John Updated
   ```

4. **List All Elements:**
   - Choose "list" as the operation.
   ```powershell
   Choose operation (add, update, remove, list, search, exit): list
   ```

5. **Search for an Element:**
   - Choose "search" as the operation.
   - Enter the attribute and value to search for.
   ```powershell
   Choose operation (add, update, remove, list, search, exit): search
   Enter attribute to search by (e.g., Name): Name
   Enter value to search: Jane Doe
   ```

6. **Exit:**
   - Choose "exit" as the operation to exit the script.
   ```powershell
   Choose operation (add, update, remove, list, search, exit): exit
   ```

Remember to replace the file path (`"your_file_path.json"`) in the script with the actual path to your JSON file. The script will read the JSON data from the file, perform the chosen operations interactively, and then write the updated JSON data back to the same file.
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

- @(...) around the hashtable: This part creates an array containing the hashtable. Even though in this example, there's only one hashtable, it's enclosed in an array. This is useful in scenarios where you might have multiple elements in the array, and it ensures consistency.

The script provides a foundation for interactive manipulation of JSON data, showcasing common operations such as adding, editing, and removing items from a JSON array.
