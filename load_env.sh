#!/usr/bin/bash

# The following script performs the bad practice of replace the sufix variable on the
# variables/variables.tfvars file only for training purposes; by this way we will change this
# variable that is used as sufix to build the terraform resources and to specify the terraform state.

# Set global variables and program arguments.
BIN_PATH="/usr/bin/"
VARIABLES_PATH="./variables/variables.tfvars"
ENV=$1

# get_current_env function returns the current value of the sufix variable using the commands grep + awk + sed.
# Note that we need to specify the path of the binaries for the commands as the path is not loaded.
get_current_env() {
	env=$( ${BIN_PATH}cat ${VARIABLES_PATH} | ${BIN_PATH}grep sufix | ${BIN_PATH}awk '{print $3}' | ${BIN_PATH}sed s/\"//g)
	echo $env
}

# change_current_env function performs a sed with the -i parameter to manipulate the desired file
# changing the current value for the desired one passed from the program arguments.
# Match as many content as possible inside the sed command to avoid changing undesired lanes!
change_current_env(){
	$(${BIN_PATH}sed -i "s/sufix = \"${current_env}\"/sufix = \"${ENV}\"/g" ${VARIABLES_PATH})
}

#
#	MAIN
#

# Perform program validations and error handling.
[ -z "$ENV" ] && echo "Add param with desired env!" && exit 1

current_env=$(get_current_env)
if [ "$current_env" = "$ENV" ]; then			# If the value is equal to the one we are trying to update do nothing
	echo "Environment already set to ${ENV}"
else											# If not, change the value
	echo "Changing environment to ${ENV}"
	change_current_env
	echo "Changed environment"
fi