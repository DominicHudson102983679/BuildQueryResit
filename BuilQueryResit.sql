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

/* Task 2

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
    Foreign Key (Semester, Year, SubjCode) references SubjectOffering,
    Foreign Key (StudentID) references Student
);

SELECT *
from Subject

Select * 
from Teacher

Select *
from Student

Select *
From SubjectOffering

Select *
from Enrolment

*/

/* task 3 */

