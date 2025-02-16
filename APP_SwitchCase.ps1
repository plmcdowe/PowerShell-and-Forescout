# EXE file search
$USERS = Get-ChildItem C:\Users -Directory
foreach ($USER in $USERS) {
    $SEARCH = "C:\Users\$($user.Name)"
    $EXE = Get-ChildItem -Path $SEARCH -Filter *.exe -Recurse -ErrorAction SilentlyContinue -Force
    foreach ($FILE in $EXE) {
        switch -Regex ($FILE.Name) {
            'Zoom.exe' {
                Write-Output "Found: $($FILE.Name)"
                $UNINSTALL = $FILE.DirectoryName.Replace("\bin", "\uninstall\Installer.exe")
                if (Test-Path $UNINSTALL) {
                    Write-Output "Uninstalling: $($FILE.Name)"
                    Invoke-Command {&$UNINSTALL /uninstall}
                    Write-Output "Uninstall command sent $($FILE.Name)"
                }
            }
            'ZoomInstaller.exe' {
                Write-Output "Found: $($FILE.Name)"
                $PATH = $FILE.DirectoryName
                Write-Output "Removing: $($FILE.Name)"
                Remove-Item -Path $PATH\ZoomInstaller.exe -Force
                Write-Output "Remove command sent: $($FILE.Name)"                
            }
        }
    }
}

$PACKAGES = Get-Package | Select-Object -Property Name
foreach ($PACKAGE in $PACKAGES) {
    switch -Regex ($PACKAGE.Name) {
        'Adobe.*Reader' {
            Write-Output "Found: $($PACKAGE.Name)"
            Write-Output "Uninstalling: $($PACKAGE.Name)"
            Uninstall-Package -Name $PACKAGE.Name
            Write-Output "Uninstall command sent: $($PACKAGE.Name)"
        }        
    }
}