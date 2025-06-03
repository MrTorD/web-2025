
CREATE TABLE blog.user (
	id INT UNSIGNED AUTO_INCREMENT,
	name VARCHAR(50) NOT NULL,
	description VARCHAR(200) DEFAULT '',
	avatar VARCHAR(200) NOT NULL,
	login VARCHAR(50) NOT NULL,
	password VARCHAR(100) NOT NULL,
	PRIMARY KEY (id)
);

INSERT INTO 
	blog.user(
		name,
		avatar,
		description,
		login,
		password
		)
VALUES(
		"Ваня Денисов",
		"Avatar.png",
		"Привет! Я системный аналитик в ACME :) Тут моя жизнь только для самых классных!",
		"testmail@gmail.com",
		"11849b646a5c3c65463a630c06d1c033"
);

INSERT INTO 
	blog.user(
		name,
		avatar,
		description,
		login,
		password
		)
VALUES(
		"Денис Иванов",
		"Avatar1.png",
		"Всем привет!",
		"mailtest@gmail.com",
		"fc6d311d2ae71e423b4805df6484a07d"
);