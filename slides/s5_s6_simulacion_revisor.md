# Evaluación de Propuesta - Equipo 3
**Propuesta evaluada:** (C) — Empresa: NorthStar  
**Veredicto:** (Rechazar)

> Regla: Todo punto debe estar **respaldado por la propuesta**.
> Si algo no está en la propuesta, debe ir en "Vacíos" o "Preguntas", no como afirmación.

---

## Slide 1 — Qué ofrece la propuesta (solo hechos del texto)
- Objetivo declarado: Proponer un programa integral basado en evidencia reproducible y gobernanza del quality gate, para sostener calidad continua sin frenar el flujo.
  **Referencia:** Sección 1
- Alcance / exclusiones (2+ puntos):
  - **Sección 3** Incluye escenarios (6–10) con evidencia, matriz y estrategia Top 3, diseño sistemático (≥12 casos), oráculos mínimos/estrictos, gate CI con artifacts, política de excepciones y registro de cambios.
  - **Sección 3** Excluye performance a gran escala y pruebas de seguridad especializadas. 
- Entregables principales (3+ puntos):  
  - **Sección 4** Construcción de un baseline reproducible para escenarios básicos (disponibilidad, robustez, consistencia).
  - **Sección 4. Fase 2**  Matriz de riesgo impacto×probabilidad, validada en sesión técnica rápida.
  - **Sección 4. Fase 2** Clasificación de checks: críticos (must-pass) vs informativos.
  - **Sección 4. Fase 3** Oráculos mínimos para definir pass/fail sin ambigüedad y oráculos estrictos para puntos críticos.
  - **Sección 4** Evidencia por caso y resumen de resultados.
  - **Ref: Sección 4. Fase 4** Gate CI con checks críticos bloqueantes y publicación de artifacts.
  - **Ref: Sección 4. Fase 4** Checks no funcionales inicialmente informativos hasta estabilizar baseline.
  - **Ref: Sección 4. Fase 5** Ajuste de umbrales no funcionales para lograr estabilidad de flujo.
  - **Ref: Sección 4. Fase 5** Activación de política de excepciones cuando un check no funcional bloquea entregas y existe justificación operativa.

---

## Slide 2 - Fortalezas (basadas en texto)
> 3-5 fortalezas. Cada una debe citar una sección.

- F1: Matriz de riesgo probablidad*riesgo  
  **Evidencia en propuesta:** Sección 4  
  **Por qué es valioso:** Esto permite priorizar los tests a ejecutar en el SUT y también definir los riesgos residuales.
- F2: Verificación de robustez
  **Evidencia en propuesta:** Sección 4
  **Por qué es valioso (1 frase):** El chatbot debe responder de manera coherente a preguntas del usuario
- F3: Entrega incremental: gate operativo en semana 6 y estabilización en semana 7.  
  **Evidencia en propuesta:** Sección 7  
  **Por qué es valioso:** De esta manera, se realiza un seguimiento más efectivo del trabajo que está realizando la emrpesa.

---

## Slide 3 - Debilidades / riesgos (basadas en texto)
> 3-6 debilidades. Marcar severidad: **Crítica / Mayor / Menor**.
> Cada debilidad debe citar una sección de la propuesta.

- D1 (Severidad: 4/5): Precio

  **Texto/Sección relacionada:** Sección 7
  **Riesgo/impacto (1 frase):** Alto

- D2 (Severidad: 4/5): Propuesta no adecuada para chatbots conversacionales

  **Texto/Sección relacionada:** Sección 4  
  **Riesgo/impacto:** Alto

- D3 (Severidad: 3/5): Metodología propuesta y oráculos para sistemas transaccionales tradicionales, pero no para NLP

  **Texto/Sección relacionada:** Sección 4
  **Riesgo/impacto:** Medio-alto

---

## Slide 4 - Cobertura explícita vs vacíos
### A) Lo que la propuesta sí define (3-5 puntos)
- ___ **Ref:** Sección 7 ___ Costos y cronograma
- ___ **Ref:** Sección 6 ___ Gobernanza
- ___ **Ref:** Sección 4 ___ Metodología de trabajo claramente establecida

### B) Vacíos/ambigüedades que impiden evaluar bien (3-5 puntos)
- Vacío 1: No se define criterio cuantitativo del gate
  **Qué falta exactamente:** Umbrales de consistencia del jaccard score del chatbot  
  **Por qué importa:** Esencial para medir las respuestas coherentes
- Vacío 2: Auditoría mensual de excepciones, pero no indica quién la realiza ni con qué criterios.  
  **Qué falta exactamente:** Debe haber un responsable de auditoría de parte de la empresa.  
  **Por qué importa:** Necesario por políticas de nuestra organización
- Vacío 3: Procedimiento de integración de las pruebas con los procesos de CI  
  **Qué falta exactamente:** No indica qué herramientas se van a usar para integrar los tests en el CI
  **Por qué importa:** Políticas organizacionales requieren este procedimiento.

### C) Preguntas de aclaración al proveedor (2-4 preguntas)
- P1: ¿Qué herramientas van a usar para el CI?
- P2: ¿Qué métricas evaluativas usarán para la coherencia de respuestas del chatbot?
- P3 :¿Podrían adecuar su propuesta económica a nuestras necesidades?

---

## Slide 5 — Goodhart / Gaming (solo si se deriva del texto)
> Debe basarse en señales explícitas del documento (ej.: "mantener gate verde", "ajustar umbrales", "excepciones", "reruns", etc.)

- Señal en la propuesta (citar): Posibilidad de trabajar con umbrales para los game drills. 
  **Referencia:** Sección 5

---

## Slide 6 - Condiciones para aceptar (solo si el veredicto lo requiere)
> 2-4 condiciones **verificables**. Deben apuntar a corregir debilidades o llenar vacíos.

- C1: Presupuesto  
  **Cómo se verifica:** A través de la propuesta de costos y tiempos
  **Motivo (D# o Vacío #):** Debilidad 1
- C2: Deben existir métricas cuantitativas para evaluar el modelo
  **Cómo se verifica:** D2
  **Motivo:** No cuenta con métricas cuantitativas.

---

## Slide 7 - Veredicto (decisión final)
- Decisión: NO
- Justificación (máximo 3 puntos, conectados a D# o Vacíos):
  1) Precio fuera de rango (D1)
  2) No incorpora métricas cuantitativas (D2)
  3) Continuous integration (Vacío 3)