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
### равны
SELECT c.city, c2.city
FROM city c, city c2
WHERE c.city > c2.city;
```
