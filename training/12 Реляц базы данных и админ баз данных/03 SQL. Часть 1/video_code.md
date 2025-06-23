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

# округление
SELECT ROUND(100.567);

# округление до 2 знаков
SELECT ROUND(100.567, 2);

# обрезание до 2 знаков, если указать 0 то оставит целую часть
SELECT TRUNCATE(100.567, 2);

# округление до меньшего
SELECT FLOOR(100.567);

# округление до большего
SELECT CEIL(100.567);

# получение абасютного значения
SELECT ABS(-100.567);

SELECT payment_id, ROUND(amount)
FROM payment;

SELECT payment_id, ROUND(amount), FLOOR(amount)
FROM payment;

SELECT 2 + 2;
SELECT POWER(2, 10);
SELECT POWER(5, 2);
SELECT SQRT(25);
SELECT POWER(1024, 1/10);

# но есть ньюанс
SELECT POWER(8, 1/3); -- бывает не коректно считает
SELECT POWER(16, 1/4);
SELECT POWER(32, 1/5);

# деление без остатка
SELECT 1024 DIV 100; -- результат 10

# показывает остаток
SELECT 1024 % 100; -- результат 24

# полуение наибольшего значения
SELECT GREATEST(1, 2, 3, 100, 8);

# получение минимального значения
SELECT LEAST(1, 2, 3, 100, 8);

# генерим случайно число
SELECT RAND();

# в определённом диапазоне
SELECT RAND() * 100;

# объединение строк
SELECT CONCAT(first_name, last_name)
FROM actor;
# или разделять
SELECT CONCAT(first_name, "_", last_name, "_", actor_id)
FROM actor;

# передаём разделитель одного типа
SELECT CONCAT_WS(" ", first_name, last_name)
FROM actor;
# или рахделитель "_"
SELECT CONCAT_WS("_", first_name, last_name)
FROM actor;

# сколько байт (не всегда количество байт = количеству символов)
SELECT LENGTH(first_name), first_name
FROM actor;

# количество символов
SELECT CHAR_LENGTH(first_name), first_name
FROM actor;

SELECT LENGTH("привет"), CHAR_LENGTH("привет");

# первое вхождение искомого 
SELECT POSITION("D" IN "AIDDAAANNDD");

# вырезания и отризания
SELECT last_name, SUBSTR(last_name, 2, 3), LEFT(last_name, 3), RIGHT(last_name, 3)
FROM actor;

# изменение регистра
SELECT last_name, LOWER(last_name), UPPER(last_name)
FROM actor;

#  замена
SELECT last_name, INSERT(last_name, 1, 1, "max")
FROM actor;

# замена через REPLACE
SELECT last_name, REPLACE(last_name, 'A', 'F')
FROM actor;

# вырезаем пробелы
SELECT TRIM("    aaaa    ")

# запрос на поиск первого совпадения по разделителю "|'
SELECT SUBSTRING_INDEX("AAA | BBB | CCC", "|", 1);

# найти похожее ( _ любой один знак первый, % все остальные)
SELECT * FROM actor
WHERE first_name LIKE "_EN%";

# узнать текущую дату и время
SELECT NOW();

# извлекаем время
SELECT TIME(NOW());

# извлекаем дату
SELECT DATE(NOW());

# добавим 3 дня к дате
SELECT DATE_ADD(NOW(), INTERVAL 3 DAY);

# добавим 3 месяца к дате
SELECT DATE_ADD(NOW(), INTERVAL 3 MONTH);

# уменьшаем на 3 месяца
SELECT DATE_SUB(NOW(), INTERVAL 3 MONTH);

# разбика на год месяц день
SELECT YEAR(NOW()), MONTH(NOW()), DAY(NOW());

# извлекаем из даты часы
SELECT EXTRACT(HOUR FROM NOW()); 


SELECT DATEDIFF(return_date, rental_date),
       QUARTER(return_date)
FROM rental;

# форматирование даты
SELECT return_date
FROM rental;

SELECT return_date, DATE_FORMAT(return_date, "%D - %a - %m - %Y")
FROM rental;

SELECT return_date, 
       DATE_FORMAT(return_date, "%D - %a - %m - %Y"),
       TIME_FORMAT(TIME(return_date), "%H : %i : %s")
FROM rental;
```