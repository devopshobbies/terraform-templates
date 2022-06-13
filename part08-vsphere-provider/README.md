# Create a ready to use in production Virtual Machine with Terraform

## Create a VMware vSphere virtual machine
**Login to your Vcenter**

1- Create a new virtual machine.

2- Choose a name for your virtual machine template.

3- Select a temporary compute resource for the virtual machine.

4- Select a datastore for the virtual machine.

5- Select the vSphere compatibility for the virtual machine.

6- Select "Ubuntu Linux (64-bit)" as guest OS for the virtual machine.

7- Change the type of the SCSI controller to "VMware Paravirtual".

8- Choose a temporary network for the virtual machine.

9- Add the Ubuntu 18.04 ISO to the CD/DVD drive of the virtual machine.

10- Connect the CD/DVD drive at boot.

11- Finish the hardware customization of the virtual machine.

12- Validate the creation of the virtual machine.

13- Power on the virtual machine.

14- Launch the vSphere web console.

# Install Ubuntu 18.04

Install Ubuntu.

# Install the VMware tools

# Clean the virtual machine configuration
1- Remove the temporary network configuration.
```
$ sudo rm /etc/netplan/50-cloud-init.yaml
```
2- Prevent cloud config from preserving the hostname.
```
$ sudo vim /etc/cloud/cloud.cfg
...
preserve_hostname: true
...
```
3- Power off the Ubuntu virtual machine.
```
$ sudo shutdown now
```
4- Edit the settings of the virtual machine.

5- Set the network card back to "VM Network".

6- Set the CD/DVD drive back to "Client Device".

7- Validate the modification.

# Create the VMware vSphere template
Convert the virtual machine to a vSphere template.

# Edit the Environment file and run the Terraform code

```
terraform init
terraform validate
terraform fmt
terraform plan
terraform apply
```

