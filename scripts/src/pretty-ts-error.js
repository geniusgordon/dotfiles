const prettier = require("prettier/standalone");
const parserTypescript = require("prettier/plugins/typescript");
const parserEstree = require("prettier/plugins/estree");

const message = process.argv[2] || "";

async function formatCode(string) {
  return prettier.format(string, {
    parser: "typescript",
    plugins: [parserTypescript, parserEstree],
    printWidth: 60,
    singleAttributePerLine: false,
    arrowParens: "avoid",
    semi: false,
  });
}

const convertToValidType = (type) =>
  `type x = ${type
    // Add missing parentheses when the type ends with "...""
    .replace(/(.*)\.\.\.$/, (_, p1) => addMissingParentheses(p1))
    // Replace single parameter function destructuring because it's not a valid type
    // .replaceAll(/\((\{.*\})\:/g, (_, p1) => `(param: /* ${p1} */`)
    // Change `(...): return` which is invalid to `(...) => return`
    .replace(/^(\(.*\)): /, (_, p1) => `${p1} =>`)
    .replaceAll(/... (\d{0,}) more .../g, (_, p1) => `___${p1}MORE___`)
    .replaceAll(/... (\d{0,}) more ...;/g, (_, p1) => `___MORE___: ${p1};`)
    .replaceAll("...;", "___KEY___: ___THREE_DOTS___;")
    .replaceAll("...", "__THREE_DOTS__")};`;

const convertToOriginalType = (type) =>
  type
    .replaceAll("___KEY___: ___THREE_DOTS___", "...;")
    .replaceAll("__THREE_DOTS__", "...")
    .replaceAll(/___MORE___: (\d{0,});/g, (_, p1) => `... ${p1} more ...;`)
    .replaceAll(/___(\d{0,})MORE___/g, (_, p1) => `... ${p1} more ...`)
    .replaceAll(/... (\d{0,}) more .../g, (_, p1) => `/* ${p1} more */`) // ... x more ... not shown sell
    // .replaceAll(/\(param\: \/\* (\{ .* \}) \*\//g, (_, p1) => `(${p1}: `)
    .replace(/type x = /g, "")
    .trim();

async function main() {
  const regex = /'([^']*)'/g;
  const matches = [...message.replace(/.$/, "").matchAll(regex)];

  let result = message.replace(/.$/, "");
  for (const match of matches) {
    const type = match[1];
    try {
      const formatted = await formatCode(convertToValidType(type));
      const prettierType = convertToOriginalType(formatted);
      result = result.replace(match[0], `\n${prettierType}`);
    } catch (error) {
      result = result.replace(match[0], `\n${type}`);
    }
  }

  console.log(result);
}

main();
