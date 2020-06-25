
--***************************--Dim Tables--***************************************

create database Loan_Datawarehouse
go 
use Loan_Datawarehouse

create schema Dim
go
create schema Fact
go
create table [Dim].[Borrower]
( [Borrower_Dimkey] int identity(1,1) not null,
  [BorrwerID] int not null,
  [SSN] varchar(9) not null,
  [FirstName] varchar(75) not null,
  [LastName] varchar(75) not null,
  [DateOfBirth] date not null,
  [MaritalStatus] varchar(10) not null,
  [Gender] varchar(5) not null,
  [NumberOfDependent] tinyint null ,
  [Phone] varchar(12) not null,
  [Email] varchar(50) not null ,
  [CurrentStreetAddress] varchar(50) not null,
  [City] varchar(50) not null,
  [State_Name] varchar(100) not null,
  [Zip] varchar(10) not null ,
  [YearsAtThisAddress] tinyint not null,
  [IsCosinger] Varchar(5) not null,
  [PrimaryBorrowerSSN] varchar(9)  null,
  [CreditScore] smallint not null,
  [EmployementStatus] varchar not null,
  [IncomeExpensID] int,
  [MonthlyGrossIncome] money ,
  [MonthlyMortgageRent] Money,
  [MonthlyOther_Loan_Expense] Money
  )
  go

  Create table [Dim].[Employment_Business]		
   ( [EMP_DimKey] int identity not null,
     [EPID] int not null,
     [CompanyName] Varchar(75),
     [CurrentAddress] varchar(100),
     [City] varchar(50),
     [StateName] varchar(100),
     [Zip] varchar(10) ,
     [PositionTitle] varchar(50),
     [CompanyPhone] varchar(12) not null ,
     [YrsonJob] tinyint ,
     [BorrowerID] int 
	 )

 Create Table [Dim].[Bank] 
 ([Bank_DimKey] int identity (1,1)not null,
  [BankID]	smallint not null,
  [Name]	varchar(50) not null,
  [Discription]	varchar(250) null,
  [Address]	varchar(75) null,
  [Zip]	Varchar(10) null ,
  [City] varchar(50) null,
  [State_Name] Varchar(100) null

)	

Create Table [Dim].[Branch]

( [Branch_DimKey ]int identity (1,1)not null,
  [BranchID] smallint not null,
  [BranchName]	Varchar(75),
  [Phone] Varchar(12) ,
  [Street_Address] Varchar(75),
  [City]	Varchar(50),
  [Zip]	Varchar(10) ,
  [State_Name] Varchar(100),
  [BankID]	smallint 
)

Create table [Dim].[LoanOfficer]
([LoanOfficer_DimKey] int identity (1,1)not null,
 [LoanOfficerID]	smallint not null,
 [FirstName]	Varchar(75),
 [LastName]	Varchar(75),
 [EMAIL]	Varchar(75) ,
 [PHONENUMBER]	Varchar(12) ,
 [HIREDATE]	date ,
 [Position]	Varchar(75),
 [SALARY]	Money , 
 [BranchID] smallint 
)
Create table [Dim].[MortgageLoanApplication]
(
  [MortgApp_DimKey] int identity (1,1) not null,
  [MortgageapplicationID] int not null,
  [Loan_Type] tinyint,
  [PropertyType] varchar(50),
  [PropertyStreeAddress] varchar(75),
  [PropertyCity] varchar(50),
  [Propertyzip] varchar(10),
  [PropertyState] varchar(100),
  [ApplicationID] int 
 
)
Create table [Dim].[AutoLoanApplication]
( [AutoApp_DimKey] int identity (1,1)not null,
  [AutoApplicationID]	int not null,
  [LoanTypeID]	tinyint null,
  [vehicle_type] char(5) null,
  [Maker] varchar(50) null,
  [Model] varchar(50) null,
  [Year] char(4) null,
  [Mileage]	int null,
  [ApplicationID] int null 

)
go
Create table [Dim].[PersonalLoanApplication]
(
 [PersonalApp_DimKey] int identity (1,1)not null,
 [PersonalApplicationID] int not null,
 [loantypeIDid] tinyint,
 [Reason_For_loan] varchar(250),
 [ApplicationID] int 

)
--***************************--Fact tables--********************************************************

Create table [Fact].[Loan_Payment]
( [LoanID] int not null,
  [Bank_DimKey] int not null,
  [Branch_DimKey] int not null,
  [ApplicationID] int not null,  
  [LoanStatusID] int not null,
  [DateContractStarts] date not null,
  [DateContractEnd] date not null,
  [InterstRate] Decimal(5,2)not null,
  [ScheduledPaytAmount] money not null,
  [SchechuledNumOfPayt] smallint not null,
  [ActualNumOfPayment] int not null,
  [LoanAmountLeft] money not null,
  [PaymentID] int not null,
  [LoanPaymentAmount] MONEY not null,
  [LoanPaymentDueDate] DATE not null
  )
 


 Create table [Fact].[LoanApplicationDetail]
( [ApplicationID]	int not null,
  [LoanTypeID] tinyint not null,
  [PurchasePrice] Money not null,
  [DownPaymentAmount] Money not null,
  [LoanAmount] Money not null,
  [ApplicationDate] date not null,
  [ApplicationStatusID]	tinyint not null,
  [LoanOfficer_DimKey] smallint not null,
  [Borrower_Dimkey] int not null, 
  [PersonalApp_DimKey] int not null,
  [MortgApp_DimKey] int not null,
  [AutoApp_DimKey] int not null,
  [EMP_DimKey] int not null
 )