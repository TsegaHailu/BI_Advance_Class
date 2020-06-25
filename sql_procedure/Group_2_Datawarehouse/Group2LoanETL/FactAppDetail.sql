 with cte_fact 
as 
(select 
 
  s.[ApplicationID]	,
  s.[LoanTypeID] ,
  s.[PurchasePrice] ,
  s.[DownPaymentAmount] ,
  s.[LoanAmount] ,
  s.[ApplicationDate],
  s.[ApplicationStatusID]	,
  s.[LoanOfficerID],
  s.[BorrowerID],
  Lon.[LoanOfficer_DimKey] ,
  Bor.[Borrower_Dimkey] , 
  Per.[PersonalApp_DimKey] ,
  Mor.[MortgApp_DimKey] ,
  Aut.[AutoApp_DimKey] ,
  Emp.[EMP_DimKey] 
  from [dbo].[LoanApplicationDetail] 
  inner join [dim].[LoanOfficer] Lon on Lon.[LoanOfficerID]=s.[LoanOfficerID]
  inner join [dim].[Borrower] Bor on Bor.[BorrowerID]=s.[BorrowerID]
  inner join [Dim].[PersonalLoanApplication] Per on Per.[ApplicationID]=s.[ApplicationID]
  inner join [Dim].[MortgageLoanApplication] Mor on Mor.[ApplicationID]=s.[ApplicationID]
  inner join [Dim].[AutoLoanApplication] Aut on Aut.[ApplicationID]=s.[ApplicationID]
  inner join [Dim].[Employment_Business] Emp on Emp.[BorrowerID]=s.[BorrowerID])
  
  insert into [Fact].[LoanApplicationDetail]
  select
  [ApplicationID]	,
  [LoanTypeID] ,
  [PurchasePrice],
  [DownPaymentAmount] ,
  [LoanAmount] ,
  [ApplicationDate] ,
  [ApplicationStatusID]	,
  [LoanOfficer_DimKey] ,
  [Borrower_Dimkey] , 
  [PersonalApp_DimKey] ,
  [MortgApp_DimKey] ,
  [AutoApp_DimKey] ,
  [EMP_DimKey]
