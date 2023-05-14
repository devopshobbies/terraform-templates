
# Terraform Proxmox Example
This code is based on Proxmox Provide. For more information refer to the [official documentation](https://registry.terraform.io/providers/Telmate/proxmox/latest/docs/resources/vm_qemu)


# Requirements:

## VM Template
You need a cloud-init template on Proxmox. For this purpose [this youtube tutorial](https://www.youtube.com/watch?v=shiIi38cJe4) would help.

Commands for creating **Ubuntu Cloud-Init** template in a nutshell:

```
# ssh to proxmox and download ubuntu cloud init img file
wget https://cloud-images.ubuntu.com/jammy/current/jammy-server-cloudimg-amd64.img
# create vm
qm create 8000 --memory 2048 --name ubuntu-cloud --net0 virtio,bridge=vmbr1
# create disk from img
qm importdisk 8000 jammy-server-cloudimg-amd64.img local-lvm
# connect disk to vm
qm set 8000 --scsihw virtio-scsi-pci  --scsi0 local-lvm:vm-8000-disk-0
# connect cloudinit disk to vm
qm set 8000 --ide2 local-lvm:cloudinit
qm set 8000 --boot c --bootdisk scsi0
# connect proxmox console(novnc) to vm
qm set 8000 --serial0 socket --vga serial0

# From Proxmox UI, convert ubuntu-cloud to template.
```

## Proxmox API_TOKEN
1. Creat API_TOKEN: **Login to Proxmox > Datacenter > Permissions > API Tokens**
2. Set access for API_TOKEN: In **Permissions**, Add API Token permission with '/' path and Administrator Role for the created API Token.

# More Examples:
On the official GitHub page of the Proxmox library you can see more examples:
*https://github.com/Telmate/terraform-provider-proxmox/tree/master/examples*