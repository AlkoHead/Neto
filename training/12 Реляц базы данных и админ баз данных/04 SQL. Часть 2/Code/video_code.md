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
-- МЫ научились
-- выборка полей из таблички
SELECT id, first_name 
FROM fn;
-- 
-- 
SELECT id, first_name 
FROM fn
WHERE id > 3 -- использование WHERE, где id больше 3
ORDER BY first_name DESC -- от сортируем в обратке по first_name
LIMIT 1, 3; -- первое не выводим, выводим по следующие 3 (вроде так)
--
-- INNER JOIN (INNER не пишем т к используется по умолчанию)
SELECT f.id, f.first_name, l.last_name FROM fn f -- табл fn сделали алиса как f (AS опускаем)
-- после селекта передаём какие таблички выгружаем и из табл ln
JOIN ln l on f.id = l.id; -- табл ln алиса как l и обединяем табл fn id и ln id
-- в результате получили табл в которой id совпали
--
-- LEFT JOIN
-- всё берётся с левой табл и добавляются совпавшие id с фамилиями
SELECT f.id, f.first_name, l.last_name FROM fn f 
LEFT JOIN ln l on f.id = l.id;
--
-- RIGHT JOIN
SELECT l.id, f.first_name, l.last_name FROM fn f  -- id для ln
RIGHT JOIN ln l on f.id = l.id;
--
-- CROSS JOIN для каждого имяни все фамилии
SELECT first_name, last_name FROM fn 
CROSS JOIN ln;
--
-- FULL JOIN в MySQL не работаете, но есть выход
SELECT f.id, f.first_name, l.last_name FROM fn f 
LEFT JOIN ln l on f.id = l.id
UNION  -- соединяет табл по горизонтали
SELECT l.id, f.first_name, l.last_name FROM fn f 
RIGHT JOIN ln l on f.id = l.id;
--
-- пример UNION ALL
SELECT f.id, f.first_name, l.last_name FROM fn f 
LEFT JOIN ln l on f.id = l.id
UNION all  -- соединяет две таблицы
SELECT l.id, f.first_name, l.last_name FROM fn f 
RIGHT JOIN ln l on f.id = l.id;
--
-- UNION получили уникальные id
SELECT id FROM fn
UNION
SELECT id FROM ln;
--
-- UNION all получаем ВСЕ id, даже те которые повторяются
SELECT id FROM fn
UNION ALL
SELECT id FROM ln;
--
-- EXCEPT остались только уникальные id из верхней табл
SELECT id FROM fn
EXCEPT
SELECT id FROM ln;
--
-- аналогичный результата
SELECT id FROM fn
  WHERE id NOT IN (SELECT id FROM ln);
--
-- GROUP BY
SELECT COUNT(*) FROM ln;  -- по считали количество строк
--
SELECT COUNT(*) FROM ln
WHERE id < 5;  -- id меньше 5
--
SELECT MAX(id) FROM ln;  -- максимальный id
--
SELECT MIN(id) FROM ln;
--
SELECT AVG(id) FROM ln;  -- среднее id
--
SELECT SUM(id) FROM ln;  -- сумма всех id
--
-- сделаем новую таблицу
CREATE TABLE sal (id INT, dep VARCHAR(50), prof VARCHAR(50), sallary INT);
--
-- наполним таблицу данными
INSERT INTO sal (id, dep, prof, sallary) VALUES
(1, 'ЦЕХ', 'Руководитель', 80000),
(2, 'ЦЕХ', 'Мастер', 60000),
(3, 'ЦЕХ', 'Инженер', 50000),
(4, 'ЦЕХ', 'Руководитель', 90000),
(5, 'ИТ', 'Руководитель', 120000),
(6, 'ИТ', 'Инженер', 100000),
(7, 'ИТ', 'Мастер', 70000);
--
SELECT * FROM sal;
--
SELECT max(sallary) FROM sal;  -- узнаем максимальную ЗП
--
-- по стичаем среднию ЗП по депортаментам (AVG)
SELECT dep, AVG(sallary)  FROM sal
GROUP BY dep;  -- группировка по dep
-- добавим группировку по id
-- для этого необходимо id добавить и в SELECT и GROUP BY
SELECT dep, AVG(sallary), id FROM sal
GROUP BY dep, id;
--


```