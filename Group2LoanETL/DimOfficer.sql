use Loan_Datawarehouse

Declare @ChangeSummery table(change varchar(20));
Merge  [Dim].[LoanOfficer]
using 
(select [LoanOfficerID],[FirstName],[LastName],
        [EMAIL],[PHONENUMBER],[HIREDATE],
        [Position],[SALARY],[BranchID])as s
on s.[LoanOfficerID]=t.[LoanOfficerID]
when matched 
then update set
t.[FirstName]=s.[FirstName],
t.[LastName]=s.[LastName],
t.[EMAIL]=s.[EMAIL],
t.[PHONENUMBER]=s.[PHONENUMBER],
t.[HIREDATE]=s.[HIREDATE],
t.[Position]=s.[Position],
t.[SALARY]=s.[SALARY],
t.[BranchID]=s.[BranchID]
when not matched  by target
then insert
(   [LoanOfficerID],[FirstName],
    [LastName],[EMAIL],
    [PHONENUMBER],[HIREDATE],
    [Position],[SALARY],
	[BranchID])
values
(s.[LoanOfficerID],s.[FirstName],
 s.[LastName],s.[EMAIL],
 s.[PHONENUMBER],s.[HIREDATE],
 s.[Position],s.[SALARY],s.[BranchID])

output $action into @ChangeSummery;