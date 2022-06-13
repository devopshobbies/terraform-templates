### Openstack provider


##### 1.  providers.tf 
its for define providers . "openstack" in this file come from clouds.yaml 
##### 2. variables.tf
  put all variables in this file such as number of worker node or ssh-key file
##### 3. network.tf
  First it creates an external network (or you can import it) then it creates subnet and router
Next it creates 2 floatingip and finally it assigns IPs to VMs
##### 4. keypairs.tf
We add our public key to use in OpenStack. default from ~/.ssh/id_rsa.pub
##### 5. get_images.tf
I gave the image of Debian from the local path. You can download it directly from the Internet
##### 6. flavors.tf
 flavor is size for VMs. RAM , CPU and disk
##### 7. sec_groups.tf
Security group like iptables . We can use default security group
##### 8. computes.tf
This file up and runnig VMs
##### 9. locals.tf
in locals.tf we save the IPs of the VMs. And put in host.ini with templating for use it in ansible
##### 10. templates/host.ini
this is template file for create host.ini and put IPs in this

###### note :
we need clouds.yaml as config and put username and password and auth url there and terraform read data from clouds.yaml
example:
```yaml
clouds:
  openstack:
    auth:
      auth_url: http://192.168.122.10:35357/
      project_name: demo
      username: demo
      password: 1234
    region_name: RegionOne
```
See this [address](https://specs.openstack.org/openstack/openstack-specs/specs/clouds-yaml-support.html) for more information

##### Run :
First  edit clouds.yaml file 

next:
```sh
terraform init
terrafrom plan
terraform apply
```
