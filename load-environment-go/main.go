package main

import (
	"io/ioutil"
	"os"
	"strings"
)

const PROD = "prod"
const DEV = "dev"

/*
This programs takes as argument a file and a string representing an environment. With this arguments, the program will
read the content of the file and change the current value representing the environment for the one passed from the arguments.
The possible values of the environment are "prod" and "dev" to avoid using regular expressions to get the current
value on the file.
*/
func main() {

	// Check for the minimum number of arguments
	if len(os.Args) < 3 {
		panic("Define filePath and environment")
	}
	// Set variables for the arguments
	filePath := os.Args[1]
	environment := os.Args[2]

	if environment != PROD && environment != DEV {
		panic("Invalid environment")
	}

	// Get content from file
	sourceContent, err := readFile(filePath)
	if err != nil {
		panic("Error reading file:" + err.Error())
	}

	// Replace the environment for the one specified in the arguments
	destContent := changeEnvironment(sourceContent, environment)

	// Write the file with the replaced content
	err = writeFile(filePath, destContent)
	if err != nil {
		panic("Error writting file:" + err.Error())
	}
}

// changeEnvironment replaces the unchosen environment for the desired one.
// As there are only two possible values we used an if / else. More complex scenarios will require
// regular expressions to read the exact value.
func changeEnvironment(sourceContent string, environment string) string {
	if environment == PROD {
		return strings.Replace(sourceContent, "\""+DEV+"\"", "\""+PROD+"\"", 1)
	} else {
		return strings.Replace(sourceContent, "\""+PROD+"\"", "\""+DEV+"\"", 1)
	}
}

// readFile get the content of the file as a string.
func readFile(filePath string) (string, error) {
	bytes, err := ioutil.ReadFile(filePath)
	return string(bytes), err
}

// writeFile get the content to write in the files as a string and write it's bytes on the file
func writeFile(filePath string, content string) error {
	//path, err := os.Getwd()
	//if err != nil {
	//	return err
	//}
	return ioutil.WriteFile(filePath, []byte(content), 0666) //set default permissions
}
