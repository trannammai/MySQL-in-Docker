--
-- Create a database using `MYSQL_DATABASE` placeholder
--

CREATE DATABASE IF NOT EXISTS MYSQL_DATABASE;
USE MYSQL_DATABASE;


/* =======================================  Creating database and tables  ======================================= */

/* 
SET FOREIGN_KEY_CHECKS = 0;
DROP TABLE IF EXISTS courses;
DROP TABLE IF EXISTS schools;
DROP TABLE IF EXISTS students;
DROP TABLE IF EXISTS studying;
SET FOREIGN_KEY_CHECKS = 1; */

CREATE TABLE IF NOT EXISTS schools (
        id_sch FLOAT NOT NULL AUTO_INCREMENT PRIMARY KEY
        , name_sch VARCHAR(50)
);

CREATE TABLE IF NOT EXISTS students (
        dob_std DATE
        , id_sch_fk SMALLINT
        , id_std FLOAT NOT NULL AUTO_INCREMENT PRIMARY KEY
        , male_std CHAR(1)
        , name_std VARCHAR(50)
);

CREATE TABLE IF NOT EXISTS courses (
        id_crs FLOAT NOT NULL AUTO_INCREMENT PRIMARY KEY
        , name_crs VARCHAR(50)
);

CREATE TABLE IF NOT EXISTS studying (
        date_regist DATETIME
        , id_crs_fk TINYINT NOT NULL
        , id_std_fk BIGINT NOT NULL
);