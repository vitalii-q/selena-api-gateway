FROM kong/kong-gateway:latest

RUN apt-get update && apt-get install -y bash

# Копирование конфигурации
COPY ./config/kong.conf /etc/kong/kong.conf