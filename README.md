# SynapseAPI

This repository contains the **OpenAPI design specifications** for the Synapse API platform.

> **Note:** These specs represent the **"to be"** (target) situation, **not** the current ("as is") implementation.

## Structure

```
openapi.yaml          # Root OpenAPI 3.0 specification
```

## Getting Started

The API specification is written in [OpenAPI 3.0](https://swagger.io/specification/) format (YAML).

You can view and edit the spec using tools such as:
- [Swagger Editor](https://editor.swagger.io/) – paste the contents of `openapi.yaml`
- [Stoplight Studio](https://stoplight.io/studio)
- Any editor with an OpenAPI/YAML plugin (e.g., VS Code + Swagger Viewer)

## Contributing

1. Edit `openapi.yaml` (or the relevant component files) to describe new or updated endpoints.
2. Validate your changes with a linter such as [Spectral](https://stoplight.io/open-source/spectral) before opening a pull request.
3. Open a pull request and describe the API changes you are proposing.
