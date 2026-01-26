const esbuild = require("esbuild");
const fs = require("fs");
const path = require("path");

const srcDir = path.join(__dirname, "src");
const outDir = path.join(__dirname, "..", "stow", ".local", "bin");

// Get all .js files in src/
const scripts = fs
  .readdirSync(srcDir)
  .filter((file) => file.endsWith(".js"))
  .map((file) => file.replace(".js", ""));

async function build() {
  for (const script of scripts) {
    const entryPoint = path.join(srcDir, `${script}.js`);
    const outFile = path.join(outDir, script);

    console.log(`Bundling ${script}...`);

    await esbuild.build({
      entryPoints: [entryPoint],
      bundle: true,
      platform: "node",
      target: "node18",
      outfile: outFile,
      banner: {
        js: "#!/usr/bin/env node",
      },
      minify: false, // Keep readable for debugging
    });

    // Make executable
    fs.chmodSync(outFile, 0o755);
    console.log(`  -> ${outFile}`);
  }

  console.log("Done!");
}

build().catch((err) => {
  console.error(err);
  process.exit(1);
});
