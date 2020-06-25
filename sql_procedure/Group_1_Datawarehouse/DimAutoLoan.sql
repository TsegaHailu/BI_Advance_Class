use [Loan_Datawarehouse]

go 

DECLARE @SummaryOfChanges TABLE(Change VARCHAR(20));

	MERGE [dim].[AutoLoanApplication] AS T
	USING 
	(
		select [AutoApplicationID],
			LC.[Caption] as LoanTypeName, 
			[vehicle_type] ,[Maker],[Model],[Year],[Mileage],[ApplicationID]
				FROM [LoanApplication_Test].[dbo].[AutoLoanApplication] AL
					INNER JOIN [LoanApplication_Test].[dbo].[ListItemCaption] LC on LC.[ListItemCaptionId] = AL.[LoanTypeID]
	) AS S
	ON S.[AutoApplicationID] = T.[AutoApplicationID]
	WHEN MATCHED THEN 
	UPDATE SET 
	T.[LoanTypeName] = S.[LoanTypeName],
	T.[vehicle_type] =S.[vehicle_type],
	T.[Maker]=S.[Maker],
	T.[Model]=S.[Model],
	T.[Year]=S.[Year],
	T.[Mileage]=S.[Mileage],
	T.[ApplicationID]=S.[ApplicationID]
	
	WHEN NOT MATCHED BY TARGET 
	THEN INSERT ([LoanTypeName] ,
	[vehicle_type] ,
	[Maker] ,
	[Model],
	[Year],
	[Mileage],
	[ApplicationID]
	)
	VALUES 
	(
	S.[LoanTypeName] ,
	S.[vehicle_type] ,
	S.[Maker] ,
	S.[Model],
	S.[Year],
	S.[Mileage],
	S.[ApplicationID]
	)
	
	output $action into @SummaryOfChanges;
	--log 
	select change, count(*) as counts
	from @SummaryOfChanges 
	group by change 

