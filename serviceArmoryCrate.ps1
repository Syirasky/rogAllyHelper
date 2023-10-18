# Check if the script is running with administrator privileges
if (-not ([System.Security.Principal.WindowsPrincipal] [System.Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([System.Security.Principal.WindowsBuiltInRole]::Administrator)) {
    Write-Host "This script requires administrator privileges. Please run it as an administrator."
    Read-Host -Prompt "Press Enter to exit"
    exit
}

# Specify the service name and path to the executable
$serviceName = "ARMOURY CRATE SE Service"
$servicePath = "C:\Program Files\ASUS\ARMOURY CRATE SE Service\ArmouryCrateSE.Service.exe"


 # Check the status of the service
 $serviceStatus = Get-Service -Name $serviceName
 if ($serviceStatus.Status -eq "Running") {
     Write-Host "Service '$serviceName' is currently running."
 } elseif ($serviceStatus.Status -eq "Stopped") {
     Write-Host "Service '$serviceName' is currently stopped."
 } else {
     Write-Host "Service '$serviceName' status is unknown."
 }

# Prompt the user for their choice
$choice = Read-Host "Choose an option:`n1. Turn OFF the service`n2. Turn ON the service`n3. Check the status`nEnter 1, 2, or 3"

# Perform the selected action based on the user's choice
switch ($choice) {
    1 {
        # Turn OFF the service
        Stop-Service -Name $serviceName
        Write-Host "Service '$serviceName' has been stopped."
        Read-Host -Prompt "Press Enter to exit"
        break
    }
    2 {
        # Turn ON the service
        Start-Service -Name $serviceName
        Write-Host "Service '$serviceName' has been started."
        Read-Host -Prompt "Press Enter to exit"
        break
    }
    3 {
        # Check the status of the service
        $serviceStatus = Get-Service -Name $serviceName
        if ($serviceStatus.Status -eq "Running") {
            Write-Host "Service '$serviceName' is currently running."
        } elseif ($serviceStatus.Status -eq "Stopped") {
            Write-Host "Service '$serviceName' is currently stopped."
        } else {
            Write-Host "Service '$serviceName' status is unknown."
        }
        break
    }
    default {
        Write-Host "Invalid choice. Please enter 1, 2, or 3."
        break
    }
}