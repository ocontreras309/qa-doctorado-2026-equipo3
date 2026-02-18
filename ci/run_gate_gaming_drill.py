import json
import nltk
import requests

from nltk.tokenize import word_tokenize
from nltk.metrics import jaccard_distance

nltk.download('punkt_tab')

URL = 'http://localhost:8000/chatmemory'
test_prices = ['200', '300', '500']
test_responses = ['Hola. ¿En qué puedo ayudarte?',
                  '200 Bs',
                  '04 de septiembre',
                  '300 Bs',
                  '11 de septiembre']

summary_header = '''
# Resumen - Semana 6 (Gaming drill)\n
'''

def remove_punctuations(word):
    punctuations = ['¿', '?', '.', '¡', '!']
    result = word

    for punctuation in punctuations:
        result = result.replace(punctuation, '')

    return result

def calculate_jaccard_score(prompt, response_id):
    response = requests.post(URL, json.dumps({"data": prompt}), headers={'Content-Type': 'application/json'})
    
    content_tokens = word_tokenize(remove_punctuations(response.json()['content'].lower()), language='spanish')
    hyp = word_tokenize(remove_punctuations(test_responses[response_id].lower()), language='spanish')

    content_tokens = set(content_tokens)
    hyp = set(hyp)

    return 1 - jaccard_distance(content_tokens, hyp), json.dumps(response.json(), ensure_ascii=False)

if __name__ == '__main__':
    responses = []

    with open('./evidence/week6/before/gate_ouput.log', 'w') as f, open('./evidence/week6/before/SUMMARY.md', 'w') as report_before:
        # Aplicar el umbral engañoso para que todas las pruebas pasen
        test_case_id = 1
        f.write(f'Test case,Pass/Fail,Score,Response\n')

        input = 'Hola'
        score, response = calculate_jaccard_score(input, 0)
        responses.append((score, response))

        condition = 'PASS' if score >= 0 else 'FAIL'
        f.write(f'TC0{test_case_id},{condition},{score},{response}\n')

        test_case_id += 1

        input = '¿Cuánto cuesta el curso de Python?. Dame una respuesta muy corta. Ejemplo de formato: "300 Bs"'
        score, response = calculate_jaccard_score(input, 1)
        responses.append((score, response))
        f.write(f'TC0{test_case_id},{condition},{score},{response}\n')

        test_case_id += 1

        input = '¿Cuánto comienza el curso de Python?. Dame una respuesta muy corta. Ejemplo de formato ("dd" de "mes"): "04 de enero"'
        score, response = calculate_jaccard_score(input, 2)
        responses.append((score, response))
        f.write(f'TC0{test_case_id},{condition},{score},{response}\n')

        test_case_id += 1

        input = '¿Cuánto cuesta el curso de Robótica?. Dame una respuesta muy corta. Ejemplo de formato: "300 Bs"'
        score, response = calculate_jaccard_score(input, 2)
        responses.append((score, response))
        f.write(f'TC0{test_case_id},{condition},{score},{response}\n')

        test_case_id += 1

        input = '¿Cuánto comienza el curso de Robótica?. Dame una respuesta muy corta. Ejemplo de formato ("dd" de "mes"): "04 de enero"'
        score, response = calculate_jaccard_score(input, 2)
        responses.append((score, response))
        f.write(f'TC0{test_case_id},{condition},{score},{response}\n')

        report_before.write('\n### REPORTE ANTES:\n\n')
        report_before.write(f'\n### NÚMERO DE PRUEBAS: {test_case_id}')
        report_before.write(f'\n### TODAS LAS PRUEBAS APROBADAS')

    with open('./evidence/week6/after/gate_ouput.log', 'w') as f, open('./evidence/week6/after/SUMMARY.md', 'w') as report_after:
        # Detectar los jaccard scores engañosos
        f.write(f'Test case,Pass/Fail,Score,Response\n')
        tests_bypassed = 0
        test_case_id = 1

        for score, response in responses:
            condition = score >= 0 and score < 0.5
            report = 'BYPASS DETECTED' if condition else 'PASS'
            f.write(f'TC0{test_case_id},{report},{score},{response}\n')

            test_case_id += 1

            if condition:
                tests_bypassed += 1

        report_after.write('\n### REPORTE DESPUÉS:\n\n')
        report_after.write(f'\n### NÚMERO DE PRUEBAS: {test_case_id - 1}')
        report_after.write(f'\n### BYPASSES DETECTADOS: {tests_bypassed}')
    