#!/bin/bash
# Suite de smoke test para la aplicación Chatbot

source ./scripts/common.sh

echo "Ejecutando smoke test para Chatbot..."

BASE_URL="http://localhost:8000/"
TIMESTAMP=$(date +%Y%m%d_%H%M%S)
RESULTS_FILE="evidence/week2/smoke_test_$TIMESTAMP.log"

# Crear directorio de resultados si no existe
mkdir -p evidence/week2

# Inicializar archivo de resultados
echo "Resultados de Pruebas de Humo - $TIMESTAMP" > "$RESULTS_FILE"
echo "================================" >> "$RESULTS_FILE"

# Suite de pruebas
TOTAL_TESTS=0
PASSED_TESTS=0

# Prueba 1: Devuelve código 200 al visitar la página principal
test_basic_endpoint "GET" "/" 200 "Visita de la página principal del SUT"
RESULT=$?
TOTAL_TESTS=$((TOTAL_TESTS + 1))
if [ $RESULT -eq 0 ]; then
    PASSED_TESTS=$((PASSED_TESTS + 1))
fi

# Prueba 2: Endpoint inválido (debería retornar 404)
test_basic_endpoint "GET" "/invalid/endpoint" 404 "Endpoint inválido (prueba negativa)"
RESULT=$?
TOTAL_TESTS=$((TOTAL_TESTS + 1))
if [ $RESULT -eq 0 ]; then
    PASSED_TESTS=$((PASSED_TESTS + 1))
fi

# Prueba 3: Invocación al endpoint /chat debe retornar código 200 (retorno de código 200)

test_basic_endpoint "POST" "/chat" 200 "Envío de datos al modelo" '{"data": "hola"}' "application/json"
RESULT=$?
TOTAL_TESTS=$((TOTAL_TESTS + 1))
if [ $RESULT -eq 0 ]; then
    PASSED_TESTS=$((PASSED_TESTS + 1))
fi

# Prueba 4: Invocación al endpoint /chat debe retornar {"content": "..."} (retorno de respuesta)

test_advanced_endpoint "POST" "/chat" '{"content":' "Envío de datos al modelo" '{"data": "hola"}' "application/json"
RESULT=$?
TOTAL_TESTS=$((TOTAL_TESTS + 1))
if [ $RESULT -eq 0 ]; then
    PASSED_TESTS=$((PASSED_TESTS + 1))
fi

# Prueba 5: Invocación al endpoint /chatmemory debe retornar código 200 (retorno de código 200)

test_basic_endpoint "POST" "/chatmemory" 200 "Envío de datos al modelo" '{"data": "hola"}' "application/json"
RESULT=$?
TOTAL_TESTS=$((TOTAL_TESTS + 1))
if [ $RESULT -eq 0 ]; then
    PASSED_TESTS=$((PASSED_TESTS + 1))
fi

# Prueba 6: Invocación al endpoint /chatmemory debe retornar {"content": "..."} (retorno de respuesta)

test_advanced_endpoint "POST" "/chatmemory" '{"content":' "Envío de datos al modelo" '{"data": "hola"}' "application/json"
RESULT=$?
TOTAL_TESTS=$((TOTAL_TESTS + 1))
if [ $RESULT -eq 0 ]; then
    PASSED_TESTS=$((PASSED_TESTS + 1))
fi

# Resumen
echo ""
echo "================================"
echo "Resumen de Pruebas de Humo"
echo "Pruebas totales: $TOTAL_TESTS"
echo "Aprobadas: $PASSED_TESTS"
echo "Falladas: $((TOTAL_TESTS - PASSED_TESTS))"
echo "Tasa de éxito: $(( (PASSED_TESTS * 100) / TOTAL_TESTS ))%"
echo "Resultados guardados en: $RESULTS_FILE"

# Resumen en archivo de resultados
echo "" >> "$RESULTS_FILE"
echo "RESUMEN: $PASSED_TESTS/$TOTAL_TESTS pruebas aprobadas" >> "$RESULTS_FILE"

if [ $PASSED_TESTS -eq $TOTAL_TESTS ]; then
    echo "✅ ¡Todas las pruebas de humo pasaron!"
    exit 0
else
    echo "❌ Algunas pruebas de humo fallaron"
    exit 1
fi
