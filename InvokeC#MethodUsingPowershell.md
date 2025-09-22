# Sample: Load .NET DLL and Use Class with Multiple Constructors via PowerShell

This guide demonstrates how to load a .NET DLL and instantiate a class that has multiple constructors using PowerShell.

---

## 1. ✅ Sample C# Class with Multiple Constructors (`MyClass.cs`)

```csharp
// File: MyClass.cs
using System;

namespace MyLibrary
{
    public class MyClass
    {
        public string Message { get; }
        public int Count { get; }

        // Default constructor
        public MyClass()
        {
            Message = "Default constructor";
            Count = 0;
        }

        // Constructor with one string parameter
        public MyClass(string message)
        {
            Message = message;
            Count = 0;
        }

        // Constructor with string and int
        public MyClass(string message, int count)
        {
            Message = message;
            Count = count;
        }

        public void ShowMessage()
        {
            Console.WriteLine($"Message: {Message}, Count: {Count}");
        }
    }
}
````

### 🛠️ Compile Instructions

Compile into a DLL using:

```bash
csc -target:library -out:MyLibrary.dll MyClass.cs
```

---

## 2. ⚙️ PowerShell Script to Use Multiple Constructors

```powershell
# ------------------------------
# Load the assembly
# ------------------------------
$cloudCoreDllPath = "C:\Path\To\MyLibrary.dll"
[System.Reflection.Assembly]::LoadFrom($cloudCoreDllPath)

# ------------------------------
# Get the type from the assembly
# ------------------------------
$typeName = "MyLibrary.MyClass"
$assembly = [System.AppDomain]::CurrentDomain.GetAssemblies() |
    Where-Object { $_.GetTypes() -match $typeName } |
    Select-Object -First 1

if (-not $assembly) {
    throw "Type $typeName not found in loaded assemblies."
}

$type = $assembly.GetType($typeName)

# ------------------------------
# Example 1: Use default constructor
# ------------------------------
$instance1 = [Activator]::CreateInstance($type)
$instance1.ShowMessage()

# ------------------------------
# Example 2: Use constructor with one string parameter
# ------------------------------
$instance2 = [Activator]::CreateInstance($type, @("Hello from PowerShell"))
$instance2.ShowMessage()

# ------------------------------
# Example 3: Use constructor with string and int
# ------------------------------
$instance3 = [Activator]::CreateInstance($type, @("Multi-param", 42))
$instance3.ShowMessage()
```

---

## 3. 📌 Notes on Constructor Selection

* `[Activator]::CreateInstance(type, parameters)` chooses the constructor based on parameter **count and type**.
* Make sure the parameter order and types match the constructor exactly.
* You can also use reflection for advanced matching (e.g., to pick optional constructors or named parameters).

---

## ✅ Output When Run

```
Message: Default constructor, Count: 0
Message: Hello from PowerShell, Count: 0
Message: Multi-param, Count: 42
```

---

## 🧠 Optional: Find Constructors with Reflection

To list all available constructors:

```powershell
$constructors = $type.GetConstructors()
foreach ($ctor in $constructors) {
    $params = $ctor.GetParameters() | ForEach-Object { "$($_.ParameterType.Name) $_.Name" }
    Write-Host "Constructor: ($($params -join ', '))"
}
```

---

## 📎 References

* [System.Activator.CreateInstance](https://learn.microsoft.com/en-us/dotnet/api/system.activator.createinstance)
* [Reflection in PowerShell](https://learn.microsoft.com/en-us/powershell/scripting/learn/deep-dives/reflection-in-powershell)

```
