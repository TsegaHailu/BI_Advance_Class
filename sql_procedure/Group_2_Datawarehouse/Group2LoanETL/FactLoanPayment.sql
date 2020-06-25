/*--To calculate number of payments--*****/

create proc Spget#ofpmt
@Totalcount int out
as begin 
select @Totalcount=count(PaymentID )from [dbo].[Loan] group by LoanID
end
/*-----To calculate  Loan Amout left---*/
create proc SpAMtlft
@Amt money,@Schamt money @AmtLft money out
as begin
select  [LoanAmount]=@AmtLft  from [dbo].[LoanApplicationDetail]group by [ApplicationID]
select   [ScheduledPaytAmount]=@Schamt  from [dbo].[Loan]
@AmtLft=(@AmtLft - @Schamt*@Totalcount )
end
  
/********************FactTable--Insetion************************************/  
with cte_fact 
as 
(select 
Lo.[LoanID]
Lo.[ApplicationID]
Lo.[BranchID]
Lo.[LoanStatusID]
Lo.[DateContractStarts]
Lo.[DateContractEnd],
Lo.[InterstRate],
Lo.[ScheduledPaytAmount],
Lo.[SchechuledNumOfPayt],
Lo.[ActualNumOfPayment]=@Totalcount,
Lo.[LoanAmountLeft]=@AmtLft,
Pay.[PaymentID],
Pay.[LoanPaymentAmount],
Pay.[LoanPaymentDueDate]
from [dbo].[Loan]Lo
inner join [dbo].[Payment] Pay on Lo.[LoanID]=Pay.[LoanID])
select 
  f.[LoanID] ,
  Bk.[Bank_DimKey] ,
  Br. [Branch_DimKey],
  f.[ApplicationID] ,  
  f.[LoanStatusID] ,
  f.[DateContractStarts] ,
  f.[DateContractEnd] ,
  f.[InterstRate] ,
  f.[ScheduledPaytAmount] ,
  f.[SchechuledNumOfPayt] ,
  f.[ActualNumOfPayment] ,
  f.[LoanAmountLeft] ,
  f.[PaymentID],
  f.[LoanPaymentAmount] ,
  f.[LoanPaymentDueDate]
from cte_fact f
inner join [dim].[Bank] Bk on Bk.BranchID=f.BranchID
inner join [dim].[Branch] Br on Br.BranchID=f.BranchID
 
 insert into 
  [LoanID] ,
  [Bank_DimKey] ,
  [Branch_DimKey],
  [ApplicationID] ,  
  [LoanStatusID] ,
  [DateContractStarts] ,
  [DateContractEnd] ,
  [InterstRate] ,
  [ScheduledPaytAmount] ,
  [SchechuledNumOfPayt] ,
  [ActualNumOfPayment] ,
  [LoanAmountLeft] ,
  [PaymentID],
  [LoanPaymentAmount] ,
  [LoanPaymentDueDate]
  