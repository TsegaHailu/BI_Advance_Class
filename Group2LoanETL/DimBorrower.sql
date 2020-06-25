

With cte_Borrowr_List
as
(
Select b.BorrowerID,
SSN,FirstName,
LastName,
DateOfBirth,
[MaritalStatus]=L.[Caption] ,
[Gender]=LI.[Caption],
NumberOfDependent,
Phone,
Email,
CurrentStreetAddress,
City,[State]=LC.[Caption],
Zip,
YearsAtThisAddress,
IsCosinger,
PrimaryBorrowerSSN,
CreditScore,
[EmployementStatus]=LTC.Caption,
IE.[MonthlyGrossIncome],
IE.[MonthlyMortgageRent],
IE.[MonthlyOther_Loan_Expense] from [dbo].[Borrower] as b
inner join [dbo].[ListItemCaption] as L
on b.[MaritalStatusId]=L.[ListItemCaptionId]
inner join [dbo].[ListItemCaption] AS LI
on b.[GenderId]=LI.[ListItemCaptionId]
inner join [dbo].[ListItemCaption] as LC
On b.[StateId]=LC.[ListItemCaptionId]
inner join [dbo].[ListItemCaption] as LTC
on b.[EmployementStatusId]=LTC.ListItemCaptionId
Inner join [dbo].[IncomeExpenseinfo] as IE
on b.BorrowerID=IE.BorrowerID)


Merge [Dim].[Borrower] T
	Using  cte_Borrowr_List S
	On (T.BorrowerID=S.BorrowerID)
When Matched Then Update set
	T.[SSN]=S.[SSN],
	T.[FirstName]=S.[FirstName],
	T.[LastName]=S.[LastName],
	T.[DateOfBirth]=S.[DateOfBirth],
	T.[MaritalStatus]=S.[MaritalStatus],
	T.[Gender]=S.[Gender],
	T.[NumberOfDependent]=S.[NumberOfDependent],
	T.[Phone]=S.[Phone],
	T.[Email]=S.[Email],
	T.[CurrentStreetAddress]=S.[CurrentStreetAddress],
	T.[City]=S.[City],
	T.[State]=S.[State],
	T.[Zip]=S.[Zip],
	T.[YearsAtThisAddress]=S.[YearsAtThisAddress],
	T.[IsCosinger]=S.[IsCosinger],
	T.[PrimaryBorrowerSSN]=S.[CreditScore],
	T.[CreditScore]=S.[CreditScore],
	T.[EmployementStatus]=S.[EmployementStatus],
	T.[MonthlyGrossIncome]=S.[MonthlyGrossIncome],
	T.[MonthlyMortgageRent]=S.[MonthlyMortgageRent],
	T.[MonthlyOther_Loan_Expense]=S.[MonthlyOther_Loan_Expense]
When Not Matched by Target
	Then Insert (
	[BorrowerID],
	[SSN],
	[FirstName],
[LastName],
[DateOfBirth],
[MaritalStatus],
[Gender],
[NumberOfDependent],
[Email],
[Phone],
[CurrentStreetAddress],
[City],
[State],
[Zip],
[YearsAtThisAddress],
[IsCosinger],
[PrimaryBorrowerSSN],
[CreditScore],
[EmployementStatus],
[MonthlyGrossIncome],
[MonthlyMortgageRent],
[MonthlyOther_Loan_Expense]

	)

	Values(
	S.[BorrowerID],
	S.[SSN],
	S.[FirstName],
S.[LastName],
S.[DateOfBirth],
S.[MaritalStatus],
S.[Gender],
S.[NumberOfDependent],
S.[Email],
S.[Phone],
S.[CurrentStreetAddress],
S.[City],
S.[State],
S.[Zip],
S.[YearsAtThisAddress],
S.[IsCosinger],
S.[PrimaryBorrowerSSN],
S.[CreditScore],
S.[EmployementStatus],
S.[MonthlyGrossIncome],
S.[MonthlyMortgageRent],
S.[MonthlyOther_Loan_Expense]
	
	);


