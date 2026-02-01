# RUNLOG — Semana 3

**Fecha**: 2026-01-31 (referencial)  
**SUT**: Aplicación ChatBot
**Objetivo**: recopilar evidencia para los Top 3 riesgos (R1–R3) definidos en `risk/risk_matrix.csv`.

1) Escalabilidad de la petición (Q4 / Riesgo R1)
- Comando: `./scripts/riskbased.sh`
- Oráculo: El modelo debe preservar coherencia y orden aún con varios usuarios
- Artefactos: `./scripts/riskbased.py`

2) Disponibilidad (Q1 / Riesgo R2)
- Comando: `./scripts/riskbased.sh`
- Oráculo: ningún debe retornar códigos diferentes a 200
- Artefactos: `./scripts/riskbased.py`

3) Baseline de latencia local (Q2 / Riesgo R3)
- Comando: `./scripts/riskbased.sh`
- Oráculo: registrar `time_total` por cada ejecución
- Artefactos: `./scripts/riskbased.py`

## Copia a carpeta de semana
- Acción: `cp -r evidence/week2/* evidence/week3/`
- Motivo: trazabilidad de entregables por semana (sin cambiar scripts en este ejemplo).