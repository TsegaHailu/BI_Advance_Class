use [Loan_Datawarehouse]

go 

DECLARE @SummaryOfChanges TABLE(Change VARCHAR(20));

	MERGE [dim].[LoanOfficer] AS T
	USING 
	(
		select [LoanOfficerID]
		  ,[FirstName]
		  ,[LastName]
		  ,[EMAIL]
		  ,[PHONENUMBER]
		  ,[HIREDATE]
		  ,[Position]
		  ,[SALARY]
		  ,[BranchID]
    			FROM [LoanApplication_Test].[dbo].[LoanOfficer]
	) AS S
	ON S.[LoanOfficerID] = T.[LoanOfficerID]
	WHEN MATCHED THEN 
	UPDATE SET 
		T.[FirstName] = S.[FirstName],
		T.[LastName] =S.[LastName],
		T.[EMAIL] = S.[EMAIL],
		T.[PHONENUMBER] =S.[PHONENUMBER],
		T.[HIREDATE] = S.[HIREDATE],
		T.[Position] = S.[Position],	
		T.[SALARY] = S.[SALARY],
		T.[BranchID] = S.[BranchID]	
	WHEN NOT MATCHED BY TARGET 
	THEN INSERT ([FirstName]
		  ,[LastName]
		  ,[EMAIL]
		  ,[PHONENUMBER]
		  ,[HIREDATE]
		  ,[Position]
		  ,[SALARY]
		  ,[BranchID]
	)
	VALUES 
	(
	S.[FirstName] ,
	S.[LastName] ,
	S.[EMAIL],
	S.[PHONENUMBER],
	S.[HIREDATE],
	S.[Position],
	S.[SALARY],
	S.[BranchID]
	)
	
	output $action into @SummaryOfChanges;
	--log 
	select change, count(*) as counts
	from @SummaryOfChanges 
	group by change 