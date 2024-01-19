# Humanitec example library

This repository contains a curated set of example files covering a range of entities for working with the [Humanitec Platform Orchestrator](https://humanitec.com/products/platform-orchestrator).

Examples are grouped by entity type, e.g. "Resource Definition", or topic, e.g. "resource graph patterns". Refer to the READMEs inside the individual folders for details regarding that topic.

# Contributing

## Content guidelines

The goal of the example library is to **explain** how to achieve a goal, rather than provide a plethora of sample files for all possible variations. Examples should enable users to **understand and adapt**, rather than being ready for **copy and paste**.

Keep examples **simple** and feel free to **omit** parts not needed to drive the point home. Indicate what you left out, and focus on the relevant items.

Where applicable, favor [`humctl` CLI](https://developer.humanitec.com/platform-orchestrator/cli/) YAML over all other formats. The CLI is the universal language of Humanitec platform orchestration, and also the most concise and easiest to read. Feel free to provide additional formats, such as Terraform, as well.

## No configuration required

There is no configuration or metadata required when adding content. Follow the conventions described in the [content organization rules](#organize-content) to help structure your files.

## Creating pull requests

- Perform one logical change per pull request.
- Maintain a clean list of commits, squash them if necessary.

## Organize content

The repository contents are transformed and displayed on regular pages in the Humanitec developer docs on [developer.humanitec.com](https://developer.humanitec.com). See [displaying examples](#displaying-examples-in-the-developer-docs) for details.

Contributing content does not require defining any metadata or other configuration. Please be aware of these transformation rules for best results.

- Organize content using directories.
  - Directories become section headings in the target page.
  - Each section name is derived from the directory name by replacing "-" and "_" with spaces and capitalizing the first character. E.g. the directory `resource-definitions` will become a heading "Resource definitions".
  - Since directories will become headings, give them human-readble names (`resource-definitions` as opposed to `defs`).
- We support a maximum directory depth of **three** counting from the repository root.
- In each directory, you may optionally place a `README.md` (case sensitive) and any number of code files.
- A `README.md`, if present, is rendered first in a section, followed by the rendered code files in lexicographical order.
- The `README.md` content is modified as follows:
  - The level of all headings (`#`) is squashed to one level below the rendered section. This is necessary to maintain a clean TOC in the result.
  - All non-external links are removed. They only work inside the source repo and would be broken.
- Each rendered code block will show the source file name above it and a link to the original file on GitHub.
- The code block highlighting is based on the source file extension, e.g. `yaml`.

## README guidelines

- Add a `README.md` to a folder to provide explanations on its contents.
- List some or all example files and explain any details you consider relvant. Refer to files by their filename, e.g. `somefile.yaml`, so that readers can easily locate them.
- Refer to "_this section_" or "_this examples collection_" as opposed to "_this repo_". Remember that the content will be rendered into the developer docs and not be part of a repo in this context.
- Explain complex code examples by
  - adding inline comments
  - showing small code snippets as inline code blocks in the README, and explaning them there
  - all of the above.

# Displaying examples in the developer docs

The contents of this repo are selectively integrated into the Humanitec developer docs on [developer.humanitec.com](https://developer.humanitec.com). The `main` branch is used as the source.

There are two ways of integrating content:

1. **A particular folder** (and all of its subfolders) is integrated **at a particular position inside a particular page** of the docs.
    - All folder content is recursively displayed on that page, with subfolders becoming section headers. See the [content organization rules](#organize-content) below for details.
    - If you add content underneath folder that is already integrated into the docs, or modify content in that folder, then those changes - when merged into `main` - will be reflected in the developer docs in their next build.
2. **An individual example file** is integrated **at a particular position inside a particular page** of the docs.

Individual parts of this library can therefore be displayed on different pages throughout the developer docs. It is also possible to display examples more than once, or to display just a specific subset (subfolder) as part of a page to help illustrate a point.