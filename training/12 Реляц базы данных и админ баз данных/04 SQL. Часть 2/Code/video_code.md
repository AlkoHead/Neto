```sql
-- сделаем тестовую базу
CREATE	DATABASE part_2;
-- переключимся на неё
USE part_2;
-- сделаем несколько таблиц (не зависимые таблицы)
CREATE TABLE fn (id INT, first_name VARCHAR(50));
CREATE TABLE ln (id INT, last_name VARCHAR(50));
-- заполняем таблицы
-- для таблицы fn
INSERT INTO fn (id, first_name)
VALUES (1, 'Maxim'), (2, 'Igor'), (5, 'Pavel'), (9, 'Marina'), (10, 'Irina');
-- для таблицы ln
INSERT INTO ln (id, last_name)
VALUES (1, 'Petrov'), (3, 'Ivanov'), (5, 'Makarov'), (8, 'Frolov'), (10, 'Kuznecov');
-- проверка 
SELECT * FROM fn;
SELECT * FROM ln;
-- при попытке исправить 'Kuznecov' на 'Kuznecova' выдало ошибку
-- обнулим данные в таблице
TRUNCATE ln;
-- заведём по новой
INSERT INTO ln (id, last_name)
VALUES (1, 'Petrov'), (3, 'Ivanov'), (5, 'Makarov'), (8, 'Frolov'), (10, 'Kuznecova');
-- проверка 
SELECT * FROM ln;


```