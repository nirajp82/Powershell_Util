1. A sample C# class (`MyClass.cs`)
2. The PowerShell script to:

   * Load the DLL using `LoadFrom`
   * Instantiate the class
   * Include detailed comments and notes

---

### 📄 `SampleUsage.md`

````markdown
# Sample: Using PowerShell to Load a .NET DLL and Create an Object

This guide shows how to create a simple .NET class, compile it into a DLL, and then load and instantiate it from PowerShell using both `Assembly::LoadFrom` and `[Activator]::CreateInstance`.

---

## 1. ✅ Sample C# Class (`MyClass.cs`)

```csharp
// File: MyClass.cs
using System;

namespace MyLibrary
{
    public class MyClass
    {
        public string Message { get; }

        public MyClass(string message)
        {
            Message = message;
        }

        public void ShowMessage()
        {
            Console.WriteLine("Message from MyClass: " + Message);
        }
    }
}
````

### 🛠️ Compile Instructions

Use the following command in Developer Command Prompt to compile:

```bash
csc -target:library -out:MyLibrary.dll MyClass.cs
```

---

## 2. ⚙️ PowerShell Script

```powershell
# ------------------------------
# Load .NET Assembly from path
# ------------------------------
$cloudCoreDllPath = "C:\Path\To\MyLibrary.dll"
[System.Reflection.Assembly]::LoadFrom($cloudCoreDllPath)

# ----------------------------------------
# Get the type from the loaded assembly
# This is safer than relying on [Type]::GetType()
# ----------------------------------------
$typeName = "MyLibrary.MyClass"
$assembly = [System.AppDomain]::CurrentDomain.GetAssemblies() |
    Where-Object { $_.GetTypes() -match $typeName } |
    Select-Object -First 1

if (-not $assembly) {
    throw "Type $typeName not found in loaded assemblies."
}

$type = $assembly.GetType($typeName)

# ----------------------------------------
# Create an instance using constructor with parameter
# ----------------------------------------
$param = "Hello from PowerShell"
$instance = [Activator]::CreateInstance($type, @($param))

# ----------------------------------------
# Call a method on the object
# ----------------------------------------
$instance.ShowMessage()
```

---

## 3. 📌 Notes

* `Assembly::LoadFrom()` loads the assembly from a specific file path.
* `New-Object` might not work reliably after loading assemblies dynamically — prefer `[Activator]::CreateInstance()` for better compatibility.
* You can extend this by using reflection to inspect available constructors, properties, or methods.

---

## ✅ Output (When Run)

```
Message from MyClass: Hello from PowerShell
```

---

## 📎 Related Links

* [Activator.CreateInstance Documentation](https://learn.microsoft.com/en-us/dotnet/api/system.activator.createinstance)
* [PowerShell New-Object](https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.utility/new-object)

```

Let me know if you'd like a version with multiple constructors, or to show use of `New-Object` side-by-side for learning!
```
