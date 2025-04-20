# ----- Build Stage -----
    FROM node:16-alpine AS builder
    WORKDIR /app
    
    # Copy package files from the nested directory
    COPY cosmetics-catalog/package*.json ./
    
    # Install dependencies
    RUN npm ci --only=production
    
    # Copy application source from nested directory
    COPY cosmetics-catalog/ ./
    
    # ----- Production Stage -----
    FROM node:16-alpine
    WORKDIR /app
    
    # Copy built app from builder
    COPY --from=builder /app .
    
    # Expose port and run as non-root user
    EXPOSE 3000
    USER node
    
    # Start the application
    CMD ["npm", "start"]