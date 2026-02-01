import json
import requests
import time

SERVER_URL = 'http://localhost:8000'
    
def check_scalability(url):
    results = []
    conversations = [
        ['Usuario 1', '¿Qué precio tiene el curso de Python'], # user 1
        ['Usuario 2', '¿Dónde queda el instituto?'], # user 2
        ['Usuario 2', '¿Qué precio tiene el curso de robótica?'], # user 2
        ['Usuario 1', '¿Y cuándo empieza?'], # user 1
    ]
    
    expected_response_order = [
        ['200'],
        ['América', 'Cochabamba'],
        ['300'],
        ['04', 'septiembre']
    ]

    for i, conversation in enumerate(conversations):
        response = requests.post(url, json.dumps({'data': conversation[1]}), headers={'Content-Type': 'application/json'})
        condition = True
        content = response.json()['content']

        for token in expected_response_order[i]:
            condition &= token in content

        if condition:
            results.append(f"PASS, prompt: {conversation}, response: {content}")
        else:
            results.append(f"FAIL, prompt: {conversation}, response: {content}")

    return results

def check_latency(url, tests=10):
    latency_results = []
    for _ in range(tests):
        start = time.time()
        requests.post(url, '{"data": "hola"}', headers={'Content-Type': 'application/json'})
        end = time.time()
        latency_results.append(end - start)

    return latency_results

def check_availability(url, n_tests=10):
    results = []

    for _ in range(n_tests):
        status = requests.get(url).status_code
        if status == 200:
            results.append('PASS')
        else:
            results.append('FAIL')

    return results

if __name__ == '__main__':
    print('Executing scalability tests...')
    with open('./evidence/week3/scalability.log', 'w') as f:
        results = check_scalability(f'{SERVER_URL}/chatmemory')
        for result in results:
            f.write(f'{result}\n')

    print('Executing availability tests...')
    with open('./evidence/week3/availability.csv', 'w') as f:
        results = check_availability(f'{SERVER_URL}')

        for i, result in enumerate(results):
            f.write(f'{i + 1},{result}\n')

    print('Executing latency tests...')
    with open('./evidence/week3/latency.csv', 'w') as f:
        results = check_latency(f'{SERVER_URL}/chatmemory')

        for i, result in enumerate(results):
            f.write(f'{i + 1},{result}\n')
