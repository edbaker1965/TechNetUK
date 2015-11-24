
#change to src folder
Set-Location c:\nanodeploy

#remove any existing vhd folder and content
rd .\nanovhd -Recurse -ErrorAction SilentlyContinue

#load required scripts
. .\convert-windowsimage.ps1
. .\new-nanoserverimage.ps1

#First run needs -mediapath
# New-NanoServerImage -MediaPath j:\ -BasePath C:\nanodeploy\nanoserver -TargetPath C:\nanodeploy\nanovhd -ComputerName WebNanoTest -GuestDrivers -Language EN-US

#subsequent runs do not
#-compute for hyper-v
#New-NanoServerImage -BasePath C:\nanodeploy\nanoserver -TargetPath C:\nanodeploy\nanovhd -ComputerName WebNanoTest -GuestDrivers -Language EN-US -Compute -Clustering -AdministratorPassword ("Passw0rd!" | ConvertTo-SecureString -AsPlainText -Force) -EnableRemoteManagementPort
#-storage for sofs
New-NanoServerImage -BasePath C:\nanodeploy\nanoserver -TargetPath C:\nanodeploy\nanovhd -ComputerName WebNanoTest -GuestDrivers -Language EN-US -Storage -Clustering -AdministratorPassword ("Passw0rd!" | ConvertTo-SecureString -AsPlainText -Force) -EnableRemoteManagementPort

#create folders for VMs
md c:\VirtualMachines\Webcluster1
md c:\VirtualMachines\Webcluster2
md c:\VirtualMachines\Webcluster3
md c:\VirtualMachines\Webcluster4
md c:\VirtualMachines\Webcluster5
md c:\VirtualMachines\Webcluster6

#copy vhds to new folders
copy C:\nanodeploy\nanovhd\nanovhd.vhd c:\VirtualMachines\Webcluster1\Webcluster1.vhd
copy C:\nanodeploy\nanovhd\nanovhd.vhd c:\VirtualMachines\Webcluster2\Webcluster2.vhd
copy C:\nanodeploy\nanovhd\nanovhd.vhd c:\VirtualMachines\Webcluster3\Webcluster3.vhd
copy C:\nanodeploy\nanovhd\nanovhd.vhd c:\VirtualMachines\Webcluster4\Webcluster4.vhd
copy C:\nanodeploy\nanovhd\nanovhd.vhd c:\VirtualMachines\Webcluster5\Webcluster5.vhd
copy C:\nanodeploy\nanovhd\nanovhd.vhd c:\VirtualMachines\Webcluster6\Webcluster6.vhd

#create new vms with vhds
new-vm -name "Webcluster1" -MemoryStartupBytes 0.5Gb -SwitchName WebinarSwitch -VHDPath c:\VirtualMachines\Webcluster1\Webcluster1.vhd | start-vm
new-vm -name "Webcluster2" -MemoryStartupBytes 0.5Gb -SwitchName WebinarSwitch -VHDPath c:\VirtualMachines\Webcluster2\Webcluster2.vhd | start-vm
new-vm -name "Webcluster3" -MemoryStartupBytes 0.5Gb -SwitchName WebinarSwitch -VHDPath c:\VirtualMachines\Webcluster3\Webcluster3.vhd | start-vm
new-vm -name "Webcluster4" -MemoryStartupBytes 0.5Gb -SwitchName WebinarSwitch -VHDPath c:\VirtualMachines\Webcluster4\Webcluster4.vhd | start-vm
new-vm -name "Webcluster5" -MemoryStartupBytes 0.5Gb -SwitchName WebinarSwitch -VHDPath c:\VirtualMachines\Webcluster5\Webcluster5.vhd | start-vm
new-vm -name "Webcluster6" -MemoryStartupBytes 0.5Gb -SwitchName WebinarSwitch -VHDPath c:\VirtualMachines\Webcluster6\Webcluster6.vhd | start-vm


#start powershell direct session to webcluster1
Enter-PSSession -VMName Webcluster1

#get running processes on webcluster1
get-process 
