# Terraform Modules 

This repository contains a custom module built on top of AWS Instance module to automate the deployment and configuration of Apache2 webserver on AWS EC2 instances.

## Introduction

Custom Modules simplifie the process of provisioning and managing resources

## Requirements

To use this module, you need to have the following prerequisites:

- An AWS account with appropriate permissions to create and manage EC2 instances.
- Terraform installed on your local machine.
- Basic knowledge of Terraform and AWS services.


## Usage

To use the AWS Instance Custom Module for Apache2 Webserver, follow these steps:

1. Fill the values of variables in .tfvars file according to your requirements. You can modify settings such as instance type, security groups, and more.

2. Run `terraform apply` to provision the EC2 instance and deploy your service with custom changes in module. 


## Contributing

Contributions are welcome! If you find any issues or want to enhance this module, please submit a pull request or open an issue in the GitHub repository.
