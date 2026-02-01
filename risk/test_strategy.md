# Estrategia de Pruebas Basada en Riesgo (Semana 3)

## Propósito
Aplicar *risk-based testing* para reducir la incertidumbre de calidad bajo restricciones reales de tiempo y recursos. La estrategia prioriza riesgos según su severidad (impacto × probabilidad) y establece trazabilidad explícita **Riesgo → Escenario → Evidencia → Oráculo**, dejando claramente declarado el **riesgo residual** aceptado en esta etapa.

## Alcance (por ahora)
**Cubre:**
- Escalabilidad básica del manejo de memoria conversacional ante múltiples usuarios (Q4).
- Disponibilidad mínima del sistema frente a fallos de la API externa de OpenAI (Q1).
- Baseline de latencia extremo a extremo (RTT) desde Bolivia hacia ChatGPT para distintos tipos de payload (Q3).

**No cubre todavía:**
- Pruebas de carga concurrente real ni pruebas de estrés.
- Evaluaciones de seguridad ofensiva (prompt injection avanzado, authn/authz).
- SLA de producción ni mediciones en infraestructura distribuida.

## Top 3 riesgos priorizados (matriz: `risk/risk_matrix.csv`)

| Riesgo (ID) | Por qué es Top | Escenario | Evidencia (Semana 3) | Oráculo mínimo | Riesgo residual |
|---|---|---|---|---|---|
| **R5: Escalabilidad (memoria conversacional)** | Mayor score por alta probabilidad e impacto. La arquitectura actual no aísla correctamente el contexto entre sesiones concurrentes. | Q4 | `evidence/week2/memory_behavior.json`<br>`evidence/week3/R5_escalabilidad_sessions.log` | **Fail** si existe contaminación de contexto entre sesiones; **Pass** si cada sesión mantiene coherencia. | No se evalúa concurrencia real ni entornos distribuidos; el riesgo persiste hasta rediseñar la gestión de estado. |
| **R1: Disponibilidad (dependencia API externa)** | Impacto máximo: una interrupción del proveedor externo bloquea completamente el servicio. | Q1 | `evidence/week2/availability.csv` | **Pass** si el fallo se maneja con error controlado; **Fail** si el sistema se bloquea o expone errores no manejados. | No garantiza disponibilidad sostenida ni resiliencia (sin retries, fallback o circuit breakers). |
| **R3: Latencia (RTT internacional)** | Latencia elevada y variable en escenarios multimedia, afectando directamente la experiencia del usuario. | Q3 | `evidence/week2/latency.csv`<br>`evidence/week2/latency_detailed.csv` | **Pass** si RTT ≤ 2.0 s; **Fail** si RTT > 2.0 s. | Las mediciones son locales y sin carga; no generalizan a producción ni evalúan concurrencia. |

## Reglas de evidencia (disciplina mínima)
- Toda evidencia de la semana se guarda en `evidence/week3/` o se referencia explícitamente desde `evidence/week2/`.
- Cada evidencia debe indicar **cómo se generó** (script, comando o procedimiento) y su **oráculo** (pass/fail).
- La evidencia de Semana 2 se utiliza como **línea base observacional** para justificar la priorización de riesgos.
- Toda la ejecución y reutilización de evidencia queda documentada en `evidence/week3/RUNLOG.md`.

## Riesgo residual (declaración)
Aun mitigando los riesgos R5, R1 y R3, persisten riesgos asociados a seguridad, comportamiento bajo carga real y validez externa de las mediciones. Este riesgo residual se acepta de forma consciente en esta etapa, dado que el objetivo del módulo es construir evidencia **reproducible y defendible** sobre escenarios fundamentales, antes de ampliar el alcance hacia pruebas concurrentes, resiliencia avanzada o entornos de producción.

## Validez (amenazas y límites)
- **Interna:** la variabilidad de red y el estado del proceso pueden influir en la latencia; se mitiga registrando múltiples ejecuciones.
- **Constructo:** el RTT medido es un proxy de experiencia percibida, no un SLA de rendimiento.
- **Externa:** los resultados dependen del entorno local y de la conectividad internacional desde Bolivia, por lo que no se generalizan sin cautela.