# QA Doctorado 2026 - Equipo 3

## Descripción del Proyecto

Este repositorio contiene todo el trabajo y documentación para el proyecto QA Doctorado 2026 del Equipo 3.

## Estructura del Repositorio

- `setup/` - Scripts de configuración del entorno
- `scripts/` - Scripts de pruebas y mediciones
- `evidence/` - Recolección de evidencias semanales
- `quality/` - Escenarios de calidad y glosario
- `risk/` - Evaluación de riesgos y estrategia de pruebas
- `design/` - Diseño de casos de prueba y reglas de oráculo
- `ci/` - Configuración de integración continua
- `memos/` - Memorandums de progreso semanal
- `reports/` - Reportes de unidad
- `study/` - Materiales del estudio de investigación
- `paper/` - Paper final
- `slides/` - Materiales de presentación
- `peer_review/` - Materiales de revisión por pares

## Primeros Pasos

Revisar los acuerdos de equipo. [Agreements](./AGREEMENTS.md)

## Instalación del SUT

Las instrucciones de instalación de encuentran en [Instalación](https://github.com/ocontreras309/ChatBotProject)

### Instrucciones de ejecución del proyecto

Ejecute `make` para ver la lista de commandos disponibles.

Si su entorno (SO), no cuenta con con `make` entonces revise y ejecute los scripts de configuración en `setup/`, en el orden conveniente.

Comandos:

- `make setup` permite preparar el entorno de la aplicación
- `make start-chatbot` Iniciar la aplicación del Chatbot
- `make healthcheck` Verificar la salud del sistema
- `make smoke` Ejecutar pruebas de humo
- `make test-latency` Medir la latencia del sistema
- `make quality-gate` Ejecutar quality gates
- `make clean` Limpiar archivos temporales

## Miembros del Equipo

- APRILI JUSTINIANO ROBERTO
- CONTRERAS CARRASCO OSCAR
- FUENTES QUISPE FELIX BERNARDO
- HUANCA SEVILLA DANNY LUIS
- ROJAS GUERRERO DYDIER JOSE

