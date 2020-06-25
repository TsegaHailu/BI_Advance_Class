use Loan_Datawarehouse

Declare @ChangeSummery table(change varchar(20));

Merge [Dim].[PersonalLoanApplication] as t
using 
(select  [PersonalApplicationID],
         [loantypeIDid],
		 [Reason_For_loan],
		 [ApplicationID]
from [dbo].[PersonalLoanApplication]) as s
on s.[PersonalApplicationID]=t.[PersonalApplicationID]

when matched 
then update set 
   t.[loantypeIDid]=s.[loantypeIDid],
   t.[Reason_For_loan]=s.[Reason_For_loan],
   t.[ApplicationID]=s.[ApplicationID]
when not matched by target
then insert
 (  [PersonalApplicationID],[loantypeIDid],
    [Reason_For_loan],[ApplicationID])
values 
 (  s.[PersonalApplicationID],s.[loantypeIDid],
    s.[Reason_For_loan],s.[ApplicationID])

 output $action into @ChangeSummery;