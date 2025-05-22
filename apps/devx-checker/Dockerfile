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
