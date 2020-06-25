use [Loan_Datawarehouse]

go 

DECLARE @SummaryOfChanges TABLE(Change VARCHAR(20));

	MERGE [dim].[Branch] AS T
	USING 
	(
		select [BranchID]
      ,[BranchName]
      ,[Phone]
      ,[Street_Address]
      ,[City]
      ,[Zip]
      ,LC.[Caption] as State_Name
      ,[BankID]
     	FROM [LoanApplication_Test].[dbo].[Branch] BRA
					INNER JOIN [LoanApplication_Test].[dbo].[ListItemCaption] LC on LC.[ListItemCaptionId] = BRA.[StateID]
	) AS S
	ON S.[BranchID] = T.[BranchID]
	WHEN MATCHED THEN 
	UPDATE SET 
	T.[BranchName] = S.[BranchName],
	T.[Phone] =S.[Phone],
	T.[Street_Address]=S.[Street_Address],
	T.[City]=S.[City],
	T.[Zip]=S.[Zip],
	T.[StateName]=S.[State_Name],
	T.[BankID]= S.[BankID]

	WHEN NOT MATCHED BY TARGET 
	THEN INSERT ([BranchName]
      ,[Phone]
      ,[Street_Address]
      ,[City]
      ,[Zip]
      ,[StateName]
	  ,[BankID]
	)
	VALUES 
	(
	S.[BranchName] ,
	S.[Phone] ,
	S.[Street_Address],
	S.[City],
	S.[Zip],
	S.[State_Name],
	S.[BankID]
	)
	
	output $action into @SummaryOfChanges;
	--log 
	select change, count(*) as counts
	from @SummaryOfChanges 
	group by change 