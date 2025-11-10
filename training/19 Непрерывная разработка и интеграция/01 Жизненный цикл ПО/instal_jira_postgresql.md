### Основаня часть
1. Создайте именованный том (если еще не создан)
```bash
docker volume create jiraVolume
```

2. Создайте [docker-compose.yml](docker-compose.yml)

3. Запустите с Docker Compose
```bash
# Запуск в фоновом режиме
docker-compose up -d
# Просмотр логов
docker-compose logs -f
# Остановка
docker-compose down
```

---

### Если нужен .env

📁 Структура проекта
```txt
jira-docker/
├── docker-compose.yml
├── .env
├── jira_data/      # монтируется автоматически
└── postgres_data/  # монтируется автоматически
```

🌿 Файл .env  
Создайте файл `.env` в той же директории, где лежит `docker-compose.yml`:
```env
# Jira
JIRA_IMAGE=cptactionhank/atlassian-jira:latest
JIRA_PORT=8080
JIRA_JVM_OPTS=-Xms512m -Xmx2g

# PostgreSQL
POSTGRES_IMAGE=postgres:13
POSTGRES_PORT=5432
POSTGRES_DB=jiradb
POSTGRES_USER=jirauser
POSTGRES_PASSWORD=jirapass

# Volume paths (можно оставить как есть или настроить)
JIRA_DATA_PATH=./jira_data
POSTGRES_DATA_PATH=./postgres_data
```

🐳 Файл `docker-compose.yml` (с поддержкой .env)
```yaml
version: '3.8'

services:
  jira:
    image: ${JIRA_IMAGE}
    container_name: jira
    ports:
      - "${JIRA_PORT}:8080"
    volumes:
      - ${JIRA_DATA_PATH}:/var/atlassian/jira
    environment:
      - CATALINA_OPTS=${JIRA_JVM_OPTS}
    depends_on:
      - postgres
    restart: unless-stopped

  postgres:
    image: ${POSTGRES_IMAGE}
    container_name: jira_postgres
    ports:
      - "${POSTGRES_PORT}:5432"
    volumes:
      - ${POSTGRES_DATA_PATH}:/var/lib/postgresql/data
    environment:
      POSTGRES_DB: ${POSTGRES_DB}
      POSTGRES_USER: ${POSTGRES_USER}
      POSTGRES_PASSWORD: ${POSTGRES_PASSWORD}
    restart: unless-stopped
```

🚀 Запуск
```bash
docker-compose up -d
```

🔐 Безопасность: Скрытие паролей  
Если вы используете `Git`, добавьте `.env` в `.gitignore`:
```gitignore
.env
jira_data/
postgres_data/
```

🔄 Пример: Быстрая смена порта или БД

Нужно запустить Jira на порту 9090? Просто поменяйте в `.env`:
```env
JIRA_PORT=9090
```
И перезапустите:
```bash
docker-compose down && docker-compose up -d
```

🧪 Проверка, что переменные подхватились
```bash
docker-compose config
```