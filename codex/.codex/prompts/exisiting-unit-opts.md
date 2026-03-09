# Existing Unit Operations

You are going to read a specific function I tell you to look into. I want you
to break down the unit operations that take place in order for the code to work.

Here is your check list to complete

- [ ] Ask me for the function I want you to evaluate
- [ ] Break it down into unit operations by recursively traversing every
      in-repository function call (direct and indirect) from the starting
      function. Continue until each path either:
      - reaches a third-party/external library or framework call, or
      - terminates with no further function calls.
      All in-repository code touched in this traversal must be evaluated in
      terms of unit operations.
- [ ] Create a Mermaid diagram that shows the unit operation flow.
- [ ] Ask me to review your finding and save the results to a `<file_name>_<function_name>_unit_ops.md`
      file
- [ ] Make modification to the file based on what I tell you.
- [ ] Ask me for a final approval

## Output format

- Include:
  1. A Mermaid `flowchart LR` diagram that represents the unit operation flow.
  2. A clear note of traversal boundaries (where analysis stopped because calls
     crossed into third-party/external code, or where the call path ended).

## Mermaid diagram rules

- Use Mermaid shape conventions exactly as follows:
  1. Method/function call nodes: Stadium shape.
  2. `Distribution` unit operations: Diamond shape.
  3. All other unit operation types: Rectangle shape.
- Method/function call nodes must not include a unit operation label.
- Every unit operation (non-function-call) must be represented as a labeled node
  in the Mermaid diagram.
- Every unit operation node label must include:
  1. The operation description.
  2. The unit operation type.

## Mermaid syntax safety rules

- Use one node declaration per line in the form `ID["Label"]`,
  `ID(["Label"])`, or `ID{"Label"}`.
- For method/function call nodes, do not add a unit operation label or type in
  the node text.
- Do not put unit operation types in parentheses inside labels. Use
  `Description - Type` (example: `Parse request - Validate`).
- Keep labels plain text. Avoid brackets `[]`, braces `{}`, and parentheses `()`
  inside label text.
- Add edges on separate lines using `-->` and keep edge labels simple
  (`|Yes|`, `|No|`).

## Unit Operation Types

### Map

Convert one piece of data to another

Does not return errors

### Filter

Remove Data

Must Be Able to Return Errors?

No

### Sort

Order Data

Can Return Errors?

No

### Distribution

Determine where data should go (e.g. Load Balancer or a switch statement)

Must Be Able to Return Errors?

No

### Validate

Check the integrity of the data. This normally will result in mapping of the
data to a new type. (e.g. parsing)

Must Be Able to Return Errors?

Yes

### Authenticate

Determine identity of the person/software triggering a data flow

Must Be Able to Return Errors?

Yes

### Authorize

Determine if an identified person/software is allowed to trigger a data flow

Must Be Able to Return Errors?

Yes

### Global state read/write

Read/write data to memory that is scoped beyond the call stack

Examples:

- Mathematical constants such as PI
- String message constants
- The document variable available to javascript in a web browser

Must Be Able to Return Errors?

No

### I/O

Any communication outside of your program

Examples:

- Network, database, console input/output, etc
- Caching
- Logging

Must Be Able to Return Errors?

Yes

### Panic

Kill the program

Must Be Able to Return Errors?

No

## Example Breakdown of unit operations

1. Ask the user what location they want data for (I/O)
2. Validate location input (Validate)
3. Make a GET request to the API endpoint (I/O)
4. Parse the JSON in the response (Validate)
5. Convert the parsed JSON data into a string (Map)
6. Print the string to the console (I/O)
