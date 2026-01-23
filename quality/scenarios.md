## Documentación de escenarios de pruebas de humo para la aplicación del Chatbot

Para efectos de esta actividad se han desarrollado seis casos de prueba cuya documentación se describe a continuación. El propósito de estas pruebas es verificar la funcionalidad básica de la aplicación a nivel de endpoints. La lógica de implementación de las pruebas automatizadas se encuentra en el archivo scripts/common.sh

**Prueba 1:** Verificar que la aplicación del chatbot devuelve código 200 al visitar la página principal, es decir al acceder a http://localhost:8000/ el backend devuelve el código de estado HTTP 200. Caso contrario se reporta como fallo

**Prueba 2:** Verificar que al intentar llamar a un endpoint no válido, la aplicación devuelve un código de estado 404. De otra manera, se considera un fallo.

**Prueba 3:** Verificar que al hacer el llamado al endpoint /chat, la aplicación retorna código HTTP 200. Caso contrario se reporta como fallo

**Prueba 4:** Verificar que  al llamar al endpoint /chat por medio de un método POST con el prompt de la pregunta, retorna un resultado con la estructura {"content": "..."}. Caso contrario se reporta como fallo

**Prueba 5:** Verificar que al llamar al endpoint /chatmemory retorna código HTTP 200. Caso contrario se reporta como fallo

**Prueba 6:** Verificar que al llamar al endpoint /chatmemory enviando el prompt de la pregunta, se devuelve una respuesta con el formato {"content": "..."}. Caso contrario se reporta como fallo
