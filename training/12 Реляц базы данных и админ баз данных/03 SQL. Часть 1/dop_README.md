### Задание 1

Получите уникальные названия районов из таблицы с адресами, которые начинаются на “K” и заканчиваются на “a” и не содержат пробелов.

```sql
SELECT DISTINCT district
FROM address
WHERE district LIKE 'K%a' 
  AND district NOT LIKE '% %'
  AND district NOT LIKE '';
```
Пояснение:
1. WHERE district LIKE 'K%a' - выбирает районы, которые:

> - Начинаются на "K" (K%)

> - Заканчиваются на "a" (%a)

2. AND district NOT LIKE '% %' - исключает названия, содержащие пробелы  
3. AND district NOT LIKE '' - исключает пустые значения (если они есть)  
4. SELECT DISTINCT - гарантирует уникальность результатов  


### Задание 2
Альтернативный код   
Получите из таблицы платежей за прокат фильмов информацию по платежам,  
которые выполнялись в промежуток с 15 июня 2005 года по 18 июня 2005 года **включительно** и стоимость которых  превышает 10.00.
```sql
SELECT payment_date, amount FROM payment
WHERE DATE(payment_date) BETWEEN '2005-06-15 00:00:00' AND '2005-06-18 23:59:59'
AND amount > 10.00
ORDER BY 
    payment_date;
```

### Задание 3

Получите последние пять аренд фильмов.

```sql
SELECT rental_date
FROM rental
ORDER BY rental_date DESC
LIMIT 5;
```
Пояснение:  
1. ORDER BY rental_date DESC - сортировка записей по дате аренды в обратном порядке (от новых к старым)
2. LIMIT 5 - ограничение вывода только 5 записями

### Задание 4

Одним запросом получите активных покупателей, имена которых Kelly или Willie. 

Сформируйте вывод в результат таким образом:
- все буквы в фамилии и имени из верхнего регистра переведите в нижний регистр,
- замените буквы 'll' в именах на 'pp'.

```sql
SELECT 
    customer_id,
    REPLACE(LOWER(first_name), 'll', 'pp') AS first_name_lower,
    LOWER(last_name) AS last_name_lower,
    active
FROM 
    customer
WHERE 
    active = 1
    AND (first_name = 'Kelly' OR first_name = 'Willie')
ORDER BY 
    customer_id;
```
Пояснение:
1. Выбор активных покупателей (active = 1) с именами Kelly или Willie:
```sql
WHERE active = 1 AND (first_name = 'Kelly' OR first_name = 'Willie')
```
2. Модификация имен:

> - LOWER(first_name) - переводим имя в нижний регистр

> - REPLACE(..., 'll', 'pp') - заменяем все вхождения 'll' на 'pp'

3. Фамилия в нижнем регистре:
```sql
LOWER(last_name) AS last_name_lower
```

### Задание 5*

Выведите Email каждого покупателя, разделив значение Email на две отдельных колонки: в первой колонке должно быть значение, указанное до @, во второй — значение, указанное после @.

```sql
SELECT 
    email,
    SUBSTRING_INDEX(email, '@', 1) AS email_prefix,
    SUBSTRING_INDEX(email, '@', -1) AS email_domain
FROM 
    customer;
```
Пояснение:
1. SUBSTRING_INDEX(email, '@', 1) - извлекает часть email до символа @

> - Параметр 1 означает "взять первую часть до разделителя"

2. SUBSTRING_INDEX(email, '@', -1) - извлекает часть email после символа @

> - Параметр -1 означает "взять последнюю часть после разделителя"

### Задание 6*

Доработайте запрос из предыдущего задания, скорректируйте значения в новых колонках: первая буква должна быть заглавной, остальные — строчными.

```sql
SELECT 
    email,
    CONCAT(
        UPPER(LEFT(SUBSTRING_INDEX(email, '@', 1), 1)),
        LOWER(SUBSTRING(SUBSTRING_INDEX(email, '@', 1), 2))
    ) AS email_prefix,
    CONCAT(
        UPPER(LEFT(SUBSTRING_INDEX(email, '@', -1), 1)),
        LOWER(SUBSTRING(SUBSTRING_INDEX(email, '@', -1), 2))
    ) AS email_domain
FROM 
    customer;
```
Пояснение:
1. Для части до @ (email_prefix):  
> - SUBSTRING_INDEX(email, '@', 1) - извлекает часть до @  
> - LEFT(..., 1) - берём первый символ  
> - UPPER() - делаем его заглавным  
> - SUBSTRING(..., 2) - берём остальные символы  
> - LOWER() - переводим их в нижний регистр  
> - CONCAT() - соединяем результаты  
2. Для части после @ (email_domain):  
> - Аналогичная логика, но с SUBSTRING_INDEX(email, '@', -1)  