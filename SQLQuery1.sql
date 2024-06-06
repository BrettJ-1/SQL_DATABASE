CREATE DATABASE db_zoo

USE db_zoo;

CREATE TABLE tbl_animalia (
	animalia_id INT PRIMARY KEY NOT NULL IDENTITY (1, 1),
	animalia_type VARCHAR(30) NOT NULL
);

DROP TABLE tbl_animalia

INSERT INTO tbl_animalia
	(animalia_type)
	VALUES
	('vertebrate'),
	('invertebrate')
;

SELECT * FROM tbl_animalia;

CREATE TABLE tbl_class (
	class_id INT PRIMARY KEY NOT NULL IDENTITY (100, 1),
	class_type VARCHAR(50) NOT NULL
	);

	INSERT INTO tbl_class	
		(class_type)
		VALUES
		('bird'),
		('reptillian'),
		('mammal'),
		('arthropod'),
		('fish'),
		('worm'),
		('cnidaria'),
		('echinoderm')
;

SELECT * FROM tbl_class;

UPDATE tbl_class SET class_type = 'bird' WHERE class_type = 'birds';

SELECT REPLACE(class_type, 'bird', 'birds') FROM tbl_class;

SELECT class_type FROM tbl_class WHERE class_type = 'bird';

SELECT UPPER(class_type) FROM tbl_class WHERE class_type = 'bird';

SELECT COUNT(class_type) FROM tbl_class WHERE class_type = 'bird';



CREATE TABLE tbl_order (
	order_id INT PRIMARY KEY NOT NULL IDENTITY (1, 1),
	order_type VARCHAR(50) NOT NULL
);

CREATE TABLE tbl_care (
	care_id VARCHAR(50) PRIMARY KEY NOT NULL,
	care_type VARCHAR(50) NOT NULL,
	care_specialist INT NOT NULL
);

CREATE TABLE tbl_nutrition (
	nutrition_id INT PRIMARY KEY NOT NULL IDENTITY (2200, 1),
	nutrition_type VARCHAR(50) NOT NULL,
	nutrition_cost MONEY NOT NULL
);

CREATE TABLE tbl_habitat (
	habitat_id INT PRIMARY KEY NOT NULL IDENTITY (5000, 1),
	habitat_type VARCHAR(50) NOT NULL,
	habitat_cost MONEY NOT NULL
);

CREATE TABLE tbl_specialist (
	specialist_id INT PRIMARY KEY NOT NULL IDENTITY (1,1),
	specialist_fname VARCHAR(50) NOT NULL,
	specialist_lname VARCHAR(50) NOT NULL,
	specialist_contact VARCHAR(50) NOT NULL
);

INSERT INTO tbl_order
	(order_type)
	VALUES
	('carnivore'),
	('herbivore'),
	('omnivore')
;
SELECT * FROM tbl_order;

INSERT INTO tbl_care
	(care_id, care_type, care_specialist)
	VALUES
	('care_0', 'replace the straw', 1),
	('care_1', 'repair or replace broken toys', 4),
	('care_2', 'bottle feed vitamins', 1),
	('care_3', 'human contact_pet subject', 2),
	('care_4', 'clean up animal waste', 1),
	('care_5', 'move subject to excercise pen', 3),
	('care_6', 'drain and refill aquarium', 1),
	('care_7', 'extensive dental work', 3)
;

SELECT * FROM tbl_care;

INSERT INTO tbl_nutrition
	(nutrition_type, nutrition_cost)
	VALUES
	('raw fish', 1500),
	('living rodents', 600),
	('mixture of fruit and rice', 800),
	('warm bottle of milk', 600),
	('syringe fed broth', 600),
	('lard and seed mix', 300),
	('aphids', 150),
	('vitamins and marrow', 3500)
;

SELECT * FROM tbl_nutrition;

INSERT INTO tbl_habitat
	(habitat_type, habitat_cost)
	VALUES
	('tundra', 40000),
	('grassy knoll with trees', 12000),
	('10 ft pond and rocks', 30000),
	('icy aquarium with snowy facade', 50000),
	('short grass, shade and moat', 50000),
	('netted forest atrium', 10000),
	('jungle vines and winding branches', 15000),
	('cliff with shaded cave', 15000)
;

SELECT * FROM tbl_habitat;

INSERT INTO tbl_specialist
	(specialist_fname, specialist_lname, specialist_contact)
	VALUES
	('margaret', 'nguyen', '384-576-2899'),
	('mary', 'fischer', '384-784-4856'),
	('arnold', 'holden', '385-475-3944'),
	('kem', 'byesan', '384-485-4855'),
	('delmonte', 'fyedo', '768-288-3749')
;

SELECT * FROM tbl_specialist;

CREATE TABLE tbl_species (
	species_id INT PRIMARY KEY NOT NULL IDENTITY (1, 1),
	species_name VARCHAR(50) NOT NULL,
	species_animalia INT NOT NULL CONSTRAINT fk_animilia_id FOREIGN KEY REFERENCES tbl_animalia(animalia_id) ON UPDATE CASCADE ON DELETE CASCADE,
	species_class INT NOT NULL CONSTRAINT fk_class_id FOREIGN KEY REFERENCES tbl_class(class_id) ON UPDATE CASCADE ON DELETE CASCADE,
	species_order INT NOT NULL CONSTRAINT fk_order_id FOREIGN KEY REFERENCES tbl_order(order_id) ON UPDATE CASCADE ON DELETE CASCADE,
	species_habitat INT NOT NULL CONSTRAINT fk_habitat_id FOREIGN KEY REFERENCES tbl_habitat(habitat_id) ON UPDATE CASCADE ON DELETE CASCADE,
	species_nutrition INT NOT NULL CONSTRAINT fk_nutrition_id FOREIGN KEY REFERENCES tbl_nutrition(nutrition_id) ON UPDATE CASCADE ON DELETE CASCADE,
	species_care VARCHAR(50) NOT NULL CONSTRAINT fk_care_id FOREIGN KEY REFERENCES tbl_care(care_id) ON UPDATE CASCADE ON DELETE CASCADE
);

INSERT INTO tbl_species
	(species_name, species_animalia, species_class, species_order, species_habitat, species_nutrition, species_care)
	VALUES
	('brown bear', 1, 102, 3, 5007, 2200, 'care_1'),
	('jaguar', 1, 102, 1, 5007, 2200, 'care_4'),
	('penguin', 1, 100, 1, 5003, 2200, 'care_6'),
	('ghost bat', 1, 102, 1, 5007, 2204, 'care_2'),
	('chicken', 1, 100, 3, 5001, 2205, 'care_0'),
	('panda', 1, 102, 3, 5006, 2202, 'care_4'),
	('bobcat', 1, 102, 1, 5001, 2204, 'care_5'),
	('grey wolf', 1, 102, 1, 5000, 2201, 'care_4')
;

SELECT * FROM tbl_species;

SELECT * FROM tbl_habitat;

SELECT species_name FROM tbl_species
WHERE species_order='3';

SELECT nutrition_type FROM tbl_nutrition
WHERE nutrition_cost <= '600';

SELECT species_name AS 'Species Name:', nutrition_type AS 'Nutrition Type:'
FROM tbl_species 
INNER JOIN tbl_nutrition
ON tbl_species.species_nutrition = tbl_nutrition.nutrition_id
WHERE species_nutrition >= 2202 and species_nutrition <= 2206;

SELECT specialist_fname, specialist_lname, specialist_contact
FROM tbl_specialist
INNER JOIN tbl_care
ON tbl_specialist.specialist_id = tbl_care.care_specialist
INNER JOIN tbl_species
ON tbl_care.care_specialist = tbl_species.species_id
WHERE species_name = 'penguin';

SELECT specialist_fname, specialist_lname, specialist_contact
FROM tbl_specialist
INNER JOIN tbl_care
ON tbl_specialist.specialist_id = tbl_care.care_specialist
INNER JOIN tbl_species
ON tbl_care.care_id = tbl_species.species_care
WHERE species_name = 'penguin';


SELECT * FROM tbl_species
SELECT * FROM tbl_care
SELECT * FROM tbl_specialist



DROP TABLE tbl_species, tbl_animalia, tbl_care, tbl_class, tbl_habitat, tbl_nutrition, tbl_order, tbl_specialist;

IF EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.TABLES tbl_species)
	DROP TABLE tbl_species, tbl_animilia, tbl_care, tbl_class, tbl_habitat, tbl_nutrition, tbl_order, tbl_specialist;
CREATE TABLE tbl_persons(
	persons_id INT PRIMARY KEY NOT NULL IDENTITY (1, 1),
	persons_fname VARCHAR(50) NOT NULL,
	persons_lname VARCHAR(50) NOT NULL,
	persons_contact VARCHAR(50) NOT NULL
	);

	INSERT INTO tbl_persons
		(persons_fname, persons_lname, persons_contact)
		VALUES
		('bob', 'smith', '232-345-5768'),
		('mary', 'ann', '232-345-5768'),
		('tex', 'burns', '232-345-5768'),
		('gerry', 'kerns', '232-345-5768'),
		('sally', 'fields', '232-345-5768')
;

SELECT persons_fname, persons_lname, persons_contact FROM tbl_persons WHERE persons_id BETWEEN 2 AND 5
SELECT persons_fname, persons_lname, persons_contact FROM tbl_persons WHERE persons_lname LIKE 'ke%';

SELECT persons_fname, persons_lname, persons_contact FROM tbl_persons WHERE persons_lname LIKE '_u%s';

UPDATE tbl_persons SET persons_fname = 'mars' WHERE persons_fname = 'bob';

SELECT persons_fname, persons_lname, persons_contact FROM tbl_persons WHERE persons_fname LIKE 'm%' ORDER BY persons_lname;

SELECT persons_fname AS 'First Name', persons_lname AS 'Last Name', persons_contact AS 'Phone:'
	FROM tbl_persons WHERE persons_fname LIKE 'm%' ORDER BY persons_lname;

	DELETE FROM tbl_persons WHERE persons_lname = 'smith';

	DROP TABLE tbl_persons;
PRINT 'Hello, World!'

DECLARE @myVariable INT
SET @myVariable = 6
PRINT @myVariable

DECLARE @var1 INT, @var2 INT
SET @var1 = 3
SET @var2 = 5

PRINT 'Having fun with' + ' TSQL and MS SQL SERVER!'

PRINT 'I have ' + CONVERT(VARCHAR(50), @var1) + ' dollars...'

DECLARE @var1 INT, @var2 INT
SET @var1 = 3
SET @var2 = 5

PRINT CHAR(9) + 'I have' + CONVERT(VARCHAR(50), @var1) + CHAR(13) + 'dollars...'

PRINT 'Variable 1 = ' + CONVERT(VARCHAR(5), @var1) + CHAR(13) + 'Variable 2 = ' + CONVERT(VARCHAR(5), @var2) 

PRINT 'Variable 1 = ' + CONVERT(VARCHAR(5), @var1) + CHAR(13) + 'Variable 2 = ' + CONVERT(VARCHAR(5), @var2) + CHAR(13) + 'Total: '
PRINT @var1 + @var2

IF @var1 <= 3
	BEGIN
		PRINT 'Variable 1 <= ' + CONVERT(VARCHAR(5), @var1) + CHAR(13)
	END
ELSE
	BEGIN
		PRINT 'Variable 1 is not < ' +CONVERT(VARCHAR(5), @var1) + CHAR(13)
	END

IF @var1 != 3
	BEGIN
		PRINT 'Variable 1 is NOT < ' + CONVERT(VARCHAR(5), @var1) + CHAR(13)
	END
ELSE	
	BEGIN
		PRINT 'Variable 1 is not < ' +CONVERT(VARCHAR(5), @var1) + CHAR(13)
	END

	DECLARE @var1 INT, @var2 INT
	SET @var1 = 3
	SET @var2 = 5

	IF @var1 < 2
		BEGIN
			PRINT '@Var1 < 2'
		END
	ELSE IF @var1 > 1 AND @var1 < 3
		BEGIN
			PRINT '@var1 > 1 AND @var1 < 3'
		END
	ELSE IF @var1 = 4 OR @var1 < 6
		BEGIN 
			PRINT '@var1 = 4 OR @var1 <6'
		END
	ELSE 
		PRINT '@var1 does not qualify!'
	END

