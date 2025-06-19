Выводит всех пользоватлей в таблице  
```sql
SELECT * FROM customer;
```
Выводим определнные столбцы в таблице customer
```sql
SELECT customer_id, last_name, first_name FROM customer;
```
Простой запрос. ORDER BY  
Сортировка ASC - от меньшего к большему (по умолчанияю)  
DESC - от большего к меньшему
```sql
SELECT title, rental_rate/rental_duration AS cost_per_day
FROM film
ORDER BY cost_per_day DESC, title;
# в данном примере сортируется по цене и имяни
```