# # **************************************************
# # Your changes for task 3 go in this file (and ./docker-compose.yml).
# #
# # See below.
# #
# # You must have completed task 1 (not 2) before starting on this.
# # **************************************************
FROM node:latest
RUN mkdir /app
WORKDIR /app
RUN npm install express
RUN npm install coffeescript
RUN npm install
COPY index.js .
CMD ["node", "index.js"]
EXPOSE 8000

