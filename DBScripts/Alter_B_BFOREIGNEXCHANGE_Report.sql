/****** Object:  StoredProcedure [dbo].[B_BFOREIGNEXCHANGE_Report]    Script Date: 1/27/2015 10:20:26 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER PROCEDURE [dbo].[B_BFOREIGNEXCHANGE_Report]
	@Code varchar(50),
	@UserNameLogin  nvarchar(500)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	
	declare @CurrentDate varchar(12)
	set @CurrentDate = CONVERT(VARCHAR(10),GETDATE(),101);	

    -- Insert statements for procedure here
    declare @TabCus  as table
	(
		CustomerName nvarchar(500),
		IdentityNo nvarchar(20),
		[Address] nvarchar(500),
		City nvarchar(500),
		Country nvarchar(500),
		BankAccount nvarchar(50),
		CustomerID nvarchar(50)
	)
	insert into @TabCus
	select 
		top 1 CustomerName,
		IdentityNo, 
		[Address],
		City, 
		Country, 
		BankAccount,
		CustomerID
	from BCUSTOMERS
	where CustomerID = (select Counterparty from dbo.BFOREIGNEXCHANGE where Code = @Code)
	---------------------------------------------------------------------------
	
	select @CurrentDate as CurrentDate
	
	select
		(select CustomerName from @TabCus) as CustomerName,
		(select [Address] from @TabCus) as [Address],
		(select IdentityNo from @TabCus) as IdentityNo,		
		(select City from @TabCus) as City,		
		(select Country from @TabCus) as Country,		
		(select BankAccount from @TabCus) as BankAccount,
		(select CustomerID from @TabCus) as CustomerID,		
		Code,
		(SELECT DATEPART(m, GETDATE())) as [Month],
	    (SELECT DATEPART(d, GETDATE())) as [Day],
	    (SELECT DATEPART(yy, GETDATE())) as [Year],
	    @UserNameLogin as UserNameLogin,
	    CustomerReceiving,
	    CustomerPaying,
	    BuyCurrency,
		case when BuyCurrency = 'JPY' OR BuyCurrency = 'VND' 
				then (REPLACE(CONVERT(varchar, CONVERT(money, cast(BuyAmount as decimal(18,0))), 1),'.00','') )
				else (CONVERT(varchar, CONVERT(money, cast(BuyAmount as decimal(18,2))), 1) ) end as BuyAmount,

	    --CONVERT(varchar, CONVERT(money, cast(BuyAmount as decimal(18,2))), 1) as BuyAmount,
	    SellCurrency,

		case when SellCurrency = 'JPY' OR SellCurrency = 'VND' 
				then (REPLACE(CONVERT(varchar, CONVERT(money, cast(SellAmount as decimal(18,0))), 1),'.00','') )
				else (CONVERT(varchar, CONVERT(money, cast(SellAmount as decimal(18,2))), 1) ) end as SellAmount,

	    --CONVERT(varchar, CONVERT(money, cast(SellAmount as decimal(18,2))), 1) as SellAmount,
	    Comment1,
	    Comment2,
	    Comment3,

		case when BuyCurrency = 'JPY' OR BuyCurrency = 'VND' 
				then (REPLACE(CONVERT(varchar, CONVERT(money, cast(BuyAmount as decimal(18,0))), 1),'.00','')  + ' ' + BuyCurrency )
				else (CONVERT(varchar, CONVERT(money, cast(BuyAmount as decimal(18,2))), 1)  + ' ' + BuyCurrency ) end as TongSoTienThanhToan,

	    --case when BuyCurrency = 'VND' OR BuyCurrency = 'JPY' then (CONVERT(varchar, CONVERT(money, cast(BuyAmount as decimal(18,0))), 1) + ' ' + BuyCurrency)
	    --else (CONVERT(varchar, CONVERT(money, cast(BuyAmount as decimal(18,2))), 1) + ' ' + BuyCurrency) end  as TongSoTienThanhToan,
	    
	    (select dbo.f_CurrencyToText(cast(BuyAmount as decimal(18,2)), BuyCurrency)) as SoTienBangChu
		
	from dbo.BFOREIGNEXCHANGE
	where Code = @Code
	
--	Chuyen khoan: Buy Amt (co the vnd)
--	      Sell Amt

--Noi dung: Comment tren FX
--Counterparty: thong tin khach hang

--CT: bo luon
--No: Debit Account
--Co: Credit Account

--tren FX:
--field Comment them 2 -> tong cong 3 cai



	
END
