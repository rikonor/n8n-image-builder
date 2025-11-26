#!/bin/bash

set -eu

# Default to latest if not provided
UPSTREAM_TAG=${1:-}

if [ -z "$UPSTREAM_TAG" ]; then
  echo "Fetching latest n8n release tag..."
  # Try to fetch latest tag from GitHub API
  UPSTREAM_TAG=$(curl -s https://api.github.com/repos/n8n-io/n8n/releases/latest | jq -r .tag_name | sed 's/^n8n@//')
  echo "${UPSTREAM_TAG}"
  
  if [ -z "$UPSTREAM_TAG" ]; then
    echo "Could not automatically determine upstream tag."
    echo "Please provide a tag as an argument: ./local-build.sh <tag>"
    exit 1
  fi
  echo "Latest tag detected: $UPSTREAM_TAG"
fi

IMAGE_NAME="n8n"
IMAGE_TAG="${UPSTREAM_TAG}-custom"

echo "Building $IMAGE_NAME:$IMAGE_TAG based on n8n-io/n8n:$UPSTREAM_TAG..."

docker build \
  --build-arg BASE_IMAGE="n8nio/n8n:$UPSTREAM_TAG" \
  -t "$IMAGE_NAME:$IMAGE_TAG" \
  -t "$IMAGE_NAME:latest" \
  .

echo ""
echo "Build complete!"
echo "Image tagged as:"
echo "  - $IMAGE_NAME:$IMAGE_TAG"
echo "  - $IMAGE_NAME:latest"
echo ""
echo "You can run it with:"
echo "  docker run -it --rm -p 5678:5678 $IMAGE_NAME:latest"
echo "Or use docker-compose:"
echo "  docker-compose up"