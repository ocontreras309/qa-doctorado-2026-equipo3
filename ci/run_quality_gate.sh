#!/bin/bash

set -euo pipefail

OUT_DIR="evidence/week5"
mkdir -p "${OUT_DIR}"

cp -f evidence/week2/*.log  "${OUT_DIR}/"

RUNLOG="${OUT_DIR}/RUNLOG.md"
{
  echo "# RUNLOG - Semana 5"
  echo ""
  echo "- Fecha: $(date -u +"%Y-%m-%d %H:%M:%S UTC")"
  echo "- Comando: ci/run_quality_gate.sh"
  echo ""
  echo "## Pasos ejecutados"
} > "${RUNLOG}"

source ChatBotProject/venv/bin/activate
python ./ci/run_quality_gate.py
deactivate

SUMMARY="${OUT_DIR}/SUMMARY.md"
{
  echo "# Resumen - Semana 5 (Quality Gate)"
  echo ""
  echo "## Evidencia generada"
  echo "- Quality gate 1: ${OUT_DIR}/evidence_gate1.log"
  echo "- Quality gate 2: ${OUT_DIR}/evidence_gate2.log"
  echo "- Quality gate 3: ${OUT_DIR}/evidence_gate3.log"
  echo ""
  echo "## Nota"
  echo "Este gate prioriza checks deterministas (alta señal / bajo ruido)."
} > "${SUMMARY}"

echo "" >> "${RUNLOG}"
echo "## Evidencia producida" >> "${RUNLOG}"
echo "- ${SUMMARY}" >> "${RUNLOG}"
echo "- ${OUT_DIR}/evidence_gate1.log" >> "${RUNLOG}"
echo "- ${OUT_DIR}/evidence_gate2.log" >> "${RUNLOG}"
echo "- ${OUT_DIR}/evidence_gate3.log" >> "${RUNLOG}"

echo "✅ Quality gate completado. Evidencia en ${OUT_DIR}/"
