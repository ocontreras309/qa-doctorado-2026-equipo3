#!/bin/bash

python3 ./scripts/risk_based.py
cp -r ./evidence/week2/* ./evidence/week3/

echo "============================================================"
echo "TODAS LAS PRUEBAS EJECUTADAS"
echo "Evidencias en week2 y week3"
echo "============================================================"
