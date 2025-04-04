-- Создание пользователя
CREATE USER konga_user WITH ENCRYPTED PASSWORD 'konga_password';

-- Предоставление прав на базу данных
GRANT ALL PRIVILEGES ON DATABASE konga_db TO konga_user;
