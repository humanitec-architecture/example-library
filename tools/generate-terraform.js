// This script recursively generates the Terraform variants of YAML Resource Definitions
// using the jq helper script.
// Usage:
// node <./path/to/this/script.js> <resource-definitions-directory>
// e.g.
// node ./tools/generate-terraform.js resource-definitions

const fs = require("fs");
const path = require("path");
const sourceFolder = process.argv[2];
const { exec } = require("child_process");

async function generateTfFiles(directory) {
  const files = fs.readdirSync(directory);

  for (const file of files) {
    const filePath = path.join(directory, file);
    const stats = fs.statSync(filePath);

    if (stats.isDirectory()) {
      generateTfFiles(filePath); // Search recursively in subdirs
    } else if (path.extname(file) === ".yaml") {
      if (isResourceDefinition(filePath)) {
        console.log(`Found YAML source   : ${filePath}`);
        const newFilePath = path.join(directory, path.parse(file).name + ".tf");
        console.log(`Creating TF variant : ${newFilePath}`);
        await convertYamlToTerraform(filePath, newFilePath);
      }
    }
  }
}

function isResourceDefinition(filePath) {
  const content = fs.readFileSync(filePath, "utf8");
  return content.includes("kind: Definition");
}

function convertYamlToTerraform(inputPath, outputPath) {
  return new Promise((resolve, reject) => {
    exec(
      `cat ${inputPath} | yq -o json | jq -r -f ./tools/def-json-hcl.jq > ${outputPath}`,
      (error, stdout, stderr) => {
        if (error) {
          console.error(`exec error: ${error}`);
          reject(error);
        } else {
          resolve();
        }
      }
    );
  });
}

generateTfFiles(sourceFolder);
