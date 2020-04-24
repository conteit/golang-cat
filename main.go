package main

import (
	"fmt"
	"io/ioutil"
	"os"
	"path/filepath"
	"strings"
)

func main() {
	fmt.Println(string(readFileContent()))
}

func readFileContent() []byte {
	name := getFileName()

	content, err := ioutil.ReadFile(name)
	if err != nil {
		os.Exit(2)
	}
	return content
}

func getFileName() string {
	args := os.Args
	name := autoDetermineFileToPrintOut(args)
	if len(args) > 1 {
		name = args[1]
	}
	return name
}

func autoDetermineFileToPrintOut(args []string) string {
	name := args[0]
	if index := strings.LastIndex(name, filepath.Ext(name)); index >= 0 {
		name = name[0:index] + ".txt"
	} else {
		os.Exit(1)
	}
	return name
}
