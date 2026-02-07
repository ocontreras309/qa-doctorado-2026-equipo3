# Presentación Equipo 3 — Revisión Semanas 3 y 4 (Máx. 6 slides)

[Presentación en Google Slides](https://docs.google.com/presentation/d/1qgysQyxJGwgGd2dR-b8c8FYOlYhsajVsLOYiIzfaXQQ/edit?usp=sharing)

---

## Slide 1 — Priorización de riesgos
**SUT:** Sistema de Chatbot conversacional
**Fuente (repo):** `risk/risk_matrix.csv`

**Top 3 riesgos (score + justificación breve):**
| Id | Atributo        | Descripción                                                                 | Causa                                                                 | I | P | Score | Motivo                                                                                                                                 | Evidencia                                                                                                  | Escenario              |
|----|-----------------|------------------------------------------------------------------------------|------------------------------------------------------------------------|---|---|-------|----------------------------------------------------------------------------------------------------------------------------------------|------------------------------------------------------------------------------------------------------------|------------------------|
| 5  | Escalabilidad   | El chatbot con memoria no gestiona correctamente múltiples usuarios concurrentes, generando respuestas incoherentes o mezcladas. | Manejo inadecuado del estado y de las sesiones en la implementación de memoria de LLM. | 4 | 5 | 20    | La arquitectura actual no fue diseñada para concurrencia y presenta una alta probabilidad de fallo al escalar a múltiples usuarios. | evidence/week2/smoke_test_20260122_232253.log<br>evidence/week3/scalability.log                              | quality/scenarios.md#Q4 |
| 1  | Disponibilidad  | El servicio deja de responder cuando la API externa de OpenAI no está disponible o alcanza límites de uso.                     | Dependencia directa de un proveedor externo sin mecanismos de degradación o fallback. | 5 | 3 | 15    | El sistema depende completamente de un servicio externo, lo que introduce un riesgo significativo de indisponibilidad parcial o total. | evidence/week2/smoke_test_20260122_232253.log<br>evidence/week3/availability.log                             | quality/scenarios.md#Q1 |
| 3  | Latencia        | El tiempo de respuesta aumenta significativamente al procesar solicitudes que incluyen audio o imágenes de gran tamaño.      | Procesamiento intensivo de archivos multimedia sin optimización ni control de recursos. | 4 | 3 | 12    | El procesamiento multimedia es costoso en términos computacionales y afecta de forma perceptible la experiencia del usuario. | evidence/week2/latency.csv                                                                                  | quality/scenarios.md#Q2 |

## Slide 2 — Semana 3: trazabilidad (Riesgo → Escenario → Evidencia → Oráculo → Residual)
**Fuente (repo):** `risk/test_strategy.md` y `evidence/week3/`

| Riesgo (ID) | Por qué es Top | Escenario | Evidencia (Semana 3) | Oráculo mínimo | Riesgo residual |
|-------------|---------------|-----------|----------------------|----------------|-----------------|
| **R5: Escalabilidad (memoria conversacional)** | Mayor score por alta probabilidad e impacto. La arquitectura actual no aísla correctamente el contexto entre sesiones concurrentes. | Q4 | evidence/week2/smoke_test_20260122_232253.log<br>evidence/week3/scalability.log | **Fail** si existe contaminación de contexto entre sesiones; **Pass** si cada sesión mantiene coherencia. | No se evalúa concurrencia real ni entornos distribuidos; el riesgo persiste hasta rediseñar la gestión de estado. |
| **R1: Disponibilidad (dependencia API externa)** | Impacto máximo: una interrupción del proveedor externo bloquea completamente el servicio. | Q1 | evidence/week2/smoke_test_20260122_232253.log<br>evidence/week3/availability.log | **Pass** si el fallo se maneja con error controlado; **Fail** si el sistema se bloquea o expone errores no manejados. | No garantiza disponibilidad sostenida ni resiliencia (sin retries, fallback o circuit breakers). |
| **R3: Latencia (RTT internacional)** | Latencia elevada y variable en escenarios multimedia, afectando directamente la experiencia del usuario. | Q2 | evidence/week2/latency.csv | **Pass** si RTT &lt; 2.0 s; **Fail** si RTT &gt; 2.0 s. | Las mediciones son locales y sin carga; no generalizan a producción ni evalúan concurrencia. |

---

## Slide 3 — Semana 3: riesgo residual (qué queda fuera y por qué)

| Escenario           | Riesgo                                                                                                                                 | Calificación | Justificación                                                                                                                      | Acciones de mejora                                                                 |
|---------------------|----------------------------------------------------------------------------------------------------------------------------------------|--------------|-------------------------------------------------------------------------------------------------------------------------------------|-----------------------------------------------------------------------------------|
| Robustez            | El sistema podría exponer información sensible o comportamientos no deseados ante intentos de prompt injection.                     | 5            | El modelo de lenguaje está equipado con mecanismos básicos de protección, la probabilidad es baja.                                 | Validar por medio de expresiones regulares e inyectando caracteres especiales.   |
| Seguridad de datos  | La API key podría exponerse en logs o mensajes de error.                                                                               | 5            | El API key se almacena en una variable de entorno, no está en el código.                                                            | Limitar la información visible en las respuestas.                                 |
| Precisión           | El chatbot entrega respuestas incorrectas ante preguntas complejas que requieren razonamiento numérico.                            | 4            | GPT-3.5 Turbo es particularmente avanzado en abordar las preguntas realizadas.                                                     | Probar en escenarios de cálculos complejos que involucren precios y números de participantes. |

---

## Slide 4 — Semana 4: objeto de prueba + técnica sistemática
**Objeto de prueba (endpoint/función):** `POST /chatmemory`
**Fuente (repo):** `design/test_cases.md`

**Justificaciones**
- Es el endpoint del chatbot principal del SUT.
- Las preguntas y respuestas pueden ser evaluadas mediante diversas métricas.

---

**Técnica utilizada:**
**EO:** Existencia de tokens específicos en la respuesta.

---

**Cobertura**
Se afirma que el endpoint responde correctamente a preguntas básicas.  
No se afirma la funcionalidad ante escenarios más complejos.

---

**Cómo se derivaron los casos:**
Enfoque en preguntas y respuestas coherentes.

## Slide 5 — Semana 4: oráculos defendibles (mínimos vs estrictos)
**Fuente (repo):** `design/oracle_rules.md` y `evidence/week4/`

## Reglas mínimas

- **OR1 (Formato):**  
  El resultado de cada ejecución debe ser devuelto en formato JSON.

- **OR2 (Presencia de `content`):**  
  La respuesta debe contener el atributo `content`.

- **OR3 (No 5xx):**  
  La respuesta no debe retornar códigos 5xx en ningún caso.

---

## Reglas por partición

- **OR4 (Precios de cursos en moneda corriente):**  
  Si el usuario pregunta por el precio de un curso, en la respuesta debería figurar el texto **"Bs"** o **"Bolivianos"**.

- **OR5 (Preguntas sobre temas que el modelo no conoce):**  
  Si se hace una pregunta sobre algo que el modelo no conoce, debería figurar la cadena  
  `info.cebtic@gmail.com`  
  en la respuesta.

---

## Reglas estrictas

- **OR6 (Información correcta al pedir la ubicación del instituto):**  
  Si el usuario pide la dirección del instituto, la cadena de respuesta debería contener  
  **"Av. América Este"** y **"Cochabamba"**.

---

## Ambigüedad detectada

> **Nota:** Probar el endpoint con base en los precios de los cursos o sus fechas de inicio.

## Slide 6 — Validez + mejora concreta
## Amenazas a la validez

- **Interna:**  
  El estado o los datos del SUT pueden cambiar y afectar si un `{}` retorna valores desconocidos.  
  **Mitigación:** Usar oráculos que no dependan de valores desconocidos.

- **Constructo:**  
  Usar códigos JSON como proxy de *robustez* no cubre otras dimensiones (seguridad, integridad).  
  **Mitigación:** Declarar explícitamente el alcance del atributo evaluado (manejo de entradas y estabilidad de respuesta).

- **Externa:**  
  Los resultados dependen del entorno (local, red, versión del SUT).  
  **Mitigación:** Registrar el entorno y repetir en otra máquina o instancia si se requiere generalización.

---

## Mejora concreta

Utilizar métricas cuantitativas para modelos de lenguaje para validar la coherencia de las respuestas.

---

## Aspectos defendibles

- Validez esencial del retorno de las respuestas.

---

## Limitaciones

- No se utilizaron métricas evaluativas específicas para LLMs.
