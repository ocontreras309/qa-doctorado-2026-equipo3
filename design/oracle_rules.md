# Reglas de Oráculo — Semana 4 (Chatbot)

**Objeto de prueba:** `POST /chatmemory`

Estas reglas definen criterios **pass/fail** para evaluar casos sistemáticos.  
Se distinguen reglas **mínimas** y reglas **estrictas**.

## Reglas mínimas

- **OR1 (Formato):** El resultado de cada ejecución debe ser devuelto en formato json.
- **OR2 (Presencia de "content"):** La respuesta debe contener el atributo "content".
- **OR3 (No 5xx):** la respuesta no debe retornar **5xx** en ningún caso.

## Reglas por partición (EQ)

- **OR4 (Precios de cursos en moneda corriente):** si el usuario pregunta por el precio de un curso, en la respuesta debería figurar el texto `Bs` o `Bolivianos`.
- **OR5 (Preguntas sobre temas que el modelo no conoce):** Si se hace una pregunta sobre algo que el modelo no conoce, debería figurar la cadena `info.cebtic@gmail.com` en la respuesta

## Reglas estrictas (opcional / reportar como “estrictas”)

- **OR6 (Información correcta al pedir la ubicación del instituto):** Si el usuario pide la dirección del instituto, la cadena de respuesta debería tener `"Av. América Este"` y `"Cochabamba"`