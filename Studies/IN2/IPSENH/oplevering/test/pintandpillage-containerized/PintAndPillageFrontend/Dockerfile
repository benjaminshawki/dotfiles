# Stage 1: Build the frontend
FROM node:18.19.1-slim as build
WORKDIR /app
COPY PintAndPillageFrontend/package*.json ./
RUN npm install
COPY PintAndPillageFrontend/ .
RUN npm run build

# Stage 2: Serve the application using Nginx
FROM nginx:1.25.4-alpine3.18-slim
COPY --from=build /app/dist /usr/share/nginx/html
COPY nginx/default.conf /etc/nginx/conf.d/default.conf
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
