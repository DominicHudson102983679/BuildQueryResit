/* Dominic Hudson - 102983679 */

use buildqueryresit

/* task 1 


Subject (SubjCode, Description)
Primary Key (SubjCode)

Student (StudentID, Surname, GivenName, Gender)
Primary Key (StudentID)

SubjectOffering (Year, Semester, SubjCode, StaffID, Fee)
Primary Key (Year, Semester, SubjCode, StaffID)
Foreign key (SubjCode) references Subject
Foreign key (StaffID) references Teacher

Enrolment (Year, Semester, SubjCode, StudentID, DateEnrolled, Grade)
Primary Key (Year, Semester, SubjCode, StudentID)
Foreign Key (Year, Semester, SubjCode) references SubjectOffering
Foreign Key (StudentID) references Student

Teacher (StaffID, Surname, GivenName)
Primary Key (StaffID)

*/

-- Task 2
/*
CREATE TABLE Subject (
    SubjCode    NVARCHAR(100),
    Description NVARCHAR(500),
    Primary Key (SubjCode)
);

CREATE TABLE Teacher (
    StaffID     INT CHECK(LEN(StaffID) = 8),
    Surname     NVARCHAR(100) NOT NULL,
    GivenName   NVARCHAR(100) NOT NULL,
    Primary Key (StaffID)
);  

CREATE TABLE Student (
    StudentID   NVARCHAR(10),
    Surname     NVARCHAR(100) NOT NULL,
    GivenName   NVARCHAR(100) NOT NULL,
    Gender      NVARCHAR(1) CHECK (Gender IN ('M', 'F', 'I')) NULL,
    Primary Key (StudentID)
);

CREATE TABLE SubjectOffering (
    SubjCode    NVARCHAR(100),
    Year        INT CHECK (LEN(Year) = 4),
    Semester    INT CHECK (Semester IN (1, 2)),
    Fee         MONEY CHECK (Fee > 0) NOT NULL,
    StaffID     INT CHECK(LEN(StaffID) = 8) NULL,
    Primary Key (Year, Semester, SubjCode),
    Foreign key (SubjCode) references Subject,
    Foreign key (StaffID) references Teacher
);

CREATE TABLE Enrolment (
    StudentID   NVARCHAR(10),
    SubjCode    NVARCHAR(100),
    Year        INT CHECK (LEN(Year) = 4),
    Semester    INT CHECK (Semester IN (1, 2)),
    Grade       NVARCHAR(2) CHECK (Grade IN ('N', 'P', 'C', 'D', 'HD')) NULL,
    DateEnrolled    DATE,
    Primary Key (StudentID, SubjCode, Year, Semester),
    Foreign Key (Year, Semester, SubjCode) references SubjectOffering,
    Foreign Key (StudentID) references Student
);
*/

-- task 3
/*
INSERT INTO Student (StudentID, Surname, GivenName, Gender) VALUES
('s12233445', 'Baird', 'Tim', 'M'),
('s23344556', 'Nguyen', 'Anh', 'M'),
('s34455667', 'Hallinan', 'James', 'M'),
('102983679', 'Hudson', 'Dominic', 'M');

INSERT INTO Subject (SubjCode, Description) VALUES
('ICTPRG418', 'Apply SQL to extract & manipulate data'),
('ICTBSB430', 'Create Basic Databases'),
('ICTDBS205', 'Design a Database');

INSERT INTO Teacher (StaffID, Surname, GivenName) VALUES
(98776655 , 'Young', 'Angus'),
(87665544 , 'Scott', 'Bon'),
(76554433 , 'Slade', 'Chris');

INSERT INTO SubjectOffering (SubjCode, Year, Semester, Fee, StaffID) VALUES
('ICTPRG418', 2019, 1, 200, 98776655),
('ICTPRG418', 2020, 1, 225, 98776655),
('ICTBSB430', 2020, 1, 200, 87665544),
('ICTBSB430', 2020, 2, 200, 76554433),
('ICTDBS205', 2019, 2, 225, 87665544);

INSERT INTO Enrolment (StudentID, SubjCode, [Year], Semester, Grade, DateEnrolled) VALUES
('s12233445', 'ICTPRG418', 2019, 1, 'D', '02/25/2019'),
('s23344556', 'ICTPRG418', 2019, 1, 'P', '02/15/2019'),
('s12233445', 'ICTPRG418', 2020, 1, 'C', '01/30/2020'),
('s23344556', 'ICTPRG418', 2020, 1, 'HD', '02/26/2020'),
('s34455667', 'ICTPRG418', 2020, 1, 'P', '01/28/2020'),
('s12233445', 'ICTBSB430', 2020, 1, 'C', '02/8/2020'),
('s23344556', 'ICTBSB430', 2020, 2, null, '06/30/2020'),
('s34455667', 'ICTBSB430', 2020, 2, null, '07/3/2020'),
('s23344556', 'ICTDBS205', 2019, 2, 'P', '07/1/2019'),
('s34455667', 'ICTDBS205', 2019, 2, 'N', '07/13/2019');
*/

--task 4

/* query 1 */

/*

SELECT 
    stu.GivenName, stu.Surname, 
    sbj.SubjCode, sbj.Description, 
    enr.Year, enr.Semester, 
    sbjo.Fee, 
    tch.GivenName, tch.Surname

FROM ((((SubjectOffering sbjo
    INNER JOIN Subject sbj ON Sbj.SubjCode = sbjo.SubjCode)
    INNER JOIN Teacher tch ON tch.StaffID = sbjo.StaffID)
    INNER JOIN Enrolment enr ON enr.Year = sbjo.Year AND enr.Semester = sbjo.Semester)
    INNER JOIN Student stu ON stu.StudentID = enr.StudentID)

ORDER BY year asc, semester asc; 
*/

/* query 2

SELECT enr.Year, enr. Semester, COUNT(enr.studentID) as 'Num Enrolments'
FROM enrolment enr
GROUP BY enr. year, enr. semester
ORDER BY year asc, semester asc; 
*/


/* query 3 
*/
SELECT enr.studentID, sbjo.SubjCode, enr.year, enr.semester, sbjo.fee
FROM enrolment enr

INNER JOIN 
    subjectoffering sbjo ON sbjo.SubjCode = enr.SubjCode AND 
    sbjo.Year = enr.Year AND 
    sbjo.semester = enr.semester

WHERE sbjo.fee = (select MAX(sbjo.fee) FROM subjectoffering sbjo);



-- task 5

/*

CREATE VIEW buildqueryview AS

SELECT 
    stu.GivenName, stu.Surname, 
    sbj.SubjCode, sbj.Description, 
    enr.Year, enr.Semester, 
    sbjo.Fee, 
    tch.staffID

FROM 
    ((((SubjectOffering sbjo
    INNER JOIN Subject sbj ON Sbj.SubjCode = sbjo.SubjCode)
    INNER JOIN Teacher tch ON tch.StaffID = sbjo.StaffID)
    INNER JOIN Enrolment enr ON enr.Year = sbjo.Year AND enr.Semester = sbjo.Semester)
    INNER JOIN Student stu ON stu.StudentID = enr.StudentID)

*/

-- task 6

-- SELECT COUNT(DateEnrolled) From Enrolment;

/* 

2019/1 had 2 enrolments, 2019/2 had 2 enrolments, 2020/1 had 4 enrolments and 2020/2 had 
2 enrolments, totalling 10 enrolments in across the 2 years. This query returns a single column value of 10, the same number of rows of data in the 
enrolment table excel sheet
*/


select count(sbjo.fee) from subjectoffering sbjo;

/*

this query returns a single row value of 5, the same numbers of rows returned in query 3 for high est fee paid 

*/