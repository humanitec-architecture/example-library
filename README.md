# Humanitec example library

This repository contains a curated set of example files covering a range of entities for working with the [Humanitec Platform Orchestrator](https://developer.humanitec.com/platform-orchestrator/overview/).

Examples are grouped by entity type, e.g. "Resource Definition", or topic, e.g. "resource graph patterns". Refer to the READMEs inside the individual folders for details regarding that topic.

# Usage

It is recommended that you fully review any code before you apply it to ensure you understand its impact on your environment. Humanitec does not take responsibility for any costs incurred or damage caused when using these examples.

# Contributing

We appreciate your contributions!

## Creating pull requests

- Please fork this repo and submit a pull request to contribute new content or changes
- Perform one logical change per pull request
- Maintain a clean list of commits and squash them if necessary

## Example usage in downstream sites

All examples except the `resource-graph-patterns` are regularly transferred for display in the [Example Library](https://developer.humanitec.com/examples/) site for greater community reach.

The Humanitec documentation team might choose to integrate selected examples into content pages of the [Humanitec developer docs](https://developer.humanitec.com/) to help illustrate specific concepts.

By submitting a pull request, you agree to these types of use.

The `main` branch is always used as the source.

## Organize content

Organize content using directories. Follow the directory structure of existing examples for correct processing in [downstream sites](#example-usage-in-downstream-sites).

## Content guidelines

The goal of the example library is to **explain how** to achieve a goal, rather than provide a plethora of sample files for all possible variations. Examples should enable users to **understand and adapt**, rather than being ready to **copy and paste**.

Keep examples **simple** and feel free to **omit** parts not needed to drive the point home. Indicate what you left out, and focus on the relevant items.

Where applicable, favor [`humctl` CLI](https://developer.humanitec.com/platform-orchestrator/cli/) YAML over all other formats. The CLI is the universal language of Humanitec platform orchestration, and also the most concise and easiest to read. Feel free to provide additional formats such as Terraform.

## No configuration required

There is no configuration or mandatory metadata required when adding content. Follow the conventions described in the [content organization rules](#organize-content) to structure your files.

You may optionally assign "`features`" to an example which will become selectable in the [Example Library](https://developer.humanitec.com/examples) site. Add a metadata section to the example's `README.md` right at the top like this:

```yaml
---
features:
  - workload-identity
  - some-other-feature
---

... regular README content
```

Allowable characters for a feature name are lowercase letters, digits, dash ("-"), and space (" "), where the latter two will be considered equal (`workload-identity` = `workload identity`).

## Displaying examples in the developer docs

When the Humanitec documentation team integrates examples into content pages, these patterns apply:

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
- List some or all example files and explain any details you consider relevant. Refer to files by their filename, e.g. `somefile.yaml`, so that readers can easily locate them.
- Refer to "_this section_" or "_this examples collection_" as opposed to "_this repo_". Remember that the content will be rendered into the developer docs and not be part of a repo in this context.
- Explain complex code examples by
  - Adding inline comments
  - Showing small code snippets as inline code blocks in the README, and explaning them there
  - All of the above

## Displaying examples on developer docs pages

Some contents of this repo are selectively integrated into the Humanitec developer docs pages on [developer.humanitec.com](https://developer.humanitec.com).

There are two ways of integrating content:

1. **A particular folder** (and all of its subfolders) is integrated **at a particular position inside a particular page** of the docs.
    - All folder content is recursively displayed on that page, with subfolders becoming section headers. See the [content organization rules](#organize-content) below for details.
    - If you add content underneath a folder that's already integrated into the docs, or modify content in that folder, then those changes when merged into `main` will be reflected in the developer docs in their next build.
2. **An individual example file** is integrated **at a particular position inside a particular page** of the docs.

Individual parts of this library can therefore be displayed on different pages throughout the developer docs. It's also possible to display examples more than once, or to display just a specific subset (subfolder) as part of a page to help illustrate a point.
