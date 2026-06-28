---
name: unit-operations
description: ONLY USE THIS SKILL IF THE USER TELLS YOU TO. Make scoped changes to an existing codebase through a required six-phase workflow.
---

# Change Codebase

Use this skill to make changes to an existing codebase through explicit phase gates. Stop after each phase and wait for the user to approve, edit, reject, or send the work back to an earlier phase.

Preserve unrelated user work. Before editing, inspect the worktree and relevant files. Keep changes scoped to the approved phase and do not perform opportunistic refactors.

## Unit Operations

Use only these unit operations when decomposing the requested change:

- `Map`: Convert one piece of data to another.
- `Filter`: Remove data.
- `Sort`: Order data.
- `Distribution`: Determine where data should go, such as load balancing or switch/branch routing.
- `Validate`: Check data integrity. This normally results in mapping data to a new type, such as parsing.
- `Authenticate`: Determine the identity of the person or software triggering a data flow.
- `Authorize`: Determine whether an identified person or software may trigger a data flow.
- `Global state read/write`: Read or write data scoped beyond the call stack, including mathematical constants, message constants, or ambient globals such as browser `document`.
- `I/O`: Communicate outside the program, including network, database, console input/output, caching, or logging.
- `Panic`: Kill or terminate the program.

## Phase Workflow

### Phase 1: Determine Unit Operations

Determine the ordered series of unit operations needed to implement the requested change.

Include for each step:

- Step number.
- Unit operation.
- Brief description of the data flow or behavior.
- Existing code areas that appear relevant, if already known.
- Open questions or assumptions.

Stop after Phase 1 and ask the user to approve, edit, or reject the operation sequence.

### Phase 2: Search and Add Notes

After the user approves Phase 1, search the existing codebase for methods/functions and types/structs/classes that could be reused or modified for each approved operation.

Add editable source-code comments near the relevant existing code. Use this exact prefix:

```text
Phase 2 Note: <step-number> <unit-operation> <description of operation>
```

Immediately after the note, add a concise comment explaining what modification is needed, if any. If the existing code can be used without changes, say so in the modification comment.

Example:

```text
Phase 2 Note: 3 Validate parse incoming account payload
Modification needed: extend this parser to reject missing account IDs before mapping to AccountId.
```

Keep Phase 2 notes in source files so the user can modify or delete them in context. Do not implement the modification during Phase 2.

Stop after Phase 2 and tell the user to review, edit, or delete the notes before approving the next phase.

### Phase 3: Stub Functions and Modify Types

After the user approves Phase 2 notes, make the modifications for existing classes/types and stub out new functions that need to be made.

Keep stubs minimal:

- Add signatures, types, and placeholders needed for the planned flow.
- Prefer local conventions for TODOs, unimplemented markers, or explicit placeholder failures.
- Do not complete business logic unless the user explicitly asks to merge Phase 3 and Phase 5.

Stop after Phase 3 and summarize what was stubbed or structurally changed.

### Phase 4: Stub Tests

Start by determining how the code should be tested. Infer from the repo by inspecting existing tests, package scripts, CI config, naming conventions, and nearby test patterns.

Then stub focused unit tests for the approved change. Meaningful failing tests are acceptable before implementation. Add any new classes/types that are needed by the tests and were not already created in Phase 3.

Do not create broad integration or full coverage scaffolding unless the repo conventions or user request require it.

Stop after Phase 4 and summarize:

- Test framework and command inferred from the repo.
- Test files or cases stubbed.
- Any expected failures before implementation.

### Phase 5: Implement Changes

Implement the approved change using the Phase 2 notes, Phase 3 stubs, and Phase 4 tests.

If you must create new functions or types not already approved, or if you must deviate from the approved phase plan in any way, record the deviation in:

```text
reports/codebase-change-report.md
```

Create the report directory and file if needed. Include:

- What changed from the approved plan.
- Why the deviation was necessary.
- Which files were affected.
- Whether the user should review or approve the deviation.

Notify the user whenever the report is created or updated.

Stop after Phase 5 and summarize implementation status, tests run, failures, and report entries.

### Phase 6: Final Review

Perform a final review against the requested change and the approved phase artifacts.

Include:

- Whether the implementation matches the approved unit operations and Phase 2 notes.
- Tests run and results.
- Remaining risks, TODOs, or known failures.
- Any deviations recorded in `reports/codebase-change-report.md`.

Ask the user whether they approve the final changes. If the user does not approve, ask what needs to change and support returning to the appropriate earlier phase to correct flawed assumptions.
