### Задание 2

Получите количество фильмов, продолжительность которых больше средней продолжительности всех фильмов.
```sql
SELECT COUNT(*) AS films_count_above_average
FROM film
WHERE length > (SELECT AVG(length) FROM film);
```
Пояснение:  
1. Вложенный запрос (SELECT AVG(length) FROM film) вычисляет среднюю  продолжительность всех фильмов  
2. Основной запрос подсчитывает (COUNT(*)) количество фильмов, у которых продолжительность (length) больше этого среднего значения  

Альтернативный вариант с выводом дополнительной информации:  
```sql
SELECT 
    COUNT(*) AS films_count_above_average,
    AVG(length) AS average_length,
    MIN(length) AS min_length,
    MAX(length) AS max_length
FROM 
    film
WHERE 
    length > (SELECT AVG(length) FROM film);
```

Получения списка фильмов:  
```sql
SELECT film_id, title, length
FROM film
WHERE length > (SELECT AVG(length) FROM film)
ORDER BY length DESC;
```

