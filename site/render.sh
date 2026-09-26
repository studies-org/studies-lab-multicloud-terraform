#!/bin/sh
# Preenche os marcadores {{...}} do site/index.html com os dados da instância.
# Uso: CLOUD=AWS CLOUD_KEY=aws INSTANCE=web-01 REGION=us-east-1 ZONE=us-east-1a \
#      LB="Application Load Balancer" SERVER="Apache httpd" render.sh <modelo> <saída>
set -eu

src="$1"
dst="$2"

host="$(hostname)"
ip="$(hostname -i 2>/dev/null | awk '{print $1}')"
[ -n "$ip" ] || ip="$(hostname -I 2>/dev/null | awk '{print $1}')"
booted="$(date -u '+%d/%m/%Y %H:%M UTC')"

sed \
  -e "s|{{CLOUD}}|${CLOUD}|g" \
  -e "s|{{CLOUD_KEY}}|${CLOUD_KEY}|g" \
  -e "s|{{INSTANCE}}|${INSTANCE}|g" \
  -e "s|{{INSTANCE_PREFIX}}|${INSTANCE%-*}-|g" \
  -e "s|{{INSTANCE_NUM}}|${INSTANCE##*-}|g" \
  -e "s|{{REGION}}|${REGION}|g" \
  -e "s|{{ZONE}}|${ZONE}|g" \
  -e "s|{{LB}}|${LB}|g" \
  -e "s|{{SERVER}}|${SERVER}|g" \
  -e "s|{{HOSTNAME}}|${host}|g" \
  -e "s|{{PRIVATE_IP}}|${ip:-desconhecido}|g" \
  -e "s|{{BOOTED_AT}}|${booted}|g" \
  "$src" > "$dst"
