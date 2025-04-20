# syntax=docker/dockerfile:1
ARG NODE_VERSION=22.13.1
FROM node:${NODE_VERSION}-slim AS base
WORKDIR /app

# Install dependencies in a separate stage for caching
FROM base AS deps
# Copy only package files for dependency installation
COPY --link package.json package-lock.json ./
RUN --mount=type=cache,target=/root/.npm \
    npm ci --production

# Copy application source (excluding .env and files in .dockerignore)
FROM base AS app-src
# Copy from subdirectory instead of root
COPY --link cosmetics-catalog/ .

# Final production image
FROM node:${NODE_VERSION}-slim AS final
WORKDIR /app
# Create non-root user for security
RUN addgroup --system appgroup && adduser --system --ingroup appgroup appuser

# Copy dependencies and app source
COPY --from=deps /app/node_modules ./node_modules
COPY --from=app-src /app .

# Set environment variables
ENV NODE_ENV=production
ENV NODE_OPTIONS="--max-old-space-size=4096"

USER appuser
EXPOSE 3000
CMD ["npm", "start"]