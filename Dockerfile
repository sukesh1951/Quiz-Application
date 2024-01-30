
# # Use an official Node.js image as the base image
 FROM node:14

# # Set the working directory in the container
 WORKDIR /app

# # Copy package.json and package-lock.json to the working directory
 COPY package*.json ./

# # Install app dependencies
 RUN npm install

# # Copy the remaining app source code to the working directory
 COPY . .

# # Build the React app for production
 RUN npm run build

# # Expose the port the app runs on
 EXPOSE 3004

# # Set the default command to run the app
 CMD ["npm", "start"]