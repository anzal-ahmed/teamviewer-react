# Stage 1: Build React app
FROM node:18 as build

# Stage 1: Build React app
WORKDIR /app

# Only copy dependency files first for layer caching
COPY package*.json ./

#install dependencies
RUN npm ci

# Copy rest of the app
COPY . .

# Build the app
RUN npm run build

#nginx
FROM nginx:alpine


#cleaner
RUN rm -rf /usr/share/nginx/html/*

#copy build output from builder
COPY --from=build /app/build /usr/share/nginx/html

EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
