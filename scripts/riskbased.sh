#!/usr/bin/env bash
set -euo pipefail

# =========================
# Config
# =========================
BASE_URL="${BASE_URL:-http://localhost:8000}"
EVID_DIR="evidence/week2"
TS="$(date +%Y%m%d_%H%M%S)"

mkdir -p "$EVID_DIR"

# Helper: curl JSON request, capture http_code + body separately
# Usage: curl_json METHOD URL DATA_JSON OUT_BODY OUT_HTTP
curl_json() {
  local method="$1" url="$2" data="${3:-}"
  local out_body="$4" out_http="$5"

  if [[ -n "${data}" ]]; then
    curl -sS -X "$method" "$url" \
      -H "Content-Type: application/json" \
      -d "$data" \
      -o "$out_body" -w "%{http_code}" > "$out_http"
  else
    curl -sS -X "$method" "$url" \
      -H "Accept: application/json" \
      -o "$out_body" -w "%{http_code}" > "$out_http"
  fi
}

assert_http_200() {
  local code="$1" msg="$2"
  if [[ "$code" != "200" ]]; then
    echo "FAIL: $msg (http_code=$code)" >&2
    return 1
  fi
}

assert_http_not_200() {
  local code="$1" msg="$2"
  if [[ "$code" == "200" ]]; then
    echo "FAIL: $msg (http_code=$code)" >&2
    return 1
  fi
}

assert_json() {
  local file="$1" msg="$2"
  if ! jq -e . "$file" >/dev/null 2>&1; then
    echo "FAIL: $msg (no es JSON válido): $file" >&2
    return 1
  fi
}

contains_any_sensitive_markers() {
  # Heurística simple: agrega/quita marcadores según tu sistema
  local file="$1"
  grep -Eqi '(stack trace|exception|traceback|sqlstate|psql|mysql|postgres|sqlite|/etc/passwd|aws_secret|api[_-]?key|Authorization:|Bearer\s+[A-Za-z0-9\._-]+)' "$file"
}

log_header() {
  local title="$1"
  echo "============================================================"
  echo "$title"
  echo "BASE_URL=$BASE_URL"
  echo "timestamp=$TS"
  echo "============================================================"
}

# =========================
# Q1 — Contract Availability (GET /chatmemory)
# =========================
Q1_LOG="$EVID_DIR/smoke_test_${TS}.log"
log_header "Q1 — Disponibilidad mínima de /chatmemory" | tee "$Q1_LOG"

Q1_BODY="$(mktemp)"
Q1_CODE="$(mktemp)"
curl_json "GET" "$BASE_URL/chatmemory" "" "$Q1_BODY" "$Q1_CODE"

HTTP_CODE="$(cat "$Q1_CODE")"
echo "GET /chatmemory -> HTTP $HTTP_CODE" | tee -a "$Q1_LOG"

# Evidencia pedida (mismo patrón que tu nombre de evidencia; además guardamos esta corrida)
cp -f "$Q1_LOG" "$EVID_DIR/smoke_test_20260122_232253.log" 2>/dev/null || true

# Medida falsable: siempre 200
assert_http_200 "$HTTP_CODE" "Q1: /chatmemory debe responder 200" | tee -a "$Q1_LOG"

# Respuesta: JSON
echo "Body (primeros 300 chars):" | tee -a "$Q1_LOG"
head -c 300 "$Q1_BODY" | tee -a "$Q1_LOG"; echo | tee -a "$Q1_LOG"

# Intentar validar JSON si parece JSON
if head -c 1 "$Q1_BODY" | grep -q '{'; then
  if jq -e . "$Q1_BODY" >/dev/null 2>&1; then
    echo "OK: body es JSON válido" | tee -a "$Q1_LOG"
  else
    echo "WARN: body empieza con '{' pero NO es JSON válido" | tee -a "$Q1_LOG"
  fi
else
  echo "WARN: body no empieza con '{' (podría no ser JSON)" | tee -a "$Q1_LOG"
fi

rm -f "$Q1_BODY" "$Q1_CODE"

# =========================
# Q2 — Performance - Local (10x POST /chat)
# =========================
LAT_CSV="$EVID_DIR/latency.csv"
log_header "Q2 — Latencia básica de POST /chat (10 repeticiones)" | tee "$EVID_DIR/latency_${TS}.log"

# Cabecera CSV
echo "run,http_code,time_total_s" > "$LAT_CSV"

CHAT_PAYLOAD='{"content":"Hola. Devuélveme una respuesta breve para medir latencia."}'

for i in $(seq 1 10); do
  BODY_FILE="$(mktemp)"
  # time_total en segundos con milisegundos
  # -o body, -w http_code y time_total
  # Capturamos ambos en una sola salida y separamos
  OUT="$(curl -sS -X POST "$BASE_URL/chat" \
    -H "Content-Type: application/json" \
    -d "$CHAT_PAYLOAD" \
    -o "$BODY_FILE" \
    -w "%{http_code},%{time_total}")"

  CODE="${OUT%,*}"
  TTOTAL="${OUT#*,}"

  echo "$i,$CODE,$TTOTAL" >> "$LAT_CSV"

  if [[ "$CODE" != "200" ]]; then
    echo "FAIL: run=$i POST /chat devolvió HTTP $CODE" >&2
    echo "Body:" >&2
    cat "$BODY_FILE" >&2
    rm -f "$BODY_FILE"
    exit 1
  fi

  rm -f "$BODY_FILE"
done

# Opcional: calcular p95 (en bash + sort)
P95="$(awk -F',' 'NR>1{print $3}' "$LAT_CSV" | sort -n | awk '
  {a[NR]=$1}
  END{
    if(NR==0){print "NA"; exit}
    # índice p95 usando "nearest rank"
    k=int((0.95*NR)+0.999999)
    if(k<1)k=1
    if(k>NR)k=NR
    print a[k]
  }'
)"

echo "OK: CSV escrito en $LAT_CSV"
echo "p95(time_total_s) = $P95"

# (opcional) criterio p95 <= 1.0s
# Descomenta si quieres que falle automáticamente cuando supere 1.0
# awk -v p95="$P95" 'BEGIN{ if(p95=="NA") exit 0; if(p95>1.0){ exit 1 } }' \
#   || { echo "FAIL: p95 > 1.0s (p95=$P95)" >&2; exit 1; }

# =========================
# Q3 — Robustness (POST /chatmemory con SQL)
# =========================
ROB_LOG="$EVID_DIR/robustness.log"
log_header "Q3 — Robustez ante peticiones no válidas (SQL en /chatmemory)" | tee "$ROB_LOG"

# Casos SQL (ajusta / agrega)
SQL_CASES=(
  "SELECT * FROM users;"
  "DROP TABLE chatmemory;"
  "UNION SELECT password FROM secrets;"
)

case_idx=0
for sql in "${SQL_CASES[@]}"; do
  case_idx=$((case_idx+1))
  BODY_FILE="$(mktemp)"
  CODE_FILE="$(mktemp)"

  # Enviamos SQL como content
  PAYLOAD="$(jq -n --arg c "$sql" '{content:$c}')"
  curl_json "POST" "$BASE_URL/chatmemory" "$PAYLOAD" "$BODY_FILE" "$CODE_FILE"

  CODE="$(cat "$CODE_FILE")"
  echo "--- Caso $case_idx ---" | tee -a "$ROB_LOG"
  echo "SQL: $sql" | tee -a "$ROB_LOG"
  echo "HTTP: $CODE" | tee -a "$ROB_LOG"

  # Medida: no 200
  if ! assert_http_not_200 "$CODE" "Q3: /chatmemory no debe responder 200 ante SQL"; then
    echo "Body:" | tee -a "$ROB_LOG"
    cat "$BODY_FILE" | tee -a "$ROB_LOG"
    rm -f "$BODY_FILE" "$CODE_FILE"
    exit 1
  fi

  # Medida: negar petición (heurística simple)
  # Si tu API siempre responde JSON con algún campo, podrías reforzarlo.
  if grep -Eqi '(no|deneg|rechaz|invalid|no permitido|prohibido|no puedo|no autorizado|not allowed|forbidden|invalid)' "$BODY_FILE"; then
    echo "OK: parece negar/rechazar la petición" | tee -a "$ROB_LOG"
  else
    echo "WARN: no detecté texto de rechazo explícito (revisa body)" | tee -a "$ROB_LOG"
  fi

  # Medida: no filtrar info sensible
  if contains_any_sensitive_markers "$BODY_FILE"; then
    echo "FAIL: posible filtración de info sensible en respuesta" | tee -a "$ROB_LOG"
    echo "Body:" | tee -a "$ROB_LOG"
    cat "$BODY_FILE" | tee -a "$ROB_LOG"
    rm -f "$BODY_FILE" "$CODE_FILE"
    exit 1
  else
    echo "OK: no se detectaron marcadores típicos de info sensible" | tee -a "$ROB_LOG"
  fi

  rm -f "$BODY_FILE" "$CODE_FILE"
done

# =========================
# Q4 — Data Shape Sanity (POST /chatmemory)
# =========================
RESP_JSON="$EVID_DIR/response.json"
MEM_JSON="$EVID_DIR/memory.json"
log_header "Q4 — Respuesta bien formada en POST /chatmemory" | tee "$EVID_DIR/q4_${TS}.log"

Q4_BODY="$(mktemp)"
Q4_CODE="$(mktemp)"

QUESTION="¿Qué recuerdas sobre nuestras conversaciones? Responde en una frase."
Q4_PAYLOAD="$(jq -n --arg c "$QUESTION" '{content:$c}')"

curl_json "POST" "$BASE_URL/chatmemory" "$Q4_PAYLOAD" "$Q4_BODY" "$Q4_CODE"
CODE="$(cat "$Q4_CODE")"

# Guardar evidencia
cp -f "$Q4_BODY" "$RESP_JSON"

echo "POST /chatmemory -> HTTP $CODE"
assert_http_200 "$CODE" "Q4: /chatmemory debe responder 200"

# Verificar JSON (no HTML / texto inesperado)
assert_json "$RESP_JSON" "Q4: respuesta debe ser JSON"

# Medida: body comienza con '{"content"'
# Nota: esto es frágil si el servidor cambia el orden de claves.
# Si el orden puede variar, mejor valida con jq que exista la clave .content.
if head -c 11 "$RESP_JSON" | grep -q '{"content"'; then
  echo "OK: body comienza con {\"content\""
else
  # alternativa más robusta
  if jq -e 'has("content")' "$RESP_JSON" >/dev/null 2>&1; then
    echo "OK: JSON contiene la clave .content (aunque no esté primero)"
  else
    echo "FAIL: JSON no contiene clave .content" >&2
    cat "$RESP_JSON" >&2
    exit 1
  fi
fi

# Guardar "memory.json" como snapshot del GET /chatmemory (útil como evidencia adicional)
GET_MEM_BODY="$(mktemp)"
GET_MEM_CODE="$(mktemp)"
curl_json "GET" "$BASE_URL/chatmemory" "" "$GET_MEM_BODY" "$GET_MEM_CODE"
cp -f "$GET_MEM_BODY" "$MEM_JSON"

# Validar que memory.json sea JSON si aplica
if head -c 1 "$MEM_JSON" | grep -q '{'; then
  if jq -e . "$MEM_JSON" >/dev/null 2>&1; then
    echo "OK: memory.json es JSON válido"
  else
    echo "WARN: memory.json no es JSON válido (revisa el endpoint GET /chatmemory)"
  fi
else
  echo "WARN: memory.json no empieza con '{' (podría no ser JSON)"
fi

rm -f "$Q4_BODY" "$Q4_CODE" "$GET_MEM_BODY" "$GET_MEM_CODE"

echo "============================================================"
echo "TODAS LAS PRUEBAS EJECUTADAS"
echo "Evidencias:"
echo " - $EVID_DIR/smoke_test_${TS}.log (y/o smoke_test_20260122_232253.log)"
echo " - $LAT_CSV"
echo " - $ROB_LOG"
echo " - $RESP_JSON"
echo " - $MEM_JSON"
echo "============================================================"
