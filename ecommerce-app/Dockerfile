
FROM node:20-alpine3.18 AS build
RUN apk add --no-cache bash curl zlib-dev python3 make g++

WORKDIR /app


COPY package*.json ./


RUN npm ci 


COPY src ./src
COPY public ./public


RUN npm run build


FROM nginx:alpine

# Copy build output to Nginx html folder
COPY --from=build /app/build /usr/share/nginx/html

# Copy custom Nginx config
COPY nginx.conf /etc/nginx/conf.d/default.conf

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]
