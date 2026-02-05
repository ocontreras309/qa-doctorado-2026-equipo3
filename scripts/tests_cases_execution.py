import json
import requests

URL = 'http://localhost:8000/chatmemory'

test_cases = {
    "TC01": {
        "input_id": "{}",
        "partition": "P1",
        "evidence": "TC01_response.txt"
    },
    "TC02": {
        "input_id": '{"dat": "hola"}',
        "partition": "P1",
        "evidence": "TC02_response.txt"
    },
    "TC03": {
        "input_id": '{"data": "Dame el precio total de los cursos de Python y Robotica"}',
        "partition": "P2",
        "evidence": "TC03_response.txt"
    },
    "TC04": {
        "input_id": '{"data": "Cuál es el precio del curso de Python en Bs"}',
        "partition": "P2",
        "evidence": "TC04_response.txt"
    },
    "TC05": {
        "input_id": '{"data": "¿Qué días se pasa clases?"}',
        "partition": "P3",
        "evidence": "TC05_response.txt"
    },
    "TC06": {
        "input_id": '{"data": "Dame el precio del curso de Robótica en Dolares"}',
        "partition": "P3",
        "evidence": "TC06_response.txt"
    },
    "TC07": {
        "input_id": '{"data": "Cuál es el contenido del curso de Python"}',
        "partition": "P3",
        "evidence": "TC07_response.txt"
    },
    "TC08": {
        "input_id": '{"data": "Quien es el docente del curso de Python?"}',
        "partition": "P3",
        "evidence": "TC08_response.txt"
    },
    "TC09": {
        "input_id": '{"data": "Cúal es la ubicación del instituto?"}',
        "partition": "P4",
        "evidence": "TC09_response.txt"
    },
    "TC10": {
        "input_id": '{"data": "Dónde está ubicado el instituto"}',
        "partition": "P4",
        "evidence": "TC10_response.txt"
    },
    "TC11": {
        "input_id": '{"data": "SELECT usuario, clave FROM user"}',
        "partition": "P5",
        "evidence": "TC11_response.txt"
    },
    "TC12": {
        "input_id": '{"data": "DELETE FROM USERS"}',
        "partition": "P5",
        "evidence": "TC12_response.txt"
    }
}

def send_request(input):
    return requests.post(URL, data=input.encode("utf-8"), headers={"Content-Type": "application/json; charset=utf-8"})

def execute_test(input, test_case):
    response = send_request(input)
    response.encoding = "utf-8"
    content_type = response.headers.get("Content-Type", "")

    if "application/json" in content_type:
        response_body = json.dumps(response.json(), ensure_ascii=False)
    else:
        response.encoding = "utf-8"
        response_body = response.text

    if test_case == "TC01" or test_case == "TC02":
        condition = response.status_code == 400
    elif test_case == "TC03":
        condition = "500" in response_body and ("bs" in response_body.lower() or "bolivianos" in response_body.lower())
    elif test_case == "TC04":
        condition = "200" in response_body and ("bs" in response_body.lower() or "bolivianos" in response_body.lower())
    elif test_case in ["TC05", "TC06", "TC07", "TC08", "TC11", "TC12"]:
        condition = "info.cebtic@gmail.com" in response_body
    elif test_case in ["TC09", "TC10"]:
        condition = "Av. América Este" in response_body and "Cochabamba" in response_body

    return response.status_code, condition, response_body

if __name__ == "__main__":
    tests_count = 0
    passed = 0

    with open(f'./evidence/week4/results.csv', 'w') as results_csv:
        results_csv.write('tc_id,input_id,partition,http_code,oracle_pass,response_file\n')

        for key, value in test_cases.items():
            print(f"Executing: {key}")
            status, condition, response_body = execute_test(value["input_id"], key)
            passed += int(condition)
            tests_count += 1

            results_csv.write(f'{key},{value["input_id"]},{value["partition"]},{status},{condition},{value["evidence"]}\n')

            with open(f'./evidence/week4/{value["evidence"]}', 'w') as f:
                f.write(response_body)

    with open(f'./evidence/week4/summary.txt', 'w') as summary:
        summary.write("Semana 4 — Resumen de ejecución sistemática\n" + \
                      f"- Total casos: {tests_count}\n" + \
                      f"- Pass (oráculo mínimo): {passed}\n" + \
                      f"- Fail (oráculo mínimo): {tests_count - passed}\n" + \
                      "Archivos:\n" + \
                      "- results.csv: matriz por caso (código, pass/fail, notas)\n" + \
                      "- <TC>_response.*: evidencia por caso")
        
