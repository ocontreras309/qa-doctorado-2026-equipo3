# Memo de Progreso – Semana 4

**Fecha:** 13/02/2026  
**Equipo:** Equipo 3  
**Semana:** 5 de 8

---

## Objetivos de la semana

- Definir un **quality gate** alineado a riesgos priorizados (Semana 3).
- Implementar el gate en CI para ejecutar checks confiables y producir evidencia descargable.
- Mantener el gate con foco en **alta señal / bajo ruido** (evitar falsos positivos).

---

## Logros

- Documento del gate creado: `ci/quality_gates.md` (checks, oráculos y relación con riesgos/oráculos previos).
- Script de ejecución local del gate: `ci/run_quality_gate.sh` (genera `evidence/week5/`).
- Workflow de CI agregado: `.github/workflows/ci.yml` (ejecuta el gate en push/PR y publica artifacts).
- Makefile extendido con target `quality-gate` para reproducir localmente el flujo de CI.
- README actualizado con instrucciones y ubicación de evidencias.

---

## Evidencia principal

- Definición del gate: `ci/quality_gates.md`.
- Ejecución local del gate: `ci/run_quality_gate.sh` + `make quality-gate`.
- CI workflow: `.github/workflows/ci.yml`.
- Evidencia producida: `evidence/week5/` (artifact en CI).

---

## Retos y notas

- Se evitó usar latencia como criterio de fallo del gate para reducir ruido (variabilidad del entorno en CI).
- El gate prioriza las respuestas básicas que el chatbot debe proporcionar ante preguntas del usuario.
- El gate prioriza checks deterministas basados en códigos HTTP, JSON bien formado y reglas de oráculo.

---

## Lecciones aprendidas
- Un quality gate sencillo asegura de que se están cumplimiendo los requisitos mínimos del software funcional.
- Conectar gate a riesgos y oráculos existentes mejora trazabilidad y reduce discusiones subjetivas.

---

## Próximos pasos (semana 6)

- Definir cómo reportar estabilidad del gate (sin introducir ruido).
- Revisar criterios de aceptación por iteración y declaración de riesgo residual.

---

**Preparado por:** Equipo 3  
**Próxima revisión:** Semana 5