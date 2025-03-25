USE [SkyBarrelBank_UAT];


SELECT * FROM [dbo].[LoanSetupInformation];

SELECT * FROM [dbo].[Borrower];


---1A The Director of Credit Analytics wants a report of ALL borrower who HAVE taken a loan with the bank. 
--- (We are only interested in borrowers who have a loan in the LoanSetup table). 

SELECT  B.[BorrowerID],
		CONCAT_WS(' ',B.[BorrowerFirstName],B.[BorrowerMiddleInitial],B.[BorrowerLastName]) AS FULL_NAME,
		CONCAT('*****',LEFT(B.[TaxPayerID_SSN],4)) AS SSN,
		YEAR(L.[PurchaseDate]) AS PURCHASE_YEAR,
		FORMAT(L.[PurchaseAmount]/1000, 'C0')+'K' AS PURCHASE_AMOUNT
FROM [dbo].[Borrower] AS B
INNER JOIN [dbo].[LoanSetupInformation] AS L  -- RETURNING ALL MATCHING RECORDS FROM BOTH TABLES AS THE LIST OF BORROWERS THAT HAVE LOANS IN THE LOAN SETUP TABLE. 
ON B.[BorrowerID] = L.[BorrowerID];


--1B. Generate a similar list to the one above, this time, show all customers, EVEN THOSE WITHOUT LOANS. Return it with similar columns as above. 
SELECT  B.[BorrowerID],
		CONCAT_WS(' ',B.[BorrowerFirstName],B.[BorrowerMiddleInitial],B.[BorrowerLastName]) AS FULL_NAME,
		CONCAT('*****',LEFT(B.[TaxPayerID_SSN],4)) AS SSN,
		YEAR(L.[PurchaseDate]) AS PURCHASE_YEAR,
		FORMAT(L.[PurchaseAmount]/1000, 'C0')+'K' AS PURCHASE_AMOUNT
FROM [dbo].[Borrower] AS B
LEFT JOIN [dbo].[LoanSetupInformation] AS L --  RETURNING ALL RECORDS FROM THE BORROWER TABLE AND ALL MATCHING RECORDS FROM THE LOANSETUPINFORMATION TABLE AS A LIST OF ALL CUSTOMERS WITH AND WITHOUT LOANS. 
ON B.[BorrowerID] = L.[BorrowerID];








/* REPORT 2 - Aggregate the borrowers by country and show, per country,  Note ltv = loan to value   
a)The total purchase amount,    
b)	Average purchase amount,     
c)	Count of borrowers,     
d)	Average ltv,     
e)	Minimum ltv,    
f)	Maximum ltv    
g)	Average age of the borrowers    
-	Order the report by the Total Purchase Amount in descending order    
-	HINT > SELECT FORMAT(10000.004, 'c0') */   

SELECT	[Citizenship],
		[TOTAL PURCHASE AMOUNT] = FORMAT(SUM([PurchaseAmount]),'C0'),
		[AVERAGE PURCHASE AMOUNT] = FORMAT(AVG([PurchaseAmount]),'C0'),
		[COUNT OF BORROWERS] = COUNT(B.[BorrowerID]),
		[AVERAGE LTV] = CONCAT(ROUND(AVG([LTV])*100,2), '%'),
		[MINIMUM LTV] = CONCAT(MIN([LTV])*100,'%'),
		[MAXIMUM LTV] = CONCAT(MAX([LTV])*100, '%'),
		--[AGE] = AVG(YEAR(GETDATE())-YEAR([DoB])),
		[AVERAGE AGE] = AVG(DATEDIFF(YY,[DoB],GETDATE())) 
FROM [dbo].[LoanSetupInformation] AS LS 
LEFT JOIN [dbo].[Borrower] AS B
ON LS.[BorrowerID] = B.[BorrowerID]
GROUP BY [Citizenship]
ORDER BY [TOTAL PURCHASE AMOUNT] DESC;








/* 2B --Aggregate the borrowers by gender ( If the gender is missing or is blank, please replace it with X) and show, per country, 
h)  The total purchase amount,    
i)	Average purchase amount,     
j)	Count of borrowers,     
k)	Average ltv,     
l)	Minimum ltv,    
m)	Maximum ltv    
n)	Average age of the borrowers    
-	Order the report by the Total Purchase Amount in descending order    
-	HINT > SELECT FORMAT(10000.004, 'c0')*/

-- GROUP BY, COALESCE

SELECT	COALESCE(NULLIF([Gender],' '), 'X') AS GENDER, 
		[TOTAL PURCHASE AMOUNT] = FORMAT(SUM([PurchaseAmount]),'C0'),
		[AVERAGE PURCHASE AMOUNT] = FORMAT(AVG([PurchaseAmount]),'C0'),
		[COUNT OF BORROWERS] = COUNT(B.[BorrowerID]),
		[AVERAGE LTV] = CONCAT(ROUND(AVG([LTV])*100,2), '%'),
		[MINIMUM LTV] = CONCAT(MIN([LTV])*100,'%'),
		[MAXIMUM LTV] = CONCAT(MAX([LTV])*100, '%'),
		--[AGE] = AVG(YEAR(GETDATE())-YEAR([DoB])),
		[AVERAGE AGE] = AVG(DATEDIFF(YEAR,[DoB],GETDATE())) 
FROM [dbo].[LoanSetupInformation] AS LS 
LEFT JOIN [dbo].[Borrower] AS B
ON LS.[BorrowerID] = B.[BorrowerID]
GROUP BY COALESCE(NULLIF([Gender],' '), 'X')
ORDER BY [TOTAL PURCHASE AMOUNT] DESC;



--SELECT NULLIF([Gender],'') FROM [dbo].[Borrower]






/*2C Aggregate the borrowers by gender (Only for F and M gender) and show, per country,  
o)   The total purchase amount,    
p)	Average purchase amount,     
q)	Count of borrowers,     
r)	Average ltv,     
s)	Minimum ltv,    
t)	Maximum ltv 
u)	Average age of the borrowers    
-	Order the report by the Year in Descending order and Gender */   

SELECT	TOP (5) YEAR([PurchaseDate]) AS 'YEAR OF PURCHASE',
		[Gender],
		[TOTAL PURCHASE AMOUNT] = FORMAT(SUM([PurchaseAmount]),'C0'),
		[AVERAGE PURCHASE AMOUNT] = FORMAT(AVG([PurchaseAmount]),'C0'),
		[COUNT OF BORROWERS] = COUNT(B.[BorrowerID]),
		[AVERAGE LTV] = CONCAT(ROUND(AVG([LTV])*100,2), '%'),
		[MINIMUM LTV] = CONCAT(MIN([LTV])*100,'%'),
		[MAXIMUM LTV] = CONCAT(MAX([LTV])*100, '%'),
		--[AGE] = AVG(YEAR(GETDATE())-YEAR([DoB])),
		[AVERAGE AGE] = AVG(DATEDIFF(YY,[DoB],GETDATE())) 
FROM [dbo].[LoanSetupInformation] AS LS 
LEFT JOIN [dbo].[Borrower] AS B
ON LS.[BorrowerID] = B.[BorrowerID]
WHERE GENDER = 'F' OR GENDER = 'M' ----- FILTERING THE DATASET TO GET ONLY MAKE AND FEMALE GENDER
GROUP BY [Gender],YEAR([PurchaseDate])
ORDER BY 'YEAR OF PURCHASE' DESC ---- ORDERING THE RESULT IN ASCEDING ORDER 














/*3A Calculate the years to maturity for each loan( Only loans that have a maturity date in the future)
and then categorize them in bins of years 
(0-5, 6-10, 11-15, 16-20, 21-25, 26-30, >30).    
Show the number of loans in each bins and the total purchase amount for each bin in billions */

WITH CTE AS (
SELECT 
		CASE
				WHEN DATEDIFF(YY,GETDATE(),[MaturityDate]) BETWEEN 0 AND 5 THEN '0-5'
				WHEN DATEDIFF(YY,GETDATE(),[MaturityDate]) BETWEEN 6 AND 10 THEN '06-10'
				WHEN DATEDIFF(YY,GETDATE(),[MaturityDate]) BETWEEN 11 AND 15 THEN '11-15'
				WHEN DATEDIFF(YY,GETDATE(),[MaturityDate]) BETWEEN 16 AND 20 THEN '16-20'
				WHEN DATEDIFF(YY,GETDATE(),[MaturityDate]) BETWEEN 21 AND 25 THEN '21-25'
				WHEN DATEDIFF(YY,GETDATE(),[MaturityDate]) BETWEEN 26 AND 30 THEN '26-30'
				WHEN DATEDIFF(YY,GETDATE(),[MaturityDate]) >30 THEN '>30'
				ELSE '0'
		END AS YEARS_LEFT_TO_MATURITY,
		[NO OF LOANS] = COUNT([BorrowerID]),
		[TOTAL PURCHASE AMOUNT] = FORMAT(SUM([PurchaseAmount]),'$0,,,.000B')
FROM [dbo].[LoanSetupInformation]
GROUP BY CASE 
				WHEN DATEDIFF(YY,GETDATE(),[MaturityDate]) BETWEEN 0 AND 5 THEN '0-5'
				WHEN DATEDIFF(YY,GETDATE(),[MaturityDate]) BETWEEN 6 AND 10 THEN '06-10'
				WHEN DATEDIFF(YY,GETDATE(),[MaturityDate]) BETWEEN 11 AND 15 THEN '11-15'
				WHEN DATEDIFF(YY,GETDATE(),[MaturityDate]) BETWEEN 16 AND 20 THEN '16-20'
				WHEN DATEDIFF(YY,GETDATE(),[MaturityDate]) BETWEEN 21 AND 25 THEN '21-25'
				WHEN DATEDIFF(YY,GETDATE(),[MaturityDate]) BETWEEN 26 AND 30 THEN '26-30'
				WHEN DATEDIFF(YY,GETDATE(),[MaturityDate]) > 30 THEN '>30'
				ELSE '0'
		END)
	SELECT * FROM CTE WHERE NOT YEARS_LEFT_TO_MATURITY = '0'
	ORDER BY YEARS_LEFT_TO_MATURITY;

	



/*WITH CTE AS 
(SELECT	[LoanNumber],
		DATEDIFF(YEAR, GETDATE(),[MaturityDate]) AS LEFTYEARS,
		[PurchaseAmount]
	FROM [dbo].[LoanSetupInformation] LS
WHERE DATEDIFF(YEAR, GETDATE(),[MaturityDate]) > 0)
SELECT 
		CASE 
			WHEN LEFTYEARS BETWEEN 0 AND 5 THEN '0-5'
			WHEN LEFTYEARS BETWEEN 6 AND 10 THEN '06-10'
			WHEN LEFTYEARS BETWEEN 11 AND 15 THEN '11-15'
			WHEN LEFTYEARS BETWEEN 16 AND 20 THEN '16-20'
			WHEN LEFTYEARS BETWEEN 21 AND 25 THEN '21-25'
			WHEN LEFTYEARS BETWEEN 25 AND 30 THEN '25-30'
			ELSE '>30'
		END AS 'YEARS LEFT TO MATURITY',
		COUNT([LoanNumber]) AS 'COUNT OF LOANS', 
		FORMAT(SUM([PurchaseAmount]),'$0,,,.000B') AS 'TOTAL PURCHASE AMOUNT'
	FROM CTE 
	GROUP BY  CASE 
			WHEN LEFTYEARS BETWEEN 0 AND 5 THEN '0-5'
			WHEN LEFTYEARS BETWEEN 6 AND 10 THEN '06-10'
			WHEN LEFTYEARS BETWEEN 11 AND 15 THEN '11-15'
			WHEN LEFTYEARS BETWEEN 16 AND 20 THEN '16-20'
			WHEN LEFTYEARS BETWEEN 21 AND 25 THEN '21-25'
			WHEN LEFTYEARS BETWEEN 25 AND 30 THEN '25-30'
			ELSE '>30'
		END
	ORDER BY 'YEARS LEFT TO MATURITY'; */



--SELECT FORMAT(10000457.004, '$0,,,.000B')  



--4A Aggregate the Number Loans by Year of Purchase and the Payment frequency description column found in the LU_Payment_Frequency table.    
SELECT * FROM [dbo].[LU_PaymentFrequency]

SELECT YEAR([PurchaseDate]) AS YEAR_OF_PURCHASE,
		[PaymentFrequency_Description],
		[NO OF LOANS] = COUNT([LoanNumber])
	FROM [dbo].[LU_PaymentFrequency] AS A 
	LEFT JOIN [dbo].[LoanSetupInformation] AS B 
	ON A.[PaymentFrequency] = B.[PaymentFrequency]
	GROUP BY YEAR([PurchaseDate]),[PaymentFrequency_Description]
	ORDER BY YEAR_OF_PURCHASE DESC;



---RESEARCH ABOUT THIS -------------------------------
SELECT  
    [Gender] = ISNULL(NULLIF([Gender], ''), 'X'),
    [TOTAL PURCHASE AMOUNT] = FORMAT(SUM([PurchaseAmount]), 'C0'),
    [AVERAGE PURCHASE AMOUNT] = FORMAT(AVG([PurchaseAmount]), 'C0'),
    [COUNT OF BORROWERS] = COUNT(B.[BorrowerID]),
    [AVERAGE LTV] = CONCAT(ROUND(AVG([LTV]) * 100, 2), '%'),
    [MINIMUM LTV] = CONCAT(MIN([LTV]) * 100, '%'),
    [MAXIMUM LTV] = CONCAT(MAX([LTV]) * 100, '%'),
    [AVERAGE AGE] = AVG(DATEDIFF(YEAR, [DoB], GETDATE()))
FROM [dbo].[LoanSetupInformation] AS LS 
LEFT JOIN [dbo].[Borrower] AS B
ON LS.[BorrowerID] = B.[BorrowerID]
GROUP BY ISNULL(NULLIF([Gender], ''), 'X')
ORDER BY SUM([PurchaseAmount]) DESC;

----------------------------------------------------------------------------

SELECT * FROM [dbo].[LoanSetupInformation]





SELECT * FROM [dbo].[LoanSetupInformation] LS
RIGHT JOIN [dbo].[Borrower] B
ON B.[BorrowerID] = LS.[BorrowerID]



SELECT * FROM [dbo].[Borrower]

SELECT YEAR(GETDATE())



SELECT NULLIF('GENDER', ' ')

SELECT COALESCE(NULLIF([Gender], ' '),'X') FROM [dbo].[Borrower]





















----------------------------------------------------------------------

WITH CTE AS (

SELECT [BorrowerID], COUNT([BorrowerID]) AS CNT
FROM [dbo].[LoanSetupInformation_FULL]
GROUP BY [BorrowerID]
HAVING COUNT([BorrowerID]) > 1)

SELECT SUM(CNT) FROM CTE;



 