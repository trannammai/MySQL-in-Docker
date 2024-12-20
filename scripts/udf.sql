-- UDF to generate mock data for testing or simulating a database system. For example:
-- Populating a table with random student records (ID, gender, DOB, etc.).
-- Simulating course enrollment data (student, course, timestamp).
-- Mocking school datasets for analytics or debugging

CREATE FUNCTION random_student() RETURNS INT DETERMINISTIC
        RETURN FLOOR(RAND() * 1000) + 1;

CREATE FUNCTION random_school() RETURNS INT DETERMINISTIC
        RETURN FLOOR(RAND() * 10) + 1;

CREATE FUNCTION random_course() RETURNS INT DETERMINISTIC
        RETURN FLOOR(RAND() * 3) + 1;

DELIMITER $$
CREATE FUNCTION random_gender(in_strlen int) RETURNS VARCHAR(1) DETERMINISTIC
BEGIN 
SET @var := '';
IF (in_strlen > 1) THEN SET in_strlen = 1; END IF;
WHILE(in_strlen > 0) DO
SET @var := CONCAT(@var, ELT(FLOOR(RAND() * 2) + 1, 'Y', 'N'));
SET in_strlen := in_strlen - 1;
END WHILE;	
RETURN @var;
END $$
DELIMITER ;

CREATE FUNCTION random_name(in_length VARCHAR(50)) RETURNS VARCHAR(50) DETERMINISTIC
        RETURN SUBSTRING(MD5(RAND()) FROM 1 FOR in_length);

CREATE FUNCTION random_time() RETURNS VARCHAR(30) DETERMINISTIC
        RETURN FROM_UNIXTIME(ROUND(RAND() * (1620175999 - 1404537600)) + 1404537600);

CREATE FUNCTION random_dob() RETURNS VARCHAR(30) DETERMINISTIC
        RETURN FROM_UNIXTIME(ROUND(RAND() * (1451606399 - 1104537600)) + 1104537600);