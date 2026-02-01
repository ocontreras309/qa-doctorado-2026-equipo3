# Escenarios de Calidad

## Descripción General

Este documento define los escenarios de calidad utilizados para evaluar la aplicación del ChatBot.

# Semana 2 — Escenarios de calidad (falsables y medibles)

Referencia de formato:
- Un escenario debe tener: Estímulo, Entorno, Respuesta, Medida, Evidencia.

## Escenario Q1 — Disponibilidad mínima de los endpoints (Contract Availability)
- Estímulo: un consumidor realiza peticiones GET al endpoint /chatmemory
- Entorno: ejecución local, SUT recién iniciado
- Respuesta: el SUT entrega un objeto JSON con la respuesta
- Medida (falsable): La respuesta siempre es código HTTP 200
- Evidencia: evidence/week2/smoke_test_20260122_232253.log

## Escenario Q2 — Latencia básica del endpoint de inventario (Performance - Local)
- Estímulo: se solicita POST /chat
- Entorno: ejecución local, sin carga externa, 10 repeticiones consecutivas
- Respuesta: el SUT responde con HTTP 200
- Medida (falsable): registrar time_total por ejecución; (opcional) p95 <= 1.0s
- Evidencia: evidence/week2/latency.csv

## Escenario Q3 — Robustez ante peticiones no válidas (Robustness / Error Handling)
- Estímulo: se solicita POST /chatmemory con código SQL
- Entorno: ejecución local, sin carga, 1 vez por caso
- Respuesta: el SUT NO debe exponer información sensible del sistema y no puede responder con código 200
- Medida (falsable): para cada caso, la respuesta debe negar la petición del usuario
- Evidencia: evidence/week2/robustness.log

## Escenario Q4 — Respuesta “bien formada” en /chatmemory (Data Shape Sanity)
- Estímulo: se solicita POST /chatmemory
- Entorno: ejecución local, sin carga, 1 vez
- Respuesta: el cuerpo es JSON (no HTML / texto inesperado)
- Medida (falsable): el cuerpo comienza con '{"content"', el request devuelve HTTP 200 y la respuesta aborda la pregunta realizada correctamente.
- Evidencia: evidence/week2/response.json, evidence/week2/memory.json


## Criterios de Éxito

El SUT tiene la capacidad de generar respuestas correctas a las peticiones, pero al mismo niega respuestas a preguntas que podrían comprometer la seguridad del sistema.
