DELIMITER $$
DROP PROCEDURE IF EXISTS store_prod_random $$
CREATE PROCEDURE store_prod_random(dtb VARCHAR(100), tbl VARCHAR(100), num_sample INT)
BEGIN

DECLARE field VARCHAR(50);
DECLARE type_field VARCHAR(50);
DECLARE datatype VARCHAR(50);
DECLARE max_length VARCHAR(50);

DECLARE get_data VARCHAR(1000);

DECLARE x INT;
DECLARE sample_size INT;

DECLARE finished INT DEFAULT 0;

DECLARE result_set CURSOR FOR
    SELECT  COLUMN_NAME, 
            COLUMN_TYPE, 
            DATA_TYPE, 
            CHARACTER_MAXIMUM_LENGTH
    FROM INFORMATION_SCHEMA.COLUMNS 
    WHERE TABLE_NAME = tbl 
    AND TABLE_SCHEMA = dtb;

DECLARE CONTINUE HANDLER FOR NOT FOUND SET finished = 1;

SET get_data = '';
OPEN result_set;
value_loop: loop

FETCH result_set INTO field, type_field, datatype, max_length;
  IF (finished = 1) THEN LEAVE value_loop;
  END IF;

CASE    WHEN datatype IN ('varchar') THEN SET get_data = CONCAT(get_data, 'random_name(', IFNULL(max_length, 0),'), ');
        WHEN datatype IN ('char') THEN SET get_data = CONCAT(get_data, 'random_gender(', IFNULL(max_length, 0),'), ');
        WHEN datatype IN ('date') THEN SET get_data = CONCAT(get_data, 'random_dob(), ');
        WHEN datatype IN ('bigint') THEN SET get_data = CONCAT(get_data, 'random_student(), ');
        WHEN datatype IN ('smallint') THEN SET get_data = CONCAT(get_data, 'random_school(), ');
        WHEN datatype IN ('tinyint') THEN SET get_data = CONCAT(get_data, 'random_course(), ');
        WHEN datatype IN ('datetime') THEN SET get_data = CONCAT(get_data, 'random_time(), ');
        ELSE SET get_data = CONCAT(get_data, 'NULL, ');
END CASE;

END LOOP value_loop;
CLOSE result_set;

SET get_data = TRIM(TRAILING ', ' FROM get_data);
SET @get_data = CONCAT("INSERT INTO ", dtb, ".", tbl," VALUES (", get_data, ");");
SET @get_data = CONCAT("INSERT IGNORE INTO ", dtb, ".", tbl," VALUES (", get_data, ")");

SET sample_size = 2000;
WHILE sample_size > 0 DO
   SET sample_size  = sample_size - 1;
   SET @get_data = CONCAT(@get_data , " ,(", get_data, ")");
END WHILE;

SET x = num_sample;
SET sample_size = 2000;
store_prod_random:loop
        WHILE (x > sample_size) DO
          PREPARE stmt_name FROM @get_data;
          EXECUTE stmt_name;
          SET x = x - sample_size;
        END WHILE;

SET @get_data = CONCAT("INSERT INTO ", dtb, ".", tbl, " VALUES (", get_data, ");");
        WHILE (x > 0) DO
          PREPARE stmt_name FROM @get_data;
          EXECUTE stmt_name;
          SET x = x - 1;
        END WHILE;

LEAVE store_prod_random;
END LOOP store_prod_random;
END $$
DELIMITER;