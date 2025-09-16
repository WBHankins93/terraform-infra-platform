# Use official Node.js base image
FROM node:24-slim

# Create app directory
WORKDIR /usr/src/app

# Copy app code
COPY index.js .

# Install Express
RUN npm install express

# Expose port
EXPOSE 3000

# Start the app
CMD ["node", "index.js"]



# Multi-stage build
# FROM node:24-alpine AS dependencies  # Smaller base image
# WORKDIR /app
# COPY package*.json ./               # Layer caching optimization
# RUN npm ci --only=production        # More secure than npm install

# FROM node:24-alpine AS runtime
# RUN adduser -S nodeapp              # Non-root user security
# WORKDIR /app
# COPY --from=dependencies /app/node_modules ./node_modules
# COPY --chown=nodeapp:nodejs index.js ./
# USER nodeapp                        # Run as non-root
# HEALTHCHECK CMD wget --spider http://localhost:3000/ || exit 1
# CMD ["node", "index.js"]