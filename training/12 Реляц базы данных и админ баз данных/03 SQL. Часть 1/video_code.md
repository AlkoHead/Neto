``sql
# несоклько столбцов из таблицы 
SELECT actor_id, first_name, last_name FROM actor;

# применение алиасов
SELECT actor_id AS номер,
       first_name AS имя,
       last_name AS фамилия
FROM actor;

# сортировка по first_name
SELECT actor_id AS номер,
       first_name AS имя,
       last_name AS фамилия
FROM actor
ORDER BY first_name;

# сортировка в обратном порядке
SELECT actor_id AS номер,
       first_name AS имя,
       last_name AS фамилия
FROM actor
ORDER BY first_name DESC;

# показывает первые 5 после сортировки
SELECT actor_id AS номер,
       first_name AS имя,
       last_name AS фамилия
FROM actor
ORDER BY first_name ASC
LIMIT 5;

# пропускает 1 значение и показывает следующие 5
SELECT actor_id AS номер,
       first_name AS имя,
       last_name AS фамилия
FROM actor
LIMIT 5
OFFSET 1;

# короткая запись лимитов и пропуска
# LIMIT, пропускаем 10, показываем 5 (начиная с 8 версии работает)
SELECT actor_id AS номер,
       first_name AS имя,
       last_name AS фамилия
FROM actor
LIMIT 10, 5;

# получим уникальные значения DISTINCT
SELECT DISTINCT last_name FROM actor;

# используеем WHERE (придерживайся '  или " кавыек)
SELECT actor_id AS номер,
       first_name AS имя,
       last_name AS фамилия
FROM actor
WHERE first_name = 'ED';

# используем AND
SELECT actor_id AS номер,
       first_name AS имя,
       last_name AS фамилия
FROM actor
WHERE first_name = "ED" AND last_name = "MANSFIELD";

# использование WHERE и AND
SELECT *
FROM payment
WHERE amount > 2 AND amount <3;

# аналог
SELECT *
FROM payment
WHERE amount BETWEEN 2 AND 3;

# Используем CAST
SELECT payment_id, CAST(payment_date AS DATE)
FROM payment;

# только к TIME
SELECT payment_id, CAST(payment_date AS TIME)
FROM payment;




```