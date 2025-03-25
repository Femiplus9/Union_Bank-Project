
---DML OPERATIONS FOR SKYBARREL AT UNION BANK

use master

CREATE DATABASE DMLWINTER_2025;
DROP DATABASE DMLWINTER_2025 
USE DMLWINTER_2025;
---TASK 1: CREATE TABLES
--TABLE FOR THE EMPLOYEES
Create Schema SKYBARREL;

Create Table SKYBARREL.Employees
(
EmployeeID Int not null,
FirstName Varchar (50) not null,
LastName Varchar (50) not null,
DepartmentID Int not null,
Position Varchar (50) not null,
Salary Decimal (10,2) not null
);


---APPLY PRIMARY KEY TO EMPLOYEEID 
ALTER TABLE[SKYBARREL].[Employees] 
ADD CONSTRAINT PK_EMPLOYEES_EmployeeID PRIMARY KEY ([EmployeeID]);
---APPLY PRIMARY KEY TO DepartmentID
ALTER TABLE [SKYBARREL].[Employees]
ADD CONSTRAINT PK_DepartmentID_ PRIMARY KEY ([DepartmentID]);

---APPLY FOREIGN KEY TO DepartmentID on SKYBARREL.Employees
ALTER TABLE [SKYBARREL].[Employees]
ADD CONSTRAINT FK_Employees_DepartmentID FOREIGN KEY ([DepartmentID]) REFERENCES [SKYBARREL].[Departments]([DepartmentID]);

---TABLE FOR THE DEPARTMENTS

Create Table SKYBARREL.Departments
(
DepartmentID Int not null,
DepartmentName Varchar (50) not null
);

---APPLY PRIMARY KEY TO DepartmentID
ALTER TABLE [SKYBARREL].[Departments]
ADD CONSTRAINT PK_Departments_DepartmentID PRIMARY KEY ([DepartmentID]);
 
---TABLE FOR INVESTMENTS

Create Table SKYBARREL.Investments
(
InvestmentID Int not null,
InvestmentName Varchar (100) not null,
InvestmentType Varchar (50) not null,
DepartmentID Int not null,
AmountInvested Decimal (15,2),
StartDate Date not null
);
---APPLY PRIMARY KEY  TO INVESTMENTID COLUMN
ALTER TABLE [SKYBARREL].[Investments]
ADD CONSTRAINT PK_Investments_InvestmentID PRIMARY KEY ([InvestmentID]);

---APPLY FOREIGN KEK TO DepartmentID
ALTER TABLE [SKYBARREL].[Investments]
ADD CONSTRAINT FK_Investment_DepartmentID FOREIGN KEY ([DepartmentID]) REFERENCES [SKYBARREL].[Departments]([DepartmentID]);

---TASK 2:
--- Populate Data Into Departments Table
INSERT INTO [SKYBARREL].[Departments]([DepartmentID],[DepartmentName])
Values                          (1,'Marketing'),
	                            (2,'Finance'),
	                            (3,'Engineering'),
	                            (4, 'Risk Management'),
	                            (5,'Sales');

---CHECKING TO SEE THE  CONTAINS OF THE TABLE.
SELECT * FROM [SKYBARREL].[Departments];

---Populate Data Into Employees Table
INSERT INTO [SKYBARREL].[Employees]([EmployeeID],[FirstName],[LastName],[DepartmentID],[Position],[Salary])
           VALUES            (1, 'John', 'Doe', 1, 'Marketing Manager', $120000.00),
		                     (2, 'Jane', 'Smith', 2, 'Financial Analyst', $95000.00),
							 (3, 'Robert','Johnson', 3, 'Software Engineer',105000.00),
							 (4, 'Emily', 'Davis', 1, 'Senior Marketing Strategist', $88000.00),
							 (5, 'Michael', 'Brown', 4, 'Risk Analyst', $85000.00),
							 (6, 'Sarah', 'Wilson', 2, 'Senior Accountant', $115000.00),
							 (7, 'David', 'Lee', 3, 'Systems Archiect', $125000.00),
							 (8,'Rachel', 'Kim', 5, 'Sales Manager', $110000.00),
							 (9,'Daniel', 'Green',2 , 'Investment Manager', $130000.00),
							 (10, 'Alex', 'Baker', 4, 'Risk Management Consultant', $94000.00);

 ---CHECKING TO SEE THE  CONTAINS OF THE TABLE.

 Select * From [SKYBARREL].[Employees];

--- Populate Data Into Investments Table
INSERT INTO [SKYBARREL].[Investments]([InvestmentID],[InvestmentName],[InvestmentType],[DepartmentID],[AmountInvested],[StartDate])
                      VALUES  (1, 'Sky Fund Alpha', 'Equity', 1,2000000.00, '2025-01-10'),
					          (2, 'Sky Fund Beta', 'Bond', 2, 1500000.00, '2025-02-01'),
							  (3,'Sky Fund Delta', 'Real Estate', 3, 3000000.00, '2025-03-01'),
							  (4, 'Sky Fund Omega', 'Stock', 4, 500000.00,'2025-01-20'),
							  (5, 'Sky Fund Gamma', 'Real Estate', 2, 1200000.00, '2025-04-15'),
							  (6, 'Sky Fund Zeta', 'Bond', 3, 2500000.00, '2025-02-28'),
							  (7, 'Sky Fund Theta', 'Equity', 1,3500000.00,'2025-03-10'),
							  (8, 'Sky Fund Kappa', 'Real Estate', 4, 8000000.00, '2025-04-05'),
							  (9, 'Sky Fund Iota', 'Stock', 5, 2000000.00, '2025-05-01');

  ---CHECKING TO SEE THE  CONTAINS OF THE TABLE.
  Select * From [SKYBARREL].[Investments];
 --- Task 3: Perform DML OPerations
  ---3.1 Update Data
  --- (a) Salary Adjustment
  --- Increase = salary * 0.15
 --- New Salary = Salary + Increase 


   UPDATE [SKYBARREL].[EMPLOYEES]
SET [SALARY]=[SALARY]*1.15
WHERE [DEPARTMENTID]=1 AND [SALARY] <100000;
 ---- Run a Test on the code
select * from [SKYBARREL].[Employees]

--- (b) Department Change

UPDATE [SKYBARREL].[Employees]
SET [DepartmentID] = 3
WHERE [EmployeeID] = 4
 ------Created a Bonus Column.
ALTER TABLE [SKYBARREL].[Employees]
ADD BONUS DECIMAL (10,2) NULL
--- Testing code
Select* from [SKYBARREL].[Employees]
---Performance Bonus applied to Risk Management Department
UPDATE [SKYBARREL].[Employees]
SET BONUS=[Salary] * 0.10
WHERE [DepartmentID] = 4
----Testing  the code
select * from [Skybarrel].[Employees];



UPDATE [skybarrel].[Employees]
SET [Salary]= [Salary] * 1.10 
WHERE [DepartmentID] = 4;
----Testing  the code 
Select * from [Skybarrel].[Employees];
--- (d) Salary Correction 
Update [Skybarrel].[Employees]
Set [Salary] = $60000
Where [EmployeeID] = 6 
-----Testing code
Select * from [SKYBARREL].[Employees]
--- 3.2 Insert Data ----
--- (a) New Employee Record (Inserted into Employees Table)
--------EmployeeID was not given so we assumed the next number

INSERT INTO [Skybarrel].[Employees] ([EmployeeID],[FirstName],[LastName],[DepartmentID],[Position],[Salary])
                  VALUES (      11 ,    'John',   'Thompson',   1,  'Senoir Marketing Strategist', $95000  ) 
--- Testing to code
SELECT * FROM 	[Skybarrel].[Employees];	  

--- (b) New Investment (Insert into Investment Table)

INSERT INTO [Skybarrel].[Investments] ([InvestmentID],[InvestmentName],[InvestmentType],[DepartmentID],[AmountInvested],[StartDate])
                 VALUES         (    10,       'Sky Fund X',     'Real Estate',      3     , $2000000 ,'2025-02-15' )

				 -----InvestmentiD already exist new InvestmentID number (10) was used (Provided by the consultant)  
--- (C) Bulk Employee Addition ( Insert into Employees Table)BULK INSERT   { database_name.schema_name.table_or_view_name | schema_name.table_or_view_name | table_or_view_name }       FROM 'data_file'     [ WITH    (    [ [ , ] DATA_SOURCE = 'data_source_name' ]
 

INSERT INTO            Skybarrel.Employees (EmployeeID,FirstName,LastName,DepartmentID,Position,Salary)
 VALUES                       ( 12   ,   ' Alex' ,            ' Baker' ,    2   ,     'Null'    ,  $70000),
                              (  13    ,  'Rachel' ,        'Kim'    ,       2    ,   'Null'    ,   $85000),
							  (  14   ,   'Daniel',        'Green'    ,      2  ,     'Null'    , $90000 );
 ----Looks like it is missing the Position data coulmn. 


INSERT INTO [Skybarrel].[Investments] ([InvestmentID],[InvestmentName],[InvestmentType],[DepartmentID],[AmountInvested],[StartDate])
VALUES                          (       11     , 'SkyFund Y'    , 'Bond'         ,    2        ,      $15000000 , '2025-03-01' ),
                                (        12    ,  'SkyFund Z'    ,  'Stock'       ,   1         ,     $800000 ,  '2025-03-15'),
								(        13    ,  'SkyFund W',    'Real Estate'   ,    4         , $3000000   , '2025-04-01');

-----To check table for inserts 
SELECT * FROM [Skybarrel].[Investments];

---3.3 Delete Data

--- (a) Delete an Employee
DELETE FROM [skybarrel].[Employees]
WHERE [EmployeeID] = 10 

--- (b) Delete a Department 

DELETE FROM [SKYBARREL].[Investments]
WHERE [InvestmentID] =  9
----Test code
Select * from [SKYBARREL].[Investments]

--- We were asked to delete Department, with Id = 5
DELETE FROM [SKYBARREL].[Departments] 
WHERE [DepartmentID] =  5
---This could not be done due of Foreign Ket netted to other tables

--- 3.4 Select Queries
--- a. Retrieve Employees and Departments
	 SELECT E.[EmployeeID],
        [EMPLOYEES FULL NAME] = CONCAT_WS(' ',E.[FirstName],E.[LastName]),
        E.[DepartmentID],
        E.[Position],
        E.[Salary],      
        D.[DepartmentName]
FROM [SKYBARREL].[Employees] AS E
LEFT JOIN [SKYBARREL].[Departments] AS D
ON     E.[DepartmentID] = D.[DepartmentID]

--- b. Employees with Salary Above $100,000

--Write a SELECT query to retrieve the FirstName, LastName, and DepartmentName 
--of all employees whose salary is greater than $100,000.
   SELECT  E.[FirstName],E.[LastName],E.[DepartmentID],E.[Salary],D.[DepartmentName]
   FROM [SKYBARREL].[Employees] AS E
   JOIN [SKYBARREL].[Departments] AS D
   ON E.[DepartmentID] = D.[DepartmentID]
   WHERE [Salary] >$100000;
--- C. Highest Paid Employee in Each Department
--Write a SELECT query to retrieve the employee with the highest salary in each department. 
--Ensure that the query returns only one employee per department.
SELECT E.[FirstName],E.[LastName],D.[DepartmentName],E.[Salary]
FROM [SKYBARREL].[Employees] AS E
JOIN [SKYBARREL].[Departments] AS D
ON E.[DepartmentID] = D.[DepartmentID]
WHERE [Salary] =
( SELECT MAX([Salary])
     FROM [SKYBARREL].[Employees],[SKYBARREL].[Departments]
     WHERE   [SKYBARREL].[Employees].[DepartmentID] = ([SKYBARREL].[Departments].[DepartmentID])
);

--  Task 4: Data Integrity
--  1.	Foreign Key Constraint
--Ensure that the DepartmentID in the Employees and Investments tables is a foreign key 
--referencing the DepartmentID in the Departments table. This ensures that no employee can be 
--assigned to a department that doesn’t exist, and no investment can be assigned to a non-existent department.
---APPLY FOREIGN KEK TO DepartmentID
ALTER TABLE [SKYBARREL].[Investments]
ADD CONSTRAINT FK_Investment_DepartmentID FOREIGN KEY ([DepartmentID]) REFERENCES [SKYBARREL].[Departments]([DepartmentID]);
---APPLY FOREIGN KEY TO DepartmentID on SKYBARREL.Employees
ALTER TABLE [SKYBARREL].[Employees]
ADD CONSTRAINT FK_Employees_DepartmentID FOREIGN KEY ([DepartmentID]) REFERENCES [SKYBARREL].[Departments]([DepartmentID]);

--2.	Transactional Integrity
--Use transactions to ensure that if any errors occur during the update of employee salaries (Task 3.1),
--no changes are made to the database. If any part of the update process fails, the transaction should be rolled back,
--ensuring that no partial updates occur.








	






 
