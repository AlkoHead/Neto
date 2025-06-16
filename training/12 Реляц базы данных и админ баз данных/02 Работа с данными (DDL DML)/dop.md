1.5 задание альтернативная комманда
SELECT * FROM information_schema.user_privileges WHERE GRANTEE="'sys_temp'@'*'";

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

