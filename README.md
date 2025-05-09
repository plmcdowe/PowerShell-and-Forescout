# PowerShell-and-Forescout
With a service account in an AD security group granting administrator privileges on Windows clients, and the Forescout SecureConnector application installed on those clients - it is possible to integrate PowerShell through Forescout in a multitude of ways.   

I had been leveraging PowerShell scripts in Forescout policies for a few months when I realized that the script repository in Forescout was becoming cluttered, and version control was growing cumbersome. In those preceding months, I had been creating PowerShell scripts unique to each individual policy.   
> \> Discover and track logged on users? Script.   
> \> Discover and remove USB devices? Script.. for *each* USB device.   
> \> Discover and unistall prohibited software? Script.. for *each* program.   
> \> Track software versions? Scripts.    
> \> And so on, and on, and on.    

As you can imagine, this scaled terribly.   

The 2 scripts in this repository are examples of my effort to deconflict Forescout Policy and the use of unique PowerShell scripts. I sought to create scripts which were modular and easily extendable to meet new requirements within their general use-cases. This boiled down to 2 scripts. One to manage installed or running software, and one to manage installed or active USB devices. This enabled Forescout policies to be reshaped as well, resulting in fewer scripts on clients being ran simultanously, or individually throughout a host's time on the network.   

### [ 1 ] [APP_SwitchCase.ps1](https://github.com/plmcdowe/PowerShell-and-Forescout/blob/46b27bdb2193f8ee5286ae92a2f75d76491e80e8/APP_SwitchCase.ps1)
The link above redirects to the script in this repository. The outline below demonstrates its use of Regex switch cases and general structure.      
The script centers around the software type to be uninstalled: `.exe` or `package`.     

> <b>The first foreach loops all user profiles on the host from `$USERS`.</b>
>> <b>In each profile, a second foreach loops executables from `$EXE` with:</b>
>>> - <b>a regex case that checks for and removes prohibited executables,</b>     
>>> - <b>a regex case that checks for and removes prohibited executable installers.</b>
>
> <b>The third switch case checks for prohibited packages on the host.</b>


```PowerShell
# EXE file search
$USERS = Get-ChildItem C:\Users -Directory
foreach ($USER in $USERS) {
    # searches all user profiles
    $SEARCH = "C:\Users\$($user.Name)"
    # filtered on .exe extensions
    $EXE = Get-ChildItem -Path $SEARCH -Filter *.exe -Recurse -ErrorAction SilentlyContinue -Force
    # switch case for all .exe files 
    foreach ($FILE in $EXE) {
        switch -Regex ($FILE.Name) {
            # case where file name in $FILE.Name is a regex match
            'UnauthorizedSoftware.exe' {
                # static path concat based on known, universal path to uninstaller
                $UNINSTALL = $FILE.DirectoryName.Replace("\bin", "\uninstall\Installer.exe")
                if (Test-Path $UNINSTALL) {
                    # send the uninstall command
                    Invoke-Command {&$UNINSTALL /uninstall}
                }
            }
            # case where file name in $FILE.Name is regex match with 'UnauthorizedSoftwareInstaller.exe'
            'UnauthorizedSoftwareInstaller.exe' {
                $PATH = $FILE.DirectoryName
                # delete the installer
                Remove-Item -Path $PATH\UnauthorizedSoftwareInstaller.exe -Force
            }
            # add more regex cases for additional exe files here
        }
    }
    # add additional file extension types to 'foreach' loop
}
# PACKAGE search
$PACKAGES = Get-Package | Select-Object -Property Name
foreach ($PACKAGE in $PACKAGES) {
    # switch case for all packages
    switch -Regex ($PACKAGE.Name) {
        # case where package name is regex match with 'Prohibited.*PackageName'
        'Prohibited.*PackageName' {
            # uninstall the package
            Uninstall-Package -Name $PACKAGE.Name
        }
        # add more cases for additional packages to uninstall
    }
}
```

### [ 2 ] [PNP_SwitchCase.ps1](https://github.com/plmcdowe/PowerShell-and-Forescout/blob/d739a8da5b674ebc42414585801fa1112dd83f2f/PNP_SwitchCase.ps1)
I won't code-block PNP_SwitchCase here because it's well commented in the source, and a bit lengthy.  
<ins>But, here's an outline of what's happening in it</ins>:    

> <b>First, retrieve and store `$HOSTNAME`</b>
>> <b>`if` conditioned on the hostname calls either `PRIV` or `NONPRIV`</b>   
>>> <b><ins>Both `PRIV` and `NONPRIV` will disable the following drivers based on vendor ID and product ID</ins>:</b>
>>> - <b>Bluetooth</b>
>>> - <b>Apple</b>
>>> - <b>Galaxy</b>
>>> - <b>Google</b>
>>> - <b>LG</b>
>>> - <b>Motorola</b>   
>>>
>>> <b>`PRIV` will not disable USB printers</b>     
>>> <b>`NONPRIV` disables USB printers:</b>
>>> - <b>Lexmark</b>
>>> - <b>Dell</b>
>>> - <b>HP</b>
>>> - <b>Software Device Scanner</b>   
