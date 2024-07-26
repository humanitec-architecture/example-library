// This script recursively generates the Terraform variants of YAML Resource Definitions
// using the jq helper script.
// Usage:
// node <./path/to/this/script.js> <resource-definitions-directory>
// e.g.
// node ./tools/generate-terraform.js resource-definitions

const fs = require('fs');
const path = require('path');
const sourceFolder = process.argv[2];
const { exec } = require("child_process");

async function generateTfFiles(directory) {
  const files = fs.readdirSync(directory);
  
  for (const file of files) {
    const filePath = path.join(directory, file);
    const stats = fs.statSync(filePath);
    
    if (stats.isDirectory()) {
      generateTfFiles(filePath); // Search recursively in subdirs
    } else if (path.extname(file) === '.yaml') {
      console.log(`Found YAML source   : ${filePath}`);
      const newFilePath = path.join(directory, path.parse(file).name + ".tf");
      console.log(`Creating TF variant : ${newFilePath}`);

      // Call the helper script to generate the TF version of the YAML
      exec(`cat ${filePath} | yq -o json | jq -r -f ./tools/def-json-hcl.jq > ${newFilePath}`, (error, stdout, stderr) => {
        if (error) {
          console.error(`exec error: ${error}`);
          return;
        }
      });
      
    }
  }
}

generateTfFiles(sourceFolder);