CREATE DATABASE EmployeeDB;
GO
USE EmployeeDB;
GO

CREATE TABLE Department (
    DepartId INT PRIMARY KEY,
    DepartName VARCHAR(50) NOT NULL,
    Description VARCHAR(100) NOT NULL
);
GO
-- create the employee table
CREATE TABLE Employee (
    EmpCode CHAR(6) PRIMARY KEY,
    FirstName VARCHAR(30) NOT NULL,
    LastName VARCHAR(30) NOT NULL,
    Birthday SMALLDATETIME NOT NULL,
    Gender BIT DEFAULT 1,
    Address VARCHAR(100),
    DepartID INT,
    Salary MONEY,
    CONSTRAINT fk_Department FOREIGN KEY (DepartID) REFERENCES Department(DepartId)
);
GO
-- cau 1
-- insert into department table
INSERT INTO Department (DepartId, DepartName, Description)
VALUES 
    (101, 'Sales', 'Ban san pham va dich vu'),
    (102, 'Marketing', 'Quang ba cac san pham'),
    (103, 'Engineering', 'Thiet ke va xay dung san pham');
GO

-- insert into employee table
INSERT INTO Employee (EmpCode, FirstName, LastName, Birthday, Gender, Address, DepartID, Salary)
VALUES
    ('E10101', 'Bien', 'Hao', '2001-01-22', 1, 'Ha Nam', 101, 50000),
    ('E10102', 'HUY', 'Canh', '1994-05-12', 0, 'Ninh Binh', 101, 55000),
    ('E10201', 'Minh', 'Thu', '1989-07-23', 1, 'Nam Dinh', 102, 60000),
    ('E10202', 'Hanh', 'Ly', '1999-10-15', 0, 'Hai Duong', 102, 65000),
    ('E10301', 'Quynh', 'Hoang', '1989-03-07', 1, 'Da Nang', 103, 70000),
    ('E10302', 'Nga', 'Chien', '2000-11-28', 0, 'Ha Noi', 103, 75000);
GO
--cau 2
UPDATE Employee
SET Salary = Salary * 1.1;
--cau3
ALTER TABLE Employee
ADD CONSTRAINT CK_Salary CHECK (Salary > 0);
--cau 4
CREATE TRIGGER  TG_CheckBirthday
ON Employee
AFTER update, insert
AS
BEGIN
    DECLARE @dayOfBirthDay date;
	SELECT @dayOfBirthDay  = inserted.Birthday from inserted;

	if(Day(@dayOfBirthDay) <= 23 ) 
	BEGIN
	    PRINT 'Day of birthday must be greater than 23!';
		ROLLBACK transaction;
	END
END
--CAU 5
 CREATE NONCLUSTERED INDEX IX_DepartmentName
 ON Department(DepartName)