package main

import (
    "os"
    "io/ioutil"
    "./Assembler"
)

func main() {
    b, ferr := ioutil.ReadFile(os.Args[1]) // just pass the file name
    if ferr != nil {
        panic(ferr)
    }

    ins := string(b)

	code, err := assembler.Assemble(ins)
	if err != 0 {
        panic(err)
	}

    ferr = ioutil.WriteFile("imem.txt", []byte(*code), 0644)
    if ferr != nil {
        panic(ferr)
    }
}
