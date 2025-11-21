# Create Unit Operations

Before we start writing any lines of code. We are going to break down the
approach into a series of "unit operations" in order to solve the problem.

Below you will find the unit operation types the unit operations are available.
Please suggest new ones if necessary, but do your best to stick to those.

Here is your check list to complete

- [ ] Ask me the data pipeline we want to complete
- [ ] Break it down into unit operations and ask me to confirm or modify
- [ ] Investigate the existing code base to see if there is existing logic that can
      be leveraged
- [ ] Create a final code plan and ask me to confirm or modify the plan
- [ ] For each unit operation, tell me what you are able to do.
      Write the code for that unit operation along with tests to confirm
      the unit operations work correctly.
      Mock out I/O calls for unit tests
- [ ] Test to make sure the code works

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
