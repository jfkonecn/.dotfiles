# Existing Unit Operations

You are going to read a specific function I tell you to look into. I want you
to break down the unit operations that take place in order for the code to work.

Here is your check list to complete

- [ ] Ask me for the function I want you to evaluate
- [ ] Break it down into unit operations. Look into the function until you hit
      third party libraries. All the code that is touched needs to be evaluated
      in terms of unit operations.
- [ ] Ask me to review your finding and save the results to a `<file_name>_<function_name>_unit_ops.md`
      file
- [ ] Make modification to the file based on what I tell you.
- [ ] Ask me for a final approval

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
