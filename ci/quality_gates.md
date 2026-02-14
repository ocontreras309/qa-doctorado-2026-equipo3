# Quality Gate (Semana 5)

## Propósito
Ejecutar un conjunto **mínimo y confiable** de chequeos automatizados en cada cambio para reducir incertidumbre sobre los **riesgos priorizados** (Semana 3) usando oráculos y casos sistemáticos (Semana 4).
Este gate **no** pretende certificar “calidad total”, sino entregar **evidencia reproducible** y frenar regresiones obvias.

## Checks del gate

1) **POST Chatmemory responde con JSON válido**
- Claim: endpoint clave responde de forma bien formada (código HTTP 200 y presencia de content en la respuesta).
- Evidencia: `evidence/week5/evidence_gate1.log`
- Oráculo: El script produce `PASS` si la prueba es satisfactoria y `FAIL` en caso contrario.
- Relación: escenarios Semana 2 / robustez operativa.

2) **Casos sistemáticos mejorados**
- Claim: El chatbot es capaz de responder preguntas básicas de precios de los cursos.
- Evidencia: `evidence/week5/evidence_gate2.log`
- Oráculo: El script produce `PASS` si la prueba es satisfactoria y `FAIL` en caso contrario.
- Relación: `design/test_cases.md` y `design/oracle_rules.md`.

3) **Coherencia cuantitativa de las respuestas del chatbot**
- Claim: Ante preguntas sobre precios y direcciones, el chatbot responde de manera coherente.
- Evidencia: `evidence/week5/evidence_gate3.log`
- Oráculo: para cada caso, se calcula el jaccard score comparado con una respuesta esperada. Este valor debería ser al menos 0.5 para considerar una respuesta válida.
- Relación: `design/oracle_rules.md` (oráculo 6).

## Alta señal / bajo ruido (confiabilidad)
- El gate debe preferir checks **deterministas** (códigos HTTP, JSON bien formado, oráculos explícitos).
- Evitar depender de métricas sensibles al entorno (p. ej., umbrales estrictos de latencia) como criterio de fallo.
- Mantener evidencia trazable: **riesgo → escenario → evidencia → oráculo**.

## Cómo ejecutar localmente (equivalente a CI)
- `make quality-gate` (genera `evidence/week5/`).