# terraform-kata

This kata contains three blocks

## Scripting
The terraform/load_env.sh file contains a script to manipulate files created only for training purposes.
This script is replacing the terraform variable used as prefix to build the different resources. This is not really a good practice as this should be done creating different variables files. Having a single file with the prefix referring to the environment being manipulated by a script can be also extremely dangerous as we are not changing the terraform backend! For more details about the script take a look to the inline comments.

## Developing
In the load-environment-go/ folder there is a go program that have the similar training purposes that the shell script. This program is reading a file and changing the word "dev" to "prod" or vicecersa based on the arguments passed. I must say that this application should have it's own repository and definitively should be cloned in the $GOPATH/src folder.

## Terraform
The main purpose of this kata is creating a set of user-group-policy-role in terraform.
### Description
To realice this kata without an aws environment we used localstack. This will be reflected in the provider file with some extra configuration to be able to run the tflocal command instead of terraform talking with the local aws environment.
### Project structure
The structure proposed is the following:
#### Variables
The variables for this run are located in /terraform/variables/ci/variables.tfvars. This would represent to the ci stack; in case of wanting other stack we should create another folder with the same variables except "name" and the backend key and we will be able to create a second stack. The variables also should be split by environment but on this exercice is not done as we are sharing the same variable file beacause of the first exercice.
#### Resources
The resources, the provider, and the variables definitions are all inside the /terraform/project/.
All the resources are stored in the main.tf file, but could be splited in files or we could even create a module with some inputs to create user-group-policy-role stack
### Tests & utils
To test this terraform first we need to run localstack. In the /utils folder there is the localstack.sh that creates the localstack container in the local instance and exposes the ports to be able to use the local aws environment.
Once the localstack environment is ready we installed terraform-local that is a tool that configures the terraform routes to the localstack api instead of the aws ones. After this we will be able to run the tflocal commands equivalent to terraform in our local enviroment.
After create all the resources, we validated it creating an access key for the prod-ci-user and ran the aws sts assume-role against the prod-ci-role.
