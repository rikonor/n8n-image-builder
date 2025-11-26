ARG BASE_IMAGE
FROM ${BASE_IMAGE:-latest}

# Switch to root if you need to install system dependencies
USER root

# Example: Install system packages (uncomment if needed)
# RUN apk add --no-cache git curl

# Switch back to the n8n user
USER node

RUN npm init --yes

RUN cat package.json | jq '.type = "module"' > package.json

# Install npm packages
RUN npm i \
    matrix-js-sdk \
    commander
