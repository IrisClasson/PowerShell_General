# PowerShell_General

The sql.ps1 file has been reformatted in to separate functions to make reusing the code easier for different queries.

The functions will need to be loaded before they can be used.  This can be achieved in 2 different ways:

2. Adding these functions in to a module.  

 Modules have a different file extension (psm1) and need to be located in a specific folder structure under the $env:PsModulePath environment variable. 
 
 However once there they are automatically loaded when required in PowerShell V3+ and can be loaded and unloaded manually (using the Import-Module and Remove-Module cmdlets respectively).
 
 [More information on modules can be found here.](https://technet.microsoft.com/en-us/library/dd878324(v=vs.85).aspx)
 
 **Modules are the recommended approach for making easily resusable functions in PowerShell.**

1. Dot-sourcing the sql.ps1 file.  
 
 Assuming the sql.ps1 file is in the current working directory, this is done by running ". .\sql.ps1" (without quotes).  
 
 It's important to note the space between the first dot (.) and the path to sql.ps1


