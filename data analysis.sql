CREATE DATABASE STUDENTMANGEMENT;
USE STUDENTMANGEMENT;


CREATE TABLE Students (
StudentID INT PRIMARY KEY,
Name VARCHAR(50) NOT NULL,
Gender VARCHAR(10) NOT NULL,
Age INT,
Grade CHAR(1),
Maths_score INT,
Science_score INT,
English_score INT
);



INSERT INTO Students(StudentID ,Name,Gender,age,Grade,Maths_score,Science_score,English_score)VALUES
(1,'GIRIDHAR','MALE',20,'A',85,78,88),
(2,'VASANTH','MALE',22,'B',72,81,75),
(3,'MAMATHA','FEMALE',24,'A',90,92,89),
(4,'KEERTHI','FEMALE',20,'C',65,70,68),
(5,'SATHWIKA','FEMALE',22,'A',85,88,91),
(6,'POOJESH','MALE',20,'B',75,79,80),
(7,'AKHIL','MALE',26,'A',95,89,93),
(8,'RAVI','MALE',25,'C',60,72,67),
(9,'RAMA','FEMALE',20,'A',85,98,88),
(10,'MANI','MALE',24,'A',85,88,91);

         
SELECT *FROM Students;

SELECT AVG(Maths_score)AS AVG_MATHS FROM Students;

SELECT AVG(Science_score)AS AVG_SCIENCE FROM Students;


SELECT AVG(English_score)AS AVG_ENGLISH FROM Students;

SELECT Name,(Maths_score + Science_score + English_score) AS Total_score FROM Students
ORDER BY Total_score DESC ;


SELECT GRADE,COUNT(*)AS Total_Students FROM Students GROUP BY Grade;

SELECT Gender,AVG(Maths_score + Science_score + English_score) AS AVERAGE_score FROM Students GROUP BY GENDER;


SELECT Name,Maths_score FROM Students WHERE Maths_score >80;

UPDATE Students 
SET Grade = 'A'
WHERE StudentID =2;









 


   

