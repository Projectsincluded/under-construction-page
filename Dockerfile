# Using Node.js 18 Alpine as base image
FROM node:18-alpine as base

# Set work directory in the container
WORKDIR /src

# Copy package files into the work directory
COPY website/package.json website/package-lock.json /src/

# Expose port 3000 for development, will be overridden for production
EXPOSE 3000

# Define a production build stage based on the base stage
FROM base as production

# Set up environment variables for the production stage
ENV NODE_ENV=production
ENV EXPRESS_IP=127.0.0.1
ENV EXPRESS_PORT=8080

# Install only production dependencies (ignoring devDependencies)
RUN npm ci

# Copy all source files
COPY website /src

# Run the scripts for tailwind and production
CMD ["npm", "run", "production"]

# Define a development build stage based on the base stage
FROM base as dev

# Set up environment variables for the development stage
ENV NODE_ENV=development
ENV EXPRESS_IP=127.0.0.1
ENV EXPRESS_PORT=3000

# Install nodemon globally and install all dependencies (including devDependencies)
RUN npm install -g nodemon
RUN npm install

# Copy all source files
COPY website /src

# Run the scripts for tailwind and production
CMD ["npm", "run", "production"]