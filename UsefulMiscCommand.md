#### Monitor directory

* PowerShell command that monitors log files matching the pattern "log*" in a specified directory and retrieves the lines that contain a given keyword:
    * `$directory = "C:\Logs"`  # Specify the directory path where log files are located
    * `$keyword = "error"`      # Specify the keyword to search for
    * `Get-Content -Path "$directory\log*" -Tail 0 -Wait | Select-String -Pattern $keyword`
   
In the above command, you need to update the $directory variable with the path to the directory where your log files are located. The command uses Get-Content to read the contents of log files, and the -Tail 0 -Wait parameters ensure that it continuously monitors new lines appended to the log files.

Select-String is then used to search for lines containing the specified $keyword. Any matching lines will be displayed in the console.

Please note that this command will continuously monitor the log files and display matching lines in real-time until you stop it manually (by pressing Ctrl+C in the PowerShell window).




