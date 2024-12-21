package main

import (
	"bufio"
	"fmt"
	"os"
	"strings"
)

// WrapText wraps the given text to the specified width.
func WrapText(text string, width int) string {
	var wrapped strings.Builder
	words := strings.Fields(text)
	lineLen := 0

	for i, word := range words {
		wordLen := len(word)
		if lineLen+wordLen > width {
			wrapped.WriteString("\n")
			lineLen = 0
		} else if i > 0 {
			wrapped.WriteString(" ")
			lineLen++
		}
		wrapped.WriteString(word)
		lineLen += wordLen
	}

	return wrapped.String()
}

func readInput() (string, error) {
	info, err := os.Stdin.Stat()
	if err != nil {
		return "", fmt.Errorf("error accessing standard input: %v", err)
	}

	if info.Mode()&os.ModeCharDevice != 0 && len(os.Args) > 1 {
		// No data in stdin, read from the first argument
		return os.Args[1], nil
	}

	// Read from standard input
	var input strings.Builder
	scanner := bufio.NewScanner(os.Stdin)
	for scanner.Scan() {
		input.WriteString(scanner.Text())
		input.WriteRune('\n')
	}
	if err := scanner.Err(); err != nil {
		return "", fmt.Errorf("error reading standard input: %v", err)
	}

	return input.String(), nil
}

func main() {
	const wrapWidth = 80

	input, err := readInput()
	if err != nil {
		fmt.Fprintln(os.Stderr, err)
		os.Exit(1)
	}

	// Wrap the text to the specified width
	output := WrapText(input, wrapWidth)
	fmt.Println(output)
}
