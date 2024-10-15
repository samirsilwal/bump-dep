# Bump Dependencies GitHub Action

This GitHub Action allows you to easily bump the version of a package in your JavaScript/TypeScript monorepo. It automates the process of updating the package version, creating a commit, and opening a pull request to merge the changes.

## Features

- Automatically bumps the version of a specified package in your monorepo.
- Creates a pull request with the changes.
- Allows customization of the base branch to create the pull request against.

## Inputs

| Name            | Description                                       | Required | Default                      |
|-----------------|---------------------------------------------------|----------|-----------------------------|
| `monorepo-root` | The root directory of the monorepo.               | `true`   |                             |
| `name`          | The name of the package to bump.                  | `true`   |                             |
| `version`       | The version to bump to.                           | `false`  | `1.0.0`                     |
| `token`         | GITHUB_TOKEN or a repo-scoped PAT.                | `false`  | `${{ github.token }}`       |
| `create-pr`     | Whether to create a pull request (`true`/`false`).| `false`  | `true`                      |
| `base-branch`   | The base branch to create the PR against.         | `false`  | `main`                      |

## Usage

Add the following in your workflow file

```

- name: Bump package json
  uses: samirsilwal/bump-dep@v1.0.0
  with:
    monorepo-root: './src'
    name: 'chalk'
    version: 5.1.0
    token: ${{ secrets.GITHUB_TOKEN }}
    create-pr: "true"
    base-branch: main
```

## Example Usage

Here is an example of how to use this action in your workflow file:

```yaml
name: Bump Dependencies

on:
  workflow_dispatch:
    inputs:
      monorepo-root:
        description: 'Root directory of the monorepo'
        required: true
        default: 'packages/my-package'
      name:
        description: 'Name of the package to bump'
        required: true
        default: 'my-package'
      version:
        description: 'Version to bump to'
        required: false
        default: '2.1.0'

jobs:
  bump:
    runs-on: ubuntu-latest
    steps:
      - name: Bump package version
        uses: samirsilwal/bump-dependencies-action@v1
        with:
          monorepo-root: ${{ github.event.inputs.monorepo-root }}
          name: ${{ github.event.inputs.name }}
          version: ${{ github.event.inputs.version }}
          token: ${{ secrets.GITHUB_TOKEN }}
          create-pr: true
          base-branch: 'main'
```
