FROM node:22-bookworm-slim

# Install git (required for the build process)
RUN apt-get update && apt-get install -y git && rm -rf /var/lib/apt/lists/*

# Install pnpm globally
RUN npm install -g pnpm

WORKDIR /app

# Copy everything
COPY . .

# Install dependencies
RUN pnpm install

# 1. Build the WASM rewriter first (Fixes the "module not found" error)
RUN pnpm run rewriter:build || echo "Rewriter already built or manual skip"

# 2. Build the main project
RUN pnpm run build

# Start the app
EXPOSE 8080
CMD ["pnpm", "start"]
