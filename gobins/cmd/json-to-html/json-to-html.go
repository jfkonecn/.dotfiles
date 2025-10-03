package main

import (
	"encoding/json"
	"flag"
	"fmt"
	"io/ioutil"
	"os"
	"strings"
)

const resetCSS = `html,body,div,span,applet,object,iframe,
h1,h2,h3,h4,h5,h6,p,blockquote,pre,
a,abbr,acronym,address,big,cite,code,
del,dfn,em,img,ins,kbd,q,s,samp,
small,strike,strong,sub,sup,tt,var,
b,u,i,center,
dl,dt,dd,ol,ul,li,
fieldset,form,label,legend,
table,caption,tbody,tfoot,thead,tr,th,td,
article,aside,canvas,details,embed,
figure,figcaption,footer,header,hgroup,
menu,nav,output,ruby,section,summary,
time,mark,audio,video {
  margin: 0;
  padding: 0;
  border: 0;
  font-size: 100%;
  font: inherit;
  vertical-align: baseline;
}
article,aside,details,figcaption,figure,
footer,header,hgroup,menu,nav,section {
  display: block;
}
body {
  line-height: 1;
  background: #f9f9f9;
  color: #222;
  font-family: system-ui, sans-serif;
  padding: 2em;
}
ol,ul {
  list-style: none;
}
table {
  border-collapse: collapse;
  border-spacing: 0;
}
/* Custom styles */
.json-container {
  max-width: 700px;
  margin: 2em auto;
  background: #fff;
  border-radius: 8px;
  box-shadow: 0 2px 8px rgba(0,0,0,0.07);
  padding: 2em;
}
.json-key {
  font-weight: bold;
  color: #005cc5;
}
.json-value {
  color: #333;
  margin-left: 1em;
}
.json-pair {
  margin-bottom: 1em;
  display: flex;
}
`

func main() {
	inputFile := flag.String("f", "", "Path to JSON file (optional, otherwise reads from stdin)")
	flag.Parse()

	var data []byte
	var err error

	if *inputFile != "" {
		data, err = ioutil.ReadFile(*inputFile)
		if err != nil {
			fmt.Fprintf(os.Stderr, "Error reading file: %v\n", err)
			os.Exit(1)
		}
	} else {
		info, _ := os.Stdin.Stat()
		if info.Mode()&os.ModeCharDevice == 0 {
			// Data is being piped in
			data, err = ioutil.ReadAll(os.Stdin)
			if err != nil {
				fmt.Fprintf(os.Stderr, "Error reading stdin: %v\n", err)
				os.Exit(1)
			}
		} else if flag.NArg() > 0 {
			data = []byte(flag.Arg(0))
		} else {
			fmt.Fprintln(os.Stderr, "No input provided. Use -f <file>, pipe JSON to stdin, or pass as argument.")
			os.Exit(1)
		}
	}

	var jsonObj interface{}
	if err := json.Unmarshal(data, &jsonObj); err != nil {
		fmt.Fprintf(os.Stderr, "Invalid JSON: %v\n", err)
		os.Exit(1)
	}

	html := buildHTML(jsonObj)
	fmt.Println(html)
}

func buildHTML(obj interface{}) string {
	var b strings.Builder
	b.WriteString("<!DOCTYPE html>\n<html lang=\"en\">\n<head>\n<meta charset=\"UTF-8\">\n<meta name=\"viewport\" content=\"width=device-width,initial-scale=1\">\n<title>JSON to HTML</title>\n<style>\n")
	b.WriteString(resetCSS)
	b.WriteString("\n</style>\n</head>\n<body>\n<div class=\"json-container\">\n")
	writeJSON(&b, obj, 0)
	b.WriteString("</div>\n</body>\n</html>")
	return b.String()
}

func writeJSON(b *strings.Builder, obj interface{}, indent int) {
	switch v := obj.(type) {
	case map[string]interface{}:
		for key, val := range v {
			b.WriteString("<div class=\"json-pair\">")
			b.WriteString("<span class=\"json-key\">" + htmlEscape(key) + ":</span>")
			b.WriteString("<span class=\"json-value\">")
			writeJSON(b, val, indent+1)
			b.WriteString("</span></div>\n")
		}
	case []interface{}:
		b.WriteString("[")
		for i, item := range v {
			if i > 0 {
				b.WriteString(", ")
			}
			writeJSON(b, item, indent+1)
		}
		b.WriteString("]")
	case string:
		b.WriteString(htmlEscape(v))
	case float64, bool, nil:
		b.WriteString(fmt.Sprintf("%v", v))
	default:
		b.WriteString(fmt.Sprintf("%v", v))
	}
}

func htmlEscape(s string) string {
	replacer := strings.NewReplacer(
		"&", "&amp;",
		"<", "&lt;",
		">", "&gt;",
		"\"", "&quot;",
		"'", "&#39;",
	)
	return replacer.Replace(s)
}
