USE [bisolutions_vvcb]
GO
/****** Object:  StoredProcedure [dbo].[P_ExportLCPaymentReport]    Script Date: 11/10/2015 9:07:52 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER PROCEDURE [dbo].[P_ExportLCPaymentReport](
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

		set @TaiKhoanNo = (select  top 1  NostroAccount from BOUTGOINGCOLLECTIONPAYMENTMT910 where PaymentId = @PaymentId)
		set @TenTaiKhoanNo = (select  top 1  [Description] from BSWIFTCODE where AccountNo = @TaiKhoanNo)
		--set @TenTaiKhoanCo = (select  top 1  DrawerCusName + ' - ' + DrawerAddr1 + ' ' + DrawerAddr2 + ' ' + DrawerAddr3 from BEXPORT_DOCUMETARYCOLLECTION where DocCollectCode = @LCCode)
		(select  top 1  @TenTaiKhoanCo = DrawerCusName, @CollectionType = CollectionType from BEXPORT_DOCUMETARYCOLLECTION where DocCollectCode = @LCCode)

		
		select (SELECT DATEPART(d, GETDATE())) as [Day], (SELECT DATEPART(m, GETDATE())) as [Month], (SELECT DATEPART(yy, GETDATE())) as [Year],
			CollectionPaymentCode LCCode, @VATNo VATNo, @UserId CurrentUserLogin, 
			@TaiKhoanNo SoTaiKhoanNo, @TenTaiKhoanNo TenTaiKhoanNo,
			--Currency + cast(DrawingAmount AS VARCHAR) SoTienTaiKhoanNo, 
			case when Currency = 'JPY' OR Currency = 'VND' 
				then (REPLACE(CONVERT(varchar, CONVERT(money, cast((DrawingAmount + @OverseasPlus - @OverseasMinus) as decimal(18,0))), 1),'.00','') + ' ' + Currency)
				else (CONVERT(varchar, CONVERT(money, cast((DrawingAmount + @OverseasPlus - @OverseasMinus) as decimal(18,2))), 1) + ' ' + Currency) end as SoTienTaiKhoanNo,

			--REPLACE(CONVERT(varchar, CONVERT(money, cast(isnull(DrawingAmount,0) as decimal(18,2))), 1) , '.00', '')+ ' ' + Currency AS SoTienTaiKhoanNo,
			dbo.f_CurrencyToTextVn((DrawingAmount + @OverseasPlus - @OverseasMinus), Currency) SoTienTaiKhoanNoBangChu,
			--Currency + cast(DrawingAmount AS VARCHAR) SoTienTaiKhoanCo, 
			
			case when Currency = 'JPY' OR Currency = 'VND' 
				then (REPLACE(CONVERT(varchar, CONVERT(money, cast((DrawingAmount + @OverseasPlus - @OverseasMinus) as decimal(18,0))), 1),'.00','') + ' ' + Currency)
				else (CONVERT(varchar, CONVERT(money, cast((DrawingAmount + @OverseasPlus - @OverseasMinus) as decimal(18,2))), 1) + ' ' + Currency) end as SoTienTaiKhoanCo,
			
			--REPLACE(CONVERT(varchar, CONVERT(money, cast(isnull(DrawingAmount,0) as decimal(18,2))), 1), '.00', '') + ' ' + Currency AS SoTienTaiKhoanCo,

			dbo.f_CurrencyToTextVn((DrawingAmount + @OverseasPlus - @OverseasMinus), Currency) SoTienTaiKhoanCoBangChu,
			CreditAccount SoTaiKhoanCo, @TenTaiKhoanCo TenTaiKhoanCo, @CollectionType CollectionType
		from BOUTGOINGCOLLECTIONPAYMENT where PaymentId = @PaymentId
		
		return
	end
	---2 : VAT
	if @ReportType = 2
	begin
		Declare @TaiKhoanCo nvarchar(50);
		Declare @collType nvarchar(10);
		set @TaiKhoanCo = (select  top 1  CreditAccount from BOUTGOINGCOLLECTIONPAYMENT where PaymentId = @PaymentId) 
		set @TaiKhoanNo = (select  top 1  NostroAccount from BOUTGOINGCOLLECTIONPAYMENTMT910 where PaymentId = @PaymentId)
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
			@CustomerBankAcc BankAccount, @TaiKhoanNo DebitAccount, @TaiKhoanCo CreaditAccount, @VATNo VATNo,
			SUBSTRING(a.Currency,1,3) + ' ' + CONVERT(varchar, CONVERT(money, @TongSoTienThanhToan), 1) TongSoTienThanhToan, 
			dbo.f_CurrencyToTextVn(@TongSoTienThanhToan, SUBSTRING(a.Currency,1,3)) SoTienBangChu,
			SUBSTRING(a.Currency,1,3) + ' ' + CONVERT(varchar, CONVERT(money, @TongVAT), 1) + ' PL90304' VAT, @collType CollectionType
		into #tblPayment
		from BOUTGOINGCOLLECTIONPAYMENT a where PaymentId = @PaymentId
		---
		select a.*, 
			  b1.ChargeName ChargeName_1, b1.ChargeCcy + ' ' + CONVERT(varchar, CONVERT(money, (b1.ChargeAmt )) + CONVERT(money,  ISNULL(b1.TaxAmt,0)), 1) + ' ' + b1.PLAccount ChargeInfo_1
			, b2.ChargeName ChargeName_2, b2.ChargeCcy + ' ' + CONVERT(varchar, CONVERT(money, (b2.ChargeAmt )) + CONVERT(money,  ISNULL(b2.TaxAmt,0)), 1) + ' ' + b2.PLAccount ChargeInfo_2
			, b3.ChargeName ChargeName_3, b3.ChargeCcy + ' ' + CONVERT(varchar, CONVERT(money, (b3.ChargeAmt )) + CONVERT(money,  ISNULL(b3.TaxAmt,0)), 1) + ' ' + b3.PLAccount ChargeInfo_3
			, b4.ChargeName ChargeName_4, b4.ChargeCcy + ' ' + CONVERT(varchar, CONVERT(money, (b4.ChargeAmt )) + CONVERT(money,  ISNULL(b4.TaxAmt,0)), 1) + ' ' + b4.PLAccount ChargeInfo_4
		from #tblPayment a
			left join #tblCharge b1 on a.Id = b1.PaymentId and b1.ChargeTab = 'EC.CABLE' and b1.rowchages = 1--'EC.RECEIVE'
			left join #tblCharge b2 on a.Id = b2.PaymentId and b2.ChargeTab = 'EC.CABLE' and b2.rowchages = 2--'EC.COURIER'
			left join #tblCharge b3 on a.Id = b3.PaymentId and b3.ChargeTab = 'EC.OTHER'
			left join #tblCharge b4 on a.Id = b4.PaymentId and b4.ChargeTab = 'EC.PAYMENT'
		
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

		select (SELECT DATEPART(d, GETDATE())) as [Day], (SELECT DATEPART(m, GETDATE())) as [Month], (SELECT DATEPART(yy, GETDATE())) as [Year], @UserId CurrentUserLogin,
		@PaymentId DocCollectCode, @CustomerName CustomerName, @CustomerID IdentityNo, 
		@Address1 [Address], @Address2 City, @Address3 Country, @Amount Amount, @currency Currency,
		dbo.f_CurrencyToTextVn(@Amount, SUBSTRING(a.Currency,1,3)) SoTienVietBangChu
		from BOUTGOINGCOLLECTIONPAYMENT a where PaymentId = @PaymentId
	end 
end
