# Casos de prueba sistemáticos — Semana 4 (Chatbot)

**Técnica usada:** Equivalencia (EQ) `request_body` en `POST /chatmemory`.

## Particiones (EQ)
- **P1 (Objeto sin "data"):** `{}` objeto JSON sin atributos.
- **P2 (Preguntas sobre precios):** `{"data": "¿Cuánto cuesta el curso de Python?"}` contiene las palabras `"cuesta", "costos", "precio"`.
- **P3 (Preguntas que el modelo no conoce):** `{"data": "¿Qué días se pasa clases?"}` es una pregunta con la que el modelo no fue entrenado.
- **P4 (Preguntas sobre ubicación):** `{"data": "¿Dónde queda el instituto?"}` contiene las palabras `"dónde"`, `"ubicación"` o `"localización"`.
- **P5 (Preguntas con código SQL):** `{"data": "SELECT * FROM users"}` contiene código SQL.

## Formato de evidencia
Cada caso genera:
- `evidence/week4/<TC_ID>_response.txt`
- Registro agregado: `evidence/week4/results.csv` + `evidence/week4/summary.txt`

## Casos (≥ 12)
> Referencias a reglas: ver `design/oracle_rules.md`

| TC-ID | Input `request body` | Partición | Expected (oráculo mínimo) | Evidencia esperada |
|---|---:|---|---|---|
| TC01 | `{}` | P1 | OR1, OR2, OR3 | `TC01_response.*` |
| TC02 | `{"dat": "hola"}` | P1 | OR1, OR2, OR3 | `TC02_response.*` |
| TC03 | `{"data": "Dame el precio total de los cursos de Python y Robotica"}` | P2 | OR1, OR2, OR3, OR4 | `TC03_response.*` |
| TC04 | `{"data","Cuál es el precio del curso de Python en Bs"}` | P2 | OR1, OR2, OR3, OR4 | `TC04_response.*` |
| TC05 | `{"data": "¿Qué días se pasa clases?"}` | P3 | OR1, OR2, OR3, OR5 | `TC05_response.*` |
| TC06 | `{"data": "Dame el precio del curso de Robótica en Dolares"}` | P3 | OR1, OR2, OR3, OR5 | `TC06_response.*` |
| TC07 | `{"data":"Cuál es el contenido del curso de Python"}` | P3 | OR1, OR2, OR3, OR5 | `TC07_response.*` |
| TC08 | `{"data": "Quien es el docente del curso de Python?"}` | P3 | OR1, OR2, OR3, OR5 | `TC08_response.*` |
| TC09 | `{"data": "Cúal es la ubicación del instituto?"}` | P4 | OR1, OR2, OR3, OR6 | `TC09_response.*` |
| TC10 | `{"data": "Dónde está ubicado el instituto"}` | P4 | OR1, OR2, OR3, OR5 | `TC10_response.*` |
| TC11 | `{"data": "SELECT usuario, clave FROM user"}` | P5 | OR1, OR2, OR3, OR5 | `TC11_response.*` |
| TC12 | `{"data": "DELETE FROM USERS"}` | P5 | OR1, OR2, OR3, OR5 | `TC12_response.*` |
