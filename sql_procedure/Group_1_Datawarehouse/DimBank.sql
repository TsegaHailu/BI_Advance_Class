use [Loan_Datawarehouse]

go 

DECLARE @SummaryOfChanges TABLE(Change VARCHAR(20));

	MERGE [dim].[Bank] AS T
	USING 
	(
		select [BankID]
      ,[Name]
      ,[Discription]
      ,[Address]
      ,[Zip]
      ,[City]
      ,LC.[Caption] as State_Name
			FROM [LoanApplication_Test].[dbo].[Bank] B
					INNER JOIN [LoanApplication_Test].[dbo].[ListItemCaption] LC on LC.[ListItemCaptionId] = B.[State_ID]
	) AS S
	ON S.[BankID] = T.[BankID]
	WHEN MATCHED THEN 
	UPDATE SET 
	T.[Name] = S.[Name],
	T.[Discription] =S.[Discription],
	T.[Address]=S.[Address],
	T.[Zip]=S.[Zip],
	T.[City]=S.[City],
	T.[StateName]=S.[State_Name]	
	
	WHEN NOT MATCHED BY TARGET 
	THEN INSERT ([Name]
      ,[Discription]
      ,[Address]
      ,[Zip]
      ,[City]
      ,[StateName]
	)
	VALUES 
	(
	S.[Name] ,
	S.[Discription] ,
	S.[Address],
	S.[Zip],
	S.[City],
	S.[State_Name]
	)
	
	output $action into @SummaryOfChanges;
	--log 
	select change, count(*) as counts
	from @SummaryOfChanges 
	group by change 