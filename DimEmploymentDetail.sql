use [Loan_Datawarehouse]

go 

DECLARE @SummaryOfChanges TABLE(Change VARCHAR(20));

	MERGE [dim].[EmploymentDetail] AS T
	USING 
	(
		select [EPID]
      ,[CompanyName]
      ,[CurrentAddress]
      ,[City]
	  ,LC.[Caption] AS State_Name
      ,[Zip]
      ,[PositionTitle]
      ,[CompanyPhone]
      ,[YrsonJob]
      ,[BorrowerID]
		   
			FROM [LoanApplication_Test].[dbo].[Employment_Business] ED
					INNER JOIN [LoanApplication_Test].[dbo].[ListItemCaption] LC on LC.[ListItemCaptionId] = ED.[StateId]
					
	) AS S
	ON S.[EPID] = T.[EPID]
	WHEN MATCHED THEN 
	UPDATE SET 
		   T.[CompanyName] = S.[CompanyName]
		  ,T.[CurrentAddress] = S.[CurrentAddress]
		  ,T.[City] = S.[City]
		  ,T.[StateName]= S.[State_Name]
		  ,T.[Zip] = S.[Zip]
		  ,T.[PositionTitle] = S.[PositionTitle]
		  ,T.[CompanyPhone] = S.[CompanyPhone]
		  ,T.[YrsonJob] = S.[YrsonJob]
		  ,T.[BorrowerID] = S.[BorrowerID]
		
	WHEN NOT MATCHED BY TARGET 
	THEN INSERT (  
		[EPID]
      ,[CompanyName]
      ,[CurrentAddress]
      ,[City]
      ,[StateName]
      ,[Zip]
      ,[PositionTitle]
      ,[CompanyPhone]
      ,[YrsonJob]
      ,[BorrowerID]
	)
	VALUES 
	(
		S.[EPID]
      ,S.[CompanyName]
      ,S.[CurrentAddress]
      ,S.[City]
      ,S.[State_Name]
      ,S.[Zip]
      ,S.[PositionTitle]
      ,S.[CompanyPhone]
      ,S.[YrsonJob]
      ,S.[BorrowerID]
	)
	
	output $action into @SummaryOfChanges;
	--log 
	select change, count(*) as counts
	from @SummaryOfChanges 
	group by change 