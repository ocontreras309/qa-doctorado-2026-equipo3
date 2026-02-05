# Memo de Progreso – Semana 4

**Fecha:** 03/02/2026  
**Equipo:** Equipo 3  
**Semana:** 4 de 8

---

## Objetivos de la semana

- Diseñar pruebas **sistemáticas (no ad-hoc)** para un punto concreto del SUT.
- Definir **reglas de oráculo claras y defendibles (pass/fail)** para evaluar el comportamiento del chatbot.
- Implementar una **ejecución reproducible** de los casos de prueba.
- Generar **evidencia trazable y versionada** de la ejecución.
- Elaborar un **reporte metodológico** que documente el diseño y sus límites.

---

## Logros

Durante la Semana 4 se lograron los siguientes hitos, de acuerdo con los entregables obligatorios del curso:

- Se definió explícitamente el **objeto de prueba**: el endpoint `POST /chatmemory`, responsable de procesar consultas de usuarios al chatbot.
- Se documentaron **reglas de oráculo** en `design/oracle_rules.md`, incluyendo:
  - reglas mínimas (formato JSON, presencia de `content`, ausencia de errores 5xx),
  - reglas por partición de equivalencia (precios en Bs, manejo de preguntas fuera de dominio),
  - y una regla estricta para validación de ubicación institucional.
- Se diseñaron **12 casos de prueba sistemáticos** en `design/test_cases.md`, derivados mediante la técnica de **Particiones de Equivalencia (EQ)** sobre el `request_body` del endpoint.
- Se implementó una **ejecución reproducible** de los casos mediante el script: scripts/systematic_cases.sh el cual ejecuta los casos definidos y produce evidencia automática.
- Se generó **evidencia week4 completa y versionada** en `evidence/week4/`, incluyendo:
- salidas individuales por caso (`TC01_response.txt` … `TC12_response.txt`),
- archivo consolidado de resultados (`results.csv`),
- resumen de ejecución (`summary.txt`),
- registro de ejecución (`RUNLOG.md`).
- Se produjo el **informe metodológico** correspondiente en `reports/week4_report.md`.

---

## Evidencia principal

La evidencia principal de la semana está compuesta por:

- Carpeta `evidence/week4/` con:
- respuestas por caso (`TC##_response.txt`),
- resultados agregados (`results.csv`),
- resumen de pass/fail (`summary.txt`),
- registro de ejecución reproducible (`RUNLOG.md`).
- Script de ejecución sistemática: scripts/systematic_cases.sh
- Reglas de oráculo documentadas en `design/oracle_rules.md`.
- Casos de prueba sistemáticos documentados en `design/test_cases.md`.

---

## Retos y notas

- Definir oráculos para un sistema conversacional implicó evitar validaciones basadas únicamente en texto libre.
- Fue necesario distinguir entre **oráculos mínimos** (robustos y seguros) y **oráculos estrictos** (más específicos pero con mayor riesgo de falsos negativos).
- El diseño de particiones de equivalencia requirió interpretar correctamente el dominio funcional del chatbot y sus límites declarados.

---

## Lecciones aprendidas

- El uso de **pruebas sistemáticas** mejora la defendibilidad frente a pruebas exploratorias o ad-hoc.
- Los **oráculos explícitos** son fundamentales para evaluar sistemas de IA de forma objetiva.
- La evidencia reproducible y versionada fortalece la calidad técnica y académica del trabajo.
- Probar un único endpoint bien seleccionado aporta mayor valor que intentar cubrir todo el sistema superficialmente.

---

## Próximos pasos

- Refinar las reglas de oráculo estrictas para reducir ambigüedad semántica.
- Extender el diseño sistemático a otros endpoints críticos del SUT.
- Incorporar métricas no funcionales (latencia y disponibilidad) a las ejecuciones.
- Evaluar la integración de estos scripts en un flujo de CI/CD.
- Preparar la presentación del diseño, decisiones metodológicas y amenazas a la validez.

---

**Preparado por:** Equipo 3  
**Próxima revisión:** Semana 5