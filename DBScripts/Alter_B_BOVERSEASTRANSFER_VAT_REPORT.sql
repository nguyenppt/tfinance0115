
/****** Object:  StoredProcedure [dbo].[B_BOVERSEASTRANSFER_VAT_REPORT]    Script Date: 1/25/2015 10:10:25 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


ALTER PROCEDURE [dbo].[B_BOVERSEASTRANSFER_VAT_REPORT]
	@Code varchar(50),
	@UserNameLogin  nvarchar(500)
AS
BEGIN
	declare @CurrentDate varchar(12)
	set @CurrentDate = CONVERT(VARCHAR(10),GETDATE(),101);	
	
	declare @TabCus  as table
	(
		CustomerName nvarchar(500),
		IdentityNo nvarchar(20),
		[Address] nvarchar(500),
		City nvarchar(500),
		Country nvarchar(500)
	)
	insert into @TabCus
	select CustomerName, IdentityNo, [Address], City, Country from dbo.BCUSTOMERS
	where CustomerID = (select OtherBy from dbo.BOVERSEASTRANSFER where OverseasTransferCode = @Code)
	
	
	----------------------------------------------
	
	declare @BOVERSEASTRANSFERCHARGECOMMISSION as table
	(
		VATNo nvarchar(250),		
		AddRemarks1 nvarchar(250),
		AddRemarks2 nvarchar(250),
		
		CommissionCurrency  varchar(50),
		CommissionAmount float,
		CommissionType nvarchar(250),
		
		ChargeType nvarchar(250),
		ChargeAmount float,
		ChargeCurrency varchar(50),
		ChargeAcct nvarchar(250)
	)
	insert into @BOVERSEASTRANSFERCHARGECOMMISSION
	select top 1
		VATNo ,		
		AddRemarks1,
		AddRemarks2,
		
		CommissionCurrency  ,
		CommissionAmount ,
		CommissionType ,
		
		ChargeType ,
		ChargeAmount ,
		ChargeCurrency ,
		ChargeAcct 
	from dbo.BOVERSEASTRANSFERCHARGECOMMISSION
	where OverseasTransferCode = @Code
	--------------------------------------------
	
	declare @TongSoTienThanhToan float
	declare @TotalCharge float
	declare @VAT float
	
	set @TotalCharge = (select (CommissionAmount + ChargeAmount) from @BOVERSEASTRANSFERCHARGECOMMISSION)		
		
	set @VAT = (@TotalCharge * 0.1)
	set @TongSoTienThanhToan = @TotalCharge + @VAT	
	
	declare @AddRemark1 nvarchar(250)
	declare @AddRemarks2 nvarchar(250)
	declare @ChargeCurrency varchar(50)
	declare @CommissionAmount float
	declare @ChargeAmount float
	declare @CommissionCurrency  varchar(50)
	declare @ChargeType nvarchar(250)
	declare @CommissionType nvarchar(250)
	
	set @AddRemark1 = (select AddRemarks1 from @BOVERSEASTRANSFERCHARGECOMMISSION)
	set @AddRemarks2 = (select AddRemarks2 from @BOVERSEASTRANSFERCHARGECOMMISSION)
	set @ChargeCurrency = (select ChargeCurrency from @BOVERSEASTRANSFERCHARGECOMMISSION)
	set @CommissionAmount = (select CommissionAmount from @BOVERSEASTRANSFERCHARGECOMMISSION)
	set @ChargeAmount = (select ChargeAmount from @BOVERSEASTRANSFERCHARGECOMMISSION)
	set @CommissionCurrency =  (select CommissionCurrency from @BOVERSEASTRANSFERCHARGECOMMISSION)
	set @ChargeType =  (select ChargeType from @BOVERSEASTRANSFERCHARGECOMMISSION)
	set @CommissionType =  (select CommissionType from @BOVERSEASTRANSFERCHARGECOMMISSION)
	--------------------------------------------
	
	declare @BCHARGECODE as table
	(
		Code  varchar(20),
		Name_VN nvarchar(100)
	)
	insert into @BCHARGECODE
	select Code, Name_VN  from dbo.BCHARGECODE
	------------------------------
	select @CurrentDate as CurrentDate
	
	select
		ov.OverseasTransferCode,
		(select VATNo from @BOVERSEASTRANSFERCHARGECOMMISSION) as VATNo,
		(select ChargeAcct from @BOVERSEASTRANSFERCHARGECOMMISSION) as ChargeAcct,
		
		@UserNameLogin as UserNameLogin,
		
		case when isnull(@AddRemarks2, '') != '' then @AddRemark1 + ', ' + @AddRemarks2	else @AddRemark1 end as ChargeRemarks,
				
		ov.OtherBy as CustomerID,
		ov.OtherBy2  as CustomerName,
		(select IdentityNo from @TabCus) as IdentityNo,		
		ov.OtherBy3 + ', ' + ov.OtherBy4 + ', ' + ov.OtherBy5 as CustomerAddress,
		
		case when @ChargeCurrency = 'JPY' OR @ChargeCurrency = 'VND' 
			then (select dbo.f_CurrencyToText(CONVERT(INT, @TongSoTienThanhToan), @ChargeCurrency))
			else (select dbo.f_CurrencyToText(cast(@TongSoTienThanhToan as decimal(18,2)), @ChargeCurrency)) end as SoTienBangChu,
			
		case when @ChargeCurrency = 'JPY' OR @ChargeCurrency = 'VND' 
			then (REPLACE(CONVERT(varchar, CONVERT(money, cast(@TongSoTienThanhToan as decimal(18,0))), 1),'.00','') + ' ' + @ChargeCurrency)
			else (CONVERT(varchar, CONVERT(money, cast(@TongSoTienThanhToan as decimal(18,2))), 1) + ' ' + @ChargeCurrency) end as TongSoTienThanhToan,

		--CONVERT(varchar, CONVERT(money, cast(@TongSoTienThanhToan as decimal(18,2))), 1) + ' ' + @ChargeCurrency as TongSoTienThanhToan,		
		
		case when @ChargeCurrency = 'JPY' OR @ChargeCurrency = 'VND' 
			then (REPLACE(CONVERT(varchar, CONVERT(money, cast(@VAT as decimal(18,0))), 1),'.00','') + ' ' + @ChargeCurrency)
			else (CONVERT(varchar, CONVERT(money, cast(@VAT as decimal(18,2))), 1) + ' ' + @ChargeCurrency) end as VAT,
		
		--CONVERT(varchar, CONVERT(money, cast(@VAT as decimal(18,2))), 1) + ' ' + @ChargeCurrency as VAT,
		
		case when @CommissionCurrency = 'JPY' OR @CommissionCurrency = 'VND' 
			then (REPLACE(CONVERT(varchar, CONVERT(money, cast(@CommissionAmount as decimal(18,0))), 1),'.00','') + ' ' + @CommissionCurrency + '  PL70020')
			else (CONVERT(varchar, CONVERT(money, cast(@CommissionAmount as decimal(18,2))), 1) + ' ' + @CommissionCurrency + '  PL70020') end as CommissionAmount,

		--CONVERT(varchar, CONVERT(money, cast(@CommissionAmount as decimal(18,2))), 1) + ' ' + @CommissionCurrency + '  PL70020'  as CommissionAmount,

		case when @ChargeCurrency = 'JPY' OR @ChargeCurrency = 'VND' 
			then (REPLACE(CONVERT(varchar, CONVERT(money, cast(@ChargeAmount as decimal(18,0))), 1),'.00','') + ' ' + @ChargeCurrency+ '  PL70023')
			else (CONVERT(varchar, CONVERT(money, cast(@ChargeAmount as decimal(18,2))), 1) + ' ' + @ChargeCurrency + '  PL70023') end as ChargeAmount,
		--CONVERT(varchar, CONVERT(money, cast(@ChargeAmount as decimal(18,2))), 1) + ' ' + @ChargeCurrency + '  PL70023'  as ChargeAmount,
		
		(select Name_VN from @BCHARGECODE where Code = @CommissionType) as CommissionType_VN,
		(select Name_VN from @BCHARGECODE where Code = @ChargeType) as ChargeType_VN,	
			
		@ChargeType as ChargeType,
		@ChargeCurrency as ChargeCurrency,
		@CommissionCurrency as CommissionCurrency
		
	from dbo.BOVERSEASTRANSFER ov 
	where ov.OverseasTransferCode = @code
END
