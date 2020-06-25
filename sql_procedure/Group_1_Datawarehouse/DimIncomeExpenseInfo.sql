use [Loan_Datawarehouse]

go 

DECLARE @SummaryOfChanges TABLE(Change VARCHAR(20));

	MERGE [dim].[IncomeExpenseInfo] AS T
	USING 
	(
		select [IncomeExpensID]
      ,[MonthlyGrossIncome]
      ,[MonthlyMortgageRent]
      ,[MonthlyOther_Loan_Expense]
      ,[BorrowerID]
      
			FROM [LoanApplication_Test].[dbo].[IncomeExpenseinfo] 
					
	) AS S
	ON S.[IncomeExpensID] = T.[IncomeExpensID]
	WHEN MATCHED THEN 
	UPDATE SET 
	T.[MonthlyGrossIncome] = S.[MonthlyGrossIncome],
	T.[MonthlyMortgageRent] =S.[MonthlyMortgageRent],
	T.[MonthlyOther_Loan_Expense]=S.[MonthlyOther_Loan_Expense],
	T.[BorrowerID]=S.[BorrowerID]
		
	WHEN NOT MATCHED BY TARGET 
	THEN INSERT (
		[MonthlyGrossIncome]
      ,[MonthlyMortgageRent]
      ,[MonthlyOther_Loan_Expense]
      ,[BorrowerID]
	)
	VALUES 
	(
		S.[MonthlyGrossIncome] ,
		S.[MonthlyMortgageRent] ,
		S.[MonthlyOther_Loan_Expense],
		S.[BorrowerID]
	)
	
	output $action into @SummaryOfChanges;
	--log 
	select change, count(*) as counts
	from @SummaryOfChanges 
	group by change 