
# # Use an official Node.js image as the base image
#FROM node:14

# # Set the working directory in the container
#WORKDIR /app

# # Copy package.json and package-lock.json to the working directory
#COPY package*.json ./

# # Install app dependencies
 #RUN npm install

# # Copy the remaining app source code to the working directory
 #COPY . .

# # Build the React app for production
 #RUN npm run build

# # Expose the port the app runs on
 #EXPOSE 3000

# # Set the default command to run the app
 #CMD ["npm", "start"]


# FROM node:14 AS builder

# WORKDIR /app
# COPY . .

# RUN npm install -g typescript
# RUN npm install
# RUN npm run build

#######################################

# FROM node:14

# RUN apk add bash
# RUN apk add --no-cache \
#         python3 \
#     && rm -rf /var/cache/apk/*
# RUN apk add --update alpine-sdk
# RUN apk add chromium \
#     harfbuzz

# RUN apk update
# RUN apk upgrade

# WORKDIR /app
# RUN rm -rf ./*

# COPY --from=builder ./app/package*.json ./
# COPY --from=builder ./app/build .

# RUN npm install --production
# RUN npm install pm2 -g
# COPY . /app
# CMD [ "pm2-runtime","src/index.tsx" ]
#CMD ["node", "index.js"]

# RUN chmod +x /app/entrypoint.sh
#ENTRYPOINT ["/bin/bash", "-c", "/app/entrypoint.sh"]
###############################################################

FROM node:14 as builder
WORKDIR /app
COPY package*.json /app/
RUN npm install
COPY . /app
RUN npm run build

################

FROM nginx:alpine as production
COPY --from=builder /app/build /usr/share/nginx/html
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
