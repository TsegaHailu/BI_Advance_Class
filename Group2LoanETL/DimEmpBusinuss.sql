Declare @ChangeSummery table (change varchar(20));
With cte_EmpBss
as
(
Select[EPID],
      [CompanyName],
      [CurrentAddress],
      [City],
      [State_Name]=LC.[Caption],
	  [Zip],
	  [PositionTitle],
	  [CompanyPhone],
	  [YrsonJob],
	  [BorrowerID]
	  from [dbo].[Employment_Business]
inner join [dbo].[ListItemCaption] as LC
On [StateId]=LC.[ListItemCaptionId])
insert into [Dim].[Bank]

Select
     [EMP_DimKey] ,
     [EPID] ,
     [CompanyName] ,
     [CurrentAddress] ,
     [City] ,
     [StateName] ,
     [Zip]  ,
     [PositionTitle] ,
     [CompanyPhone]  ,
     [YrsonJob]  ,
     [BorrowerID]


Merge [Dim].[Employment_Business] as t
using 
( select [EPID],
      [CompanyName],
      [CurrentAddress],
      [City],
      [State_Name],
	  [Zip],
	  [PositionTitle],
	  [CompanyPhone],
	  [YrsonJob],
	  [BorrowerID] from cte_Bank)as s
on t.[EPID]=s.[EPID]
when matched 
then update set
t.[CompanyName] =s.[CompanyName],
t.[CurrentAddress] =s.[CurrentAddress],
t.[City] =s.[City],
t.[State_Name]=s.[State_Name],
t.[Zip] = s.[Zip],
t.[PositionTitle]=s.[PositionTitle],
t.[CompanyPhone]=s.[CompanyPhone],
t.[YrsonJob]=s.[YrsonJob],
t.[BorrowerID]=s.[BorrowerID]
when not matched by target
then insert
([EMP_DimKey] ,
     [EPID] ,
     [CompanyName] ,
     [CurrentAddress] ,
     [City] ,
     [StateName] ,
     [Zip]  ,
     [PositionTitle] ,
     [CompanyPhone]  ,
     [YrsonJob]  ,
     [BorrowerID])
values 
(    s. [EPID] ,
     s.[CompanyName],
     s.[CurrentAddress],
     s.[City],
     s.[State_Name],
	 s.[Zip],
	 s.[PositionTitle],
	 s.[CompanyPhone],
	 s.[YrsonJob],
	 s.[BorrowerID])

output $action into @ChangeSummery;









