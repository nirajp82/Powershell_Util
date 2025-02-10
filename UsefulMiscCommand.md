#### Monitor directory

* PowerShell command that monitors log files matching the pattern "log*" in a specified directory and retrieves the lines that contain a given keyword:
    * `$directory = "C:\Logs"`  # Specify the directory path where log files are located
    * `$keyword = "error"`      # Specify the keyword to search for
    * `Get-Content -Path "$directory\log*" -Tail 0 -Wait | Select-String -Pattern $keyword`
   
In the above command, you need to update the $directory variable with the path to the directory where your log files are located. The command uses Get-Content to read the contents of log files, and the -Tail 0 -Wait parameters ensure that it continuously monitors new lines appended to the log files.

Select-String is then used to search for lines containing the specified $keyword. Any matching lines will be displayed in the console.

Please note that this command will continuously monitor the log files and display matching lines in real-time until you stop it manually (by pressing Ctrl+C in the PowerShell window).


###
```ps1
tnc ocsp.globalsign.com -Port 80
```
The command `tnc ocsp.globalsign.com -Port 80` uses **Test-NetConnection** (`tnc`) in PowerShell to check the connectivity to a remote server. Here's a breakdown:

- **`tnc`**: This is the alias for the **Test-NetConnection** cmdlet in PowerShell, which is used for testing network connections.
  
- **`ocsp.globalsign.com`**: This is the target host (the server) you want to check the connection to. In this case, it’s a server related to **GlobalSign**'s OCSP (Online Certificate Status Protocol) service, which is used to check the revocation status of SSL certificates.

- **`-Port 80`**: This specifies the port number you want to check the connection on. Port 80 is the default port for HTTP traffic.

So, the command is essentially checking if your machine can establish a connection to **ocsp.globalsign.com** on **port 80** (HTTP). It will return information about the connection status, including whether the server is reachable and if the connection on port 80 can be established successfully.

This is useful for diagnosing network connectivity issues, especially for services relying on HTTP connections.
