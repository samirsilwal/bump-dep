# bump-dep
A GitHub Action that updates node dependencies with given params in a monorepo with microservices 


## Usage

Add the following in your workflow file

```

- name: Bump package json
  uses: samirsilwal/bump-dev@v1.0.0
  with:
    monorepo-root: './src'
    name: 'chalk'
    version: 5.1.0
    token: ${{ secrets.GITHUB_TOKEN }}
    create-pr: "true"
    base-branch: main
```
