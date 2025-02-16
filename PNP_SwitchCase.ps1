function PRIV {
    Write-Output "PRIV"
    $PNPDEVICE = Get-PnpDevice | Select-Object InstanceId, Class, FriendlyName, Status
    foreach ($DEVICE in $PNPDEVICE) {
        switch -Regex ($DEVICE.Status) {
            {$PSItem -match "OK"} {
                switch -Regex ($DEVICE.InstanceId, $DEVICE.Class, $DEVICE.FriendlyName) {
                    #Bluetooth Class
                    'Bluetooth' {Write-Output "ENABLED Match on: Bluetooth | CLASS: $($DEVICE.Class), INSTANCE: $($DEVICE.InstanceId), NAME: $($DEVICE.FriendlyName), STATUS: $($DEVICE.Status)"
                                    Disable-PnpDevice -InstanceId $DEVICE.InstanceId -Confirm:$false}
                    #Apple
                    'VID_05AC' {Write-Output "ENABLED Match on: VID_05AC - Apple | CLASS: $($DEVICE.Class), INSTANCE: $($DEVICE.InstanceId), NAME: $($DEVICE.FriendlyName), STATUS: $($DEVICE.Status)"
                                    Disable-PnpDevice -InstanceId $DEVICE.InstanceId -Confirm:$false}
                    #Galaxy
                    'VID_04E8&PID_6860' {Write-Output "ENABLED Match on: VID_04E8&PID_6860 - Galaxy | CLASS: $($DEVICE.Class), INSTANCE: $($DEVICE.InstanceId), NAME: $($DEVICE.FriendlyName), STATUS: $($DEVICE.Status)"
                                            Disable-PnpDevice -InstanceId $DEVICE.InstanceId -Confirm:$false} 
                    #Google
                    'VID_18D1' {
                        switch -Regex ($DEVICE.InstanceId) {
                            'PID_2D..' {Write-Output "ENABLED Match on: VID_18D1 - Google | CLASS: $($DEVICE.Class), INSTANCE: $($DEVICE.InstanceId), NAME: $($DEVICE.FriendlyName), STATUS: $($DEVICE.Status)"
                                            Disable-PnpDevice -InstanceId $DEVICE.InstanceId -Confirm:$false} 
                            'PID_4E..' {Write-Output "ENABLED Match on: VID_18D1 - Google | CLASS: $($DEVICE.Class), INSTANCE: $($DEVICE.InstanceId), NAME: $($DEVICE.FriendlyName), STATUS: $($DEVICE.Status)"
                                            Disable-PnpDevice -InstanceId $DEVICE.InstanceId -Confirm:$false}
                            'PID_5033' {Write-Output "ENABLED Match on: VID_18D1 - Google | CLASS: $($DEVICE.Class), INSTANCE: $($DEVICE.InstanceId), NAME: $($DEVICE.FriendlyName), STATUS: $($DEVICE.Status)"
                                            Disable-PnpDevice -InstanceId $DEVICE.InstanceId -Confirm:$false}
                            'PID_D[01]0.' {Write-Output "ENABLED Match on: VID_18D1 - Google | CLASS: $($DEVICE.Class), INSTANCE: $($DEVICE.InstanceId), NAME: $($DEVICE.FriendlyName), STATUS: $($DEVICE.Status)"
                                                Disable-PnpDevice -InstanceId $DEVICE.InstanceId -Confirm:$false}
                        }
                    }
                    #LG
                    'VID_1004' {
                        switch -Regex ($DEVICE.InstanceId) {
                            'PID_6...' {Write-Output "ENABLED Match on: VID_1004 - LG | CLASS: $($DEVICE.Class), INSTANCE: $($DEVICE.InstanceId), NAME: $($DEVICE.FriendlyName), STATUS: $($DEVICE.Status)"
                                            Disable-PnpDevice -InstanceId $DEVICE.InstanceId -Confirm:$false}
                            'PID_7...' {Write-Output "ENABLED Match on: VID_1004 - LG | CLASS: $($DEVICE.Class), INSTANCE: $($DEVICE.InstanceId), NAME: $($DEVICE.FriendlyName), STATUS: $($DEVICE.Status)"
                                            Disable-PnpDevice -InstanceId $DEVICE.InstanceId -Confirm:$false}
                            'PID_9...' {Write-Output "ENABLED Match on: VID_1004 - LG | CLASS: $($DEVICE.Class), INSTANCE: $($DEVICE.InstanceId), NAME: $($DEVICE.FriendlyName), STATUS: $($DEVICE.Status)"
                                            Disable-PnpDevice -InstanceId $DEVICE.InstanceId -Confirm:$false}
                        }
                    }
                    #MOTOROLA
                    'VID_22B8' {Write-Output "ENABLED Match on: VID_1004 - LG | CLASS: $($DEVICE.Class), INSTANCE: $($DEVICE.InstanceId), NAME: $($DEVICE.FriendlyName), STATUS: $($DEVICE.Status)"
                                    Disable-PnpDevice -InstanceId $DEVICE.InstanceId -Confirm:$false}
                }                
            }
            {$PSItem -notmatch "OK"} {
                switch -Regex ($DEVICE.InstanceId, $DEVICE.Class, $DEVICE.FriendlyName) {
                    #Bluetooth Class
                    'Bluetooth' {Write-Output "ERROR/UNKOWN Match on: Bluetooth | CLASS: $($DEVICE.Class), INSTANCE: $($DEVICE.InstanceId), NAME: $($DEVICE.FriendlyName), STATUS: $($DEVICE.Status)"}
                    #Apple
                    'VID_05AC' {Write-Output "ERROR/UNKOWN Match on: VID_05AC - Apple | CLASS: $($DEVICE.Class), INSTANCE: $($DEVICE.InstanceId), NAME: $($DEVICE.FriendlyName), STATUS: $($DEVICE.Status)"}
                    #Galaxy
                    'VID_04E8&PID_6860' {Write-Output "ERROR/UNKOWN Match on: VID_04E8&PID_6860 - Galaxy | CLASS: $($DEVICE.Class), INSTANCE: $($DEVICE.InstanceId), NAME: $($DEVICE.FriendlyName), STATUS: $($DEVICE.Status)"}
                    #Google
                    'VID_18D1' {
                        switch -Regex ($DEVICE.InstanceId) {
                            'PID_2D..' {Write-Output "ERROR/UNKOWN Match on: VID_18D1 - Google | CLASS: $($DEVICE.Class), INSTANCE: $($DEVICE.InstanceId), NAME: $($DEVICE.FriendlyName), STATUS: $($DEVICE.Status)"}
                            'PID_4E..' {Write-Output "ERROR/UNKOWN Match on: VID_18D1 - Google | CLASS: $($DEVICE.Class), INSTANCE: $($DEVICE.InstanceId), NAME: $($DEVICE.FriendlyName), STATUS: $($DEVICE.Status)"}
                            'PID_5033' {Write-Output "ERROR/UNKOWN Match on: VID_18D1 - Google | CLASS: $($DEVICE.Class), INSTANCE: $($DEVICE.InstanceId), NAME: $($DEVICE.FriendlyName), STATUS: $($DEVICE.Status)"}
                            'PID_D[01]0.' {Write-Output "ERROR/UNKOWN Match on: VID_18D1 - Google | CLASS: $($DEVICE.Class), INSTANCE: $($DEVICE.InstanceId), NAME: $($DEVICE.FriendlyName), STATUS: $($DEVICE.Status)"}
                        }
                    }
                    #LG
                    'VID_1004' {
                        switch -Regex ($DEVICE.InstanceId) {
                            'PID_6...' {Write-Output "ERROR/UNKOWN Match on: VID_1004 - LG | CLASS: $($DEVICE.Class), INSTANCE: $($DEVICE.InstanceId), NAME: $($DEVICE.FriendlyName), STATUS: $($DEVICE.Status)"}
                            'PID_7...' {Write-Output "ERROR/UNKOWN Match on: VID_1004 - LG | CLASS: $($DEVICE.Class), INSTANCE: $($DEVICE.InstanceId), NAME: $($DEVICE.FriendlyName), STATUS: $($DEVICE.Status)"}
                            'PID_9...' {Write-Output "ERROR/UNKOWN Match on: VID_1004 - LG | CLASS: $($DEVICE.Class), INSTANCE: $($DEVICE.InstanceId), NAME: $($DEVICE.FriendlyName), STATUS: $($DEVICE.Status)"}
                        }
                    }
                    #MOTOROLA
                    'VID_22B8' {Write-Output "ERROR/UNKOWN Match on: VID_1004 - LG | CLASS: $($DEVICE.Class), INSTANCE: $($DEVICE.InstanceId), NAME: $($DEVICE.FriendlyName), STATUS: $($DEVICE.Status)"}
                }                
            }
        }
    }
}
function NONPRIV {
    Write-Output "NONPRIV"
    $PNPDEVICE = Get-PnpDevice | Select-Object InstanceId, Class, FriendlyName, Status
    foreach ($DEVICE in $PNPDEVICE) {
        switch -Regex ($DEVICE.Status) {
            {$PSItem -match "OK"} {
                switch -Regex ($DEVICE.InstanceId, $DEVICE.Class, $DEVICE.FriendlyName) {
                    #Bluetooth Class
                    'Bluetooth' {Write-Output "ENABLED Match on: Bluetooth | CLASS: $($DEVICE.Class), INSTANCE: $($DEVICE.InstanceId), NAME: $($DEVICE.FriendlyName), STATUS: $($DEVICE.Status)"
                                    Disable-PnpDevice -InstanceId $DEVICE.InstanceId -Confirm:$false}
                    #Apple
                    'VID_05AC' {Write-Output "ENABLED Match on: VID_05AC - Apple | CLASS: $($DEVICE.Class), INSTANCE: $($DEVICE.InstanceId), NAME: $($DEVICE.FriendlyName), STATUS: $($DEVICE.Status)"
                                    Disable-PnpDevice -InstanceId $DEVICE.InstanceId -Confirm:$false}
                    #Galaxy
                    'VID_04E8&PID_6860' {Write-Output "ENABLED Match on: VID_04E8&PID_6860 - Galaxy | CLASS: $($DEVICE.Class), INSTANCE: $($DEVICE.InstanceId), NAME: $($DEVICE.FriendlyName), STATUS: $($DEVICE.Status)"
                                            Disable-PnpDevice -InstanceId $DEVICE.InstanceId -Confirm:$false}
                    #Google
                    'VID_18D1' {
                        switch -Regex ($DEVICE.InstanceId) {
                            'PID_2D..' {Write-Output "ENABLED Match on: VID_18D1 - Google | CLASS: $($DEVICE.Class), INSTANCE: $($DEVICE.InstanceId), NAME: $($DEVICE.FriendlyName), STATUS: $($DEVICE.Status)"
                                            Disable-PnpDevice -InstanceId $DEVICE.InstanceId -Confirm:$false}
                            'PID_4E..' {Write-Output "ENABLED Match on: VID_18D1 - Google | CLASS: $($DEVICE.Class), INSTANCE: $($DEVICE.InstanceId), NAME: $($DEVICE.FriendlyName), STATUS: $($DEVICE.Status)"
                                            Disable-PnpDevice -InstanceId $DEVICE.InstanceId -Confirm:$false}
                            'PID_5033' {Write-Output "ENABLED Match on: VID_18D1 - Google | CLASS: $($DEVICE.Class), INSTANCE: $($DEVICE.InstanceId), NAME: $($DEVICE.FriendlyName), STATUS: $($DEVICE.Status)"
                                            Disable-PnpDevice -InstanceId $DEVICE.InstanceId -Confirm:$false}
                            'PID_D[01]0.' {Write-Output "ENABLED Match on: VID_18D1 - Google | CLASS: $($DEVICE.Class), INSTANCE: $($DEVICE.InstanceId), NAME: $($DEVICE.FriendlyName), STATUS: $($DEVICE.Status)"
                                                Disable-PnpDevice -InstanceId $DEVICE.InstanceId -Confirm:$false}
                        }
                    }
                    #LG
                    'VID_1004' {
                        switch -Regex ($DEVICE.InstanceId) {
                            'PID_6...' {Write-Output "ENABLED Match on: VID_1004 - LG | CLASS: $($DEVICE.Class), INSTANCE: $($DEVICE.InstanceId), NAME: $($DEVICE.FriendlyName), STATUS: $($DEVICE.Status)"
                                            Disable-PnpDevice -InstanceId $DEVICE.InstanceId -Confirm:$false}
                            'PID_7...' {Write-Output "ENABLED Match on: VID_1004 - LG | CLASS: $($DEVICE.Class), INSTANCE: $($DEVICE.InstanceId), NAME: $($DEVICE.FriendlyName), STATUS: $($DEVICE.Status)"
                                            Disable-PnpDevice -InstanceId $DEVICE.InstanceId -Confirm:$false}
                            'PID_9...' {Write-Output "ENABLED Match on: VID_1004 - LG | CLASS: $($DEVICE.Class), INSTANCE: $($DEVICE.InstanceId), NAME: $($DEVICE.FriendlyName), STATUS: $($DEVICE.Status)"
                                            Disable-PnpDevice -InstanceId $DEVICE.InstanceId -Confirm:$false}
                        }
                    }
                    #MOTOROLA
                    'VID_22B8' {Write-Output "ENABLED Match on: VID_1004 - LG | CLASS: $($DEVICE.Class), INSTANCE: $($DEVICE.InstanceId), NAME: $($DEVICE.FriendlyName), STATUS: $($DEVICE.Status)"
                                    Disable-PnpDevice -InstanceId $DEVICE.InstanceId -Confirm:$false}
                    #Fujitsu
                    'VID_04C5' {Write-Output "ENABLED Match on: VID_04C5 - Fujitsu | CLASS: $($DEVICE.Class), INSTANCE: $($DEVICE.InstanceId), NAME: $($DEVICE.FriendlyName), STATUS: $($DEVICE.Status)"
                                    Disable-PnpDevice -InstanceId $DEVICE.InstanceId -Confirm:$false}
                    'USBPRINT' {
                        if ($DEVICE.InstanceId -notmatch "DYMO") {
                            Write-Output "ENABLED Match on: USBPRINT | CLASS: $($DEVICE.Class), INSTANCE: $($DEVICE.InstanceId), NAME: $($DEVICE.FriendlyName), STATUS: $($DEVICE.Status)"
                                Disable-PnpDevice -InstanceId $DEVICE.InstanceId -Confirm:$false}
                    }
                    'USBDevice' {
                        switch -Regex ($DEVICE.InstanceId) {
                            #Lexmark
                            'VID_043D&PID_0270' {Write-Output "ENABLED Match on: USBDevice - Lexmark | CLASS: $($DEVICE.Class), INSTANCE: $($DEVICE.InstanceId), NAME: $($DEVICE.FriendlyName), STATUS: $($DEVICE.Status)"
                                                    Disable-PnpDevice -InstanceId $DEVICE.InstanceId -Confirm:$false}
                            #Dell
                            'VID_413C' {Write-Output "ENABLED Match on: USBDevice - Dell | CLASS: $($DEVICE.Class), INSTANCE: $($DEVICE.InstanceId), NAME: $($DEVICE.FriendlyName), STATUS: $($DEVICE.Status)"
                                            Disable-PnpDevice -InstanceId $DEVICE.InstanceId -Confirm:$false}
                            #HP
                            'VID_03F0' { 
                                switch -Regex ($DEVICE.InstanceId) {
                                    'PID_852A' {Write-Output "ENABLED Match on: USBDevice - HP | CLASS: $($DEVICE.Class), INSTANCE: $($DEVICE.InstanceId), NAME: $($DEVICE.FriendlyName), STATUS: $($DEVICE.Status)"
                                                    Disable-PnpDevice -InstanceId $DEVICE.InstanceId -Confirm:$false}
                                    'PID_542A' {Write-Output "ENABLED Match on: USBDevice - HP | CLASS: $($DEVICE.Class), INSTANCE: $($DEVICE.InstanceId), NAME: $($DEVICE.FriendlyName), STATUS: $($DEVICE.Status)"
                                                    Disable-PnpDevice -InstanceId $DEVICE.InstanceId -Confirm:$false}
                                    'PID_522A' {Write-Output "ENABLED Match on: USBDevice - HP | CLASS: $($DEVICE.Class), INSTANCE: $($DEVICE.InstanceId), NAME: $($DEVICE.FriendlyName), STATUS: $($DEVICE.Status)"
                                                    Disable-PnpDevice -InstanceId $DEVICE.InstanceId -Confirm:$false}
                                    'PID_0873' {Write-Output "ENABLED Match on: USBDevice - HP | CLASS: $($DEVICE.Class), INSTANCE: $($DEVICE.InstanceId), NAME: $($DEVICE.FriendlyName), STATUS: $($DEVICE.Status)"
                                                    Disable-PnpDevice -InstanceId $DEVICE.InstanceId -Confirm:$false}
                                    'PID_0972' {Write-Output "ENABLED Match on: USBDevice - HP | CLASS: $($DEVICE.Class), INSTANCE: $($DEVICE.InstanceId), NAME: $($DEVICE.FriendlyName), STATUS: $($DEVICE.Status)"
                                                    Disable-PnpDevice -InstanceId $DEVICE.InstanceId -Confirm:$false}
                                    'PID_0773' {Write-Output "ENABLED Match on: USBDevice - HP | CLASS: $($DEVICE.Class), INSTANCE: $($DEVICE.InstanceId), NAME: $($DEVICE.FriendlyName), STATUS: $($DEVICE.Status)"
                                                    Disable-PnpDevice -InstanceId $DEVICE.InstanceId -Confirm:$false}
                                }
                            }
                            #Software Device Scanner
                            'SWD\\ESCL' {
                                if ($DEVICE.Class -eq "Image" -or
                                    $DEVICE.Class -eq "Printer" -or
                                    $DEVICE.Class -match "USB" -and (
                                        $DEVICE.FriendlyName -match "Dell" -or
                                        $DEVICE.FriendlyName -match "HP" -or
                                        $DEVICE.FriendlyName -match "Lexmark")
                                ) {Write-Output "ENABLED Match on: SWD\\ESCL | CLASS: $($DEVICE.Class), INSTANCE: $($DEVICE.InstanceId), NAME: $($DEVICE.FriendlyName), STATUS: $($DEVICE.Status)"
                                        Disable-PnpDevice -InstanceId $DEVICE.InstanceId -Confirm:$false}
                            }
                        }
                    }
                }
            } 
            {$PSItem -notmatch "OK"} {
                switch -Regex ($DEVICE.InstanceId, $DEVICE.Class, $DEVICE.FriendlyName) {
                    #Bluetooth Class
                    'Bluetooth' {Write-Output "ERROR/UNKOWN Match on: Bluetooth | CLASS: $($DEVICE.Class), INSTANCE: $($DEVICE.InstanceId), NAME: $($DEVICE.FriendlyName), STATUS: $($DEVICE.Status)"}
                    #Apple
                    'VID_05AC' {Write-Output "ERROR/UNKOWN Match on: VID_05AC - Apple | CLASS: $($DEVICE.Class), INSTANCE: $($DEVICE.InstanceId), NAME: $($DEVICE.FriendlyName), STATUS: $($DEVICE.Status)"}
                    #Galaxy
                    'VID_04E8&PID_6860' {Write-Output "ERROR/UNKOWN Match on: VID_04E8&PID_6860 - Galaxy | CLASS: $($DEVICE.Class), INSTANCE: $($DEVICE.InstanceId), NAME: $($DEVICE.FriendlyName), STATUS: $($DEVICE.Status)"}
                    #Google
                    'VID_18D1' {
                        switch -Regex ($DEVICE.InstanceId) {
                            'PID_2D..' {Write-Output "ERROR/UNKOWN Match on: VID_18D1 - Google | CLASS: $($DEVICE.Class), INSTANCE: $($DEVICE.InstanceId), NAME: $($DEVICE.FriendlyName), STATUS: $($DEVICE.Status)"}
                            'PID_4E..' {Write-Output "ERROR/UNKOWN Match on: VID_18D1 - Google | CLASS: $($DEVICE.Class), INSTANCE: $($DEVICE.InstanceId), NAME: $($DEVICE.FriendlyName), STATUS: $($DEVICE.Status)"}
                            'PID_5033' {Write-Output "ERROR/UNKOWN Match on: VID_18D1 - Google | CLASS: $($DEVICE.Class), INSTANCE: $($DEVICE.InstanceId), NAME: $($DEVICE.FriendlyName), STATUS: $($DEVICE.Status)"}
                            'PID_D[01]0.' {Write-Output "ERROR/UNKOWN Match on: VID_18D1 - Google | CLASS: $($DEVICE.Class), INSTANCE: $($DEVICE.InstanceId), NAME: $($DEVICE.FriendlyName), STATUS: $($DEVICE.Status)"}
                        }
                    }
                    #LG
                    'VID_1004' {
                        switch -Regex ($DEVICE.InstanceId) {
                            'PID_6...' {Write-Output "ERROR/UNKOWN Match on: VID_1004 - LG | CLASS: $($DEVICE.Class), INSTANCE: $($DEVICE.InstanceId), NAME: $($DEVICE.FriendlyName), STATUS: $($DEVICE.Status)"}
                            'PID_7...' {Write-Output "ERROR/UNKOWN Match on: VID_1004 - LG | CLASS: $($DEVICE.Class), INSTANCE: $($DEVICE.InstanceId), NAME: $($DEVICE.FriendlyName), STATUS: $($DEVICE.Status)"}
                            'PID_9...' {Write-Output "ERROR/UNKOWN Match on: VID_1004 - LG | CLASS: $($DEVICE.Class), INSTANCE: $($DEVICE.InstanceId), NAME: $($DEVICE.FriendlyName), STATUS: $($DEVICE.Status)"}
                        }
                    }
                    #MOTOROLA
                    'VID_22B8' {Write-Output "ERROR/UNKOWN Match on: VID_1004 - LG | CLASS: $($DEVICE.Class), INSTANCE: $($DEVICE.InstanceId), NAME: $($DEVICE.FriendlyName), STATUS: $($DEVICE.Status)"}
                    #Fujitsu
                    'VID_04C5' {Write-Output "ERROR/UNKOWN Match on: VID_04C5 - Fujitsu | CLASS: $($DEVICE.Class), INSTANCE: $($DEVICE.InstanceId), NAME: $($DEVICE.FriendlyName), STATUS: $($DEVICE.Status)"}
                    'USBPRINT' {
                        if ($DEVICE.InstanceId -notmatch "DYMO") {
                            Write-Output "ERROR/UNKOWN Match on: USBPRINT | CLASS: $($DEVICE.Class), INSTANCE: $($DEVICE.InstanceId), NAME: $($DEVICE.FriendlyName), STATUS: $($DEVICE.Status)"}
                    }
                    'USBDevice' {
                        switch -Regex ($DEVICE.InstanceId) {
                            #Lexmark
                            'VID_043D&PID_0270' {Write-Output "ERROR/UNKOWN Match on: USBDevice - Lexmark | CLASS: $($DEVICE.Class), INSTANCE: $($DEVICE.InstanceId), NAME: $($DEVICE.FriendlyName), STATUS: $($DEVICE.Status)"}
                            #Dell
                            'VID_413C' {Write-Output "ERROR/UNKOWN Match on: USBDevice - Dell | CLASS: $($DEVICE.Class), INSTANCE: $($DEVICE.InstanceId), NAME: $($DEVICE.FriendlyName), STATUS: $($DEVICE.Status)"}
                            #HP
                            'VID_03F0' {
                                switch -Regex ($DEVICE.InstanceId) {
                                    'PID_852A' {Write-Output "ERROR/UNKOWN Match on: USBDevice - HP | CLASS: $($DEVICE.Class), INSTANCE: $($DEVICE.InstanceId), NAME: $($DEVICE.FriendlyName), STATUS: $($DEVICE.Status)"}
                                    'PID_542A' {Write-Output "ERROR/UNKOWN Match on: USBDevice - HP | CLASS: $($DEVICE.Class), INSTANCE: $($DEVICE.InstanceId), NAME: $($DEVICE.FriendlyName), STATUS: $($DEVICE.Status)"}
                                    'PID_522A' {Write-Output "ERROR/UNKOWN Match on: USBDevice - HP | CLASS: $($DEVICE.Class), INSTANCE: $($DEVICE.InstanceId), NAME: $($DEVICE.FriendlyName), STATUS: $($DEVICE.Status)"}
                                    'PID_0873' {Write-Output "ERROR/UNKOWN Match on: USBDevice - HP | CLASS: $($DEVICE.Class), INSTANCE: $($DEVICE.InstanceId), NAME: $($DEVICE.FriendlyName), STATUS: $($DEVICE.Status)"}
                                    'PID_0972' {Write-Output "ERROR/UNKOWN Match on: USBDevice - HP | CLASS: $($DEVICE.Class), INSTANCE: $($DEVICE.InstanceId), NAME: $($DEVICE.FriendlyName), STATUS: $($DEVICE.Status)"}
                                    'PID_0773' {Write-Output "ERROR/UNKOWN Match on: USBDevice - HP | CLASS: $($DEVICE.Class), INSTANCE: $($DEVICE.InstanceId), NAME: $($DEVICE.FriendlyName), STATUS: $($DEVICE.Status)"}
                                }
                            }
                            #Software Device Scanner
                            'SWD\\ESCL' {
                                if ($DEVICE.Class -eq "Image" -or
                                    $DEVICE.Class -eq "Printer" -or
                                    $DEVICE.Class -match "USB" -and (
                                        $DEVICE.FriendlyName -match "Dell" -or
                                        $DEVICE.FriendlyName -match "HP" -or
                                        $DEVICE.FriendlyName -match "Lexmark")
                                ) {Write-Output "ERROR/UNKOWN Match on: SWD\\ESCL | CLASS: $($DEVICE.Class), INSTANCE: $($DEVICE.InstanceId), NAME: $($DEVICE.FriendlyName), STATUS: $($DEVICE.Status)"}
                            }
                        }
                    }
                }
            }
        }
    }
}
$HOSTNAME = hostname
if ($HOSTNAME -match "ABC..123") {
    PRIV
}
else {
    NONPRIV
}
