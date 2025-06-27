### JOIN

В SQL JOIN используются для соединения нескольких таблиц и
получения из них данных. Существуют следующие типы JOIN:
>- INNER JOIN
>- LEFT JOIN
>- RIGHT JOIN
>- FULL JOIN
>- CROSS JOIN

В LEFT OUTER JOIN, RIGHT OUTER JOIN и FULL OUTER JOIN  
ключевое слово OUTER можно опустить, оно не обязательно для  
использования.  
Также при использовании INNER JOIN можно опустить ключевое  
слово INNER.  
При работе с JOIN желательно использовать алиасы, для удобства  
чтения или написания запросов и указания, из каких таблиц  
какие столбцы нужно получать.


### INNER JOIN 

возвращает данные по строкам, содержащим
одинаковые значения.  
Нужно вывести названия фильмов и имена актеров, которые
снимались в этих фильмах:  
```sql
SELECT f.title, CONCAT(a.last_name, ' ', a.first_name) AS actor_name
FROM film f
INNER JOIN film_actor fa ON fa.film_id = f.film_id
INNER JOIN actor a ON a.actor_id = fa.actor_id;
```


### LEFT JOIN 

возвращает все данные из левой таблицы, добовляет справой, если есть совподения. 
Нужно получить данные по всем пользователям и добавить
информацию по городам, в которых они живут:  
```sql
SELECT CONCAT(c.last_name, ' ', c.first_name), c2.city
FROM customer c
LEFT JOIN address a ON a.address_id = c.address_id
LEFT JOIN city c2 ON c2.city_id = a.city_id;
```
Чтобы получить только те строки, которые не содержат данных в  
правой таблице, можно использовать оператор **WHERE**  
Нужно получить все фильмы, которые не брали в аренду:
```sql
SELECT f.title
FROM film f
LEFT JOIN inventory i ON i.film_id = f.film_id
LEFT JOIN rental r ON r.inventory_id = i.inventory_id
WHERE r.rental_id IS NULL;
```

### RIGHT JOIN

Обратная версия **LEFT JOIN**.  
Возвращает все данные из правой таблицы.  
Нужно получить список всех городов и добавить информацию по  
пользователям, которые живут в этих городах:  
```sql
SELECT CONCAT(c.last_name, ' ', c.first_name), c2.city
FROM customer c
RIGHT JOIN address a ON a.address_id = c.address_id
RIGHT JOIN city c2 ON c2.city_id = a.city_id;
```


### CROSS JOIN

Это Декартово произведение, когда каждая строка  
левой таблицы сопоставляется с каждой строкой правой таблицы.  
В результате получается таблица со всеми возможными  
сочетаниями строк обеих таблиц.  
Нужно получить все возможные пары городов и убрать  
зеркальные варианты А-Б, Б-А:  
```sql
SELECT c.city, c2.city
FROM city c
CROSS JOIN city c2
WHERE c.city > c2.city;
-- равны
SELECT c.city, c2.city
FROM city c, city c2
WHERE c.city > c2.city;
```


### UNION/EXCEPT

Если при работе с JOIN соединение данных происходит «слева»  
или «справа», то при работе с операторами UNION или EXCEPT  
работа происходит «сверху» и «снизу».  
Создадим две таблицы и внесем в них данные:  
```sql
CREATE TABLE table_1 (
color_1 VARCHAR(10) NOT NULL
);
CREATE TABLE table_2 (
color_2 VARCHAR(10) NOT NULL
);
INSERT INTO table_1
VALUES('white'), ('black'), ('red'), ('green');
INSERT INTO table_2
VALUES('black'), ('yellow'), ('blue'), ('red');
```

При объединении данных через оператор UNION в результате
будет список уникальных значений для двух таблиц.  
```sql
SELECT color_1 FROM table_1
UNION
SELECT color_2 FROM table_2;
```
>- Обязательное условие при работе с операторами
>- **UNION** или **EXCEPT** — количество столбцов и их типы
>- данных в таблицах сверху и снизу должно быть
>- одинаковым  

#### UNION ALL

При объединении данных через оператор **UNION ALL** в результате  
будет список всех значений для двух таблиц:  
```sql
SELECT color_1 FROM table_1
UNION ALL
SELECT color_2 FROM table_2;
```

#### EXCEPT

При использовании оператора EXCEPT из значений, полученных в  
верхней части запроса, будут вычтены значения, которые  
совпадут со значениями, полученными в нижней части запроса.
```sql
SELECT color_1 FROM table_1
EXCEPT
SELECT color_2 FROM table_2;
```
Если вдруг MySQL старый
```sql
SELECT color_1
FROM table_1
WHERE color_1 NOT IN (
SELECT color_2
FROM table_2
);
```


### Агрегатные функции

**Агрегация** — когда данные группируются по ключу, в качестве  
которого выступает один или несколько атрибутов, и внутри  
каждой группы вычисляются некоторые статистики.  
- **SUM** — возвращает общую сумму числового столбца  
- **COUNT** — возвращает количество строк, соответствующих  
заданному критерию  
- **AVG** — возвращает среднее значение числового столбца  
- **MIN** — возвращает наименьшее значение выбранного столбца  
- **MAX** — возвращает наибольшее значение выбранного столбца  
Посчитаем, сколько фильмов в базе начинается на букву 'a':  
```sql
SELECT COUNT(*)
FROM film
WHERE LOWER(LEFT(title, 1)) = 'a';
```
В одном запросе получим информацию по количеству платежей,  
общей сумме платежей, среднему платежу, максимальному и  
минимальному платежу по каждому пользователю:  


### Группировка данных

**GROUP BY** — агрегирующий оператор, с помощью которого можно
формировать данные по группам и уже в рамках этих групп
получать значения с помощью агрегатных функций.  
В одном запросе получим информацию по количеству платежей и  
общей сумме платежей по каждому пользователю на каждый  
месяц:  
```sql
SELECT customer_id, MONTH(payment_date), COUNT(payment_id), SUM(amount)
FROM payment
GROUP BY customer_id, MONTH(payment_date);
```
В примере ниже вместо указания в GROUP BY столбцов title,  
release_year и lenght можно указать первичный ключ таблицы film  
 film_id:  
 ```sql
 SELECT f.title, f.release_year, f.length, COUNT(fa.actor_id)
FROM film f
JOIN film_actor fa ON fa.film_id = f.film_id
GROUP BY f.film_id;
```

#### HAVING

**WHERE** фильтрует данные до группировки.  
**HAVING** фильтрует данные после группировки.  
Найдём пользователей, которые совершили более 40  
аренд:  
```sql
SELECT CONCAT(c.last_name, ' ', c.first_name), COUNT(r.rental_id)
FROM rental r
JOIN customer c ON r.customer_id = c.customer_id
GROUP BY c.customer_id
HAVING COUNT(r.rental_id) > 40;
```


### Подзапросы

Нужно получить процентное отношение платежей по каждому  
месяцу к общей сумме платежей:  
```sql
SELECT MONTH(payment_date),
COUNT(payment_id) / (SELECT COUNT(1) FROM payment) * 100
FROM payment
GROUP BY MONTH(payment_date);
```
Нужно получить фильмы из категорий, начинающихся на букву С:  
```sql
SELECT f.title, c.name
FROM film f
JOIN film_category fc ON fc.film_id = f.film_id
JOIN category c ON c.category_id = fc.category_id
WHERE c.category_id IN (
SELECT category_id
FROM category
WHERE name LIKE 'C%')
ORDER BY f.title;
```
Получим отношение количества платежей к количеству аренд по  
каждому сотруднику:  
```sql
SELECT CONCAT(s.last_name, ' ', s.first_name), cp / cr
FROM staff s
JOIN (
SELECT staff_id, COUNT(payment_id) AS cp
FROM payment
GROUP BY staff_id) t1 ON s.staff_id = t1.staff_id
JOIN (
SELECT staff_id, COUNT(rental_id) AS cr
FROM rental
GROUP BY staff_id) t2 ON s.staff_id = t2.staff_id;
```


### Условия

#### CASE

**CASE** напоминает операторы if/else.  

Если пользователь купил более чем на 200 у. е., то он хороший  клиент, если менее чем на 200, то не  
очень хороший, в остальных случаях — «средний».  
```sql
SELECT customer_id, SUM(amount),
CASE
WHEN SUM(amount) > 200 THEN 'Good user'
WHEN SUM(amount) < 200 THEN 'Bad user'
ELSE 'Average user'
END AS good_or_bad
FROM payment
GROUP BY customer_id
ORDER BY SUM(amount) DESC
LIMIT 5;
```

#### IFNULL

Функция IFNULL позволяет возвращать альтернативное значение,  
если выражение возвращает NULL.  
Нужно получить список всех пользователей и сумму их платежа за  
18.06.2005, вместо значений NULL нужно проставить 0:  
```sql
SELECT CONCAT(c.last_name, ' ', c.first_name) AS user,
IFNULL(SUM(p.amount), 0)
FROM customer c
LEFT JOIN (
SELECT *
FROM payment
WHERE DATE(payment_date) = '2005-06-18') p
ON p.customer_id = c.customer_id
GROUP BY c.customer_id
```

#### COALESCE

Функция COALESCE позволяет возвращать первое значение из  
списка, которое не равно NULL.  
Выведем в результат первый не NULL результат разницы между  
датой аренды и датой возврата, текущей датой и датой возврата,  
текущей датой и датой аренды:  
```sql
SELECT rental_id,
COALESCE(DATEDIFF(return_date, rental_date), DATEDIFF(NOW(), return_date),
DATEDIFF(NOW(), rental_date)) AS diff
FROM rental
```
