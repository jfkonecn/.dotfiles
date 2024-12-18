package main

import (
	"bufio"
	"fmt"
	"os"

	"golang.org/x/text/cases"
	"golang.org/x/text/language"
)

func main() {
	scanner := bufio.NewScanner(os.Stdin)

	c := cases.Title(language.English)

	for scanner.Scan() {
		line := scanner.Text()
		fmt.Println(c.String(line))
	}

	if err := scanner.Err(); err != nil {
		fmt.Fprintln(os.Stderr, "Error reading standard input:", err)
		os.Exit(1)
	}
}
