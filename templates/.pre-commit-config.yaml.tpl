---
# NOTE: THIS IS A TEMPLATE, REMOVE THE COMMENTS AND KEEP THE BITS YOU WANT!

repos:

# GENERAL
  - repo: https://github.com/pre-commit/pre-commit-hooks
    rev: v4.6.0
    hooks:
      - id: check-case-conflict
      - id: check-json
      - id: detect-private-key
      - id: end-of-file-fixer
      - id: trailing-whitespace

# YAMLFIX
  - repo: https://github.com/lyz-code/yamlfix
    rev: 1.16.1
    hooks:
      - id: yamlfix
        entry: env YAMLFIX_WHITELINES=1 YAMLFIX_LINE_LENGTH=200 yamlfix

# JSONNET
  - repo: https://github.com/google/go-jsonnet
    rev: v0.20.0
    hooks:
      - id: jsonnet-format
        args: [-i, --string-style, s, -n, '2']

# DOCTOC
  - repo: https://github.com/thlorenz/doctoc
    rev: v2.2.0
    hooks:
      - id: doctoc
        # NOTE: CHECK THIS IF USING
        entry: doctoc .github/README.md

# HADOLINT - DOCKER
  - repo: https://github.com/hadolint/hadolint
    rev: v2.12.0
    hooks:
      - id: hadolint
        args: [-f, json, --ignore, DL3008, '-']

# TERRAFORM
  - repo: https://github.com/antonbabenko/pre-commit-terraform
    rev: v1.92.0
    hooks:
      - id: terraform_fmt
        args: [--args=-no-color, --args=-diff, --args=-write=false, --args=-recursive]


exclude: ^\.svg$|\.drawio$
