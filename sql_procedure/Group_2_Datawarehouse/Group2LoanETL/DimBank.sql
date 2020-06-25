Declare @ChangeSummery table (change varchar(20));
With cte_Bank
as
(
Select[BankID,
      [Name],
      [Discription],
      [Address],
	  [Zip],
	  [City],
      [State_Name]=LC.[Caption],
	  from [dbo].[Bank]
inner join [dbo].[ListItemCaption] as LC
On b.[StateId]=LC.[ListItemCaptionId]
insert into [Dim].[Bank]

Select
  [Bank_DimKey] ,
  [BankID]	,
  [Name]	,
  [Discription]	,
  [Address]	,
  [Zip]	 ,
  [City] ,
  [State_Name]

Merge [Dim].[Bank] as t
using 
( select [BankID],[Name],[Discription],[Address],[Zip],[City],[State_Name] from cte_Bank)as s
on t.[BankID]=s.[BankID]
when matched 
then update set
t.[Name] =s.[Name],
t.[Discription] =s.[Discription],
t.[Address] =s.[Address],
t.[Zip] = s.[Zip],
t.[City] =s.[City],
t.[State_Name] =s.[State_Name]
when not matched by target
then insert
([BankID],[Name],[Discription],[Address],[Zip],[City],[[State_Name])
values 
(s.[BankID],s.[Name],s.[Discription],s.[Address],s.[Zip],s.[City],s.[State_Name])

output $action into @ChangeSummery;
