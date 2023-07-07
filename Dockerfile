# Multistage Docker Build to ensure smaller images with just the GO executable
FROM golang:1.20.5-alpine3.18 AS build

RUN mkdir /app
ADD . /app
WORKDIR /app
RUN CGO_ENABLED=0 GOOS=linux go build -o golang-api

FROM alpine:latest AS prod

COPY --from=build /app/golang-api .
CMD ["./golang-api"]