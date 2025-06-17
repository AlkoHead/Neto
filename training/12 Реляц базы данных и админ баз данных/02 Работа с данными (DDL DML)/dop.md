1.5 задание альтернативная комманда
```sql
SELECT * FROM information_schema.user_privileges WHERE GRANTEE="'sys_temp'@'*'";
```

Какие плагины шифрования используются
```sql
SELECT plugin_name, plugin_status 
FROM information_schema.plugins 
WHERE plugin_name LIKE '%password%';
```

Показать все плагины
```sql
SHOW PLUGINS;
```

Какой то статус
```sql
SHOW STATUS;
```

Информация о пользователях
```sql
SELECT HOST, USER, plugin FROM mysql.user;
```

```bash
docker run --name test_db -p 3306:3306 -e MYSQL_ROOT_PASSWORD=secret -d mysql:latest
```

Задание 2  
```sql
SELECT TABLE_NAME, COLUMN_NAME FROM information_schema.KEY_COLUMN_USAGE kcu WHERE table_schema = 'sakila' AND kcu.CONSTRAINT_NAME = 'PRIMARY';
```
Указывает позицию  
```sql
SELECT 
    t.TABLE_NAME AS 'Table Name',
    k.COLUMN_NAME AS 'Primary Key Column',
    k.ORDINAL_POSITION AS 'Key Position'
FROM 
    INFORMATION_SCHEMA.TABLES t
JOIN 
    INFORMATION_SCHEMA.KEY_COLUMN_USAGE k
ON 
    t.TABLE_NAME = k.TABLE_NAME
    AND t.TABLE_SCHEMA = k.TABLE_SCHEMA
WHERE 
    t.TABLE_SCHEMA = DATABASE()
    AND t.TABLE_TYPE = 'BASE TABLE'
    AND k.CONSTRAINT_NAME = 'PRIMARY'
ORDER BY 
    t.TABLE_NAME, k.ORDINAL_POSITION;
```

К какой базе подключён:  
```sql
SELECT DATABASE();
# через системную переменную
SHOW VARIABLES LIKE 'database';
```
Проверка через INFORMATION_SCHEMA (для текущей сессии)
```sql
SELECT SCHEMA_NAME 
FROM INFORMATION_SCHEMA.SCHEMATA 
WHERE SCHEMA_NAME = DATABASE();
```
Создать базу
```sql
CREATE DATABASE my;
```

Подключение к базе
```sql
USE your_database_name;
```

*Результатом работы должны быть скриншоты обозначенных заданий, а также простыня со всеми запросами.*  
```sql
CREATE USER 'sys_temp'@'%' IDENTIFIED BY 'secret';
SELECT User FROM mysql.user;
GRANT ALL PRIVILEGES ON *.* TO 'sys_temp'@'%' WITH GRANT OPTION;
SHOW GRANTS FOR 'sys_temp'@'%';
SELECT * FROM information_schema.user_privileges WHERE GRANTEE="'sys_temp'@'%'";
```

Глянуть права по конкретному пользователю
```sql
SELECT * from mysql.user
WHERE User='sys_temp';
```
Более простой варик для пользователя test
```sql
SHOW GRANTS FOR 'test'
```
Добавить права на SELECT
```sql
GRANT SELECT ON my.* TO 'test'@'%';
# все привилегии
GRANT ALL PRIVILEGES  ON my.* TO 'test'@'%';
```

Применение изменений прав без перезагрузки сервера
```sql
FLUSH PRIVILEGES;
```
Убрать все привилегии
```sql
REVOKE ALL PRIVILEGES  ON my.* FROM 'test'@'%';
```
Удаление пользователя
```sql
DROP USER 'test'@'%';
# проверка что пользователя больше нет
SELECT * FROM mysql.user;
```
