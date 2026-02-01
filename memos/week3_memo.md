# Memo de Progreso – Semana 3

**Fecha:** 30/01/2026  
**Equipo:** Equipo 3  
**Semana:** 3 de 8  

---

## Objetivos de la semana

- Identificar y analizar los riesgos asociados al sistema bajo prueba (SUT), correspondiente a un chatbot informativo.
- Construir una matriz de riesgos considerando probabilidad e impacto.
- Priorizar los riesgos más relevantes para definir el foco de las pruebas.
- Definir una estrategia de pruebas basada en riesgo.
- Generar evidencias de prueba vinculadas explícitamente a los riesgos priorizados.

---

## Logros

Durante la Semana 3 se alcanzaron los siguientes logros:

- Se creó una **matriz de riesgos**, identificando riesgos funcionales y de robustez del chatbot.
- Se definió el **Top 3 de riesgos priorizados**, considerando impacto al usuario y probabilidad de ocurrencia.
- Se documentó una **estrategia de pruebas basada en riesgo**, enfocada principalmente en:
  - Manejo de entradas inválidas.
  - Respuestas fuera del dominio definido.
  - Consistencia en las respuestas del chatbot.
- Se generaron **evidencias de prueba estructuradas**, simulando salidas del chatbot en formato JSON.
- Las evidencias fueron **vinculadas explícitamente a los riesgos identificados**, asegurando trazabilidad entre riesgo y prueba.

---

## Evidencia principal

La evidencia principal de esta semana incluye:

- Evidencias de salida del chatbot almacenadas en:
- Archivos de registro (`.log` / `.json` / `.csv`) que documentan:
- Respuestas exitosas (`status_code = 200`)
- Respuestas ante entradas inválidas o fuera de dominio
- Estrategia de pruebas documentada y alineada a los riesgos priorizados.

---

## Retos y notas

- Definir oráculos claros para un sistema conversacional resultó desafiante debido a la naturaleza no determinista del lenguaje natural.
- Fue necesario estructurar las respuestas del chatbot con códigos de estado para facilitar la validación objetiva.
- Se requirió ajustar el alcance de las pruebas para priorizar riesgos de mayor impacto, dejando riesgos menores para iteraciones posteriores.

---

## Lecciones aprendidas

- El enfoque de **testing basado en riesgo** permite focalizar esfuerzos en los aspectos más críticos del sistema.
- Definir salidas estructuradas mejora la mantenibilidad y la trazabilidad de las pruebas.
- En chatbots, las pruebas de robustez aportan mayor valor que la validación exhaustiva de contenido.
- La priorización temprana de riesgos facilita la toma de decisiones en contextos de tiempo limitado.

---

## Próximos pasos

- Refinar la matriz de riesgos incorporando riesgos no funcionales adicionales.
- Diseñar casos de prueba más detallados a partir de los riesgos priorizados.
- Extender los scripts de prueba para cubrir escenarios críticos del chatbot.
- Incorporar métricas básicas de ejecución (latencia y disponibilidad) en las evidencias de prueba.
- Continuar alineando la estrategia de pruebas con la evolución del SUT.

---

**Preparado por:** Equipo 3  
**Próxima revisión:** Semana 4