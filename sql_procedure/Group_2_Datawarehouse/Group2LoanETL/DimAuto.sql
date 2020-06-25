use Loan_Datawarehouse

Declare @ChangeSummery table(change varchar(20));

Merge  [Dim].[AutoLoanApplication] as t
using 
(select  [AutoApplicationID],
         [LoanTypeID],
		 [vehicle_type],
		 [Maker],
		 [Model],
		 [Year],
		 [Mileage],
		 [ApplicationID]
from [dbo].[AutoLoanApplication]) as s
on t.[AutoApplicationID]=s.[ApplicationID]

when matched 
then update set 
  t.[loantypeIDid]=s.[loantypeIDid],
  t.[vehicle_type]=s.[vehicle_type],
  t.[Maker]=s.[Maker],
  t.[Model]=s.[Model],
  t.[Year]=s.[Year],
  t.[Mileage]=s.[Mileage],
  t.[ApplicationID]=s.[ApplicationID]
when not matched by target
then insert
 ([AutoApplicationID],
         [LoanTypeID],
		 [vehicle_type],
		 [Maker],
		 [Model],
		 [Year],
		 [Mileage],
		 [ApplicationID])
values 
 (s.[AutoApplicationID],
        s.[LoanTypeID],
		s.[vehicle_type],
		s.[Maker],
		s.[Model],
		s.[Year],
		s.[Mileage],
		s.[ApplicationID]
		)

 output $action into @ChangeSummery;