# Use a lightweight base image
FROM node:18-alpine

# Set the working directory
WORKDIR /usr/src/app

# Caching Optimization: Copy dependency files first
COPY package*.json ./

# Install dependencies
RUN npm install --production

# Copy the remaining source code
COPY . .

# Port Documentation: Document the intended container port
EXPOSE 3000

# Start the application
CMD [ "npm", "start" ]
