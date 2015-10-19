USE [TelerikAcademy]

/*Task 01 Write a SQL query to find the names and salaries of the employees that take the minimal salary in the company.
	Use a nested SELECT statement.*/
SELECT FirstName + ' ' + LastName AS [Name], Salary
	FROM Employees
	WHERE Salary = 
	(SELECT MIN(Salary) FROM Employees)

/*Task 02 Write a SQL query to find the names and salaries of the employees that have a salary 
	that is up to 10% higher than the minimal salary for the company.*/
SELECT FirstName + ' ' + LastName AS [Name], Salary
	FROM Employees
	WHERE Salary <= 1.1 *
	(SELECT MIN(Salary) FROM Employees)
	ORDER BY Salary

/* Task 03 Write a SQL query to find the full name, salary and department of the employees that take the minimal salary 
	in their department. Use a nested SELECT statement.*/
SELECT e.FirstName + ' ' + e.LastName AS [Name], e.Salary, d.Name AS [Department]
	FROM Employees e, Departments d
	WHERE Salary =
	(SELECT MIN(Salary) FROM Employees e, Departments d
	WHERE e.DepartmentID = d.DepartmentID)
	ORDER BY d.name

/* Tasks 04 Write a SQL query to find the average salary in the department #1.*/
SELECT AVG(e.Salary) AS [Average Salary], d.Name AS [Department]
	FROM Employees e, Departments d
	WHERE d.DepartmentID = 1
	GROUP BY d.Name

/* Task 05 Write a SQL query to find the average salary in the "Sales" department. */
SELECT AVG(e.Salary) AS [Average Salary], d.Name AS [Department]
	FROM Employees e, Departments d
	WHERE e.DepartmentID = d.DepartmentID AND d.Name = 'Sales'
	GROUP BY d.Name

/* Task 06 Write a SQL query to find the number of employees in the "Sales" department.*/
SELECT COUNT(*) AS [Number of Employees], d.Name AS [Department]
	FROM Employees e, Departments d
	WHERE e.DepartmentID = d.DepartmentID AND d.Name = 'Sales'
	GROUP BY d.Name

/* Task 07 Write a SQL query to find the number of all employees that have manager.*/ 
SELECT COUNT(*) AS [Employee with Manager]
	FROM Employees
	WHERE ManagerID IS NOT NULL

/* Task 08 Write a SQL query to find the number of all employees that have no manager. */
SELECT COUNT(*) AS [Employee with NO Manager]
	FROM Employees
	WHERE ManagerID IS NULL

/* Task 09 Write a SQL query to find all departments and the average salary for each of them.*/
SELECT AVG(e.Salary) AS [Average Salary], d.Name AS [Department]
	FROM Employees e, Departments d
	WHERE e.DepartmentID = d.DepartmentID 
	GROUP BY d.Name
	ORDER BY [Average Salary] ASC

/* Task 10 Write a SQL query to find the count of all employees in each department and for each town.*/
SELECT COUNT(*) AS [E count], d.Name AS [Department], t.Name AS [Town]
	FROM Employees e
	JOIN Departments d
	  ON e.DepartmentID = d.DepartmentID
	JOIN Addresses a
	  ON e.AddressID = a.AddressID
	JOIN Towns t
	  ON a.TownID = t.TownID
	GROUP BY t.Name, d.Name
	ORDER BY [E Count] DESC

/* Task 11 Write a SQL query to find all managers that have exactly 5 employees. 
	Display their first name and last name.*/  
SELECT m.FirstName, m.LastName, COUNT(e.ManagerID) AS [Employees Count]
	FROM Employees e, Employees m
	WHERE e.ManagerID = m.EmployeeID	
	GROUP BY m.FirstName, m.LastName
	HAVING COUNT(e.ManagerID) = 5

/* Task 12 Write a SQL query to find all employees along with their managers. 
	For employees that do not have manager display the value "(no manager)".*/
SELECT e.FirstName + ' ' + e.LastName AS [Employee], 
	COALESCE(m.FirstName + ' ' + m.LastName, '(no manager)') AS [Manager]
	FROM Employees e
	LEFT OUTER JOIN Employees m
	ON e.ManagerID = m.EmployeeID

/* Task 13 Write a SQL query to find the names of all employees whose last name 
	is exactly 5 characters long. Use the built-in LEN(str) function.*/
SELECT LastName
	FROM Employees
	WHERE LEN(LastName) = 5
	ORDER BY LastName ASC

/* Task 14 Write a SQL query to display the current date and time in the following format 
	"day.month.year hour:minutes:seconds:milliseconds".*/
SELECT convert(varchar, GETDATE(), 113) AS [Current Date And Time]

/* Task 15 Write a SQL statement to create a table Users. Users should have username, password, full name and last login time.
	-Choose appropriate data types for the table fields. Define a primary key column with a primary key constraint.
	-Define the primary key column as identity to facilitate inserting records.
	-Define unique constraint to avoid repeating usernames.
	-Define a check constraint to ensure the password is at least 5 characters long.*/
CREATE TABLE Users (
	[UserID] int IDENTITY,
	[UserName] nvarchar(50) NOT NULL,
	[PassWord] nvarchar(50) NOT NULL,
	[Full Name] nvarchar(150),
	[Last Login] datetime, 
 	CONSTRAINT PK_Users PRIMARY KEY([UserId]),
	UNIQUE ([UserName]),
	CHECK (LEN([PassWord]) >= 5)
)
GO

/* Task 16 Write a SQL statement to create a view that displays the users from the Users table that 
	have been in the system today.*/
CREATE VIEW [All Users From Today] AS
SELECT *
FROM Users
	WHERE GETDATE() = [Last Login]
GO

/* Task 17 Write a SQL statement to create a table Groups. Groups should have unique name (use unique constraint).
	Define primary key and identity column.*/
CREATE TABLE Groups (
	[GroupID] int IDENTITY,
	[Name] nvarchar(50) NOT NULL,
 	CONSTRAINT PK_Groups PRIMARY KEY([GroupID]),
	UNIQUE ([Name])
)
GO

/* Task 18 Write a SQL statement to add a column GroupID to the table Users.
	Fill some data in this new column and as well in the `Groups table.
	Write a SQL statement to add a foreign key constraint between tables Users and Groups tables.*/
ALTER TABLE Users
	ADD 
	[GroupID] int
	CONSTRAINT FK_Users_Groups
	FOREIGN KEY ([GroupID])
	REFERENCES Groups([GroupID])
GO

/* Task 19 Write SQL statements to insert several records in the Users and Groups tables.*/
INSERT INTO Groups ([Name]) VALUES
	('Java Script Masters'),
	('SQL Masters'),
	('Advanced C++')
GO

INSERT INTO Users ([UserName], [PassWord], [Last Login], [GroupID]) VALUES
	('Johnny5', 'trickyone', GETDATE(), 1),
	('John Hon', 'japan1234', GETDATE(), 1),
	('Lise', 'ilikepink', GETDATE(), 2),
	('Natasha', 'catslover', GETDATE(), 2),
	('John Snow', 'ilikethenorth', GETDATE(), 1),
	('Penelope Cruz', 'sexylatina', GETDATE(), 1)
GO

/* Task 20 Write SQL statements to update some of the records in the Users and Groups tables.*/
UPDATE Groups
	SET [Name] = 'JS Applications'
	WHERE [Name] LIKE 'Java%'

UPDATE Users
	SET [UserName] = 'Mike Ross'
	WHERE [UserName] = 'Johnny5'

UPDATE Users
	SET [GroupID] = 1
	WHERE [UserName] LIKE '%sha'

/* Task 21 Write SQL statements to delete some of the records from the Users and Groups tables.*/
DELETE FROM Users
	WHERE [UserName] = 'John Snow'
GO

DELETE FROM Groups
	WHERE [Name] LIKE '%++%'
GO

/* Task 22 Write SQL statements to insert in the Users table the names of all employees from the Employees table.
	Combine the first and last names as a full name.
	For username use the first letter of the first name + the last name (in lowercase).
	Use the same for the password, and NULL for last login time.*/
INSERT INTO Users
	SELECT 
	LEFT(FirstName, 3) + LOWER(LastName) AS [UserName],
	LEFT(FirstName, 1) + LOWER(LastName) AS [PassWord],
	FirstName + ' ' + LastName AS [Full Name],
	CONVERT(DATE, '01.03.2010') AS [Last Login],
	1 AS [GroupID]
	FROM Employees	
GO

/* Task 23 Write a SQL statement that changes the password to NULL for all users that have 
	not been in the system since 10.03.2010. */
UPDATE Users
	SET [PassWord] = NULL
	WHERE [Last Login] <= CONVERT(DATE, '10.03.2010', 104)

/* Task 24 Write a SQL statement that deletes all users without passwords (NULL password). */

DELETE FROM Users
	WHERE [PassWord] IS NULL

/* Task 25 Write a SQL query to display the average employee salary by department and job title.*/
SELECT d.Name AS [Department], e.JobTitle, AVG(Salary) AS [Average Salary]
	FROM Employees e
	JOIN Departments d
	ON e.DepartmentID = d.DepartmentID
	GROUP BY d.Name, e.JobTitle
	ORDER BY [Average Salary] DESC

/* Task 26 Write a SQL query to display the minimal employee salary by department and job title 
	along with the name of some of the employees that take it.*/
SELECT d.Name AS [Department], e.JobTitle, e.FirstName + ' ' + e.LastName as [Name], e.Salary
	FROM Employees e
	JOIN Departments d
	ON e.DepartmentID = d.DepartmentID
	WHERE e.Salary = 
	(
		SELECT MIN(Salary) 
		FROM Employees emp
		WHERE emp.JobTitle = e.JobTitle AND emp.DepartmentID = e.DepartmentID
	)
	GROUP BY e.JobTitle, d.Name, e.FirstName + ' ' + e.LastName, e.Salary

/* Task 27 Write a SQL query to display the town where maximal number of employees work. */
SELECT TOP 1 COUNT(*) AS [Number of employees], t.Name
	FROM Employees e
		JOIN Addresses a
		ON e.AddressID = a.AddressID
		JOIN Towns t
		ON a.TownID = t.TownID
	GROUP BY t.Name
	ORDER BY [Number of employees] DESC

/* Task 28 Write a SQL query to display the number of managers from each town.*/
SELECT t.Name, COUNT(DISTINCT e.EmployeeID) AS [Number of Managers]
	FROM Employees e
		JOIN Addresses a
		ON e.AddressID = a.AddressID
		JOIN Towns t
		ON a.TownID = t.TownID
		JOIN Employees m
		ON e.EmployeeID = m.ManagerID
	GROUP BY t.Name
	ORDER BY [Number of Managers] DESC

/* Task 29 Write a SQL to create table WorkHours to store work reports for each employee 
	(employee id, date, task, hours, comments).
	- Don't forget to define identity, primary key and appropriate foreign key.	*/

CREATE TABLE WorkHours (
	[WorkHourID] int IDENTITY,
	[Task] nvarchar(100) NOT NULL,
	[StartDate] datetime, 
	[WorkHours] int NOT NULL, 	 	
	[Comments] text, 
	[EmployeeID] int NOT NULL
 	CONSTRAINT PK_WorkHours PRIMARY KEY([WorkHourID]),
	CONSTRAINT FK_WorkHours_Employees FOREIGN KEY ([EmployeeID]) REFERENCES Employees([EmployeeID])
)
GO

/* - Issue few SQL statements to insert, update and delete of some data in the table. */
INSERT INTO WorkHours ([Task], [WorkHours], [EmployeeID]) VALUES
	('Design New Machine', 2, 1),
	('Play Golf', 5, 2),
	('Prepare Documents', 2, 3),
	('Research some Info', 4, 4)
GO


UPDATE WorkHours
	SET [EmployeeID] = 6
	WHERE [EmployeeID] = 1

UPDATE WorkHours
	SET [StartDate] = GETDATE()
	WHERE [StartDate] IS NULL

DELETE FROM WorkHours
	WHERE [WorkHourID] = 1

/* - Define a table WorkHoursLogs to track all changes in the WorkHours table with triggers.
	- For each change keep the old record data, the new record data and the command (insert / update / delete).*/
CREATE TABLE WorkHourLogs (
	[ChangeID] int IDENTITY,
	[OldEmployeeID] int,
	[OldTask] nvarchar(100),
	[OldReportDate] datetime,	
	[OldTaskHours] int,
	[OldComments] text,
	[NewEmployeeID] int,
	[NewTask] nvarchar(100),
	[NewReportDate] datetime,	
	[NewTaskHours] int,
	[NewComments] text,
	Command nvarchar(20)
	CONSTRAINT PK_WorkHourLogs PRIMARY KEY([ChangeID]),
)
GO

CREATE TRIGGER tr_InsertTrigger ON WorkHours FOR INSERT
AS
	INSERT INTO WorkHourLogs
	SELECT NULL, NULL, NULL, NULL, NULL, 
	i.EmployeeID, i.Task, i.StartDate, i.WorkHours, i.Comments, 'INSERT'
	FROM inserted i
GO

CREATE TRIGGER tr_UpdateTrigger ON WorkHours FOR UPDATE
AS
	INSERT INTO WorkHourLogs
	SELECT d.EmployeeID, d.Task, d.StartDate, d.WorkHours, d.Comments, 
	i.EmployeeID, i.Task, i.StartDate, i.WorkHours, i.Comments, 'UPDATE'
	FROM inserted i, deleted d
GO

CREATE TRIGGER tr_DELETETrigger ON WorkHours FOR DELETE
AS
	INSERT INTO WorkHourLogs
	SELECT d.EmployeeID, d.Task, d.StartDate, d.WorkHours, d.Comments, 
	NULL, NULL, NULL, NULL, NULL, 'DELETE'
	FROM deleted d
GO

UPDATE WorkHours
	SET [EmployeeID] = 6
	WHERE [EmployeeID] = 1

UPDATE WorkHours
	SET [StartDate] = GETDATE()
	WHERE [StartDate] IS NULL

DELETE FROM WorkHours
	WHERE [WorkHourID] = 1

/* Task 30 Start a database transaction, delete all employees from the 'Sales' department along with all dependent 
records from the pother tables. At the end rollback the transaction. */
DECLARE @TransactionDelete varchar(20) = 'DeleteSalesEmployees';

BEGIN TRAN @TransactionDelete
	DELETE FROM TelerikAcademy.dbo.Employees 
	WHERE DepartmentID = 3;
ROLLBACK TRAN @TransactionDelete;

/* Task 31 tart a database transaction and drop the table EmployeesProjects.
	Now how you could restore back the lost table data?*/
BEGIN TRAN 
	DROP TABLE EmployeesProjects
ROLLBACK TRAN 

/* Task 32 Find how to use temporary tables in SQL Server.
	Using temporary tables backup all records from EmployeesProjects 
	and restore them back after dropping and re-creating the table. */
SELECT * 
	INTO #Temp FROM EmployeesProjects
	DROP TABLE EmployeesProjects
		SELECT * INTO EmployeeProjects FROM #Temp
		DROP TABLE #Temp