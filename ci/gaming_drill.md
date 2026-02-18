# Semana 6 — Gaming Drill del Quality Gate (Goodhart) + Endurecimiento

## Táctica de gaming elegida (ejemplo)
**Táctica:** Se debilita el quality gate 3 de la semana 5, que consiste en evaluar cuantitativamente la respuesta del chatbot a una pregunta. Para tal efecto se utilizó la métrica del Jaccard score:

- Para evaluar la robustez de las respuestas, es ideal un Jaccard score mayor o igual a 0.5.
- Si el valor es inferior a este umbral, entonces las respuestas no son coherentes.
- La debilitación de este quality gate consistió en forzar que el valor del Jaccard score sea mayor o igual a cero, de tal manera que todas las pruebas pasen.
- La defensa técnica consiste en determinar si el test pasa cuando el Jaccard score está entre 0 y 0.5.

**Por qué es plausible:** la respuesta del modelo se considerará coherente aún en los casos en que no lo es de acuerdo al valor del Jaccard score.

## Qué demuestra este drill
- **Antes:** El umbral del Jaccard score es `>= 0` para que todas las pruebas de coherencia pasen.
- **Después:** Al aplicar un rango para el umbral del Jaccard score tales que `0 <= umbral < 0.5`, entonces el bypass queda detectado.

## Cómo ejecutar (local)
1) Ejecutar:
   - `make gaming-drill`
2) Revisar:
   - `evidence/week6/before/`
   - `evidence/week6/after/`
   - `evidence/week6/summary.txt`

## Artefactos protegidos por integridad (baseline)
- `scripts/systematic_cases.sh`
- `design/oracle_rules.md`
- `design/test_cases.md`

> Si se cambian intencionalmente, actualizar `ci/gate_integrity_baseline.txt` y registrar el cambio en `ci/gate_change_log.md`.