#######################################################################################
# Check if BitLocker is enabled in C:. If it is not, enable it and encrypt the drives #
#######################################################################################

$OutputVariable = (Get-BitlockerVolume -MountPoint "C:")
If ($OutputVariable.protectionstatus -like "Off") 
{
    Enable-BitLocker C: -RecoveryPasswordProtector -SkipHardwareTest
} 
Else 
{
    Exit
}
