create database spider_taskdb;
create database spider_projectdb;
create database spider_resultdb;

create user spider with PASSWORD 'test1234';
GRANT ALL PRIVILEGES ON DATABASE "spider_taskdb" to spider;
GRANT ALL PRIVILEGES ON DATABASE "spider_projectdb" to spider;
GRANT ALL PRIVILEGES ON DATABASE "spider_resultdb" to spider;