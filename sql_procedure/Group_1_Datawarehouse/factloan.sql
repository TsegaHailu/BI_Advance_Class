use Loan_Datawarehouse

go 

with cte_fact 

as 
(
	select ln.[LoanID]
       ,ln.[ApplicationID]
      ,ln.[BranchID]
      ,ln.[LoanStatusID]
      ,ln.[DateContractStarts]
      ,ln.[DateContractEnd]
      ,ln.[InterstRate]
      ,ln.[ScheduledPaytAmount]
      ,ln.[SchechuledNumOfPayt]
      ,ln.[ActualNumOfPayment]
      ,ln.[LoanAmountLeft]
      ,p.[PaymentID]
      ,p.[LoanPaymentAmount]
      ,p.[LoanPaymentDueDate]
			from [LoanApplication_Test].[dbo].[Loan] ln
				inner join [LoanApplication_Test].[dbo].[Payment] p on ln.[LoanID] = p.[LoanID]
) 

insert into [fact].[Loan]

	( 
		[LoanID] ,[DimBranchKey],[DimLoanOfficerKey],[DimBankKey] ,[DimAutoLoanKey] ,[DimPersonalLoanKey]
      ,[DimMortgLoanKey]  ,[DimBorrowerKey] ,[DimIncomeExpenseKey],[ApplicationID] ,[BranchID] ,[LoanStatusID]
      ,[DateContractStarts] ,[DateContractEnd] ,[InterstRate] ,[ScheduledPaytAmount] ,[SchechuledNumOfPayt] ,[ActualNumOfPayment] ,[LoanAmountLeft] ,[PaymentID]
      ,[LoanPaymentAmount] ,[LoanPaymentDueDate]
	)
select 
		f.[LoanID] ,DB.[DimBranchKey],lo.[DimLoanOfficerKey],b.[DimBankKey] , au.[DimAutoLoanKey],pr.[DimPersonalLoanKey]
      ,mr.[DimMortgLoanKey]  ,br.[DimBorrowerKey] ,ie.[DimIncomeExpenseKey],f.[ApplicationID] ,f.[BranchID],[LoanStatusID],
      [DateContractStarts] ,[DateContractEnd] ,[InterstRate] ,[ScheduledPaytAmount] ,[SchechuledNumOfPayt] ,[ActualNumOfPayment] ,[LoanAmountLeft] ,[PaymentID]
		,[LoanPaymentAmount] ,[LoanPaymentDueDate]
		from cte_fact f
		inner join [dim].[Branch] db on db.[BranchID] = f.[BranchID]
		inner join [fact].[LoanApplicationDetail] la on la.ApplicationID = f.ApplicationID 
		inner join [dim].[LoanOfficer] lo on lo.[LoanOfficerID] = la.[LoanOfficerID]
		inner join [dim].[Bank] b on b.[BankID] =db.[BankID]
		inner join [dim].[Borrower] br on br.BorrowerID = la.BorrowerID
		inner join [dim].[AutoLoanApplication] Au on Au.ApplicationID = f.ApplicationID
		inner join [dim].[PersonalLoanApplication] pr on pr.ApplicationID =f.ApplicationID
		inner join [dim].[MortgageLoanApplication] mr on mr.ApplicationID =f.ApplicationID
		inner join [dim].[IncomeExpenseInfo] ie on ie.BorrowerID = br.BorrowerID
		
		
		
	