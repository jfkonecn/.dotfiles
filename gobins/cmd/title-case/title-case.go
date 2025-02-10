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

	// Check if there is data from standard input
	info, err := os.Stdin.Stat()
	if err != nil {
		fmt.Fprintln(os.Stderr, "Error accessing standard input:", err)
		os.Exit(1)
	}

	if info.Mode()&os.ModeCharDevice != 0 && len(os.Args) > 1 {
		// No data in stdin, read from the first argument
		fmt.Println(c.String(os.Args[1]))
	} else {
		// Process data from stdin
		for scanner.Scan() {
			line := scanner.Text()
			fmt.Println(c.String(line))
		}

		if err := scanner.Err(); err != nil {
			fmt.Fprintln(os.Stderr, "Error reading standard input:", err)
			os.Exit(1)
		}
	}
}
