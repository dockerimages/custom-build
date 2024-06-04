FROM node:latest
# docker build -f m.Dockerfile --format docker
SHELL ["/usr/local/bin/node", "-p"]
RUN console.log("works") || ""

