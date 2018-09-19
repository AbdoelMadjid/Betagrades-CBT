DROP DATABASE IF EXISTS ElectronicExam;
CREATE DATABASE ElectronicExam ; 
USE ElectronicExam;
DROP TABLE IF EXISTS users;
CREATE TABLE users (
    id TINYINT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    surname VARCHAR(15) NOT NULL,
    matricno VARCHAR(11) NOT NULL
    );
DROP TABLE IF EXISTS courses;
CREATE TABLE courses (
    id TINYINT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(50) NOT NULL,
    course_code VARCHAR(6)NOT NULL
    );
DROP TABLE IF EXISTS questions;
CREATE TABLE questions (
    id TINYINT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    course_id TINYINT  NULL,
    question TINYTEXT NOT NULL,
    option1 VARCHAR(50) NOT NULL,
    option2 VARCHAR(50) NOT NULL,
    option3 VARCHAR(50) NOT NULL,
    option4 VARCHAR(50) NOT NULL,
    answer_true VARCHAR(50) NOT NULL,
    FOREIGN KEY course_id(course_id) REFERENCES courses(id)
    ON UPDATE CASCADE
    ON DELETE SET NULL
    );
DROP TABLE IF EXISTS student_answers;
CREATE TABLE student_answers (
    session_id VARCHAR(80) NOT NULL PRIMARY KEY,
    course_id TINYINT  NULL,
    question_id TINYINT  NULL,
    question TINYTEXT NOT NULL,
    option1 VARCHAR(50) NOT NULL,
    option2 VARCHAR(50) NOT NULL,
    option3 VARCHAR(50) NOT NULL,
    option4 VARCHAR(50) NOT NULL,
    answer_selected VARCHAR(50) NOT NULL,
    answer_true VARCHAR(50) NOT NULL,
    FOREIGN KEY question_id(question_id) REFERENCES questions(id)
    ON UPDATE CASCADE
    ON DELETE SET NULL,
    FOREIGN KEY course_id_2 (course_id) REFERENCES courses(id)
    ON UPDATE CASCADE
    ON DELETE SET NULL
    );
DROP TABLE IF EXISTS student_results;
CREATE TABLE student_results (
    id TINYINT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    course_id TINYINT NULL,
    date_created timestamp DEFAULT CURRENT_TIMESTAMP,
    score TINYINT NOT NULL
    );