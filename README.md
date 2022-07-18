# terraform-kata

This kata contains three blocks

## Scripting
The terraform/load_env.sh file contains a script to manipulate files created only for training purposes.
This script is replacing the terraform variable used as prefix to build the different resources. This is not really a good practice as this should be done creating different variables files. Having a single file with the prefix referring to the environment being manipulated by a script can be also extremely dangerous as we are not changing the terraform backend! For more details about the script take a look to the inline comments.

## Developing
In the load-environment-go/ folder there is a go program that have the similar training purposes that the shell script. This program is reading a file and chaning the word "dev" to "prod" or vicecersa based on the arguments passed. I must say that this application should have it's own repository and definitively should be cloned in the $GOPATH/src folder.
