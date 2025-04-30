CREATE USER 'user'@'localhost' IDENTIFIED BY '123';
GRANT SELECT, INSERT, UPDATE, DELETE ON blog.* TO 'user'@'localhost';