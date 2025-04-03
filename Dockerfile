FROM kong/kong-gateway:latest

RUN apt-get update && apt-get install -y bash