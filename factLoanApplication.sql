use Loan_Datawarehouse

go 

with cte_fact 

as 
(
	select 	  [ApplicationID]
      ,[LoanTypeID]
      ,[PurchasePrice]
      ,[DownPaymentAmount]
      ,[LoanAmount]
      ,[ApplicationDate]
      ,[ApplicationStatusID]
      ,[LoanOfficerID]
      ,[BorrowerID]
			from [LoanApplication_Test].[dbo].[LoanApplicationDetail] 
				
) 

insert into [fact].[LoanApplicationDetail]

	( 
		[ApplicationID]
      ,[DimAutoLoanKey]
      ,[DimPersonalLoanKey]
      ,[DimMortgLoanKey]
      ,[DimEmployKey]
      ,[DimBorrowerKey]
	  ,[LoanTypeID]
      ,[PurchasePrice]
      ,[DownPaymentAmount]
      ,[LoanAmount]
      ,[ApplicationDate]
      ,[ApplicationStatusID]
      ,[LoanOfficerID]
      ,[BorrowerID]
	  ,[DimIncomeExpenseKey]
		
	)
select 
		
		f.[ApplicationID] ,au.[DimAutoLoanKey] ,pr.[DimPersonalLoanKey]  ,mr.[DimMortgLoanKey]
      ,ed.[DimEmployKey]  ,br.[DimBorrowerKey],  ie.[DimIncomeExpenseKey], f.[LoanTypeID]      ,f.[PurchasePrice]
      ,f.[DownPaymentAmount]  ,f.[LoanAmount]     ,f.[ApplicationDate]   ,f.[ApplicationStatusID]
      ,f.[LoanOfficerID],f.[BorrowerID]
			from cte_fact f
				inner join [dim].[EmploymentDetail] ed on ed.BorrowerID = f.BorrowerID
				inner join [dim].[Borrower] br on br.BorrowerID = f.BorrowerID
				inner join [dim].[AutoLoanApplication] Au on Au.ApplicationID = f.ApplicationID
				inner join [dim].[PersonalLoanApplication] pr on pr.ApplicationID =f.ApplicationID
				inner join [dim].[MortgageLoanApplication] mr on mr.ApplicationID =f.ApplicationID
				inner join [dim].[IncomeExpenseInfo] ie on ie.BorrowerID = f.BorrowerID
		
		
		
	