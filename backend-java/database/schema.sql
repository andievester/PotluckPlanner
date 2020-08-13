BEGIN TRANSACTION;

DROP TABLE IF EXISTS dietary_restrictions;
DROP TABLE IF EXISTS potluck;
DROP TABLE IF EXISTS guests;
DROP TABLE IF EXISTS dish_potluck;
DROP TABLE IF EXISTS dish;
DROP TABLE IF EXISTS gueststable;
DROP TABLE IF EXISTS users;
DROP TABLE IF EXISTS user_diet;
DROP TABLE IF EXISTS dish_restriction;






CREATE TABLE users (
	user_id 		SERIAL NOT NULL,
	firstName		varchar(50)	not null,
	lastName		varchar(50)	not null,
	phone			varchar(50)	not null,
	email			varchar(50)	not null,
	username 		varchar(50) NOT NULL,
	password_hash 	varchar(200) NOT NULL,
	role 			varchar(50) NOT NULL,
	CONSTRAINT PK_user PRIMARY KEY (user_id)
);

INSERT INTO users (firstName, lastName, phone, email, username,password_hash,role) VALUES ('firstName', 'lastName', 'phone', 'email','user','$2a$08$UkVvwpULis18S19S5pZFn.YHPZt3oaqHZnDwqbCW9pft6uFtkXKDC','ROLE_USER');
INSERT INTO users (firstName, lastName, phone, email,username,password_hash,role) VALUES ('John', 'Admin', 'phone', 'email','admin','$2a$08$UkVvwpULis18S19S5pZFn.YHPZt3oaqHZnDwqbCW9pft6uFtkXKDC','ROLE_ADMIN');



CREATE TABLE dietary_restrictions (
	dietary_id 			SERIAL NOT NULL,
	restriction_name	varchar(50),
	PRIMARY KEY (dietary_id)
);

INSERT INTO dietary_restrictions(restriction_name) VALUES ('Vegan' ),
														  ('Vegetarian'),
														  ('Lactose Intolerant'),
														  ('Nut Allergy'),
														  ('Gluten Allergy'),
														  ('Halal'), 
														  ('Kosher'),
														  ('Shellfish Allergy');
														  
CREATE TABLE user_diet (	
	user_id  	 int NOT NULL references users (user_id),    
	dietary_id   int Not NULL references dietary_restrictions (dietary_id),	
	PRIMARY KEY (user_id, dietary_id)	
);

CREATE TABLE potluck (
	potluck_id 		SERIAL NOT NULL,
	name			varchar(50)		NOT NULL,
	location		varchar(50)		NOT NULL,
	potluck_date	DATE 			NOT NULL,
	potluck_time	TIME			NOT NULL,
	user_id 		int				NOT NULL references users (user_id),
	description		varchar(250)	NOT NULL,
	guests			int,
	appetizers		int,
	entrees			int,
	side_dishes		int,
	desserts        int,
	alcohol			int,
	non_alcohol     int,
	PRIMARY KEY (potluck_id)
);


CREATE TABLE guests (	
	user_id 		int	    NOT NULL references users (user_id),
	potluck_id 		int     NOT NULL references potluck (potluck_id),
	PRIMARY KEY (user_id, potluck_id)
);


CREATE TABLE dish (
	dish_id 		SERIAL 			NOT NULL,
	dish_name		varchar(50)		NOT NULL,
	category		varchar(250)	NOT NULL,
	servings		int				NOT NULL,
	potluck_id 		int 			NOT NULL references potluck (potluck_id),
	recipe			varchar(250)	NOT NULL,
	user_id			int,
	PRIMARY KEY (dish_id)

);


CREATE TABLE dish_potluck (	
	dish_id 		int	    NOT NULL references dish (dish_id),
	potluck_id 		int     NOT NULL references potluck (potluck_id),
	PRIMARY KEY (dish_id, potluck_id)
);

CREATE TABLE dish_restriction (
	dish_id  	 	int 	NOT NULL references dish (dish_id),    
	dietary_id   	int 	Not NULL references dietary_restrictions (dietary_id),
	PRIMARY KEY (dish_id, dietary_id)
);

COMMIT TRANSACTION;




