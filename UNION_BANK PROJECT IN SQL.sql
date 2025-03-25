

use UNION_BANK

----------------------------------CREATING DATABASE UNION_BANK------------------------------------------------------------------

CREATE DATABASE UNION_BANK;

----------------------------------CREATING SCHEMAS-----------------------------------------------

----------------------------------CREATING BORROWER SCHEMA--------------------------

Create Schema Borrower;

---------------------------------CREATING LOAN SCHEMA-----------------------------------------

Create Schema Loan;

-----------------------------------CREATING BORROWER TABLE-----------------------

Create table Borrower.Borrower
(
BorrowerID int not null,
BorrowerFirstName varchar (225) not null,
BorrowerMiddleIntial char (1) not null,
DoB datetime not null,
Gender char (1) null,
TaxPayerID_SSN varchar (9) not null,
PhoneNumber varchar (10) not null,
Email varchar (225) not null,
Citizenship varchar (225) null,
BeneficiaryName varchar (225) null,
IsUScitizen bit null,
Createdate datetime not null,
);
--- Testing the Code
Select * from [Borrower].[Borrower];
---------------------------------------APPLYING BUSINESS RULES TO THE BORROWERS TABLE -----------------
-------The BorrowerID Should be the UNIQUE IDENTIFIER (Primary Key) of a Record on this table (Borrower.Borrower)

ALTER TABLE [Borrower].[Borrower]
ADD CONSTRAINT PK_Borrower_BorrowerID PRIMARY KEY (BorrowerID);
------All Borrowers should be at least 18 years old, as at the date of opening the account

ALTER TABLE [Borrower].[Borrower]
ADD CONSTRAINT CHECK_DOB CHECK ([DoB] <=DATEADD(YEAR,-18,GETDATE()));

--------------------The email should have a contain '@' symbol in the insert value

ALTER TABLE [Borrower].[Borrower]
ADD CONSTRAINT CHK_Borrower_Email CHECK ([Email] LIKE '%@%');

------The number of digit entred in to the PhoneNumber Column MUST be 10 LESS and not MORE

ALTER TABLE [Borrower].[Borrower]
ADD CONSTRAINT CHECK_Borrower_PhoneNumber CHECK( LEN([PhoneNumber]) = 10 AND [PhoneNumber] NOT LIKE '%[^0-9]%');

------The number of digit entered in the TaxPayerID_SSN column must be 9

ALTER TABLE [Borrower].[Borrower]
ADD CONSTRAINT CHECK_SSN_Borrower CHECK (LEN ([TaxPayerID_SSN]) = 9 AND [TaxPayerID_SSN] NOT LIKE '%[^0-9]%');

------ If no value is inserted, then the Create date should default to the current time time when the insertion is done

ALTER TABLE [Borrower].[Borrower]
ADD CONSTRAINT DF_Borrower_Createdate DEFAULT GETDATE() FOR [Createdate];

---Create BorrowerAddress table
Create table Borrower.BorrowerAddress
(
AddressID int not null,
BorrowerID int not null,
StreetAddress varchar (225) not null,
zip varchar (5) not null,
CreatDate datetime not null
);
--- Testing the Code
Select * from [Borrower].[BorrowerAddress];
---------------APPLYING BUSINESS RULE TO THE BORROWERADDRESS TABLE --------------

---BorrowerID and AddressID should be the UNIQUE IDENTIFIER (Primary Key) on the Records of the table (Borrower.BorrowerAddress)

ALTER TABLE [Borrower].[BorrowerAddress]
ADD CONSTRAINT PK_BorrowerID_AddressID PRIMARY KEY (BorrowerID, AddressID);

---Create a FOREIGN KEY  in Borrower.Address Table REFERENCING  the Borrower.BorrowerID Table
ALTER TABLE [Borrower].[BorrowerAddress]
ADD CONSTRAINT FK_BorrwerAddress_BorrowerID FOREIGN KEY ([BorrowerID]) REFERENCES [Borrower].[Borrower] ([BorrowerID]);

--If no value is inserted, then the Create date should default to the current time when the insertion is done    

ALTER TABLE [Borrower].[BorrowerAddress]
ADD CONSTRAINT DF_BorrowerAddress_Createdate DEFAULT GETDATE() FOR [CreatDate];

--This column should contain the same values as those in the ZIP of the US_Zip_Codes table. 

ALTER TABLE [Borrower].[BorrowerAddress]
ADD CONSTRAINT FK_BorrowerAddress_Zip FOREIGN KEY ([ZIP]) REFERENCES [dbo].[US_ZipCodes]([ZIP]);

---Creating a Calendar table

Create table Calendar
(
CalenderDate datetime null
);
--- Testing the Code
Select * [dbo].[Calendar];
-----APPLYING BUSINESS RUE TO THE CALENDER TABLE
ALTER TABLE [CalendarDate]
---Creating State table

Create table [State]
(
StateID char (2) not null,
StateName varchar(225) not null,
CreateDate datetime not null
);
--- Testing th Code
Select * from [dbo].[State];
--------------------------------APPLYING BUSSINESS TO THE STATE TABLE--------------------
---------------------Create PRIMARY KEY  TO THE TABLE SO WE CAN CREATE FOREIGN KEY LATER -----------------

ALTER TABLE [dbo].[State]
ADD CONSTRAINT PK_STATE PRIMARY KEY ([StateID]);
-------All Borrowers should be at least 18 years old, as at the date of opening the account

ALTER TABLE [Borrower].[Borrower]
ADD CONSTRAINT CHECK_DOB CHECK ([DoB] <=DATEADD(YEAR,-18,GETDATE()));


-----------------------This column can only take unique values, no duplicates.------------------

ALTER TABLE [dbo].[State]
ADD CONSTRAINT	Unique_State_stateName Unique (StateName);

--If no value is inserted, then the Create date should default to the current time when the insertion is done    
ALTER TABLE [dbo].[State]
ADD CONSTRAINT DF_State_CreateDate DEFAULT GETDATE() FOR [CreateDate];

---------------------------------------------Create US_ZipCodes table------------------

Create table US_ZipCodes
(
IsSurrogateKey int not null,
Zip varchar (5) not null,
Latitude float null,
Longitude float null,
City varchar (255) null,
State_id char (2) null,
[Population] int null,
Density decimal null,
Count_fips varchar (10) null,
County_name varchar (255) null,
County_names_all varchar (255) null,
County_fips_all varchar (50) null,
Timezone varchar (255),
CreateDate datetime not null
);
------Testing the code
Select * from [dbo].[US_ZipCodes];

---------------APPLYING BUSINESS RULE TO THE US_ZIPCODES  table.-----------------

-----Create PRIMARY KEY as the UNIQUE IDENTIFIER OF A RECORD on this table.

ALTER TABLE [dbo].[US_ZipCodes]
ADD CONSTRAINT PK_US_ZipCodes PRIMARY KEY ([Zip]);

----If no value is inserted, then the Create date should default to the current time when the insertion is done  

ALTER TABLE [dbo].[US_ZipCodes]
ADD CONSTRAINT DF_US_ZipCodes_Createdate DEFAULT GETDATE() FOR [CreateDate];

------Is a foreign key referencing the column   UnderwriterID in the  UnderwriterID Table      
  
ALTER TABLE [dbo].[US_ZipCodes]
ADD CONSTRAINT FK_ZIP_STATEID FOREIGN KEY ([state_id]) REFERENCES [dbo].[State]([StateID]);

ALTER TABLE [dbo].[US_ZipCodes]
ADD CONSTRAINT FK_ZIP_STATEID FOREIGN KEY ([state_id]) REFERENCES [Loan].[Underwriter]([UnderwriterID]);

-------------------create and alpply primary key to IsSurrogateKey
ALTER TABLE [dbo].[US_ZipCodes]
ADD CONSTRAINT UQ_Codes_IsSurrogateKey UNIQUE ([IsSurrogateKey]);

------------------------------Create Loanssetupinformation table ------------------------

CREATE TABLE Loan.LoanSetupInformation
(
IsSurrogateKey int not null,
LoanNumber varchar (10) not null,
PurchaseAmount numeric (18,2) not null,
PurchaseDate datetime not null,
LoanTerm int not null,
BorrowerID int not null,
UnderWriterID int not null,
ProductID char (2) not null,
InterestRate decimal not null,
PaymentFrequency int not null,
ApprisalValue numeric (18,2) not null,
CreateDate datetime not null,
LTV decimal (4,2) not null,
FirstInterestPaymentDate datetime null,
MaturityDate datetime not null
);
--- Tesing the Code
Select * from [Loan].[LoanSetupInformation];
-----------------APPLYING BUSINESS RULES TO THE LOAN.LOANSETUPINFORMATION TABLE--------------------
----LoanNumber Should be the UNIQUE IDENTIFIER OF A RECORD on this table (Loan.Loansetupinformation)
ALTER TABLE [Loan].[LoanSetupInformation]
ADD CONSTRAINT PK_LoanSetupInformation_LoanNumber PRIMARY KEY (LoanNumber);

----Setting the BorrowerID as the Primary Key  and also as Foreign Key with reference to another table 

ALTER TABLE [Loan].[LoanSetupInformation]
ADD CONSTRAINT FK_LoanSetup_BorrowerID FOREIGN KEY (BorrowerID) REFERENCES [Borrower].[Borrower](BorrowerID);

---Is a foreign key referencing the column  PaymentFrequency in the  LU_PaymentFrequency Table

ALTER TABLE [Loan].[LoanSetupInformation]
ADD CONSTRAINT FK_LSI_PAYFREQ FOREIGN KEY ([PaymentFrequency]) REFERENCES [Loan].[Lu_Delinquency]([PsymentFrequency]);
    
---LoanNumber column should only take the valves 35, 30, 15, and 10
ALTER TABLE [Loan].[LoanSetupInformation]
ADD CONSTRAINT CK_LoanTeam CHECK ([LoanTerm] IN (35,30,15,10));
---InterestRate value on this column should be ONLY between 0.01 and 0.30
ALTER TABLE [Loan].[LoanSetupInformation]
ADD CONSTRAINT CK_INTERESTRATE CHECK ([InterestRate] BETWEEN 0.01 AND 0.30);
---If no vlaue is inserted, then Create date should default to the current time when the insertion was done
ALTER TABLE [Loan].[LoanSetupInformation]
ADD CONSTRAINT DF_LSI_CREATEDATE DEFAULT GETDATE() FOR [CreateDate];

-- PaymentFrequency is a foreign key referencing the column PaymentFrequency in the LU_PaymentFrequency Table  
ALTER TABLE [Loan].[Loansetupinformation]
ADD CONSTRAINT FK_PAYFREQ FOREIGN KEY ([PaymentFrequency]) REFERENCES [Loan].[LU_PaymentFrequency]([PaymentFrequency]);

--------CREATE A UNIQUE IDENTIFIER ON ISSURROGATEKEY-----
ALTER TABLE [Loan].[Loanperiodic]
ADD CONSTRAINT UQ_Loanperidic_IsSurrogateKey UNIQUE ([IsSurrogateKey]);
-------------------------------------Create Loanperiodic table --------------------------------

Create table Loan.Loanperiodic
(
Issurrogatekey int not null,
Loannumber varchar (10) not null,
Cycldate datetime not null,
Extramonthlypayment numeric (18,2) not null,
Unpaidprincipalbalance numeric (18,2) not null,
Beginningschedulebalance numeric (18,2) not null,
Paidinstallment numeric (18,2) not null,
Interestportion numeric (18,2) not null,
Principalportion numeric (18,2) not null,
Endschedulebalance numeric (18,2) not null,
Actualschedulebalance numeric (18,2) not null,
Totalinterestaccurued numeric (18,2) not null,
Totalprincipalaccrued numeric (18,2) not null,
DEFAULTPENTALTY NUMERIC (18,2) NOT NULL,
Delinquencycode numeric (10,0) not null,
Createdate datetime not null
);
---- Testing the Code
Select * from [Loan].[Loanperiodic];
--------------------------------APPLYING BUSINESS RULES TO THE LOANPERODIC TABLE -------------------
ALTER TABLE [Loan].[Loanperiodic]
ADD CONSTRAINT PK_Loanperiodic_Loannumber PRIMARY KEY ([Loannumber]);
-----APPLYING BUSINESS RULES TO THE  ISSURROGATEKET COLUMN
ALTER TABLE [Loan].[Loanperiodic]
ADD CONSTRAINT UK_LOANPERIODIC_Issurrogatekey UNIQUE (Issurrogatekey);

---If no value is inserted, then the default value should be zero    
Alter Table [LOAN].[LOANPERIODIC]
Add Constraint DF_LoanPeriodic_EMP DEFAULT ('0') FOR ExtraMonthlyPayment;
 
 ----APPLYING FOREIGN KEY REFREENCING LOANSETUPINFORMATION TABLE -----
ALTER TABLE [LOAN].[LOANPERIODIC]
ADD CONSTRAINT FK_LOANPERIODIC_LOANNUMBER FOREIGN KEY ([LOANNUMBER]) REFERENCES [LOAN].[LOANSETUPINFORMATION] ([LOANNUMBER]);
 
-------------------------------------- Create Lu_Delinquency table

Create table Loan.Lu_Delinquency
(
DelinquencyCode int not null,
Delinquency varchar (255) not null,
PaymentFrequency int not null,
PaymentIsMadeEvery int not null,
PaymaentFrequency_Description varchar (255) not null
);
----- Testing the Code
Select * from [Loan].[Lu_Delinquency];
----------------------APPLYING BUSINESS RULES TO LOAN.LU_DELINQUENCY TABLE
---Should be the UNIQUE IDENTIFIER OF A RECORD on this table

ALTER TABLE [Loan].[Lu_Delinquency]
ADD CONSTRAINT UK_LU_Delinquency_DelinquencyCodE UNIQUE ([DelinquencyCode]);

---Create Underwriter table

Create table Underwriter
(
UnderwriterID int not null,
UnderwriterFirstName varchar (255) null,
UnderwriterMiddleInitial char (1) null,
UnderwriterLastName Varchar (255) not null,
PhoneNumber Varchar (14) null,
Email varchar (255) not null,
CreateDate datetime not null,
);
----Testin the Code
Select * from [dbo].[Underwriter];
-------APPLYING BUSINESS RULES TO THE UNDERWRITER TABLE 
ALTER TABLE [dbo].[Underwriter]
ADD CONSTRAINT PK_UNDERWRITER_UnderWriterID PRIMARY KEY ([UnderwriterID]);
-----APPLYING RULES ON THE PHONENUMBER
ALTER TABLE [dbo].[Underwriter]
ADD CONSTRAINT CK_UnderWriter_PhoneNumber CHECK (LEN ([PhoneNumber]) = 10);
-----APPLYING RULES ON THE EMAIL COLUMN OF THE TABLE
ALTER TABLE [dbo].[Underwriter]
ADD CONSTRAINT CHK_UnderWriter_Email check (Email like '%@%');
-----  APPLYING RULES TO THE CREATEDATE
ALTER TABLE [dbo].[Underwriter]
ADD CONSTRAINT DF_UnderWriter_Createdate DEFAULT GETDATE() FOR [CreateDate];


