# Plantilla de Presentación — Semanas 1 y 2 (Máx. 5 slides)

> **Regla:** máximo 5 “slides” (secciones).  
> **Tiempo total presentación:** 8-10 minutos.  

---

## Slide 1 — Semana 1 (Pregunta 1 + Respuesta 1)
**¿Qué tipo de evidencia de pruebas reduce incertidumbre sobre calidad sin confundir “testing” con “quality assurance”?**

* Testing se enfoca en el producto final, es decir el software a evaluar
* Quality assurance implica el control del proceso para asegurar la calidad del software.
* En ese contexto, las pruebas realizadas durante la primera y segunda segunda semana se enfocaron únicamente en la funcionalidad del software


**Evidencias planeadas (cada uno con oráculo + archivo):**
- **Prueba 1:** Verificar que la aplicación del chatbot devuelve código 200 al visitar la página principal, es decir al acceder a http://localhost:8000/ el backend devuelve el código de estado HTTP 200. Caso contrario se reporta como fallo

- **Prueba 2:** Verificar que al intentar llamar a un endpoint no válido, la aplicación devuelve un código de estado 404. De otra manera, se considera un fallo.

- **Prueba 3:** Verificar que al hacer el llamado al endpoint /chat, la aplicación retorna código HTTP 200. Caso contrario se reporta como fallo

- **Prueba 4:** Verificar que  al llamar al endpoint /chat por medio de un método POST con el prompt de la pregunta, retorna un resultado con la estructura {"content": "..."}. Caso contrario se reporta como fallo

- **Prueba 5:** Verificar que al llamar al endpoint /chatmemory retorna código HTTP 200. Caso contrario se reporta como fallo

- **Prueba 6:** Verificar que al llamar al endpoint /chatmemory enviando el prompt de la pregunta, se devuelve una respuesta con el formato {"content": "..."}. Caso contrario se reporta como fallo

**Límite (1 línea):**  
No se consideraron aspectos de seguridad en la elaboración de las pruebas.

---

## Slide 2 — Semana 2 (Pregunta 2 + Respuesta 2)
**Pregunta 2:** ¿Cómo convertir “calidad” en afirmaciones falsables y medibles?

**Respuesta 2:**
- Primero: Identificar los componentes y elementos del software se van a evaluar.
- Segundo: Definir métricas, es decir, operacionalizar las variables a medir. Por ejemplo: Latencia de un componente podría medirse a través del tiempo que toma la respuesta a un endpoint. Corrección medida de el punto de vista del número de tests unitarios y de integración aprobados.
- Tercero: Definir una hipótesis bien documentada
- Cuarto: Validar la hipótesis a través de pruebas estadísticas.


**Tabla de escenarios de S2 (elige 2 “estrella”):**

- **Escenario A**:  
  **E:** Llamado al endpoint `/chat` mediante método GET  
  **Entorno:** Aplicación web del chatbot en ejecución (`http://localhost:8000`)  
  **R:** El backend responde correctamente al endpoint  
  **Medida:** Código de estado HTTP  
  **Evidencia:** `evidence/week2/chat_status.txt`  
  **Falsación:** El código HTTP es distinto de 200  

- **Escenario B**:  
  **E:** Llamado al endpoint `/chat` mediante método POST enviando un prompt válido  
  **Entorno:** Aplicación web del chatbot en ejecución (`http://localhost:8000`)  
  **R:** El backend retorna una respuesta con estructura válida  
  **Medida:** Estructura del payload de respuesta  
  **Evidencia:** `evidence/week2/chat_response.json`  
  **Falsación:** La respuesta no contiene el campo `content` o no sigue el formato `{ "content": "..." }`


**Tabla de evidencias de ejecución de los escenarios:**
| Claim | Escenario | Métrica | Evidencia (archivo) | Oráculo (pass/fail) |
|------|----------|---------|----------------------|---------------------|
| Endpoint /chat disponible | Prueba 3 – GET /chat | http_code | evidence/smoke/chat_status.txt | pass si HTTP 200 |
| Respuesta válida de /chat | Prueba 4 – POST /chat con prompt | estructura de respuesta | evidence/smoke/chat_response.json | pass si retorna {"content": "..."} |

---

## Slide 3 — Método formalizado (¿cómo trabajamos para definir escenarios?.)
**Proceso aplicado:**
1) Se definió el sistema bajo pruebas (SUT), que es un sistema chatbot basado en la plataforma de OpenAI.
2) De acuerdo al manifiesto ágil, se definió una planificación para reuniones, objetivos por cada un reunión, resultados esperados y manejo de conflictos.
3) Se definieron una serie de escenarios de prueba para el SUT: Requisitos mínimos de correctitud y cobertura de las pruebas ejecutadas.
4) Generación de scripts para automatizar las pruebas de humo del software desarrollado.


**Fuentes para definición de método:**
- Hruschka, P., & Zdun, U. (s.f.). arc42 - Quality Requirements [Sitio web]. arc42. https://quality.arc42.org/requirements/
- Kazman, R., Klein, M., & Clements, P. (2000). ATAM: Method for architecture evaluation (CMU/SEI-2000-TR-004, ESC-TR-2000-004). Software Engineering Institute, Carnegie Mellon University. https://www.sei.cmu.edu/documents/629/2000_005_001_13706.pdf
- Starke, P., & Zdun, U. (s.f.). arc42 - Section 10: Quality Requirements [Sitio web]. arc42. https://docs.arc42.org/section-10/


---

## Slide 4 — Amenazas a la validez 
**Amenazas a la validez (mínimo 3) + mitigación futura:**
- **Validez interna:** Entorno de ejecución contiene diferentes capacidades en memoria y en procesamiento que el entorno de producción.
- **Validez del constructo:** Las pruebas de humo no incluyen todos los endpoints de la aplicación final. Mecanismo de mitigación: Agregar más pruebas de ejecución de los endpoints, mejorar el code-coverage.
Los resultados están influidos por el entorno en que se ejecutan las pruebas.
- **Validez externa:** El servicio web de OpenAI no está disponible para atender peticiones del cliente.

---

## Slide 5 — Cierre (2 conclusiones)
- **Evidencia más fuerte:** Correctitud -> Todos los escenarios de las pruebas de humo son aprobatorios. Latencia -> Al menos 4 de los 6 escenarios planteados resultan en un tiempo de ejecución inferior a 1 segundo.
- **Límite más crítico:**  No se realizaron pruebas de coherencia de las respuestas provistas por el modelo de lenguaje.
- **Siguiente mejora concreta:** Incluir pruebas unitarias, de integración y de aceptación.


---

Enlace a las diapositivas:
[Presentación – 24/01/2026](https://docs.google.com/presentation/d/13BbEmc3dXS41HVHOhJ7HVUCHVoGWXhYhYZKzdHtCtZ8/edit?usp=sharing)


---