Создание таблицы
```sql
CREATE TABLE proffis(
	id int primary key,
	name VARCHAR(255) not null UNIQUE 
);
```
Таблица ссылкой на таблицу proffis
добавить пользователя без профессии, которой нету в proffis не получится.
```sql
CREATE TABLE persons(
	id int primary key,
	first_name VARCHAR(255),
	last_name VARCHAR(255),
	age int,
	prof_id int,
	foreign key (prof_id) references proffis (id)
);
```
Добавим в proffis значения
```sql
INSERT INTO proffis(id, name)
VALUES (1, 'admin'), (2, 'devops'), (3, 'analitic');
# проверка что добавили
SELECT  * FROM  proffis;
```
Добавим в persons, если id из proffis не совпадёт, выдаст ошибку  
```sql
INSERT INTO persons(id, first_name, last_name, age, prof_id)
VALUES (1, "Igor", "Petrov", 30, 3);
# проверка
SELECT  * FROM  persons;
```
Изменение имяни таблички, sql понимает такие изменения  
и это ни как не влияет на работу.
```sql
ALTER TABLE proffis RENAME TO works;
```
SQL не даст удалить табличку, если на неё, кто то ссылатеся  
```sql
DROP TABLE proffis;
# не сработает, т.к. на неё есть жёстная ссылка
```
Но можно удалить зависимую табличку
```sql
DROP TABLE persons CASCADE;
```
Удаление базы данных
```sql
DROP DATABASE my;
```
