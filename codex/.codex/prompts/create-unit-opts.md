# Create Unit Operations

Before we start writing any lines of code. We are going to break down the
approach into a series of "unit operations" in order to solve the problem.

Below you will find the unit operation types the unit operations are available.
Please suggest new ones if necessary, but do your best to stick to those.

Here is your check list to complete

- [ ] Ask me the data pipeline we want to complete
- [ ] Break it down into unit operations by recursively traversing every
      in-repository function call (direct and indirect) from the pipeline entry
      points. Continue until each path either:
      - reaches a third-party/external library or framework call, or
      - terminates with no further function calls.
      Ask me to confirm or modify your breakdown.
- [ ] Create a Mermaid diagram that shows the unit operation flow and ask me to confirm or modify
- [ ] Investigate the existing code base to see if there is existing logic that can
      be leveraged
- [ ] Create a final code plan and ask me to confirm or modify the plan
- [ ] For each unit operation, tell me what you are able to do.
      Write the code for that unit operation along with tests to confirm
      the unit operations work correctly.
      Mock out I/O calls for unit tests
- [ ] Test to make sure the code works

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
