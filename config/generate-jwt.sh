#!/bin/bash

HEADER='{"alg":"HS256","typ":"JWT"}'
PAYLOAD='{"iss":"my-key","exp":'"$(($(date +%s)+3600))"'}'
SECRET="my-secret"

base64_url_encode() {
  echo -n "$1" | openssl base64 -e -A | tr '+/' '-_' | tr -d '='
}

HEADER_B64=$(base64_url_encode "$HEADER")
PAYLOAD_B64=$(base64_url_encode "$PAYLOAD")
SIGNATURE=$(echo -n "$HEADER_B64.$PAYLOAD_B64" | openssl dgst -sha256 -hmac "$SECRET" -binary | openssl base64 -e -A | tr '+/' '-_' | tr -d '=')

JWT="$HEADER_B64.$PAYLOAD_B64.$SIGNATURE"

echo ""
echo "🔑 JWT Token:"
echo "$JWT"
