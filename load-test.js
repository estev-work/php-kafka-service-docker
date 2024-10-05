import http from 'k6/http';
import { check } from 'k6';

export let options = {
    vus: 100000, // Количество виртуальных пользователей
    duration: '300s', // Время теста
};

export default function () {
    let res = http.post('http://localhost:8060/api/v1/questions', JSON.stringify({
        "title": "Некий важный вопрос",
        "content": "Некий важный вопросНекий важный вопросНекий важный вопрос"
    }), {
        headers: {
            'Content-Type': 'application/json',
            'Accept':'application/json'
        },
    });

    let isStatus202 = check(res, {
        'status is 200': (r) => r.status === 200,
    });

    if (!isStatus202) {
        console.log(`Request failed with status: ${res.status}`);
        console.log(`Response body: ${res.body}`);
    }
}
