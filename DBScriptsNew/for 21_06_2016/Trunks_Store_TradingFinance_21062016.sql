USE [bisolutions_vvcb]
/***
---------------------------------------------------------------------------------
B_BEXPORT_DOCUMETARYCOLLECTION_UpdateStatus
---------------------------------------------------------------------------------
***/

IF EXISTS(SELECT * FROM sys.procedures WHERE NAME = 'B_BEXPORT_DOCUMETARYCOLLECTION_UpdateStatus')
BEGIN
DROP PROCEDURE [dbo].[B_BEXPORT_DOCUMETARYCOLLECTION_UpdateStatus]
END

GO
/****** Object:  StoredProcedure [dbo].[B_BEXPORT_DOCUMETARYCOLLECTION_UpdateStatus]    Script Date: 6/26/2016 11:07:38 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[B_BEXPORT_DOCUMETARYCOLLECTION_UpdateStatus]
	@DocCollectCode varchar(50),
	@Status varchar(50),
	@AuthorizedBy varchar(10),
	@ScreenType varchar(50)
AS
BEGIN
if @ScreenType = 'Amend'
	begin		
		if @Status = 'REV'
		begin
			UPDATE [dbo].[BEXPORT_DOCUMETARYCOLLECTION]
			SET 
			  Amend_Status = @Status	  
			WHERE DocCollectCode = @DocCollectCode
			AND (ActiveRecordFlag is null OR ActiveRecordFlag='YES')
		end
		else 
		begin
			UPDATE [dbo].[BEXPORT_DOCUMETARYCOLLECTION]
			SET 
			  Amend_Status = @Status,
			  AmendBy = @AuthorizedBy,
			  AmountOld = Amount,
			  Amount = AmountNew
			  /*Amount = AmountAut,
			  AmountAut = 0,
			  AmountOld = Amount		  
			  */
			WHERE DocCollectCode = @DocCollectCode
			AND (ActiveRecordFlag is null OR ActiveRecordFlag='YES')
		end		
	end
	else if @ScreenType = 'Cancel' 
		if @Status = 'AUT'
			begin
				UPDATE [dbo].[BEXPORT_DOCUMETARYCOLLECTION]
				SET 
				  Cancel_Status = @Status,
				  [Status] = 'CAN', 
				  CancelBy = @AuthorizedBy 
				WHERE DocCollectCode = @DocCollectCode
				AND (ActiveRecordFlag is null OR ActiveRecordFlag='YES')
			end
		else 
			begin
				UPDATE [dbo].[BEXPORT_DOCUMETARYCOLLECTION]
				SET 
				  Cancel_Status = @Status,				
				  CancelBy = @AuthorizedBy
				WHERE DocCollectCode = @DocCollectCode
				AND (ActiveRecordFlag is null OR ActiveRecordFlag='YES')
			end
	else if @ScreenType = 'Acception' 
	begin
		UPDATE [dbo].[BEXPORT_DOCUMETARYCOLLECTION]
		SET 
		  AcceptStatus = @Status,
		  AcceptedBy = @AuthorizedBy
		WHERE DocCollectCode = @DocCollectCode
		AND (ActiveRecordFlag is null OR ActiveRecordFlag='YES')
	end
	else  -- register & register CC
	begin
		UPDATE [dbo].[BEXPORT_DOCUMETARYCOLLECTION]
		SET 
		  [Status] = @Status
		  , AuthorizedBy = @AuthorizedBy
		  , AuthorizedDate = getdate()
		WHERE DocCollectCode = @DocCollectCode	
		AND (ActiveRecordFlag is null OR ActiveRecordFlag='YES')
	end

END
GO

/***
---------------------------------------------------------------------------------
P_ExportLCPaymentReport
---------------------------------------------------------------------------------
***/

IF EXISTS(SELECT * FROM sys.procedures WHERE NAME = 'P_ExportLCPaymentReport')
BEGIN
DROP PROCEDURE [dbo].[P_ExportLCPaymentReport]
END

GO
/****** Object:  StoredProcedure [dbo].[P_ExportLCPaymentReport]    Script Date: 6/26/2016 11:10:12 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[P_ExportLCPaymentReport](
	@ReportType smallint,--1 : PhieuChuyenKhoan, 2 : VAT
	@PaymentId VARCHAR(50),
	@UserId varchar(50))
as
-- P_ExportLCPaymentReport 2, 'TF-14250-00149.1', 'a'
begin
	declare @DocId bigint, @VATNo varchar(50), @LCCode varchar(50)
	declare @CustomerID varchar(50), @CustomerName nvarchar(250), @CustomerIDNo varchar(50), @Address1 nvarchar(500), @Address2 nvarchar(500), @Address3 nvarchar(500), @CustomerBankAcc NVARCHAR(50), @CollectionType nvarchar(10)	
	declare @TaiKhoanNo nvarchar(50), @TenTaiKhoanNo nvarchar(max), @TenTaiKhoanCo nvarchar(max), @currency nvarchar(10)
	declare @OverseasMinus float, @OverseasPlus float, @Amount float
	---1 : PhieuChuyenKhoan
	if @ReportType = 1
	begin			
		
		select  top 1 @LCCode = CollectionPaymentCode, @currency = Currency from BOUTGOINGCOLLECTIONPAYMENT where PaymentId = @PaymentId
		set @VATNo = (SELECT top 1 VATNo FROM BOUTGOINGCOLLECTIONPAYMENTCHARGES WHERE CollectionPaymentCode = @PaymentId)
		(SELECT top 1 @OverseasMinus = ChargeAmt FROM BOUTGOINGCOLLECTIONPAYMENTCHARGES WHERE CollectionPaymentCode = @PaymentId and Chargecode = 'EC.OVERSEASMINUS')
		(SELECT top 1 @OverseasPlus = ChargeAmt FROM BOUTGOINGCOLLECTIONPAYMENTCHARGES WHERE CollectionPaymentCode = @PaymentId and Chargecode = 'EC.OVERSEASPLUS')

		set @TaiKhoanNo = (select  top 1  PresentorCusNo from BOUTGOINGCOLLECTIONPAYMENT where PaymentId = @PaymentId)
		set @TenTaiKhoanNo = (select  top 1  [Description] from BSWIFTCODE where AccountNo = @TaiKhoanNo)
		--set @TenTaiKhoanCo = (select  top 1  DrawerCusName + ' - ' + DrawerAddr1 + ' ' + DrawerAddr2 + ' ' + DrawerAddr3 from BEXPORT_DOCUMETARYCOLLECTION where DocCollectCode = @LCCode)
		(select  top 1  @TenTaiKhoanCo = DrawerCusName, @CollectionType = CollectionType from BEXPORT_DOCUMETARYCOLLECTION where DocCollectCode = @LCCode)

		
		select (SELECT DATEPART(d, GETDATE())) as [Day], (SELECT DATEPART(m, GETDATE())) as [Month], (SELECT DATEPART(yy, GETDATE())) as [Year],
			CollectionPaymentCode LCCode, @VATNo VATNo, @UserId CurrentUserLogin, 
			@TaiKhoanNo SoTaiKhoanNo, @TenTaiKhoanNo TenTaiKhoanNo,
			--Currency + cast(DrawingAmount AS VARCHAR) SoTienTaiKhoanNo, 
			case when Currency = 'JPY' OR Currency = 'VND' 
				then (REPLACE(CONVERT(varchar, CONVERT(money, cast(convert(numeric(32,0),DrawingAmount) as decimal(18,0))), 1),'.00','') + ' ' + Currency)
				else (CONVERT(varchar, CONVERT(money, cast(convert(numeric(32,0),DrawingAmount) as decimal(18,2))), 1) + ' ' + Currency) end as SoTienTaiKhoanNo,

			--REPLACE(CONVERT(varchar, CONVERT(money, cast(isnull(DrawingAmount,0) as decimal(18,2))), 1) , '.00', '')+ ' ' + Currency AS SoTienTaiKhoanNo,
			dbo.f_CurrencyToTextVn(convert(numeric(32,0),DrawingAmount), Currency) SoTienTaiKhoanNoBangChu,
			--Currency + cast(DrawingAmount AS VARCHAR) SoTienTaiKhoanCo, 
			
			case when Currency = 'JPY' OR Currency = 'VND' 
				then (REPLACE(CONVERT(varchar, CONVERT(money, cast(convert(numeric(32,0),DrawingAmount) as decimal(18,0))), 1),'.00','') + ' ' + Currency)
				else (CONVERT(varchar, CONVERT(money, cast(convert(numeric(32,0),DrawingAmount) as decimal(18,2))), 1) + ' ' + Currency) end as SoTienTaiKhoanCo,
			
			--REPLACE(CONVERT(varchar, CONVERT(money, cast(isnull(DrawingAmount,0) as decimal(18,2))), 1), '.00', '') + ' ' + Currency AS SoTienTaiKhoanCo,

			dbo.f_CurrencyToTextVn(convert(numeric(32,0),DrawingAmount), Currency) SoTienTaiKhoanCoBangChu,
			CreditAccount SoTaiKhoanCo, @TenTaiKhoanCo TenTaiKhoanCo, @CollectionType CollectionType
		from BOUTGOINGCOLLECTIONPAYMENT where PaymentId = @PaymentId
		
		return
	end
	---2 : VAT
	if @ReportType = 2
	begin
		Declare @TaiKhoanCo nvarchar(50);
		Declare @collType nvarchar(10);
		(select  top 1 @TaiKhoanCo = CreditAccount, @TaiKhoanNo =PresentorCusNo from BOUTGOINGCOLLECTIONPAYMENT where PaymentId = @PaymentId) 
		--set @TaiKhoanNo = (select  top 1  PresentorCusNo from BOUTGOINGCOLLECTIONPAYMENT where PaymentId = @PaymentId)
		set @TenTaiKhoanNo = (select  top 1  [Description] from BSWIFTCODE where AccountNo = @TaiKhoanNo)
		--set @TenTaiKhoanCo = (select  top 1  DrawerCusName + ' - ' + DrawerAddr1 + ' ' + DrawerAddr2 + ' ' + DrawerAddr3 from BEXPORT_DOCUMETARYCOLLECTION where DocCollectCode = @LCCode)
		

		set @VATNo = (SELECT top 1 VATNo FROM BOUTGOINGCOLLECTIONPAYMENTCHARGES WHERE CollectionPaymentCode = @PaymentId)
		
		select @LCCode =  CollectionPaymentCode from BOUTGOINGCOLLECTIONPAYMENT where PaymentId = @PaymentId
		---
		select @CustomerID = DrawerCusNo, @CustomerName = DrawerCusName, @collType = CollectionType
		from BEXPORT_DOCUMETARYCOLLECTION where DocCollectCode = @LCCode
		---
		select @CustomerIDNo = IdentityNo, @CustomerBankAcc = BankAccount, @Address1 = [Address]
		from dbo.BCUSTOMERS where CustomerID = @CustomerID
		---
		declare @TongSoTienThanhToan float, @TongVAT float
		select @TongSoTienThanhToan = sum(cast(isnull(ChargeAmt,'0') as float) + cast(isnull(TaxAmt,'0') as float)), @TongVAT = sum(cast(isnull(TaxAmt,'0') as float))
		from dbo.BOUTGOINGCOLLECTIONPAYMENTCHARGES where CollectionPaymentCode = @PaymentId and PartyCharged = 'A' and Chargecode NOT IN ('EC.OVERSEASPLUS', 'EC.OVERSEASMINUS')
		---
		select a.CollectionPaymentCode PaymentId, a.Chargecode ChargeTab, b.Name_vn ChargeName, ChargeAmt, TaxAmt, b.PLAccount, a.ChargeCcy, rowchages
		into #tblCharge
		from BOUTGOINGCOLLECTIONPAYMENTCHARGES a
			inner join BCHARGECODE b on a.ChargeCode = b.Code
		where CollectionPaymentCode = @PaymentId and ChargeAmt is not null
		---
		select PaymentId Id, (SELECT DATEPART(d, GETDATE())) as [Day], (SELECT DATEPART(m, GETDATE())) as [Month], (SELECT DATEPART(yy, GETDATE())) as [Year],
			@LCCode LCCode, @UserId CurrentUserLogin, @CustomerName CustomerName, @CustomerID CustomerID, @CustomerIDNo IdentityNo, @Address1 [Address],
			@CustomerBankAcc BankAccount, @CustomerBankAcc DebitAccount, @TaiKhoanCo CreaditAccount, @VATNo VATNo,
			SUBSTRING(a.Currency,1,3) + ' ' + CONVERT(varchar, CONVERT(money, @TongSoTienThanhToan), 1) TongSoTienThanhToan, 
			dbo.f_CurrencyToTextVn(convert(numeric(32,0),@TongSoTienThanhToan), SUBSTRING(a.Currency,1,3)) SoTienBangChu,
			SUBSTRING(a.Currency,1,3) + ' ' + CONVERT(varchar, CONVERT(money, @TongVAT), 1) + ' PL90304' VAT, @collType CollectionType
		into #tblPayment
		from BOUTGOINGCOLLECTIONPAYMENT a where PaymentId = @PaymentId
		---
		select a.*, 
			  b1.ChargeName ChargeName_1, b1.ChargeCcy + ' ' + CONVERT(varchar, CONVERT(money, (b1.ChargeAmt )), 1) + ' ' + b1.PLAccount ChargeInfo_1
			, b2.ChargeName ChargeName_2, b2.ChargeCcy + ' ' + CONVERT(varchar, CONVERT(money, (b2.ChargeAmt )), 1) + ' ' + b2.PLAccount ChargeInfo_2
			, b3.ChargeName ChargeName_3, b3.ChargeCcy + ' ' + CONVERT(varchar, CONVERT(money, (b3.ChargeAmt )), 1) + ' ' + b3.PLAccount ChargeInfo_3
			, b4.ChargeName ChargeName_4, b4.ChargeCcy + ' ' + CONVERT(varchar, CONVERT(money, (b4.ChargeAmt )), 1) + ' ' + b4.PLAccount ChargeInfo_4
		from #tblPayment a
			left join #tblCharge b1 on a.Id = b1.PaymentId and b1.ChargeTab = 'EC.PAYMENT' and b1.rowchages = 4--'EC.RECEIVE'
			left join #tblCharge b2 on a.Id = b2.PaymentId and b2.ChargeTab = 'EC.CABLE' and b2.rowchages = 2--'EC.COURIER'
			left join #tblCharge b3 on a.Id = b3.PaymentId and b3.ChargeTab = 'EC.HANDLING'
			left join #tblCharge b4 on a.Id = b4.PaymentId and b4.ChargeTab = 'EC.OTHER'
		
		return
	END

	---3: phieu xuat ngoai bang
	if @ReportType=3
	begin	
		select @LCCode =  CollectionPaymentCode from BOUTGOINGCOLLECTIONPAYMENT where PaymentId = @PaymentId
		---
		select @CustomerID = DrawerCusNo, @CustomerName = DrawerCusName, @Address1 = DrawerAddr1, 
		@Address2 = DrawerAddr2, @Address3 = DrawerAddr3, @Amount = Amount, @currency = Currency
		from BEXPORT_DOCUMETARYCOLLECTION where DocCollectCode = @LCCode

		select @CustomerIDNo = IdentityNo, @CustomerBankAcc = BankAccount, @Address1 = [Address]
		from dbo.BCUSTOMERS where CustomerID = @CustomerID

		select (SELECT DATEPART(d, GETDATE())) as [Day], (SELECT DATEPART(m, GETDATE())) as [Month], (SELECT DATEPART(yy, GETDATE())) as [Year], @UserId CurrentUserLogin,
		@PaymentId DocCollectCode, @CustomerName CustomerName, @CustomerIDNo IdentityNo, 
		@Address1 [Address], @Address2 City, @Address3 Country, @Amount Amount, @currency Currency,
		dbo.f_CurrencyToTextVn(convert(numeric(32,0),@Amount), SUBSTRING(a.Currency,1,3)) SoTienVietBangChu
		from BOUTGOINGCOLLECTIONPAYMENT a where PaymentId = @PaymentId
	end 
end
GO

/***
---------------------------------------------------------------------------------
P_BEXPORT_DOCUMETARYCOLLECTION_VAT_Amend_Report
---------------------------------------------------------------------------------
***/

IF EXISTS(SELECT * FROM sys.procedures WHERE NAME = 'P_BEXPORT_DOCUMETARYCOLLECTION_VAT_Amend_Report')
BEGIN
DROP PROCEDURE [dbo].[P_BEXPORT_DOCUMETARYCOLLECTION_VAT_Amend_Report]
END

GO
/****** Object:  StoredProcedure [dbo].[P_BEXPORT_DOCUMETARYCOLLECTION_VAT_Amend_Report]    Script Date: 6/26/2016 11:11:53 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create  PROCEDURE [dbo].[P_BEXPORT_DOCUMETARYCOLLECTION_VAT_Amend_Report] 
	-- Add the parameters for the stored procedure here
	@Code varchar(50),
	@UserNameLogin  nvarchar(500),
	@TabID nvarchar(10)
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
	where CustomerID = (select DrawerCusNo from BEXPORT_DOCUMETARYCOLLECTION where AmendNo = @Code)
	
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
	where AmendNo = @code and TabId = @TabID;
	------------------------------------------------------
	
	declare @ChargeInfo_1 float	
	declare @ChargeInfo_2 float
	declare @ChargeInfo_3 float
	declare @ChargeInfo_4 float
	
	declare @ChargeInfo_1_ChargeCcy varchar(10)	
	declare @ChargeInfo_2_ChargeCcy varchar(10)	
	declare @ChargeInfo_3_ChargeCcy varchar(10)
	declare @ChargeInfo_4_ChargeCcy varchar(10)
		
	declare @ChargeInfo_1Name nvarchar(500)	
	declare @ChargeInfo_2Name nvarchar(500)	
	declare @ChargeInfo_3Name nvarchar(500)	
	declare @ChargeInfo_4Name nvarchar(500)	
	
	select 
		@ChargeInfo_1 = ChargeAmt,
		@ChargeInfo_1_ChargeCcy = ChargeCcy,
		@ChargeInfo_1Name = Chargecode
	 from @Table_CHARGE
	 where Chargecode = 'EC.AMEND'
	
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
	 where Chargecode = 'EC.CABLE'
	
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
	 where Chargecode = 'EC.COURIER'	 
	
	if isnull(@ChargeInfo_3Name, '') != ''
	begin
		set @ChargeInfo_3Name = (select Name_VN from dbo.BCHARGECODE where Code = @ChargeInfo_3Name)
	end 
	
	------------
	select 
		@ChargeInfo_4 = ChargeAmt,
		@ChargeInfo_4_ChargeCcy = ChargeCcy,
		@ChargeInfo_4Name = Chargecode
	 from @Table_CHARGE
	 where Chargecode = 'EC.OTHER'	 
	
	if isnull(@ChargeInfo_4Name, '') != ''
	begin
		set @ChargeInfo_4Name = (select Name_VN from dbo.BCHARGECODE where Code = @ChargeInfo_4Name)
	end 
	--------------------------------------------
	declare @TongSoTienThanhToan decimal(20,2), @TongVAT float
	select @TongSoTienThanhToan =  sum(cast(isnull(ChargeAmt,'0') as float))
	from dbo.BEXPORT_DOCUMETARYCOLLECTIONCHARGES where AmendNo = @code and Chargecode IN ('EC.AMEND', 'EC.CABLE', 'EC.COURIER', 'EC.OTHER') and TabId = @TabID
	
	set @TongVAT = @TongSoTienThanhToan * 0.1
	set @TongSoTienThanhToan += @TongVAT

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
	else if isnull(@ChargeInfo_4_ChargeCcy, '') != ''
	begin
		set @Currency = @ChargeInfo_4_ChargeCcy
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
		(select top 1 ChargeAcct from @Table_CHARGE) as DebitAccount,	
		doc.NostroCusNo as CreaditAccount,
		CONVERT(varchar, CONVERT(money, @TongVAT), 1) + ' ' + @Currency + ' PL90304' as VAT,
		case when isnull(@ChargeInfo_1, 0) > 0 then CONVERT(varchar, CONVERT(money, @ChargeInfo_1), 1) + ' ' + @ChargeInfo_1_ChargeCcy + ' PL737869' else '' end as ChargeInfo_1,
		case when isnull(@ChargeInfo_2, 0) > 0 then CONVERT(varchar, CONVERT(money, @ChargeInfo_2), 1) + ' ' + @ChargeInfo_2_ChargeCcy + ' PL837870' else '' end as ChargeInfo_2,
		case when isnull(@ChargeInfo_3, 0) > 0 then CONVERT(varchar, CONVERT(money, @ChargeInfo_3), 1) + ' ' + @ChargeInfo_3_ChargeCcy + ' PL837304' else '' end as ChargeInfo_3,
		case when isnull(@ChargeInfo_4, 0) > 0 then CONVERT(varchar, CONVERT(money, @ChargeInfo_4), 1) + ' ' + @ChargeInfo_4_ChargeCcy + ' PL837304' else '' end as ChargeInfo_4,
		
		case when isnull(@ChargeInfo_1, 0) > 0 then @ChargeInfo_1Name else '' end as ChargeName_1,
		case when isnull(@ChargeInfo_2, 0) > 0 then @ChargeInfo_2Name else '' end as ChargeName_2,
		case when isnull(@ChargeInfo_3, 0) > 0 then @ChargeInfo_3Name else '' end as ChargeName_3,	
		case when isnull(@ChargeInfo_4, 0) > 0 then @ChargeInfo_4Name else '' end as ChargeName_4	
		
		
	from dbo.BEXPORT_DOCUMETARYCOLLECTION doc
	where doc.AmendNo = @Code
END
GO

/***
---------------------------------------------------------------------------------
B_BEXPORT_DOCUMETARYCOLLECTIONCHARGES_Insert
---------------------------------------------------------------------------------
***/

IF EXISTS(SELECT * FROM sys.procedures WHERE NAME = 'B_BEXPORT_DOCUMETARYCOLLECTIONCHARGES_Insert')
BEGIN
DROP PROCEDURE [dbo].[B_BEXPORT_DOCUMETARYCOLLECTIONCHARGES_Insert]
END

GO
/****** Object:  StoredProcedure [dbo].[B_BEXPORT_DOCUMETARYCOLLECTIONCHARGES_Insert]    Script Date: 6/26/2016 11:13:24 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE Procedure [dbo].[B_BEXPORT_DOCUMETARYCOLLECTIONCHARGES_Insert] 
(
	   @DocCollectCode nvarchar(500)
      ,@WaiveCharges nvarchar(500)
      ,@Chargecode nvarchar(500)
      ,@ChargeAcct nvarchar(500)
      ,@ChargePeriod nvarchar(500)
      ,@ChargeCcy nvarchar(500)
      ,@ExchRate nvarchar(500)
      ,@ChargeAmt nvarchar(500)
      ,@PartyCharged nvarchar(500)
      ,@OmortCharges nvarchar(500)
      ,@AmtInLocalCCY nvarchar(500)
      ,@AmtDRfromAcct nvarchar(500)
      ,@ChargeStatus nvarchar(500)
      ,@ChargeRemarks nvarchar(500)
      ,@VATNo nvarchar(500)
      ,@TaxCode nvarchar(500)
      ,@TaxCcy nvarchar(500)
      ,@TaxAmt nvarchar(500)
      ,@TaxinLCCYAmt nvarchar(500)
      ,@TaxDate nvarchar(500)
      ,@Rowchages nvarchar(500)
      ,@TabId int
)
as
if not exists(select DocCollectCode from BEXPORT_DOCUMETARYCOLLECTIONCHARGES where DocCollectCode = @DocCollectCode and Rowchages = @Rowchages and (ActiveRecordFlag = 'YES' or ActiveRecordFlag is NULL))
begin
select ''
	insert into BEXPORT_DOCUMETARYCOLLECTIONCHARGES([DocCollectCode]
		  ,[WaiveCharges]
		  ,[Chargecode]
		  ,[ChargeAcct]
		  ,[ChargePeriod]
		  ,[ChargeCcy]
		  ,[ExchRate]
		  ,[ChargeAmt]
		  ,[PartyCharged]
		  ,[OmortCharges]
		  ,[AmtInLocalCCY]
		  ,[AmtDRfromAcct]
		  ,[ChargeStatus]
		  ,[ChargeRemarks]
		  ,[VATNo]
		  ,[TaxCode]
		  ,[TaxCcy]
		  ,[TaxAmt]
		  ,[TaxinLCCYAmt]
		  ,[TaxDate]
		  ,[Rowchages]
		  ,[TabId])
		  values(@DocCollectCode
		  ,@WaiveCharges
		  ,@Chargecode
		  ,@ChargeAcct
		  ,@ChargePeriod
		  ,@ChargeCcy
		  ,@ExchRate
		  ,@ChargeAmt
		  ,@PartyCharged
		  ,@OmortCharges
		  ,@AmtInLocalCCY
		  ,@AmtDRfromAcct
		  ,@ChargeStatus
		  ,@ChargeRemarks
		  ,@VATNo
		  ,@TaxCode
		  ,@TaxCcy
		  ,@TaxAmt
		  ,@TaxinLCCYAmt
		  ,@TaxDate
		  ,@Rowchages
		  ,@TabId)
      end
      else
      begin
      select ''
      update BEXPORT_DOCUMETARYCOLLECTIONCHARGES set
       [WaiveCharges] = @WaiveCharges
      ,[Chargecode] = @Chargecode
      ,[ChargeAcct] = @ChargeAcct
      ,[ChargePeriod] = @ChargePeriod
      ,[ChargeCcy] = @ChargeCcy
      ,[ExchRate] = @ExchRate
      ,[ChargeAmt] = @ChargeAmt
      ,[PartyCharged] = @PartyCharged
      ,[OmortCharges] = @OmortCharges
      ,[AmtInLocalCCY] = @AmtInLocalCCY
      ,[AmtDRfromAcct] = @AmtDRfromAcct
      ,[ChargeStatus] = @ChargeStatus
      ,[ChargeRemarks] = @ChargeRemarks
      ,[VATNo] = @VATNo
      ,[TaxCode] = @TaxCode
      ,[TaxCcy] = @TaxCcy
      ,[TaxAmt] = @TaxAmt
      ,[TaxinLCCYAmt] = @TaxinLCCYAmt
      ,[TaxDate] = @TaxDate
      ,[Rowchages] =@Rowchages
      ,[TabId]=@TabId
      where [DocCollectCode] = @DocCollectCode and Rowchages =@Rowchages
      and (ActiveRecordFlag = 'YES' or ActiveRecordFlag is NULL)
      end
GO

/***
---------------------------------------------------------------------------------
f_CurrencyToTextVn
---------------------------------------------------------------------------------
***/

IF EXISTS(SELECT * FROM Information_schema.Routines WHERE 
	Specific_schema = 'dbo'
    AND specific_name = 'f_CurrencyToTextVn'
    AND Routine_Type = 'FUNCTION')
BEGIN
DROP FUNCTION [dbo].[f_CurrencyToTextVn]
END

GO
/****** Object:  UserDefinedFunction [dbo].[f_CurrencyToTextVn]    Script Date: 6/26/2016 11:15:52 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[f_CurrencyToTextVn]
(
	@sNumber nvarchar(4000),
	@ccyCode varchar(3)
)
RETURNS nvarchar(4000) AS

BEGIN
	DECLARE @ccyName nvarchar(50);
	DECLARE @ccyPence nvarchar(250);
	DECLARE @integerNum nvarchar(4000);
	DECLARE @penceNum nvarchar(4000);
	DECLARE @result nvarchar(4000);

	select @ccyName = Vietnamese, @ccyPence = Pence from dbo.bcurrency where code = @ccyCode;
	if CHARINDEX ('.',@sNumber) > 0 
	begin
		select @integerNum = SUBSTRING(@sNumber,0,CHARINDEX ('.',@sNumber));
		select @penceNum=substring(@sNumber,CHARINDEX ('.',@sNumber) + 1,len(@sNumber)-len(@integerNum));
		select @result = REPLACE(lower(dbo.fuDocSoThanhChu(@penceNum)), '  ', ' ');
		IF @ccyCode = 'VND'
		BEGIN
			IF ISNULL(@result,'') != ''
				select @result = (REPLACE(lower(dbo.fuDocSoThanhChu(@integerNum)), '  ', ' ') + N' lẻ ' + @result + @ccyName);
			else
				select @result = (REPLACE(lower(dbo.fuDocSoThanhChu(@integerNum)), '  ', ' ') + @ccyName);
		END
		else
		BEGIN
			IF ISNULL(@result,'') != ''
				select @result = (REPLACE(lower(dbo.fuDocSoThanhChu(@integerNum)), '  ', ' ') + ' ' + @ccyName + N' và ' + @result + ' ' + isnull(@ccyPence,''));
			else
				select @result = (REPLACE(lower(dbo.fuDocSoThanhChu(@integerNum)), '  ', ' ') + ' ' + @ccyName);
		end
	end
	else
	begin
		select @result = lower(dbo.fuDocSoThanhChu(@sNumber)) + ' ' + @ccyName;
	end
	---Loai bo khoang trang thua
	while len(@result) > 0
	begin
		if charindex('  ', @result) > 0
			set @result = replace(@result, '  ', ' ')
		else
			break
	end
	set @result = ltrim(rtrim(@result))
	
	return UPPER(Left(@result, 1)) + SUBSTRING(@result,2, 4000);
END
