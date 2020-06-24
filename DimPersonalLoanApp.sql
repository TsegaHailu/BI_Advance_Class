use [Loan_Datawarehouse]

go 

DECLARE @SummaryOfChanges TABLE(Change VARCHAR(20));

	MERGE[dim].[PersonalLoanApplication] AS T
	USING 
	(
		select [PersonalApplicationID]
			  ,LC.[Caption] as Loan_Type
			  ,[Reason_For_loan]
			  ,[ApplicationID]
    				FROM [LoanApplication_Test].[dbo].[PersonalLoanApplication] PA
					INNER JOIN [LoanApplication_Test].[dbo].[ListItemCaption] LC on LC.[ListItemCaptionId] = PA.[loantypeIDid]
					
	) AS S
	ON S.[PersonalApplicationID] = T.[PersonalApplicationID]
	WHEN MATCHED THEN 
	UPDATE SET 
		T.[loantypeName] = S.[Loan_Type],
		T.[Reason_For_loan] =S.[Reason_For_loan],
		T.[ApplicationID] = S.[ApplicationID]	
	WHEN NOT MATCHED BY TARGET 
	THEN INSERT ([loantypeName]
		  ,[Reason_For_loan]
		  ,[ApplicationID]
		 
	)
	VALUES 
	(
	S.[Loan_Type] ,
	S.[Reason_For_loan] ,
	S.[ApplicationID]
	
	)
	
	output $action into @SummaryOfChanges;
	--log 
	select change, count(*) as counts
	from @SummaryOfChanges 
	group by change 