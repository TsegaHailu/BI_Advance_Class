CREATE DATABASE Loan_Datawarehouse
go

CREATE SCHEMA dim
go

CREATE SCHEMA fact
go

CREATE TABLE [dim].Borrower
	(
		[DimBorrowerKey] INT Identity(1,1) NOT NULL,
		[BorrowerID] INT NOT NULL,
		[SSN] VARCHAR(9) NOT NULL,
		[FirstName] VARCHAR(75) NOT NULL,
		[LastName] VARCHAR(75) NOT NULL,
		[DateOfBirth] Date NOT NULL,
		[MaritalStatus] VARCHAR(15) NOT NULL,
		[Gender] VARCHAR(15) NOT NULL,
		[NumberOfDependent] TINYINT NULL,
		[Phone] VARCHAR(12) NOT NULL,
		[Email] VARCHAR(50) NOT NULL,
		[CurrentStreetAddress] VARCHAR(50) NOT NULL,
		[City] VARCHAR(50) NOT NULL,
		[State_Name] VARCHAR(50) NOT NULL,
		[Zip] VARCHAR(10) NOT NULL,
		[YearsAtThisAddress] TINYINT NOT NULL,
		[IsCosinger] VARCHAR(5) NOT NULL,
		[PrimaryBorrowerSSN] VARCHAR(9) NULL,
		[CreditScore] SMALLINT NOT NULL,
		[EmployementStatus] VARCHAR(50) NOT NULL
	)

CREATE TABLE [dim].EmploymentDetail
	(
		[DimEmployKey] INT IDENTITY(1,1) NOT NULL,
		[EPID] INT NOT NULL,
		[CompanyName] VARCHAR(75) NULL,
		[CurrentAddress] VARCHAR(100) NULL,
		[City] VARCHAR(50) NULL,
		[State_Name] VARCHAR(50) NULL,
		[Zip] VARCHAR(10) NULL,
		[PositionTitle] VARCHAR(50) NULL,
		[CompanyPhone] VARCHAR(12) NOT NULL,
		[YrsonJob] TINYINT NULL,
		[BorrowerID] INT NOT NULL
	)

CREATE TABLE [dim].LoanOfficer
	(
		[DimLoanOfficerKey] INT IDENTITY(1,1) NOT NULL,
		[LoanOfficerID] SMALLINT NOT NULL,
		[FirstName] VARCHAR(75) NULL,
		[LastName] VARCHAR(75) NULL,
		[EMAIL] VARCHAR(75) NULL,
		[PHONENUMBER] VARCHAR(12) NULL,
		[HIREDATE] DATE NULL,
		[Position] VARCHAR(75) NULL,
		[SALARY] MONEY NULL,
		[BranchID] SMALLINT NOT NULL
	)
CREATE TABLE [dim].AutoLoanApplication
	(
		[DimAutoLoanKey] INT IDENTITY(1,1) NOT NULL,
		[AutoApplicationID] INT NOT NULL,
		[LoanType_Name] VARCHAR(50) NULL,
		[vehicle_type] VARCHAR(5) NULL,
		[Maker] VARCHAR(50) NULL,
		[Model] VARCHAR(50) NULL,
		[Year] CHAR(4) NULL,
		[Mileage] INT NULL,
		[ApplicationID] INT NOT NULL
	)

CREATE TABLE [dim].PersonalLoanApplication
	(
		[DimPersonalLoanKey] INT IDENTITY(1,1) NOT NULL,
		[PersonalApplicationID] INT NOT NULL,
		[loantype_Name] VARCHAR(50) NULL,
		[Reason_For_loan] VARCHAR(250) NULL,
		[ApplicationID] INT NOT NULL
	)

CREATE TABLE [dim].MortgageLoanApplication
	(
		[DimMortgLoanKey] INT IDENTITY(1,1) NOT NULL,
		[MortgageapplicationID] INT NOT NULL,
		[LoanType_Name] VARCHAR(50) NULL,
		[PropertyType] VARCHAR(50) NULL,
		[PropertyStreeAddress] VARCHAR(75) NULL,
		[PropertyCity] VARCHAR(50) NULL,
		[Propertyzip] VARCHAR(10) NULL,
		[State_Name] VARCHAR(50) NULL,
		[ApplicationID] INT NOT NULL
	)

CREATE TABLE [dim].Bank
	(
		[DimBankKey] INT IDENTITY(1,1) NOT NULL,
		[BankID] SMALLINT NOT NULL,
		[Name] VARCHAR(50) NOT NULL,
		[Discription] VARCHAR(250) NULL,
		[Address] VARCHAR(75) NULL,
		[Zip] VARCHAR(10) NULL,
		[City] VARCHAR(50) NULL,
		[State_Name] VARCHAR(50) NULL
	)
CREATE TABLE [dim].Branch
	(
		[DimBranchKey] INT IDENTITY(1,1) NOT NULL,
		[BranchID] SMALLINT NOT NULL,
		[BranchName] VARCHAR(75) NULL,
		[Phone] VARCHAR(12) NULL,
		[Street_Address] VARCHAR(75) NULL,
		[City] VARCHAR(50) NULL,
		[Zip] VARCHAR(10) NULL,
		[State_Name] VARCHAR(50) NULL,
		[BankID] SMALLINT NOT NULL
	)

CREATE TABLE [fact].Loan
	(
		[LoanID] INT NOT NULL,
		[DimBranchKey] INT NOT NULL,
		[DimLoanOfficerKey] INT NOT NULL,
		[DimBankKey] INT NOT NULL,
		[DimAutoLoanKey] INT NOT NULL,
		[DimPersonalLoanKey] INT NOT NULL,
		[DimMortgLoanKey] INT NOT NULL,
		[DimBorrowerKey] INT NOT NULL,
		[ApplicationID] INT NOT NULL,
		[BranchID] SMALLINT NOT NULL,
		[LoanStatusID] TINYINT NOT NULL,
		[DateContractStarts] DATE NOT NULL,
		[DateContractEnd] DATE NOT NULL,
		[InterstRate] DECIMAL(5, 2) NOT NULL,
		[ScheduledPaytAmount] MONEY NOT NULL,
		[SchechuledNumOfPayt] SMALLINT NOT NULL,
		[ActualNumOfPayment] INT NOT NULL,
		[LoanAmountLeft] MONEY NOT NULL,
		[PaymentID] INT NOT NULL,
		[LoanPaymentAmount] MONEY NOT NULL,
		[LoanPaymentDueDate] DATE NOT NULL
	)

CREATE TABLE [Fact].LoanApplicationDetail
	(
		[ApplicationID] INT NOT NULL,
		[DimAutoLoanKey] INT NOT NULL,
		[DimPersonalLoanKey] INT NOT NULL,
		[DimMortgLoanKey] INT NOT NULL,
		[DimEmployKey] INT NOT NULL,
		[DimBorrowerKey] INT NOT NULL,
		[LoanTypeID] TINYINT NULL,
		[PurchasePrice] MONEY NULL,
		[DownPaymentAmount] MONEY NULL,
		[LoanAmount] MONEY NULL,
		[ApplicationDate] DATE NULL,
		[ApplicationStatusID] TINYINT NULL,
		[LoanOfficerID] SMALLINT NULL,
				
	)

CREATE TABLE [dim].IncomeExpenseInfo
	(
		[DimIncomeExpenseKey] INT IDENTITY(1,1) NOT NULL, 
		[IncomeExpensID] INT NOT NULL,
		[MonthlyGrossIncome] MONEY NULL,
		[MonthlyMortgageRent] MONEY NULL,
		[MonthlyOther_Loan_Expense] MONEY NULL,
		[BorrowerID] INT NOT NULL,
	)