Create Database LoanApplicationDB

Begin
if exists (select * from sys.objects where object_id=OBJECT_ID('Borrower_Personal_Info'))
drop table Borrower_Personal_Info
End
Begin
if exists (select * from sys.objects where object_id=OBJECT_ID('Employee_Details'))
drop table Employee_Details
End
Begin
if exists (select * from sys.objects where object_id=OBJECT_ID('LoanOfficerInfo'))
drop table LoanOfficerInfo
End
Begin
if exists (select * from sys.objects where object_id=OBJECT_ID('MonthlyIncomeExpense'))
drop table MonthlyIncomeExpense
End
Begin
if exists (select * from sys.objects where object_id=OBJECT_ID('LoanApplicationDetail'))
drop table LoanApplicationDetail
End
Begin
if exists (select * from sys.objects where object_id=OBJECT_ID('Auto_Loan'))
drop table Auto_Loan
End
Begin
if exists (select * from sys.objects where object_id=OBJECT_ID('PersonalLoan'))
drop table PersonalLoan
End
Begin
if exists (select * from sys.objects where object_id=OBJECT_ID('MortgageLoan'))
drop table MortgageLoan
End
Begin
if exists (select * from sys.objects where object_id=OBJECT_ID('Bank'))
drop table Bank
End
Begin
if exists (select * from sys.objects where object_id=OBJECT_ID('Branch'))
drop table Branch
End
Begin
if exists (select * from sys.objects where object_id=OBJECT_ID('LoanContract'))
drop table LoanContract
End
Begin
if exists (select * from sys.objects where object_id=OBJECT_ID('LoanPayment'))
drop table LoanPayment
End
Go

CREATE TABLE EmploymentStatus
(
	Emp_status_Id TINYINT PRIMARY KEY,
	[Status] VARCHAR(20)
)

CREATE TABLE  Borrower_Personal_Info
(
	Borrower_ID INT PRIMARY KEY,
	SSN VARCHAR(11) NOT NULL,
	FirstName VARCHAR(25) NOT NULL,
	LastName VARCHAR(25) NOT NULL,
	DateOfBirth DATE,
	Gender VARCHAR(10) NOT NULL,
	Maritial_Status VARCHAR(15) NOT NULL,
	No_Dependent INT NOT NULL,
	Email VARCHAR(20) NOT NULL,
	Phone VARCHAR(12) NOT NULL,
	[Address] VARCHAR(20) NOT NULL,
	City VARCHAR(20) NOT NULL,
	[State] VARCHAR(20) NOT NULL,
	Zip VARCHAR(15) NOT NULL,
	Emp_status_Id TINYINT FOREIGN KEY REFERENCES EmploymentStatus(Emp_status_Id) NOT NULL,
	YearsAtthisAddress TINYINT NOT NULL,
	Credit_score SMALLINT,
	Is_Cosigner VARCHAR(5)
)

CREATE TABLE Employee_Details
(
	EmpID INT PRIMARY KEY NOT NULL,
	Employer_Name VARCHAR(30) NOT NULL,
	Current_St_Address VARCHAR(20) NOT NULL,
	City VARCHAR(20) NOT NULL,
	[State] VARCHAR(20) NOT NULL,
	Zip VARCHAR(15) NOT NULL,
	Position VARCHAR(50) NOT NULL,
	BusinessPhone VARCHAR(12) NOT NULL,
	YrsOnThisJob INT NOT NULL,
	Borrower_ID	INT FOREIGN KEY REFERENCES Borrower_Personal_Info(Borrower_ID) NOT NULL
)
CREATE TABLE LoanType
(
	Loan_Type_ID TINYINT PRIMARY KEY,
	Loan_Name VARCHAR(15)
)

CREATE TABLE LoanOfficerInfo
(
	LoanOfficerID Int Primary KEY NOT NULL,
	FirstName VARCHAR(20) NOT NULL,
	LastName VARCHAR(20) NOT NULL,
	Email VARCHAR(25) NOT NULL,
	Phone_No VARCHAR(12) NOT NULL,
	HireDate DATE NOT NULL,
	Position VARCHAR(20) NOT NULL
)

CREATE TABLE MonthlyIncomeExpense
(
	Income_Expense_ID INT PRIMARY KEY NOT NULL,
	Income Money NOT NULL,
	MortgageRent Money NOT NULL,
	Other_Loan_Expense Money NOT NULL, 
	Borrower_ID INT FOREIGN KEY REFERENCES Borrower_Personal_Info(Borrower_ID) NOT NULL
)
CREATE TABLE ApplicationStatus
(
	Application_Status_ID TINYINT PRIMARY KEY,
	[Status] VARCHAR(20)
)

CREATE TABLE LoanApplicationDetail
(
	Application_ID INT PRIMARY KEY NOT NULL,
	LoanOfficerID INT FOREIGN KEY REFERENCES LoanOfficerInfo(LoanOfficerID) NOT NULL,
	Loan_Type_ID TINYINT FOREIGN KEY REFERENCES LoanType(Loan_Type_ID),
	Purchase_Pice Money NOT NULL,
	DownPaymentAmount Money NOT NULL,
	LoanAmount Money NOT NULL,
	Application_Status_ID Tinyint FOREIGN KEY REFERENCES ApplicationStatus(Application_Status_ID),
	ApplicationDate Date,
	Borrower_ID INT FOREIGN KEY REFERENCES Borrower_Personal_Info(Borrower_ID) NOT NULL
	
)

CREATE TABLE Auto_Loan
(
	AutoApplicationID int PRIMARY KEY NOT NULL,
	Vehicle_Type VARCHAR(20) NULL,
	Make VARCHAR(20) NOT NULL,
	Model VARCHAR(20) NOT NULL,
	ModelYear VARCHAR(5),
	Milage INT NOT NULL,
	Application_ID INT FOREIGN KEY REFERENCES LoanApplicationDetail(Application_ID) NOT NULL,
)

CREATE TABLE PersonalLoan
(
	PersonalApplicationID INT PRIMARY KEY NOT NULL,
	Loan_Type_ID TINYINT FOREIGN KEY REFERENCES LoanType(Loan_Type_ID) NOT NULL,
	ReasonForLoan VARCHAR(100) NOT NULL,
	Application_ID INT FOREIGN KEY REFERENCES LoanApplicationDetail(Application_ID) NOT NULL 
)

CREATE TABLE MortgageLoan
(
	MortgageApplicationID INT PRIMARY KEY NOT NULL,
	PropertyType VARCHAR(20) NOT NULL,
	PropertyAddress VARCHAR(20) NOT NULL,
	City VARCHAR(20) NOT NULL,
	PropertyZip VARCHAR(11) NOT NULL ,
	PropertyStatusID TINYINT NOT NULL,
	Application_ID int FOREIGN KEY REFERENCES LoanApplicationDetail(Application_ID) NOT NULL
)
CREATE TABLE Bank
(
	BankId INT PRIMARY KEY NOT NULL,
	[Name] VARCHAR(20) NOT NULL,
	Discription VARCHAR(20) NOT NULL,
	[Address] VARCHAR(20) NOT NULL,
	Zip VARCHAR(20) NOT NULL,
	City VARCHAR(20) NOT NULL,
	[State] VARCHAR(20) NOT NULL
)
CREATE TABLE Branch
(
	BranchID SMALLINT PRIMARY KEY NOT NULL,
	BankId INT FOREIGN KEY REFERENCES Bank(BankId) NOT NULL,
	BranchName VARCHAR(20) NOT NULL,
	[Address] VARCHAR(20) NOT NULL,
	Zip VARCHAR(20) NOT NULL,
	City VARCHAR(20) NOT NULL,
	[State] VARCHAR(20) NOT NULL,
	Country VARCHAR(25) NOT NULL,
	LoanOfficerID INT FOREIGN KEY REFERENCES LoanOfficerInfo(LoanOfficerID) NOT NULL
)
CREATE TABLE LoanStatus
(
	LoanStatusID TINYINT PRIMARY KEY,
	[Status] VARCHAR(10)
)

CREATE TABLE LoanContract
(
	LoanID INT PRIMARY KEY NOT NULL,
	Application_ID INT FOREIGN KEY REFERENCES LoanApplicationDetail(Application_ID) NOT NULL,
	BranchID SMALLINT FOREIGN KEY REFERENCES Branch(BranchID) NOT NULL,
	LoanStatusID TINYINT FOREIGN KEY REFERENCES LoanStatus(LoanStatusID) NOT NULL,
	DateContractStarts DATE NOT NULL,
	DateContractEnd	DATE NOT NULL,
	InterstRate DECIMAL NOT NULL,
	ScheduledPaytAmount MONEY NOT NULL,
	SchechuledNumOfPayt SMALLINT NOT NULL,
	ActualNumOfPayment INT NOT NULL,
	LoanAmountLeft MONEY NOT NULL
)

CREATE TABLE LoanPayment
(
	PaymentId INT PRIMARY KEY NOT NULL,
	LoanId INT FOREIGN KEY REFERENCES LoanContract(LoanId) NOT NULL,
	LoanPaymentAmount MONEY NOT NULL,
	LoanPaymentDueDate DATE NOT NULL
)

