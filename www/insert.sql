INSERT INTO 
	blog.user(
		name,
		avatar,
		description
		)
VALUES(
		"Ваня Денисов",
		"Avatar.png",
		"Привет! Я системный аналитик в ACME :) Тут моя жизнь только для самых классных!"
);

INSERT INTO 
	blog.user(
		name,
		avatar,
		description
		)
VALUES(
		"Денис Иванов",
		"Avatar1.png",
		"Всем привет!"
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

INSERT INTO 
	blog.images (
		post_id,
		img
	)
VALUES (
	1,
	"autumn.jpg"
);
	
INSERT INTO 
	blog.images (
		post_id,
		img
	)
VALUES (
	1,
	"WinterCity.png"
);

INSERT INTO 
	blog.images (
		post_id,
		img
	)
VALUES (
	1,
	"summer.jpg"
);

INSERT INTO 
	blog.images (
		post_id,
		img
	)
VALUES (
	2,
	"Party.png"
);

INSERT INTO 
	blog.images (
		post_id,
		img
	)
VALUES (
	2,
	"Yoshkar.png"
);

INSERT INTO 
	blog.images (
		post_id,
		img
	)
VALUES (
	3,
	"Cake.png"
);
	
	