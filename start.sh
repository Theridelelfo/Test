#!/usr/bin/env sh

# Exit on error
set -eu

echo "===> Starting environment setup"

# -------------------------
# 1. Check base tools
# -------------------------
check_command() {
    command -v "$1" >/dev/null 2>&1 || {
        echo "❌ Error: $1 not installed"
        exit 1
    }
}

check_command git
check_command docker

# -------------------------
# 2. Detect environment
# -------------------------
ENV="local"

if [ -n "${GOOGLE_CLOUD_PROJECT:-}" ]; then
    ENV="gcp"
elif [ -n "${KILLERCODA:-}" ]; then
    ENV="killercoda"
fi

echo "===> Environment detected: $ENV"

# -------------------------
# 3. Select Dockerfile
# -------------------------
DOCKERFILE="docker/Dockerfile.base"

if [ "$ENV" = "gcp" ]; then
    DOCKERFILE="docker/Dockerfile.gcp"
elif [ "$ENV" = "killercoda" ]; then
    DOCKERFILE="docker/Dockerfile.killercoda"
fi

if [ ! -f "$DOCKERFILE" ]; then
    echo "❌ Missing Dockerfile: $DOCKERFILE"
    exit 1
fi

echo "===> Using Dockerfile: $DOCKERFILE"

# -------------------------
# 4. Build Docker
# -------------------------
IMAGE_NAME="myapp:$ENV"

echo "===> Building Docker image..."
docker build -f "$DOCKERFILE" -t "$IMAGE_NAME" .

echo "✅ Build completed: $IMAGE_NAME"
