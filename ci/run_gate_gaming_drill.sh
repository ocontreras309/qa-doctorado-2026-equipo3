#!/bin/bash

OUT_DIR="evidence/week6"

mkdir -p ./evidence/week6/before
mkdir -p ./evidence/week6/after

RUNLOG="${OUT_DIR}/before/RUNLOG.md"
{
  echo "# RUNLOG - Semana 6"
  echo ""
  echo "- Fecha: $(date -u +"%Y-%m-%d %H:%M:%S UTC")"
  echo "- Comando: ci/run_gate_gaming_drill.sh"
  echo ""
  echo "## Pasos ejecutados"
} > "${RUNLOG}"

source ChatBotProject/venv/bin/activate
python3 ./ci/run_gate_gaming_drill.py
deactivate

echo "" >> "${RUNLOG}"
echo "## Evidencia producida" >> "${RUNLOG}"
echo "- ${SUMMARY}" >> "${RUNLOG}"
echo "- ${OUT_DIR}/before/gate_output.log" >> "${RUNLOG}"
echo "- ${OUT_DIR}/after/gate_output.log" >> "${RUNLOG}"
echo "- ${OUT_DIR}/before/SUMMARY.md" >> "${RUNLOG}"
echo "- ${OUT_DIR}/after/SUMMARY.md" >> "${RUNLOG}"

echo "✅ Gaming drill completado. Evidencia en ${OUT_DIR}/"
