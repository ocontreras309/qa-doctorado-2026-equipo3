# Función para probar un endpoint
test_basic_endpoint() {
    local method=$1
    local endpoint=$2
    local expected_status=$3
    local description=$4
    local body=$5
    local contenttype="Content-Type: $6"
    
    echo "Probando: $description"
    if [ -z "$body" ]; then
        local status=$(curl -X "$method" -s -o /dev/null -w "%{http_code}" "$BASE_URL$endpoint")
    else
        local status=$(curl -X "$method" -s -o /dev/null -d "$body" -H "$contenttype" -w "%{http_code}" "$BASE_URL$endpoint")
    fi
    
    if [ "$status" -eq "$expected_status" ]; then
        echo "✅ ÉXITO: $description (HTTP $status)"
        echo "EXITO: $description (HTTP $status)" >> "$RESULTS_FILE"
        return 0
    else
        echo "❌ FALLO: $description (Esperado $expected_status, obtenido $status)"
        echo "FALLO: $description (Esperado $expected_status, obtenido $status)" >> "$RESULTS_FILE"
        return 1
    fi
}

# Función para probar la respuesta de un endpoint
test_advanced_endpoint() {
    local method=$1
    local endpoint=$2
    local expected_result_contains=$3
    local description=$4
    local body=$5
    local contenttype="Content-Type: $6"
    
    echo "Probando: $description"
    if [ -z "$body" ]; then
        result=$(curl -X "$method" -s "$BASE_URL$endpoint")
    else
        result=$(curl -X "$method" -s -d "$body" -H "$contenttype" "$BASE_URL$endpoint")
    fi
    
    if [[ "$result" == *"$expected_result_contains"* ]]; then
        echo "✅ ÉXITO: $description (HTTP $result)"
        echo "EXITO: $description (HTTP $result)" >> "$RESULTS_FILE"
        return 0
    else
        echo "❌ FALLO: $description (Esperado $expected_result_contains, obtenido $result)"
        echo "FALLO: $description (Esperado $expected_result_contains, obtenido $result)" >> "$RESULTS_FILE"
        return 1
    fi
}