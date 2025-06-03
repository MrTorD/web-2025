CREATE TABLE blog.post (
	post_id INT UNSIGNED AUTO_INCREMENT,
	title VARCHAR(200) DEFAULT '',
	created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
	created_by INT UNSIGNED NOT NULL,
	likes INT DEFAULT 0,
	PRIMARY KEY (post_id)
);

INSERT INTO 
	blog.post(
		created_by,
		likes,
		title
		)
VALUES(
		1,
		244,
		"Так красиво зимой!"
);

INSERT INTO 
	blog.post(
		created_by,
		likes,
		title
		)
VALUES(
		2,
		143,
		"Так красиво летом!"
);

INSERT INTO 
	blog.post(
		created_by,
		likes,
		title
	)
VALUES(
		1,
		64,
		"Так красиво осенью!"
);