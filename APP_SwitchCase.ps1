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
