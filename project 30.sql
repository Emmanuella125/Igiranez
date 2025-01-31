	show databases;
 create database online_Quiz_system;   
 use online_Quiz_system;
 
CREATE TABLE User (
    user_id INT PRIMARY KEY AUTO_INCREMENT,
    username 
VARCHAR(50) NOT NULL,
    password 
VARCHAR(255) NOT NULL,
    email 
VARCHAR(100)
);
CREATE TABLE Quiz (
    quiz_id 
INT PRIMARY KEY AUTO_INCREMENT,
    title 
VARCHAR(255) NOT NULL,
    description TEXT
);
CREATE TABLE Question (
    question_id 
INT PRIMARY KEY AUTO_INCREMENT,
    quiz_id INT,
    question_text TEXT,
FOREIGN KEY (quiz_id) REFERENCES Quiz(quiz_id)
);
CREATE TABLE Answer (
answer_id 
INT PRIMARY KEY AUTO_INCREMENT,
    question_id INT,
    answer_text TEXT,
    is_correct 
BOOLEAN,
FOREIGN KEY (question_id) REFERENCES Question(question_id)
);
CREATE TABLE Result (result_id 
INT PRIMARY KEY AUTO_INCREMENT,
user_id INT,
    score INT,
    FOREIGN KEY (user_id) REFERENCES User(user_id)
); 
insert into User (user_id,username,password,email)value
(100,'keza alice','ali','kezaalice@gmail.com'),
(200,'teta tona','teta','tetatonia'),
(300,'umwali aline','aline','umwalialine@gmail.com'),
(400,'dusenge emmy','emmy','dusengeemmy@gmail.com');
insert into Quiz (quiz_id,title,description)value
(101,'biology','a qiuz to test biology'),
(102,'chemistry','a qiuz to test chemistry'),
(103,'math','a qiuz to test math'),
(104,'entreprenuer','a qiuz to test entreprenuer');
insert into Question (question_id,question_text)value
(10,'what is capital city of Rwanda'),
(11,'what is the largest  city in Rwanda'),
(12,'who is the President of Rwanda'),
(13,'how many clour are in national flag of Rwanda');
insert into Answer (answer_id,question_id)value
(30,10),
(31,11),
(32,12),
(33,13);
insert into Result (result_id,user_id,score)value
(001,100,1000),
(002,200,2000),
(003,300,3000),
(004,400,4000);
drop table Result;
select* from User;
-- update for user
update User set username= 'MUHIRE Aime' where User_id=101;
-- delete user
delete from user where User_id=400;
select* from user;
-- count for user
select count(*)from user;
-- avg for user
select avg(username)from user where user_id=100;
-- sum for user
select sum(username)from user;
-- update for Quiz
UPDATE Quiz
set title='economy'
WHERE quiz_id =103;
DELETE FROM Quiz
WHERE quiz_id = 103;
-- count for quiz
SELECT COUNT(*) 
FROM Quiz;
-- avg for user
select avg(title)from Quiz where Quiz_id=103;
-- sum for quiz
select sum(title)from Quiz;
select*from Quiz;
-- update for question
UPDATE question
SET question_text = 'What is the capital city of Rwanda? (Updated)'
WHERE question_id = 10;
-- count for question
SELECT COUNT(*) AS total_questions
FROM question;
-- average for question
SELECT AVG(question_id) from Question;
-- sum for question
SELECT SUM(question_id) 
FROM question;
select*from question;
-- update for answer
UPDATE Answer
SET answer_id = 33
WHERE question_id = 13;
DELETE FROM Answer
WHERE question_id = 11;
-- count for answer
SELECT COUNT(*) AS total_answers
FROM Answer;
-- sum for answer
SELECT SUM(answer_id) 
FROM Answer;
-- avg for answer
SELECT AVG(answer_id)
FROM Answer;
select*from Answer;
-- update for result
UPDATE Result
SET score = 1500
WHERE result_id = 001;
-- delete for result
DELETE FROM Result
WHERE result_id = 003;
-- count for result
SELECT COUNT(*) AS total_results
FROM Result;
-- avg for result
SELECT AVG(score) AS average_score
FROM Result;
select*from result;
CREATE VIEW UserView AS
SELECT * FROM User;
SELECT * FROM UserView;
CREATE VIEW QuizView AS
SELECT * FROM Quiz;
SELECT * FROM QuizView;
CREATE VIEW QuestionView AS
SELECT * FROM Question;
SELECT * FROM QuestionView;
CREATE VIEW AnswerView AS
SELECT * FROM Answer;
SELECT * FROM AnswerView;
CREATE VIEW ResultView AS
SELECT * FROM Result;
SELECT * FROM ResultView;
DELIMITER $$
CREATE PROCEDURE InsertUserData()
BEGIN
    INSERT INTO User (user_id, username, password, email) VALUES
    (100, 'keza alice', 'ali', 'kezaalice@gmail.com'),
    (200, 'teta tona', 'teta', 'tetatonia'),
    (300, 'umwali aline', 'aline', 'umwalialine@gmail.com'),
    (400, 'dusenge emmy', 'emmy', 'dusengeemmy@gmail.com');
END $$s
DELIMITER $$
CREATE PROCEDURE InsertQuizData()
BEGIN
    INSERT INTO Quiz (quiz_id, title, description) VALUES
    (101, 'biology', 'a quiz to test biology'),
    (102, 'chemistry', 'a quiz to test chemistry'),
    (103, 'math', 'a quiz to test math'),
    (104, 'entrepreneur', 'a quiz to test entrepreneur');
END $$

DELIMITER ;
DELIMITER $$
CREATE PROCEDURE InsertQuestionData()
BEGIN
    INSERT INTO Question (question_id, question_text) VALUES
    (10, 'what is the capital city of Rwanda'),
    (11, 'what is the largest city in Rwanda'),
    (12, 'who is the President of Rwanda'),
    (13, 'how many colors are in the national flag of Rwanda');
END $$

DELIMITER ;
DELIMITER $$

CREATE PROCEDURE InsertAnswerData()
BEGIN
    INSERT INTO Answer (answer_id, question_id) VALUES
    (30, 10),
    (31, 11),
    (32, 12),
    (33, 13);
END $$

DELIMITER ;
DELIMITER $$

CREATE PROCEDURE InsertResultData()
BEGIN
    INSERT INTO Result (result_id, user_id, score) VALUES
    (1, 100, 1000),
    (2, 200, 2000),
    (3, 300, 3000),
    (4, 400, 4000);
END $$

DELIMITER ;
DELIMITER $$

CREATE TRIGGER after_user_insert
AFTER INSERT ON User
FOR EACH ROW
BEGIN
    INSERT INTO User_Audit (user_id, action) 
    VALUES (NEW.user_id, 'INSERT');
END $$

DELIMITER ;
DELIMITER $$

CREATE TRIGGER after_quiz_insert
AFTER INSERT ON Quiz
FOR EACH ROW
BEGIN
    INSERT INTO Quiz_Audit (quiz_id, action_description)
    VALUES (NEW.quiz_id, 'INSERT');
END $$

DELIMITER ;
DELIMITER $$

CREATE TRIGGER after_question_insert
AFTER INSERT ON Question
FOR EACH ROW
BEGIN
    INSERT INTO Question_Audit (question_id, action_description)
    VALUES (NEW.question_id, 'INSERT');
END $$

DELIMITER ;
DELIMITER $$

CREATE TRIGGER after_answer_insert
AFTER INSERT ON Answer
FOR EACH ROW
BEGIN
    INSERT INTO Answer_Audit (answer_id, question_id, action_description)
    VALUES (NEW.answer_id, NEW.question_id, 'INSERT');
END $$

DELIMITER ;
DELIMITER $$
CREATE TRIGGER after_result_insert
AFTER INSERT ON Result
FOR EACH ROW
BEGIN
    INSERT INTO Result_Audit (result_id, user_id, score, action_description)
    VALUES (NEW.result_id, NEW.user_id, NEW.score, 'INSERT');
END $$

DELIMITER ;
-- create the databases
create database online_Quiz_system;   
-- create user and his/her password
create user '2401001756'@'127.0.0.1'identified by '2401001756';
/*grant the permission to user on created database*/
grant all privileges on online_Quiz_system.*to '2401001756'@'127.0.0.1';
/*allow the permission */
flush privileges;