use [Loan_Datawarehouse]

go 

DECLARE @SummaryOfChanges TABLE(Change VARCHAR(20));

	MERGE [dim].[Borrower] AS T
	USING 
	(
		select [BorrowerID] ,[SSN] ,[FirstName] ,[LastName] ,[DateOfBirth] , LCM.[Caption] AS MaritalStatus
		  ,LCG.[Caption] AS Gender
		  ,[NumberOfDependent]
		  ,[Phone]
		  ,[Email]
		  ,[CurrentStreetAddress]
		  ,[City]
		  ,LC.[Caption] AS State_Name
		  ,[Zip]
		  ,[YearsAtThisAddress]
		  ,[IsCosinger]
		  ,[PrimaryBorrowerSSN]
		  ,[CreditScore]
		  ,LCS.[Caption] As EmployementStatus
			FROM [LoanApplication_Test].[dbo].[Borrower] BR
					INNER JOIN [LoanApplication_Test].[dbo].[ListItemCaption] LC on LC.[ListItemCaptionId] = BR.[StateId]
					INNER JOIN [LoanApplication_Test].[dbo].[ListItemCaption] LCM on LCM.[ListItemCaptionId] = BR.[MaritalStatusId]
					INNER JOIN [LoanApplication_Test].[dbo].[ListItemCaption] LCG on LCG.[ListItemCaptionId] = BR.[GenderId]
					INNER JOIN [LoanApplication_Test].[dbo].[ListItemCaption] LCS on LCS.[ListItemCaptionId] = BR.[EmployementStatusId]
	) AS S
	ON S.[BorrowerID] = T.[BorrowerID]
	WHEN MATCHED THEN 
	UPDATE SET 
		T.[SSN] = S.[SSN],T.[FirstName]=S.[FirstName] ,T.[LastName] = S.[LastName] ,
		T.[DateOfBirth] = S.[DateOfBirth], T.MaritalStatus = S.MaritalStatus,
		T.[Gender] = S.[Gender]  , T.[NumberOfDependent] = S.[NumberOfDependent], T.[Phone]= S.[Phone],
		T.[Email] = S.[Email], T.[CurrentStreetAddress] = S.[CurrentStreetAddress], 
		T.[City] = S.[City], T.[State_Name] = S.[State_Name], T.[Zip] = S.[Zip],
		T.[YearsAtThisAddress] = S.[YearsAtThisAddress], T.[IsCosinger] = S.[IsCosinger],
		T.[PrimaryBorrowerSSN]= S.[PrimaryBorrowerSSN], T.[CreditScore] = S.[CreditScore],
		T.[EmployementStatus] = S.[EmployementStatus]
		
	WHEN NOT MATCHED BY TARGET 
	THEN INSERT ( [SSN] ,[FirstName] ,[LastName] ,[DateOfBirth] , [MaritalStatus]
		  ,[Gender]
		  ,[NumberOfDependent]
		  ,[Phone]
		  ,[Email]
		  ,[CurrentStreetAddress]
		  ,[City]
		  ,[State_Name]
		  ,[Zip]
		  ,[YearsAtThisAddress]
		  ,[IsCosinger]
		  ,[PrimaryBorrowerSSN]
		  ,[CreditScore]
		  ,[EmployementStatus]
	)
	VALUES 
	(
		S.[SSN] , S.[FirstName] ,S.[LastName] ,S.[DateOfBirth] , S.[MaritalStatus]
		  ,S.[Gender]
		  ,S.[NumberOfDependent]
		  ,S.[Phone]
		  ,S.[Email]
		  ,S.[CurrentStreetAddress]
		  ,S.[City]
		  ,S.[State_Name]
		  ,S.[Zip]
		  ,S.[YearsAtThisAddress]
		  ,S.[IsCosinger]
		  ,S.[PrimaryBorrowerSSN]
		  ,S.[CreditScore]
		  ,S.[EmployementStatus]
	)
	
	output $action into @SummaryOfChanges;
	--log 
	select change, count(*) as counts
	from @SummaryOfChanges 
	group by change 