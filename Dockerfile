ARG BASE_IMAGE
FROM ${BASE_IMAGE:-latest}

# Switch to root if you need to install system dependencies
USER root

# Example: Install system packages (uncomment if needed)
# RUN apk add --no-cache git curl

# Switch back to the n8n user
USER node

# Example: Install custom n8n nodes or npm packages
# RUN npm install n8n-nodes-text-manipulation