USE [bisolutions_vvcb]
GO
/****** Object:  StoredProcedure [dbo].[P_BEXPORT_DOCUMETARYCOLLECTION_VAT_Register_Report]    Script Date: 11/10/2015 9:19:26 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[P_BEXPORT_DOCUMETARYCOLLECTION_VAT_Register_Report] 
	-- Add the parameters for the stored procedure here
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
		BankAccount nvarchar(50),
		City nvarchar(500),
		Country nvarchar(500)
	)
	insert into @TabCus
	select CustomerName,IdentityNo, [Address], BankAccount, City, Country from BCUSTOMERS
	where CustomerID = (select DrawerCusNo from BEXPORT_DOCUMETARYCOLLECTION where DocCollectCode = @Code)
	
	-----------------------------------------------------------------------
	declare @Table_CHARGE as table 
	(
		DocCollectCode [nvarchar](50),
		[ChargeAmt] [float],
		[ChargeCcy] [nvarchar](5),
		[Chargecode] [nvarchar](50),
		[Rowchages] [nvarchar](3),
		[ChargeRemarks] [nvarchar](500) ,
		[VATNo] [nvarchar](20) ,
		[ChargeAcct] [nvarchar](20) 
	)
	insert into @Table_CHARGE
	select
		DocCollectCode ,
		[ChargeAmt] ,
		[ChargeCcy] ,
		[Chargecode],
		[Rowchages] ,
		ChargeRemarks,
		[VATNo],
		[ChargeAcct]
	from dbo.BEXPORT_DOCUMETARYCOLLECTIONCHARGES
	where DocCollectCode = @code;
	------------------------------------------------------
	
	declare @ChargeInfo_1 float	
	declare @ChargeInfo_2 float
	declare @ChargeInfo_3 float
	
	declare @ChargeInfo_1_ChargeCcy varchar(10)	
	declare @ChargeInfo_2_ChargeCcy varchar(10)	
	declare @ChargeInfo_3_ChargeCcy varchar(10)
		
	declare @ChargeInfo_1Name nvarchar(500)	
	declare @ChargeInfo_2Name nvarchar(500)	
	declare @ChargeInfo_3Name nvarchar(500)	
	
	select 
		@ChargeInfo_1 = ChargeAmt,
		@ChargeInfo_1_ChargeCcy = ChargeCcy,
		@ChargeInfo_1Name = Chargecode
	 from @Table_CHARGE
	 where Chargecode = 'EC.RECEIVE'
	
	if isnull(@ChargeInfo_1Name, '') != ''
	begin
		set @ChargeInfo_1Name = (select Name_VN from dbo.BCHARGECODE where Code = @ChargeInfo_1Name)
	end 	
	------------
	select 
		@ChargeInfo_2 = ChargeAmt,
		@ChargeInfo_2_ChargeCcy = ChargeCcy,
		@ChargeInfo_2Name = Chargecode
	 from @Table_CHARGE
	 where Chargecode = 'EC.COURIER'
	
	if isnull(@ChargeInfo_2Name, '') != ''
	begin
		set @ChargeInfo_2Name = (select Name_VN from dbo.BCHARGECODE where Code = @ChargeInfo_2Name)
	end
	------------
	select 
		@ChargeInfo_3 = ChargeAmt,
		@ChargeInfo_3_ChargeCcy = ChargeCcy,
		@ChargeInfo_3Name = Chargecode
	 from @Table_CHARGE
	 where Chargecode = 'EC.OTHER'	 
	
	if isnull(@ChargeInfo_3Name, '') != ''
	begin
		set @ChargeInfo_3Name = (select Name_VN from dbo.BCHARGECODE where Code = @ChargeInfo_3Name)
	end 
	
	--------------------------------------------
	declare @TongSoTienThanhToan float, @TongVAT float
	select @TongSoTienThanhToan =  sum(cast(isnull(ChargeAmt,'0') as float) + cast(isnull(TaxAmt,'0') as float)), @TongVAT = sum(cast(isnull(TaxAmt,'0') as float))
	from dbo.BEXPORT_DOCUMETARYCOLLECTIONCHARGES where DocCollectCode = @code and Chargecode NOT IN ('EC.CABLE', 'EC.ACCEPT')
	
	declare @Currency varchar(10)
	if isnull(@ChargeInfo_1_ChargeCcy, '') != ''
	begin
		set @Currency = @ChargeInfo_1_ChargeCcy
	end
	else if isnull(@ChargeInfo_2_ChargeCcy, '') != ''
	begin
		set @Currency = @ChargeInfo_2_ChargeCcy
	end
	else if isnull(@ChargeInfo_3_ChargeCcy, '') != ''
	begin
		set @Currency = @ChargeInfo_3_ChargeCcy
	end

	--------------------------------------------
	select @CurrentDate as CurrentDate
	select
		DATEPART(m, GETDATE()) as [Month],
	    DATEPART(d, GETDATE()) as [Day],
	    DATEPART(yy, GETDATE()) as [Year],
		doc.DocCollectCode as LCCode,
		(select top 1 VATNo from @Table_CHARGE) as VATNo,
		(select top 1 ChargeAcct from @Table_CHARGE) as  ChargeAcct,
		(select top 1 ChargeRemarks from @Table_CHARGE) as ChargeRemarks,
		
		@UserNameLogin as CurrentUserLogin,
		doc.DrawerCusName as CustomerName,
		doc.DrawerAddr1 + ', ' +doc.DrawerAddr2 + ', ' + doc.DrawerAddr3 as [Address],
		(select IdentityNo from @TabCus) as IdentityNo,
		(select BankAccount from @TabCus) as BankAccount,		
		doc.DrawerCusNo as CustomerID,				
		dbo.f_CurrencyToTextVn(cast(@TongSoTienThanhToan as nvarchar),@Currency) as SoTienBangChu,
		CONVERT(varchar, CONVERT(money,@TongSoTienThanhToan), 1) as TongSoTienThanhToan,
		@Currency Currency,
		doc.DrawerCusNo as DebitAccount,	
		doc.NostroCusNo as CreaditAccount,
		CONVERT(varchar, CONVERT(money, @TongVAT), 1) + ' ' + @Currency + ' PL90304' as VAT,
		case when isnull(@ChargeInfo_1, 0) > 0 then CONVERT(varchar, CONVERT(money, @ChargeInfo_1), 1) + ' ' + @ChargeInfo_1_ChargeCcy + ' PL737869' else '' end as ChargeInfo_1,
		case when isnull(@ChargeInfo_2, 0) > 0 then CONVERT(varchar, CONVERT(money, @ChargeInfo_2), 1) + ' ' + @ChargeInfo_2_ChargeCcy + ' PL837870' else '' end as ChargeInfo_2,
		case when isnull(@ChargeInfo_3, 0) > 0 then CONVERT(varchar, CONVERT(money, @ChargeInfo_3), 1) + ' ' + @ChargeInfo_3_ChargeCcy + ' PL837304' else '' end as ChargeInfo_3,
		
		case when isnull(@ChargeInfo_1, 0) > 0 then @ChargeInfo_1Name else '' end as ChargeName_1,
		case when isnull(@ChargeInfo_2, 0) > 0 then @ChargeInfo_2Name else '' end as ChargeName_2,
		case when isnull(@ChargeInfo_3, 0) > 0 then @ChargeInfo_3Name else '' end as ChargeName_3	
		
		
	from dbo.BEXPORT_DOCUMETARYCOLLECTION doc
	where doc.DocCollectCode = @Code
END