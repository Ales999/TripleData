# Build stage
FROM node:18-slim AS builder

# Install git and dependencies
RUN apt-get update && apt-get install -y git && \
    corepack enable && \
    corepack prepare yarn@3.1.1 --activate && \
    rm -rf /var/lib/apt/lists/*

# Set working directory
WORKDIR /app

# Clone source code (use --depth 1 to get only latest code)
RUN git clone --depth 1 https://github.com/Ales999/TripleData.git . && \
    git checkout dev

# Force node_modules mode
RUN echo 'nodeLinker: node-modules' > .yarnrc.yml && \
    echo 'npmRegistryServer: "https://registry.npmmirror.com"' >> .yarnrc.yml

# Install dependencies and build
RUN yarn install && \
    yarn build

# Production stage
FROM nginx:alpine

# Copy build output to nginx directory
COPY --from=builder /app/dist /usr/share/nginx/html

# Expose port
EXPOSE 80

# Start nginx
CMD ["nginx", "-g", "daemon off;"]