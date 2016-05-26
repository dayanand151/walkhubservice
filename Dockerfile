FROM golang:latest

RUN apt-get update && apt-get install apt-transport-https
RUN curl -s https://deb.nodesource.com/gpgkey/nodesource.gpg.key | apt-key add -
RUN echo 'deb https://deb.nodesource.com/node_4.x jessie main' > /etc/apt/sources.list.d/nodesource.list
RUN apt-get update && apt-get -y install nodejs
RUN go get github.com/Pronovix/walkhub-service

WORKDIR /go/src/github.com/Pronovix/walkhub-service
RUN echo '{}' > config.json
RUN npm install
RUN go install github.com/Pronovix/walkhub-service/cmd/walkhub

ENTRYPOINT npm run build && /go/bin/walkhub

EXPOSE 80
EXPOSE 443
