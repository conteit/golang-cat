package main

import (
	"flag"
	"fmt"
	"io/ioutil"
	"os"
	"path/filepath"
	"strings"
)

func main() {
	fmt.Println(string(readFileContent()))
	os.Exit(0)
}

func readFileContent() []byte {
	name := getFileName()

	content, err := ioutil.ReadFile(name)
	if err != nil {
		os.Exit(3)
	}
	return content
}

func getFileName() string {
	name := flag.String("f", "", "provide the name of the file to print out")
	flag.Parse()

	if *name == "" {
		name = autoDetermineFileToPrintOut()
	}
	return *name
}

func autoDetermineFileToPrintOut() *string {
	name := os.Args[0]
	if index := strings.LastIndex(name, filepath.Ext(name)); index >= 0 {
		name = name[0:index] + ".txt"
	} else {
		os.Exit(1)
	}
	return &name
}
