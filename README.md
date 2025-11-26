# Custom n8n Image Builder

This repository automatically builds a custom Docker image for n8n whenever a new release is published to the upstream [n8n-io/n8n](https://github.com/n8n-io/n8n) repository.

## How it works

1. **Scheduled Check**: A GitHub Action runs every hour to check for the latest release tag on the official n8n repository.
2. **Comparison**: It compares the latest upstream tag with the locally stored tag in `UPSTREAM_TAG.txt`.
3. **Build Trigger**: If a new version is detected:
   - It builds a new Docker image based on the official n8n image.
   - It pushes the new image to the GitHub Container Registry (GHCR).
   - It updates `UPSTREAM_TAG.txt` with the new version and commits the change to this repository.

## Customization

You can customize the `Dockerfile` to add your own nodes, system packages, or configurations.

```dockerfile
ARG BASE_IMAGE
FROM ${BASE_IMAGE}

# Switch to root if you need to install system dependencies
USER root
# RUN apk add --no-cache git curl

# Switch back to the n8n user
USER node
# RUN npm install n8n-nodes-text-manipulation
```

## Setup

1. Ensure GitHub Actions are enabled for this repository.
2. The workflow will automatically create the `UPSTREAM_TAG.txt` file on its first successful run if it doesn't exist.
