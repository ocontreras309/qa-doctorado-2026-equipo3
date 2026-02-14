import json
import nltk
import requests

from nltk.tokenize import word_tokenize
from nltk.metrics import jaccard_distance
from nltk.translate.bleu_score import SmoothingFunction

nltk.download('punkt_tab')

URL = 'http://localhost:8000/chatmemory'
test_prices = ['200', '300', '500']
test_responses = ['Hola. ¿En qué puedo ayudarte?',
                  'Python 200 Bs',
                  'Python 04 de septiembre']

def run_gate_1(prompt):
    response = requests.post(URL, json.dumps({"data": prompt}), headers={'Content-Type': 'application/json'})
    return response.status_code == 200, json.dumps(response.json(), ensure_ascii=False)

def run_gate_2(prompt, price_id):
    response = requests.post(URL, json.dumps({"data": prompt}), headers={'Content-Type': 'application/json'})
    return test_prices[price_id] in response.text and ('bs' in response.text.lower() or 'bolivianos' in response.text.lower()), json.dumps(response.json(), ensure_ascii=False)

def remove_punctuations(word):
    punctuations = ['¿', '?', '.', '¡', '!']
    result = word

    for punctuation in punctuations:
        result = result.replace(punctuation, '')

    return result

def run_gate_3(prompt, response_id):
    response = requests.post(URL, json.dumps({"data": prompt}), headers={'Content-Type': 'application/json'})
    
    content_tokens = word_tokenize(remove_punctuations(response.json()['content'].lower()), language='spanish')
    hyp = word_tokenize(remove_punctuations(test_responses[response_id].lower()), language='spanish')

    content_tokens = set(content_tokens)
    hyp = set(hyp)

    return 1 - jaccard_distance(content_tokens, hyp), json.dumps(response.json(), ensure_ascii=False)


if __name__ == '__main__':
    with open('./evidence/week5/evidence_gate1.log', 'w') as f:
        f.write(f'Pass/Fail,Response\n')

        input = 'hola'
        pass_fail, response = run_gate_1(input)
        f.write(f'{'PASS' if pass_fail else 'FAIL'},{response}\n')

        input = 'buen dia'
        pass_fail, response = run_gate_1(input)
        f.write(f'{'PASS' if pass_fail else 'FAIL'},{response}\n')

        input = '¿cómo estás?'
        pass_fail, response = run_gate_1(input)
        f.write(f'{'PASS' if pass_fail else 'FAIL'},{response}\n')

        input = 'buen dar'
        pass_fail, response = run_gate_1(input)
        f.write(f'{'PASS' if pass_fail else 'FAIL'},{response}\n')

        input = 'holas'
        pass_fail, response = run_gate_1(input)
        f.write(f'{'PASS' if pass_fail else 'FAIL'},{response}\n')
        

    with open('./evidence/week5/evidence_gate2.log', 'w') as f:
        f.write(f'Pass/Fail,Response\n')

        input = '¿Cuánto cuesta el curso de Python?'
        pass_fail, response = run_gate_2(input, 0)
        f.write(f'{'PASS' if pass_fail else 'FAIL'},{response}\n')

        input = '¿Cuánto cuesta el curso de Robótica?'
        pass_fail, response = run_gate_2(input, 1)
        f.write(f'{'PASS' if pass_fail else 'FAIL'},{response}\n')

        input = '¿Cuánto cuestan los cursos de Python y Robótica juntos?'
        pass_fail, response = run_gate_2(input, 2)
        f.write(f'{'PASS' if pass_fail else 'FAIL'},{response}\n')
    
    with open('./evidence/week5/evidence_gate3.log', 'w') as f:
        f.write(f'Pass/Fail,Score,Response\n')

        input = 'Hola'
        score, response = run_gate_3(input, 0)
        f.write(f'{'PASS' if score >= 0.5 else 'FAIL'},{score},{response}\n')

        input = '¿Cuánto cuesta el curso de Python?. Dame una respuesta muy corta. Ejemplo: "300 Bs"'
        score, response = run_gate_3(input, 1)
        f.write(f'{'PASS' if score >= 0.5 else 'FAIL'},{score},{response}\n')

        input = '¿Cuánto comienza el curso de Python?. Dame una respuesta muy corta. Ejemplo: "04 de enero"'
        score, response = run_gate_3(input, 2)
        f.write(f'{'PASS' if score >= 0.5 else 'FAIL'},{score},{response}\n')

    
