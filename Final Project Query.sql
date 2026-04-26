
-- Roles
CREATE TABLE Role (
RoleID INT IDENTITY(1,1) PRIMARY KEY,
RoleName VARCHAR(50) NOT NULL
)



-- Departments
CREATE TABLE Department (
DepartmentID INT IDENTITY(1,1) PRIMARY KEY,
DepartmentName VARCHAR(100) NOT NULL
)

-- Tracks
CREATE TABLE Track (
TrackID INT IDENTITY(1,1) PRIMARY KEY,
TrackName VARCHAR(100) NOT NULL,
DepartmentID INT NOT NULL,
FOREIGN KEY (DepartmentID) REFERENCES Department(DepartmentID)
)

-- Branches
CREATE TABLE Branch (
BranchID INT IDENTITY(1,1) PRIMARY KEY,
BranchName VARCHAR(100) NOT NULL
)

-- Intakes
CREATE TABLE Intake (
IntakeID INT IDENTITY(1,1) PRIMARY KEY,
IntakeName VARCHAR(50) NOT NULL
)

-- Instructors
CREATE TABLE Instructor
(
InstructorID INT IDENTITY(1,1) PRIMARY KEY,
Name VARCHAR(100) NOT NULL,
Email VARCHAR(100),
DepartmentID INT NOT NULL,
FOREIGN KEY (DepartmentID) REFERENCES Department(DepartmentID)
)

-- Student

CREATE TABLE Student 
(
StudentID INT IDENTITY(1,1) PRIMARY KEY,
FirstName VARCHAR(50) NOT NULL,
LastName  VARCHAR(50) NOT NULL,
Email     VARCHAR(100),
Phone     VARCHAR(20),
studentage INT NOT NULL,
IntakeID  INT NOT NULL,
BranchID  INT NOT NULL,
TrackID   INT NOT NULL,
FOREIGN KEY (IntakeID) REFERENCES Intake(IntakeID),
FOREIGN KEY (BranchID) REFERENCES Branch(BranchID),
FOREIGN KEY (TrackID) REFERENCES Track(TrackID)
)

-- Accounts
CREATE TABLE AccountUser (
UserID INT IDENTITY(1,1) PRIMARY KEY,
Username NVARCHAR(50) UNIQUE NOT NULL,
Passwordd NVARCHAR(255) NOT NULL,
RoleID INT NOT NULL,  
StudentID INT NULL,
InstructorID INT NULL,

CONSTRAINT FK_AccountUser_Role FOREIGN KEY (RoleID)
 REFERENCES Role(RoleID),

CONSTRAINT FK_AccountUser_Student FOREIGN KEY (StudentID)
REFERENCES Student(StudentID),

CONSTRAINT FK_AccountUser_Instructor FOREIGN KEY (InstructorID)
REFERENCES Instructor(InstructorID)
)



-- Courses
CREATE TABLE Course
(
CourseID INT IDENTITY(1,1) PRIMARY KEY,
CourseName VARCHAR(100) NOT NULL,
Description VARCHAR(MAX),
MaxDegree INT NOT NULL,
MinDegree INT NOT NULL
)

-- InstructorCourse 
CREATE TABLE InstructorCourse 
(
InstructorCourseID INT IDENTITY(1,1) PRIMARY KEY,
InstructorID INT NOT NULL,
CourseID INT NOT NULL,
IntakeID INT NOT NULL,
BranchID INT NOT NULL,
TrackID INT NOT NULL,
FOREIGN KEY (InstructorID) REFERENCES Instructor(InstructorID),
FOREIGN KEY (CourseID) REFERENCES Course(CourseID),
FOREIGN KEY (IntakeID) REFERENCES Intake(IntakeID),
FOREIGN KEY (BranchID) REFERENCES Branch(BranchID),
FOREIGN KEY (TrackID) REFERENCES Track(TrackID)
)

-- Questions
CREATE TABLE Question
(
QuestionID INT IDENTITY(1,1) PRIMARY KEY,
CourseID INT NOT NULL,
QuestionText VARCHAR(200) NOT NULL,
QuestionType VARCHAR(20) CHECK (QuestionType IN ('MCQ','TrueFalse')) NOT NULL,
CorrectAnswer VARCHAR(255) NOT NULL,
FOREIGN KEY (CourseID) REFERENCES Course(CourseID)
)

-- MCQ Options 
CREATE TABLE MCQ_Option 
(
OptionID INT IDENTITY(1,1) PRIMARY KEY,
QuestionID INT NOT NULL,
OptionText VARCHAR(255) NOT NULL,
IsCorrect BIT NOT NULL DEFAULT 0,
FOREIGN KEY (QuestionID) REFERENCES Question(QuestionID)
)

-- Exams 
CREATE TABLE Exam 
(
ExamID INT IDENTITY(1,1) PRIMARY KEY,
instructorCourseID INT NOT NULL,
ExamType VARCHAR(20) CHECK (ExamType IN ('Exam','Corrective')) NOT NULL,
ExamName VARCHAR(100),
StartTime DATETIME NOT NULL,
EndTime DATETIME NOT NULL,
TotalTime INT NOT NULL,
FOREIGN KEY (InstructorCourseID) REFERENCES InstructorCourse(InstructorCourseID)
)

-- Exam Questions
CREATE TABLE ExamQuestion 
(
ExamQuestionID INT IDENTITY(1,1) PRIMARY KEY,
ExamID INT NOT NULL,
QuestionID INT NOT NULL,
Degree INT NOT NULL,
FOREIGN KEY (ExamID) REFERENCES Exam(ExamID),
FOREIGN KEY (QuestionID) REFERENCES Question(QuestionID)
)

-- Student Exams
CREATE TABLE StudentExam
(
StudentExamID INT IDENTITY(1,1) PRIMARY KEY,
StudentID INT NOT NULL,
ExamID INT NOT NULL,
Status VARCHAR(20) CHECK (Status IN ('Assigned','Completed')) NOT NULL DEFAULT 'Assigned',
FinalResult DECIMAL(5,2),
FOREIGN KEY (StudentID) REFERENCES Student(StudentID),
FOREIGN KEY (ExamID) REFERENCES Exam(ExamID)
)

-- Student Answers
CREATE TABLE StudentAnswer 
(
AnswerID INT IDENTITY(1,1) PRIMARY KEY,
StudentExamID INT NOT NULL,
ExamQuestionID INT NOT NULL,
AnswerText VARCHAR(255) NOT NULL,
IsCorrect BIT,
Score DECIMAL(5,2),
FOREIGN KEY (StudentExamID) REFERENCES StudentExam(StudentExamID),
FOREIGN KEY (ExamQuestionID) REFERENCES ExamQuestion(ExamQuestionID)
)





--------------------------------------------------------------------------------------------------------------------------------------


-- 1. Roles
INSERT INTO Role (RoleName) VALUES 
('Admin'), 
('Instructor'), 
('Student')

-- 2. Departments
INSERT INTO Department (DepartmentName) VALUES 
('Computer Science'), 
('Information Technology'), 
('Data Science')

-- 3. Branches
INSERT INTO Branch (BranchName) VALUES 
('New Cairo'), 
('Nasr City')

-- 4. Intakes
INSERT INTO Intake (IntakeName) VALUES 
('Intake 1'), 
('Intake 2')

-- 5. Tracks
INSERT INTO Track (TrackName, DepartmentID) VALUES
('Software Development', 1),   
('Artificial Intelligence', 2), 
('Data Science Projects', 3)

-- 6. Instructors
INSERT INTO Instructor (Name, Email, DepartmentID) VALUES
('Ali Ahmed','ali@uni.com',1),
('Omar Hossam','omar@uni.com',2),
('Hany Samir','hany@uni.com',3),
('Ahmed Yasser','yasser@uni.com',1),
('Ramy Hassan','ramy@uni.com',2),
('Mohamed Nasser','moh6@uni.com',3)

-- 7. Students

INSERT INTO Student (FirstName, LastName, Email, Phone, StudentAge, IntakeID, BranchID, TrackID) VALUES
-- Intake 1, Branch 1
('Omar','Mohamed','omar1@mail.com','01000000001',20,1,1,1),
('Sara','Ali','sara1@mail.com','01000000002',21,1,1,1),
('Ahmed','Hassan','ahmed1@mail.com','01000000003',22,1,1,2),
('Laila','Nabil','laila1@mail.com','01000000004',23,1,1,2),
-- Intake 1, Branch 2
('Khaled','Tamer','khaled1@mail.com','01000000005',24,1,2,1),
('Nour','Hassan','nour1@mail.com','01000000006',22,1,2,1),
('Omar','Sami','omar2@mail.com','01000000007',21,1,2,3),
-- Intake 2, Branch 1
('Mona','Youssef','mona2@mail.com','01000000008',23,2,1,3),
('Sara','Hany','sara2@mail.com','01000000009',20,2,1,1),
('Ali','Laila','ali2@mail.com','01000000010',22,2,1,2),
-- Intake 2, Branch 2
('Hana','Yasser','hana@mail.com','01000000011',21,2,2,1),
('Tamer','Ahmed','tamer@mail.com','01000000012',22,2,2,2),
('Salma','Hassan','salma@mail.com','01000000013',23,2,2,3),
('Omar','Nabil','omar3@mail.com','01000000014',24,2,2,3)

-- 8. AccountUser

-- Admin
INSERT INTO AccountUser (Username, Passwordd, RoleID)
VALUES ('admin', '123456', 1)

-- Instructors
INSERT INTO AccountUser (Username, Passwordd, RoleID, InstructorID) VALUES
('instructor1', 'pass123', 2 , 1),
('instructor2', 'pass143', 2 , 2),
('instructor3', 'pass133', 2 , 3),
('instructor4', 'pass144', 2 , 4),
('instructor5', 'pass145', 2 , 5),
('instructor6', 'pass146', 2 , 6)

-- Students
INSERT INTO AccountUser (Username, Passwordd, RoleID, StudentID) VALUES
('student1', 'pass121', 3, 1),
('student2', 'pass122', 3, 2),
('student3', 'pass123', 3, 3),
('student4', 'pass124', 3, 4),
('student5', 'pass125', 3, 5),
('student6', 'pass126', 3, 6),
('student7', 'pass127', 3, 7),
('student8', 'pass128', 3, 8),
('student9', 'pass129', 3, 9),
('student10','pass130', 3, 10),
('student11','pass131', 3, 11),
('student12','pass132', 3, 12),
('student13','pass133', 3, 13),
('student14','pass134', 3, 14)


-- 9. Courses
INSERT INTO Course (CourseName, Description, MaxDegree, MinDegree) VALUES
('Programming 1','Intro to programming',100,50),
('Networking Basics','Computer networks fundamentals',100,50),
('Machine Learning','Supervised & unsupervised learning',100,50)



--InstructorCourse

-- Branch 1
INSERT INTO InstructorCourse (InstructorID, CourseID, IntakeID, BranchID, TrackID) VALUES
(1, 1, 1, 1, 1),
(1, 1, 2, 1, 1),
(2, 2, 1, 1, 2),
(2, 2, 2, 1, 2),
(3, 3, 1, 1, 3),
(3, 3, 2, 1, 3)

-- Branch 2
INSERT INTO InstructorCourse (InstructorID, CourseID, IntakeID, BranchID, TrackID) VALUES
(4, 1, 1, 2, 1),
(4, 1, 2, 2, 1),
(5, 2, 1, 2, 2),
(5, 2, 2, 2, 2),
(6, 3, 1, 2, 3),
(6, 3, 2, 2, 3)

select * from InstructorCourse


--Question


-- Track 1 


-- MCQ
INSERT INTO Question (CourseID, QuestionText, QuestionType, CorrectAnswer) VALUES
(1,'What is a variable in programming?','MCQ','A memory storage'),
(1,'Which loop runs at least once even if the condition is false?','MCQ','Do-while loop'),
(1,'Which keyword is used to define a function in Python?','MCQ','def'),
(1,'What symbol is used for comments in SQL?','MCQ','--'),
(1,'Which of these is not a programming paradigm?','MCQ','Spreadsheet')

-- True/False
INSERT INTO Question (CourseID, QuestionText, QuestionType, CorrectAnswer) VALUES
(1,'Python is a statically typed language.','TrueFalse','False'),
(1,'HTML is a programming language.','TrueFalse','False'),
(1,'In C++, ++i increments the value before using it.','TrueFalse','True'),
(1,'Functions can return multiple values in Python.','TrueFalse','True'),
(1,'SQL is used to manipulate databases.','TrueFalse','True')

-- Track 2


-- MCQ
INSERT INTO Question (CourseID, QuestionText, QuestionType, CorrectAnswer) VALUES
(2,'What does AI stand for?','MCQ','Artificial Intelligence'),
(2,'Which algorithm is used for supervised learning?','MCQ','Decision Tree'),
(2,'What does NLP stand for?','MCQ','Natural Language Processing'),
(2,'Which of these is a type of neural network?','MCQ','CNN'),
(2,'Reinforcement learning requires a reward system.','MCQ','True')

-- True/False
INSERT INTO Question (CourseID, QuestionText, QuestionType, CorrectAnswer) VALUES
(2,'AI can perfectly understand human emotions.','TrueFalse','False'),
(2,'Unsupervised learning uses labeled data.','TrueFalse','False'),
(2,'Machine learning is a subset of AI.','TrueFalse','True'),
(2,'Deep learning requires neural networks.','TrueFalse','True'),
(2,'AI systems can learn without data.','TrueFalse','False')

-- Track 3 

-- MCQ
INSERT INTO Question (CourseID, QuestionText, QuestionType, CorrectAnswer) VALUES
(3,'Which language is most popular for data analysis?','MCQ','Python'),
(3,'What is the main purpose of pandas library in Python?','MCQ','Data manipulation'),
(3,'Which chart is best for categorical data?','MCQ','Pie chart'),
(3,'What does CSV stand for?','MCQ','Comma Separated Values'),
(3,'What is the purpose of a correlation matrix?','MCQ','Shows variable relationships')

-- True/False
INSERT INTO Question (CourseID, QuestionText, QuestionType, CorrectAnswer) VALUES
(3,'Outliers can affect the mean of a dataset.','TrueFalse','True'),
(3,'Normalization changes data distribution to uniform.','TrueFalse','True'),
(3,'Big Data always refers to unstructured data.','TrueFalse','False'),
(3,'Python’s Matplotlib library is used for data visualization.','TrueFalse','True'),
(3,'Regression is used for classification problems.','TrueFalse','False')




-- MCQ Options

 -- Track 1 
 
INSERT INTO MCQ_Option (QuestionID, OptionText, IsCorrect) VALUES

(1,'A memory storage',1),
(1,'A function',0),
(1,'A loop',0),
(1,'An operator',0),

(2,'For loop',0),
(2,'While loop',0),
(2,'Do-while loop',1),
(2,'If loop',0),

(3,'func',0),
(3,'def',1),
(3,'function',0),
(3,'define',0),

(4,'#',0),
(4,'--',1),
(4,'/* */',0),
(4,'$$',0),

(5,'Object-Oriented',0),
(5,'Functional',0),
(5,'Procedural',0),
(5,'Spreadsheet',1)

-- Track 2

INSERT INTO MCQ_Option (QuestionID, OptionText, IsCorrect) VALUES
 
(11,'Artificial Intelligence',1),
(11,'Automatic Interface',0),
(11,'Algorithmic Interaction',0),
(11,'Applied Innovation',0),

(12,'Decision Tree',1),
(12,'K-Means',0),
(12,'PCA',0),
(12,'Random Forest',0),

(13,'Natural Language Processing',1),
(13,'Numeric Language Parsing',0),
(13,'Neural Learning Protocol',0),
(13,'NLP Language Package',0),

(14,'CNN',1),
(14,'RNN',0),
(14,'SVM',0),
(14,'KNN',0),

(15,'True',1),
(15,'False',0),
(15,'Maybe',0),
(15,'Depends',0)

-- Track 3

INSERT INTO MCQ_Option (QuestionID, OptionText, IsCorrect) VALUES
 
(21,'Python',1),
(21,'R',0),
(21,'Java',0),
(21,'C++',0),

(22,'Data manipulation',1),
(22,'Data collection',0),
(22,'Data visualization',0),
(22,'Machine learning',0),

(23,'Bar chart',0),
(23,'Pie chart',1),
(23,'Line chart',0),
(23,'Scatter plot',0),

(24,'Comma Separated Values',1),
(24,'Character Separated Values',0),
(24,'Column Separated Values',0),
(24,'Case Separated Values',0),

(25,'Shows variable relationships',1),
(25,'Stores raw data',0),
(25,'Creates charts',0),
(25,'Normalizes data',0)



-- Exam  


-- Branch 1 

-- Intake 1
INSERT INTO Exam (InstructorCourseID, ExamType, ExamName, StartTime, EndTime, TotalTime) VALUES
(1, 'Exam', 'Programming 1 Midterm - Intake 1', '2025-10-01 09:00', '2025-10-01 11:00', 120),
(3, 'Exam', 'Networking Basics Midterm - Intake 1', '2025-10-02 09:00', '2025-10-02 11:00', 120),
(5, 'Exam', 'Machine Learning Midterm - Intake 1', '2025-10-03 09:00', '2025-10-03 11:00', 120)

-- Intake 2
INSERT INTO Exam (InstructorCourseID, ExamType, ExamName, StartTime, EndTime, TotalTime) VALUES
(2, 'Exam', 'Programming 1 Midterm - Intake 2', '2025-10-01 09:00', '2025-10-01 11:00', 120),
(4, 'Exam', 'Networking Basics Midterm - Intake 2', '2025-10-02 09:00', '2025-10-02 11:00', 120),
(6, 'Exam', 'Machine Learning Midterm - Intake 2', '2025-10-03 09:00', '2025-10-03 11:00', 120)

-------

-- Branch 2 

-- Intake 1
INSERT INTO Exam (InstructorCourseID, ExamType, ExamName, StartTime, EndTime, TotalTime) VALUES
(7, 'Exam', 'Programming 1 Midterm - Intake 1', '2025-10-01 09:00', '2025-10-01 11:00', 120),
(9, 'Exam', 'Networking Basics Midterm - Intake 1', '2025-10-02 09:00', '2025-10-02 11:00', 120),
(11, 'Exam', 'Machine Learning Midterm - Intake 1', '2025-10-03 09:00', '2025-10-03 11:00', 120)

-- Intake 2
INSERT INTO Exam (InstructorCourseID, ExamType, ExamName, StartTime, EndTime, TotalTime) VALUES
(8, 'Exam', 'Programming 1 Midterm - Intake 2', '2025-10-01 09:00', '2025-10-01 11:00', 120),
(10, 'Exam', 'Networking Basics Midterm - Intake 2', '2025-10-02 09:00', '2025-10-02 11:00', 120),
(12, 'Exam', 'Machine Learning Midterm - Intake 2', '2025-10-03 09:00', '2025-10-03 11:00', 120)

select ExamName ,ExamID, BranchID ,IntakeID  from Exam e join InstructorCourse i on 
e.InstructorCourseID = i.InstructorCourseID
order by ExamName

--same exam diff branch
--3 1 ,9 2
--6 1 , 12 2
--2 1 , 8 2
--5 1 ,11 2
--1 1 , 7 2
--4 1 ,10 2



--ExamQuestion

INSERT INTO ExamQuestion (ExamID, QuestionID, Degree)
SELECT e.ExamID, q.QuestionID, 10
FROM Exam e
JOIN InstructorCourse ic ON e.InstructorCourseID = ic.InstructorCourseID
JOIN Question q ON q.CourseID = ic.CourseID
WHERE e.ExamID IN (1,2,3,4,5,6,7,8,9,10,11,12)


select * , QuestionText  from ExamQuestion e join Question q
on e.QuestionID = q.QuestionID
order by ExamID 



-- StudentExam



INSERT INTO StudentExam (StudentID, ExamID)
SELECT s.StudentID, e.ExamID
FROM Student s
JOIN InstructorCourse ic
    ON ic.BranchID = s.BranchID
   AND ic.IntakeID = s.IntakeID
   AND ic.TrackID = s.TrackID
JOIN Exam e 
    ON e.InstructorCourseID = ic.InstructorCourseID;



select * , BranchID , IntakeID , TrackID from StudentExam SE JOIN Student S
ON SE.StudentID = S.StudentID
ORDER BY ExamID


 --StudentAnswer

 TRUNCATE TABLE StudentAnswer;


INSERT INTO StudentAnswer (StudentExamID, ExamQuestionID, AnswerText)
SELECT
    se.StudentExamID,
    eq.ExamQuestionID,
    CASE 
        WHEN q.QuestionType = 'MCQ' THEN (
            SELECT TOP 1 mo.OptionText
            FROM MCQ_Option mo
            WHERE mo.QuestionID = q.QuestionID
            ORDER BY NEWID()
        )
        WHEN q.QuestionType = 'TrueFalse' THEN 'True'
    END AS AnswerText
FROM StudentExam se
JOIN ExamQuestion eq ON se.ExamID = eq.ExamID
JOIN Question q ON eq.QuestionID = q.QuestionID;




--------------------------------------------------------------------------------------------------------------------------------------



ALTER TABLE AccountUser
ADD CONSTRAINT  UNI_USER
CHECK (
    (RoleID = 1 AND StudentID IS NULL AND InstructorID IS NULL) 
 OR (RoleID = 2 AND InstructorID IS NOT NULL AND StudentID IS NULL) 
 OR (RoleID = 3 AND StudentID IS NOT NULL AND InstructorID IS NULL) 
)



---------------------------

ALTER TABLE StudentExam
ADD CONSTRAINT StudentExam UNIQUE (StudentID, ExamID)

-----------------


ALTER TABLE Exam
ADD CONSTRAINT Exam_Time
CHECK (StartTime < EndTime)

-----------------


ALTER TABLE ExamQuestion
ADD CONSTRAINT CK_ExamQuestion_Degree
CHECK (Degree > 0)

-----------------


ALTER TABLE StudentAnswer
ADD CONSTRAINT CK_StudentAnswer_Score
CHECK (Score >= 0)


-----------------

CREATE OR ALTER TRIGGER Final_Result
ON StudentAnswer
AFTER INSERT, UPDATE
AS


UPDATE StudentExam
SET FinalResult = ISNULL( (SELECT SUM(Score)
FROM StudentAnswer sa
WHERE sa.StudentExamID = StudentExam.StudentExamID),0)




-----------------
CREATE OR ALTER TRIGGER EXAM_DEGREE
ON ExamQuestion
AFTER INSERT, UPDATE
AS

 DECLARE @ExamID INT
 DECLARE @TotalDegree INT
 DECLARE @MaxDegree INT
 DECLARE @ErrorMessage NVARCHAR(200) = 'ERROR RAISED'


SELECT @TotalDegree = SUM(Degree)
FROM ExamQuestion
WHERE ExamID = @ExamID

SELECT @MaxDegree = MaxDegree
FROM Exam e
JOIN InstructorCourse ic ON e.InstructorCourseID = ic.InstructorCourseID
JOIN Course c ON ic.CourseID = c.CourseID
WHERE e.ExamID = @ExamID

IF (@TotalDegree > @MaxDegree)
RAISERROR(@ErrorMessage, 16, 1)




----------------------------
CREATE OR ALTER TRIGGER AUTO_CORRECT
ON StudentAnswer
AFTER INSERT, UPDATE
AS


UPDATE StudentAnswer
SET 
IsCorrect = CASE 
WHEN StudentAnswer.AnswerText = Question.CorrectAnswer THEN 1 
 ELSE 0 
 END,

 Score = CASE 
 WHEN StudentAnswer.AnswerText = Question.CorrectAnswer THEN ExamQuestion.Degree 
 ELSE 0 
 END

FROM StudentAnswer
JOIN inserted ON StudentAnswer.AnswerID = inserted.AnswerID
JOIN ExamQuestion ON StudentAnswer.ExamQuestionID = ExamQuestion.ExamQuestionID
JOIN Question ON ExamQuestion.QuestionID = Question.QuestionID





--------------------------

CREATE OR ALTER PROCEDURE GetRandomQuestions
@CourseID INT,
@NumQuestions INT

AS
   
SELECT TOP (@NumQuestions) QuestionID, QuestionText, QuestionType
FROM Question
WHERE CourseID = @CourseID
ORDER BY NEWID()   
  

EXEC GetRandomQuestions @CourseID = 1, @NumQuestions = 10


--------------------------------------------

CREATE OR ALTER VIEW StudentResult AS
SELECT 
StudentID,
ExamID,
SUM(Score) AS TotalScore
FROM StudentExam se
JOIN StudentAnswer sa ON se.StudentExamID = sa.StudentExamID
GROUP BY se.StudentID, se.ExamID


SELECT * FROM StudentResult WHERE StudentID = 5


----------------
--Indexes


-- InstructorCourse
CREATE NONCLUSTERED INDEX IX_InstructorCourse_Branch_Intake_Track
ON InstructorCourse (BranchID, IntakeID, TrackID)

-- ExamQuestion:
CREATE NONCLUSTERED INDEX IX_ExamQuestion_ExamID
ON ExamQuestion (ExamID)

-- StudentAnswer: 
CREATE NONCLUSTERED INDEX IX_StudentAnswer_StudentExam_ExamQuestion
ON StudentAnswer (StudentExamID, ExamQuestionID)

-- Question: 
CREATE NONCLUSTERED INDEX IX_Question_CourseID
ON Question (CourseID)

-- MCQ_Option: 
CREATE NONCLUSTERED INDEX IX_MCQ_Option_QuestionID
ON MCQ_Option (QuestionID)

-- Exam: 
CREATE NONCLUSTERED INDEX IX_Exam_InstructorCourseID_StartTime
ON Exam (InstructorCourseID, StartTime)

-- AccountUser:
CREATE NONCLUSTERED INDEX IX_AccountUser_Role_Student_Instructor
ON AccountUser (RoleID, StudentID, InstructorID)
















