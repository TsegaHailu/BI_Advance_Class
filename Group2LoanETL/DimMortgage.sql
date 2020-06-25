use Loan_Datawarehouse

Declare @ChangeSummery table(change varchar(20));

Merge [Dim].[MortgageLoanApplication] as t
using 
(select  [MortgageapplicationID],[Loan_Type],[PropertyType],
         [PropertyStreeAddress],[PropertyCity],[Propertyzip],
		 [PropertyStateID],[ApplicationID] 
from [dbo].[MortgageLoanApplication]) as s
on s.[MortgageapplicationID] =t.[MortgageapplicationID]
when matched
then update set
  t.[Loan_Type]=s.[Loan_Type],
  t.[PropertyType]=s.[PropertyType],
  t.[PropertyStreeAddress]=s.[PropertyStreeAddress],
  t.[PropertyCity]=s[PropertyCity].,
  t.[Propertyzip]=s.[Propertyzip],
  t.[PropertyStateID]=s.[PropertyStateID],
  t.[ApplicationID]=s.[ApplicationID]
when not matched by target
then insert 
(  [MortgageapplicationID],[Loan_Type],[PropertyType],
   [PropertyStreeAddress],[PropertyCity],[Propertyzip],
   [PropertyStateID],[ApplicationID]
   )
values
(  s.[MortgageapplicationID],s.[Loan_Type],s.[PropertyType],
   s.[PropertyStreeAddress],s.[PropertyCity],s.[Propertyzip],
   s.[PropertyStateID],s.[ApplicationID]
   )

output $action into @ChangeSummery;