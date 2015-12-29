-- Grant all local and remote access to the dba
GRANT ALL PRIVILEGES ON *.* TO 'dba'@'%' IDENTIFIED BY 'dba' WITH GRANT OPTION;
GRANT ALL PRIVILEGES ON *.* TO 'dba'@'localhost' IDENTIFIED BY 'dba' WITH GRANT OPTION;

-- Create a temp database
DROP DATABASE IF EXISTS temp_db;
CREATE DATABASE temp_db;

-- Grant basic access to the app_user
GRANT USAGE ON temp_db.* TO 'app_user'@'%' IDENTIFIED BY 'app_user';
GRANT USAGE ON temp_db.* TO 'app_user'@'localhost' IDENTIFIED BY 'app_user';

-- Remove remote access from the default 'root' user
GRANT USAGE ON *.* TO 'root'@'%' IDENTIFIED BY '';
DROP USER 'root'@'%';
