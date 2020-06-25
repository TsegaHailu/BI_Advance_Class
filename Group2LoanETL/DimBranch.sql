Declare @ChangeSummery table (change varchar(20));
With cte_Brach
as
(
Select [BranchID],
      [BranchName],
      [Phone],
      [Street_Address],
	  [City],
	  [Zip],
      [State_Name]=LC.[Caption],
	  [BankID],
	  from [dbo].[Branch]
inner join [dbo].[ListItemCaption] as LC
On b.[StateId]=LC.[ListItemCaptionId]
insert into [Dim].[Branch]

Select
  [Branch_DimKey ],
  [BranchID] ,
  [BranchName],
  [Phone] ,
  [Street_Address] ,
  [City] ,
  [Zip]	 ,
  [State_Name] ,
  [BankID]	

Merge [Dim].[Branch] as t
using 
( select [BranchID],
       [BranchName],
       [Phone],
       [Street_Address],
	   [City],
	   [Zip],[State_Name],[BankID]	 from cte_Brach)as s
on t.[BranchID]=s.[BranchID]
when matched 
then update set
t.[BranchName] =s.[BranchName],
t.[Phone] =s.[Phone],
t.[Street_Address] =s.[Street_Address],
t.[Zip] = s.[Zip],
t.[City] =s.[City],
t.[Zip]=s.[Zip],
t.[State_Name] =s.[State_Name]
when not matched by target
then insert
( [Branch_DimKey ],
  [BranchID] ,
  [BranchName],
  [Phone] ,
  [Street_Address] ,
  [City] ,
  [Zip]	 ,
  [State_Name] ,
  [BankID])
values 
(s.[BrachID],s.[BranchName],s.[Phone],s. [Street_Address],s.[City],s.[Zip],s.[State_Name],s.[BankID] )

output $action into @ChangeSummery;
