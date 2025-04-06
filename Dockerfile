FROM kong/kong-gateway:3.9

USER root

RUN apt-get update && apt-get install -y curl bash dnsutils iputils-ping

# Копирование конфигурации
COPY ./config/kong.conf /etc/kong/kong.conf