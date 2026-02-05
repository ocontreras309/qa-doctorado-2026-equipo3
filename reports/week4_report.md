# Reporte Semana 4 — Diseño sistemático de pruebas y oráculos (ChatbotMemory)

## 1) Objeto de prueba
Endpoint: POST /localhost:8000/Chatbotmemory
Motivación: el parámetro {} permite diseñar casos sistemáticos (valores extremos) y observar robustez/consistencia de manejo de errores.

## 2) Técnica de diseño utilizada
Equivalencia (EQ) sobre {}.
EQ: particiona el dominio del parámetro en clases relevantes (no numérico).

La justificación es metodológica: se evita inventar casos ad-hoc y se hace explícito el criterio de selección de entradas.

## 3) Oráculos (mínimos vs estrictos)
Las reglas están en `design/oracle_rules.md`.

Oráculos mínimos (defendibles sin suponer datos):

- No 5xx (no fallas del servidor ante solicitudes controladas).
- IDs inválidos (no numérico o ≤ 0) no deben retornar 200.

## 4) Cobertura afirmada (y lo que NO se afirma)
Se afirma:
- Cobertura sistemática de clases de entrada del parámetro {} (EQ).
- Evidencia reproducible por caso (código JSON + cuerpo guardado) con decisión pass/fail bajo oráculo mínimo.

No se afirma:
- Correctitud funcional completa del recurso Chatbotmemory (depende de datos existentes).
- Seguridad, concurrencia ni performance en producción.
- Estabilidad temporal (requiere repetición controlada).

## 5) Amenazas a la validez (interno/externo)
- Interna: estado/datos del SUT pueden cambiar y afectar si un {} retorna valor desconocidos.
  Mitigación: usar oráculos que no dependan de valores desconocidos.
- Constructo: usar códigos JSON como proxy de “robustez” no cubre otras dimensiones (seguridad, integridad).
  Mitigación: declarar alcance del atributo evaluado (manejo de entradas y estabilidad de respuesta).
- Externa: resultados dependen del entorno (local, red, versión del SUT).
  Mitigación: registrar entorno y repetir en otra máquina/instancia si se requiere generalización.

## 6) Evidencia
Casos: design/test_cases.md
Oráculos: design/oracle_rules.md
Ejecución: scripts/systematic_cases.sh
Evidencia: evidence/week4/ (por caso + results.csv + summary.txt)