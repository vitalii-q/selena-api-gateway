#!/bin/bash

# Параметры
KEY="my-key"
SECRET="my-secret"

# Заголовок (Header)
HEADER='{
  "alg": "HS256",
  "typ": "JWT"
}'

# Полезная нагрузка (Payload)
PAYLOAD='{
  "iss": "'"$KEY"'",
  "exp": '"$(($(date +%s) + 3600))"'  # истекает через 1 час
}'

# Функции для base64url и подписи
base64url_encode() {
  echo -n "$1" | openssl base64 -e | tr -d '=' | tr '/+' '_-' | tr -d '\n'
}

sign() {
  local input=$1
  local key=$2
  echo -n "$input" | openssl dgst -sha256 -hmac "$key" -binary | openssl base64 -e | tr -d '=' | tr '/+' '_-' | tr -d '\n'
}

# Кодируем header и payload
HEADER_ENC=$(base64url_encode "$HEADER")
PAYLOAD_ENC=$(base64url_encode "$PAYLOAD")

# Создаем подпись
SIGNATURE=$(sign "$HEADER_ENC.$PAYLOAD_ENC" "$SECRET")

# Финальный токен
JWT="$HEADER_ENC.$PAYLOAD_ENC.$SIGNATURE"

# Выводим
echo ""
echo "🔑 JWT Token:"
echo "$JWT"
echo ""
