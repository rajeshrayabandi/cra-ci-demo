FROM nginx:1.16.0-alpine
COPY build /usr/share/nginx/html
EXPOSE 9126
CMD ["nginx", "-g", "daemon off;"]
