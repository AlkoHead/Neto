### Простые запросы. SELECT и FROM

Для того чтобы получить данные, в запросе нужно указать:

- из какой таблицы хотим получить данные – предложение **FROM**;

- какие данные хотим вывести в результат – предложение **SELECT**.
  
```sql
SELECT * FROM customer;
```

Выводим определнные столбцы в таблице customer
```sql
SELECT customer_id, last_name, first_name FROM customer;
```

### Простой запрос. ORDER BY  

Сортировка **ASC** - от меньшего к большему (по умолчанияю)  
**DESC** - от большего к меньшему  
```sql
SELECT title, rental_rate/rental_duration AS cost_per_day
FROM film
ORDER BY cost_per_day DESC, title;
# в данном примере сортируется по цене и имяни
```
### Простые запросы. LIMIT и OFFSET  
Если нужно получить первые N записей из результата,  
используется оператор **LIMIT**.  
Если нужно исключить из результата первые N записей,  
используется оператор **OFFSET**.  
Возьмем предыдущий запрос и получим первые 10 записей  
начиная с 58:  
```sql
SELECT title, rental_rate/rental_duration AS cost_per_day
FROM film
ORDER BY cost_per_day DESC, title
LIMIT 10
OFFSET 57;
```

### Простые запросы. DISTINCT  
Для получения уникальных значений в результате, используется  
оператор **DISTINCT**.  
К примеру, нужно получить уникальный список имен  
пользователей:  
```sql
SELECT DISTINCT first_name
FROM customer;
```

Если нужно получить уникальные значения по нескольким  
столбцам, то данные столбцы перечисляются после оператора  
**DISTINCT**:  
```sql
SELECT DISTINCT last_name, first_name
FROM customer;
```


