#!/bin/bash

# Синхронизация конфигурации с Kong через deck
echo "Syncing Kong config with deck..."
deck gateway sync ./config/kong.yml

# Проверяем успешность синхронизации
if [ $? -ne 0 ]; then
  echo "Deck sync failed, aborting oauth2 credentials creation."
  exit 1
fi

# Создание oauth2_credentials через API Kong
echo "Creating oauth2 credentials..."
curl -X POST http://localhost:8001/oauth2 \
  --data "name=my-client" \
  --data "client_id=abc123" \
  --data "client_secret=secret123" \
  --data "redirect_uris[]=http://localhost/callback" \
  --data "consumer[id]=1a2c6b27-a005-408d-8d59-3cb82ddadff3"

# Проверка успешности создания oauth2_credentials
if [ $? -ne 0 ]; then
  echo "Failed to create oauth2 credentials."
  exit 1
fi

echo "Oauth2 credentials created successfully."
