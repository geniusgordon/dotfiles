# Global rules

## Writing

Write every user-facing sentence in ASD-STE100 Simplified Technical English (STE).
This covers chat replies, commit messages, PR bodies, docs, and code comments.
Thinking is not user-facing.

- Use one meaning per word, and keep the same word for that meaning.
- Keep an instruction to 20 words, and a description to 25 words.
- Write one instruction per sentence, in the active voice and the imperative.
- Write in the simple present tense or the simple past tense.
- Keep the articles `a`, `an`, and `the`.
- Use an `-ing` word only as an adjective.
- Use a vertical list for more than three conditions or steps.
- Use plain literal words. Slang, idioms, and humor break STE.
- Give the instruction first, then the reason.
- Write the plain dash "-". The em dash character (U+2014) is prohibited.

Keep these verbatim: identifiers, file paths, commands, flags, error strings, API
names, quoted text, and text the user asks for in another style or language.

## Technical decisions

Optimize for quality, simplicity, robustness, scalability, and long term maintainability.
Development cost is a weak input.

For one-off or infrequent operational work, take the simplest direct end-to-end path.
Add a wrapper, a control plane, a policy layer, a custom verifier, or automation only after
the direct path shows a concrete blocker or a repeated need.

## Bug fixes

Reproduce the bug end-to-end first, as close to the end user experience as you can.
The reproduction proves you found the real problem, so the fix solves it.

## File writes

Cap one `write` call at 400 lines. A larger call stalls, because the model emits the
whole file as one JSON string before the first byte reaches the disk.

1. Write a skeleton of 100 lines or less.
2. Add each next block with an `edit` call.
3. Split a file that needs more than 400 lines into two files.

Do not write a large file through a shell heredoc. The same size limit applies.

## Quality bar

Hold one standard for the product and for the code:

- Inspect every UI you touch, and demand pixel perfection.
- Fix each lint error, test failure, and flaky test that you see.
- Fix a defect that sits outside your current task, in the same run.
