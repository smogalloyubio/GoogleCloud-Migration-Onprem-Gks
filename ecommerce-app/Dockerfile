# Stage 1: Build React app
FROM node:20-alpine3.18 AS build

# Install build dependencies
RUN apk add --no-cache bash=5.2.15-r0 curl=8.3.0-r0 zlib-dev=1.2.13-r1 python3=3.12.2-r0 make=4.3-r1 g++=12.2.1-r0

WORKDIR /app

# Copy package files
COPY package*.json ./

# Install dependencies (use --legacy-peer-deps for safer CI build)
RUN npm ci --legacy-peer-deps

# Copy source files
COPY src ./src
COPY public ./public

# Build React app
RUN npm run build

# Stage 2: Serve with Nginx
FROM nginx:alpine

# Copy build output
COPY --from=build /app/build /usr/share/nginx/html

# Copy custom Nginx config
COPY nginx.conf /etc/nginx/conf.d/default.conf

EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]