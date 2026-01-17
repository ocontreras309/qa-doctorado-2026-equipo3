# Makefile para el Proyecto QA Doctorado

.PHONY: help setup start-petstore stop-petstore healthcheck smoke test-latency clean

# Objetivo por defecto
help:
	@echo "Objetivos disponibles:"
	@echo "  setup          - Configurar el entorno"
	@echo "  start-chatbot  - Iniciar la aplicación del Chatbot"
	@echo "  stop-chatbot   - Detener la aplicación del Chatbot"
	@echo "  healthcheck    - Verificar la salud del sistema"
	@echo "  smoke          - Ejecutar pruebas de humo"
	@echo "  test-latency   - Medir la latencia del sistema"
	@echo "  clean          - Limpiar archivos temporales"

setup:
	@echo "Configurando entorno..."
	chmod +x setup/*.sh scripts/*.sh
	./setup/run_sut.sh

start-chatbot:
	./setup/run_sut.sh

stop-chatbot:
	./setup/stop_sut.sh

healthcheck:
	./setup/healthcheck_sut.sh

smoke:
	./scripts/smoke.sh

clean:
	rm -rf tmp/
	rm -f *.log
