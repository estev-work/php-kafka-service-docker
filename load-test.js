import http from 'k6/http';
import { check } from 'k6';

export let options = {
    vus: 5000, // Количество виртуальных пользователей
    duration: '3600s', // Время теста
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

    check(res, {
        'status is 202': (r) => r.status === 202,
    });
}