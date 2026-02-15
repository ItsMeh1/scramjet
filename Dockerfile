FROM node:22-slim

# Install pnpm globally
RUN npm install -g pnpm

WORKDIR /app

# Copy everything
COPY . .

# Install dependencies
RUN pnpm install

# Build the project (Scramjet needs this!)
RUN pnpm build

# Start the app
EXPOSE 8080
CMD ["pnpm", "start"]
