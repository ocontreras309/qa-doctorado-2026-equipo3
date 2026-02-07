# Guía del Oponente — Revisión bisemanal (Semanas 3 y 4)

**Rol:** realizar una crítica metodológica breve y útil sobre el trabajo del equipo que presenta.  
**Enfoque:** razonamiento, trazabilidad y defendibilidad. **No** evaluar cantidad de pruebas ni cantidad de endpoints.

**Tiempo total:** 6 minutos  
- 1 min: Fortalezas  
- 3 min: Preguntas críticas  
- 2 min: Recomendaciones accionables

---

## 1) Estructura de la intervención (plantilla)

### A. Fortalezas (máx. 2)
- Fortaleza 1: Coherencia metodologicas en la gestion de riesgos, se aprecia la trazabilidad entre los riesgos y sus residuales
- Fortaleza 2: Hay evidencias de todos los casos de pruebas ejecutados para verificar la reproducibilidad del experimento

### B. Preguntas críticas (2–3 preguntas)
- Pregunta 1. Como llegaron a la conclusion del riesgo residual el R2 Robustez que priorizan la integridad de los datos sobre los errores
- Pregunta 2 ¿En qué escenario realista su enfoque podría dar una falsa sensación de calidad, aun cumpliendo todos sus oráculos
- Pregunta 3 Si tuvieran un mayor presupuesto para la generacion de pruebas, cambiaria su decision de priorizacion de los 3 top riesgos?

### C. Recomendaciones accionables (máx. 2)
- Recomendación 1: Validar endpoints de registro de datos
- Recomendación 2: Validar disponibilidad de campos mínimos versus una plantilla de datos esperados (cuantificable)

---

## 2) Lista de verificación rápida (Semanas 3 y 4)

### Semana 3 — Estrategia basada en riesgo
**Verificar en la presentación:**
- [X] Top 3 riesgos están justificados (impacto/probabilidad/score y razón breve)
- [X] Existe trazabilidad explícita: **riesgo → escenario → evidencia → oráculo**
- [X] La evidencia está referenciada con rutas del repo (ej.: `evidence/week3/...`)
- [X] Se declara el **riesgo residual** (qué queda fuera y por qué)

---

### Semana 4 — Diseño sistemático + oráculos
**Verificar en la presentación:**
- [X] Se eligió 1 objeto de prueba (endpoint/función) y se justifica
- [X] Técnica sistemática declarada (EQ/BV o pairwise) y coherente con los casos
- [X] Hay ≥ 5 reglas de oráculo (mínimas vs estrictas)
- [X] Casos y oráculos son trazables a evidencia (ej.: `evidence/week4/...`)
- [X] Se reconoce al menos 1 ambigüedad y cómo se resolvió

---