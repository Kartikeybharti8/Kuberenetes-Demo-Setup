FROM nginx:alpine

COPY ./StaticWebApp /usr/share/nginx/html

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]