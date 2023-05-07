# Jenkins-CasC

### Introduction


Setting up Jenkins is a complex process, as both Jenkins and its plugins require some tuning and configuration, with dozens of parameters to set within the web UI manage section.

Jenkins Configuration as Code provides the ability to define this whole configuration as a simple, human-friendly, plain text yaml syntax. Without any manual steps, this configuration can be validated and applied to a Jenkins controller in a fully reproducible way. With JCasC, setting up a new Jenkins controller will become a no-brainer event.


----------

### What do we want to do ?

- Provisioning a jenkins server on virtualbox platform with Terraform (you can also use other platforms like aws):
   - we used ubuntu vagrant box
- Running ansible playbook with terraform provisioner that is responsible to do some tasks:
   - Install Docker and Docker-compose on jenkins server
   - Run jenkins docker-compose to have its docker container up and running
   
----------

### casc.yml configuration file

One of the most important files that we have in this project is << casc.yml >> that is reponsible to define the whole jenkins configuration as a simple, human-friendly, plain text yaml syntax

#### what we did in casc.yml:
 - setting up jenkins basic configuration like system_message , num executors , jenkins url
 - Creating a local user : admin
 - Creating two credentials with different types (string , usernamePassword) for SonarQube and Jira plugins
 - Setting up Jira and SonarQube Plugins
 - Setting up the home location of jdk, maven, git tools

----------
### Now We have a jenkins server with Pre-defind configuration
