# PowerShell-and-Forescout
With a service account in the appropriate AD security group granting administrator privileges on Windows clients, and the Forescout SecureConnector application installed on those clients - it is possible to integrate PowerShell in a multitude of ways. I had been leveraging PowerShell scripts in Forescout Policies for a few months when I realized that the repository in Forescout was becoming cluttered and version control was growing cumbersome. I had been creating PowerShell scripts unique to each individual policy. The scripts in this repository are the product of my efforts to deconflict Forescout Policy and PowerShell scripts. I sought to create scripts which were modular and easily extendable for new requirements. This would allow essentially 3 scripts. One to perform discoveries, one to manage installed or running software, and one to manage installed or active usb devices. 
### [ APP_SwitchCase.ps1 ](https://github.com/plmcdowe/PowerShell-and-Forescout/blob/46b27bdb2193f8ee5286ae92a2f75d76491e80e8/APP_SwitchCase.ps1)
```PowerShell
#EXE file search
$USERS = Get-ChildItem C:\Users -Directory
foreach ($USER in $USERS) {
    #searches all user profiles
    $SEARCH = "C:\Users\$($user.Name)"
    
    #filtered on .exe extensions
    $EXE = Get-ChildItem -Path $SEARCH -Filter *.exe -Recurse -ErrorAction SilentlyContinue -Force
    #DECLARE ADDITIONAL $VAR EXTENSION SEARCH FILTERS AS NEEDED
    
    #switch case for all .exe files 
    foreach ($FILE in $EXE) {
        switch -Regex ($FILE.Name) {
            #case where file name in $FILE.Name is regex match with 'Zoom.exe'
            'Zoom.exe' {
                Write-Output "Found: $($FILE.Name)"
                #static path concat based on known, universal path to zoom uninstaller
                $UNINSTALL = $FILE.DirectoryName.Replace("\bin", "\uninstall\Installer.exe")
                if (Test-Path $UNINSTALL) {
                    Write-Output "Uninstalling: $($FILE.Name)"
                    #send the uninstall command
                    Invoke-Command {&$UNINSTALL /uninstall}
                    Write-Output "Uninstall command sent $($FILE.Name)"
                }
            }
            #case where file name in $FILE.Name is regex match with 'ZoomInstaller.exe'
            'ZoomInstaller.exe' {
                Write-Output "Found: $($FILE.Name)"
                $PATH = $FILE.DirectoryName
                Write-Output "Removing: $($FILE.Name)"
                #delete the Zoom installer
                Remove-Item -Path $PATH\ZoomInstaller.exe -Force
                Write-Output "Remove command sent: $($FILE.Name)"                
            }
            #ADD MORE REGEX CASES ADDITIONAL FOR EXE FILES HERE
        }
    }
    #ADD ADDITIONAL FILE EXTENSION 'foreach' SWITCH CASES HERE
}

#PACKAGE search
$PACKAGES = Get-Package | Select-Object -Property Name
foreach ($PACKAGE in $PACKAGES) {
    #switch case for all packages
    switch -Regex ($PACKAGE.Name) {
        #case where package name is regex match with 'Adobe.*Reader'
        'Adobe.*Reader' {
            Write-Output "Found: $($PACKAGE.Name)"
            Write-Output "Uninstalling: $($PACKAGE.Name)"
            #uninstall the package
            Uninstall-Package -Name $PACKAGE.Name
            Write-Output "Uninstall command sent: $($PACKAGE.Name)"
        }
        #ADD MORE REGEX CASES FOR ADDITIONAL PACKAGES TO UNINSTALL
    }
}
```

