use [Loan_Datawarehouse]

go 

DECLARE @SummaryOfChanges TABLE(Change VARCHAR(20));

	MERGE [dim].[MortgageLoanApplication] AS T
	USING 
	(
		select [MortgageapplicationID]
			  ,LC.[Caption] as Loan_Type
			  ,LCP.[Caption] as PropertyType
			  ,[PropertyStreeAddress]
			  ,[PropertyCity]
			  ,[Propertyzip]
			  ,LCS.[Caption] as StateName
			  ,[ApplicationID]
    				FROM [LoanApplication_Test].[dbo].[MortgageLoanApplication] MA
					INNER JOIN [LoanApplication_Test].[dbo].[ListItemCaption] LC on LC.[ListItemCaptionId] = MA.[Loan_Type]
					INNER JOIN [LoanApplication_Test].[dbo].[ListItemCaption] LCP on LCP.[ListItemCaptionId] = MA.[PropertyType]
					INNER JOIN [LoanApplication_Test].[dbo].[ListItemCaption] LCS on LCS.[ListItemCaptionId] = MA.[PropertyStateID]
	) AS S
	ON S.[MortgageapplicationID] = T.[MortgageapplicationID]
	WHEN MATCHED THEN 
	UPDATE SET 
		T.[LoanTypeName] = S.[Loan_Type],
		T.[PropertyType] =S.[PropertyType],
		T.[PropertyStreeAddress] = S.[PropertyStreeAddress],
		T.[PropertyCity] =S.[PropertyCity],
		T.[Propertyzip] = S.[Propertyzip],
		T.[StateName] = S.[StateName],
		T.[ApplicationID] = S.[ApplicationID]	
	WHEN NOT MATCHED BY TARGET 
	THEN INSERT ([LoanTypeName]
		  ,[PropertyType]
		  ,[PropertyStreeAddress]
		  ,[PropertyCity]
		  ,[Propertyzip]
		  ,[StateName]
		  ,[ApplicationID]
		 
	)
	VALUES 
	(
	S.[Loan_Type] ,
	S.[PropertyType] ,
	S.[PropertyStreeAddress],
	S.[PropertyCity],
	S.[Propertyzip],
	S.[StateName],
	S.[ApplicationID]
	
	)
	
	output $action into @SummaryOfChanges;
	--log 
	select change, count(*) as counts
	from @SummaryOfChanges 
	group by change 