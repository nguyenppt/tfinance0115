USE [bisolutions_vvcb]
/***
---------------------------------------------------------------------------------
B_BIMPORT_NORMAILLC_AMEND_MT707_REPORT
---------------------------------------------------------------------------------
***/

IF EXISTS(SELECT * FROM sys.procedures WHERE NAME = 'B_BIMPORT_NORMAILLC_AMEND_MT707_REPORT')
BEGIN
DROP PROCEDURE [dbo].[B_BIMPORT_NORMAILLC_AMEND_MT707_REPORT]
END

GO
/****** Object:  StoredProcedure [dbo].[B_BIMPORT_NORMAILLC_AMEND_MT707_REPORT]    Script Date: 8/17/2016 9:28:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create PROCEDURE [dbo].[B_BIMPORT_NORMAILLC_AMEND_MT707_REPORT]
	@Code VARCHAR(50)
AS
BEGIN-- [B_BIMPORT_NORMAILLC_AMEND_MT707_REPORT] 'TF-14281-00776.2'
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	-----------------------
	declare @Currency varchar(3), @Amount float, @OldAmount float, @AmendNo varchar(50)
	select @Currency = Currency, @Amount = Amount, @OldAmount = isnull(OldAmount,0), @AmendNo = isnull(AmendNo, '')
	from dbo.BIMPORT_NORMAILLC where NormalLCCode = @Code or AmendNo = @Code

	declare @SwiftCode varchar(50), @BankName nvarchar(150), @City nvarchar(50), @Country nvarchar(50)
	select @SwiftCode = SwiftCode, @BankName = BankName, @City = City, @Country = Country
	from BBANKSWIFTCODE where SwiftCode = (select ReceivingBank from dbo.BIMPORT_NORMAILLC_MT707 m707 where m707.NormalLCCode = @Code)
	-------------------------------
	declare @NumberOfAmendment varchar(50)
	set @NumberOfAmendment = substring(@AmendNo, charindex('.', @AmendNo) + 1, len(@AmendNo) - charindex('.', @AmendNo) + 1)
	-----------------------
	select CONVERT(VARCHAR(10),GETDATE(),101) as CurrentDate

	select ReceivingBank, @BankName as ReceivingBankName, @City as ReceivingBankCity, @Country as ReceivingBankCountry,
		 SenderReference, ApplicableRule, ReceiverReference, (select dbo.StripHTML(Narrative)) as Narrative,
		 SenderReceiverInfomation1, SenderReceiverInfomation2, SenderReceiverInfomation3, SenderReceiverInfomation4,
		 SenderReceiverInfomation5, SenderReceiverInfomation6, BeneficiaryType, BeneficiaryNo, BeneficiaryName,
		 BeneficiaryAddr1, BeneficiaryAddr2, BeneficiaryAddr3,		 
		 CONVERT(VARCHAR(10),DateOfIssue,101)as DateOfIssue,
		CONVERT(VARCHAR(10),DateOfAmendment,101)as DateOfAmendment,
		CONVERT(varchar, CONVERT(money, @Amount), 1) as NewDocCreditAmtAftetAmount,
		@Currency as NewDocCreditAmtAftetCurrency,		
		@Currency as Field32BCurrency,		
		case when @Amount - @OldAmount > 0 then '32B: Increase of Doc Credit Amount' else '33B: Decrease of Doc Credit Amount' end as TilteField32B,
		 CONVERT(varchar, CONVERT(money, abs(@Amount - @OldAmount)), 1) as Field32BAmount,
		 CONVERT(VARCHAR(10),LatesDateOfShipment,101)as LatesDateOfShipment, 
		 ShipmentPeriod1, ShipmentPeriod2, ShipmentPeriod3, ShipmentPeriod4,  
		 @NumberOfAmendment NumberOfAmendment		 
	from dbo.BIMPORT_NORMAILLC_MT707 m707 where m707.NormalLCCode = @Code
	--abs(Amount - B4_AUT_Amount)
END

GO

/***
---------------------------------------------------------------------------------
B_BIMPORT_NORMAILLC_AMEND_PHIEUXUATNGOAIBANG_REPORT
---------------------------------------------------------------------------------
***/

IF EXISTS(SELECT * FROM sys.procedures WHERE NAME = 'B_BIMPORT_NORMAILLC_AMEND_PHIEUXUATNGOAIBANG_REPORT')
BEGIN
DROP PROCEDURE [dbo].[B_BIMPORT_NORMAILLC_AMEND_PHIEUXUATNGOAIBANG_REPORT]
END

GO
/****** Object:  StoredProcedure [dbo].[B_BIMPORT_NORMAILLC_AMEND_PHIEUXUATNGOAIBANG_REPORT]    Script Date: 8/17/2016 11:50:25 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[B_BIMPORT_NORMAILLC_AMEND_PHIEUXUATNGOAIBANG_REPORT]
	@Code varchar(50),
	@CurrentUserLogin nvarchar(250)
AS
BEGIN-- B_BIMPORT_NORMAILLC_AMEND_PHIEUXUATNGOAIBANG_REPORT 'TF-14281-00776.2', 'a'
	declare @CurrentDate varchar(12), @IdentityNo VARCHAR(50), @ApplicantId VARCHAR(50), 
		@Amount decimal(20,2), @Currency VARCHAR(3), @SoTienVietBangChu NVARCHAR(MAX), @Prov FLOAT
	set @CurrentDate = CONVERT(VARCHAR(10),GETDATE(),101);	
	
	SELECT @ApplicantId = ApplicantId, @Currency = Currency
		, @Amount = abs(Amount - isnull(OldAmount,0))--case when Amount_Old > 0 then abs(Amount - Amount_Old) else abs(Amount - B4_AUT_Amount) END
		, @Prov = ISNULL(CrTolerance,0)
	from dbo.BIMPORT_NORMAILLC where NormalLCCode = @Code or AmendNo = @Code
	
	SET @Amount = @Amount + (@Amount * @Prov/100)
	
	SET @SoTienVietBangChu = dbo.f_CurrencyToText(cast(@Amount as NVARCHAR(4000)), @Currency)
	
	SELECT @IdentityNo = b.IdentityNo
	FROM BCUSTOMERS b WHERE b.CustomerID = @ApplicantId--BCUSTOMER_INFO
	
	--------------------------------
	select @CurrentDate as CurrentDate
	select
		(SELECT DATEPART(m, GETDATE())) as [Month],
	    (SELECT DATEPART(d, GETDATE())) as [Day],
	    (SELECT DATEPART(yy, GETDATE())) as [Year],
	    @CurrentUserLogin as CurrentUserLogin,
	    NormalLCCode,
	    ApplicantName,
	    ApplicantId,
	    ApplicantAddr1,
	    ApplicantAddr2,
	    ApplicantAddr3,	   
	    Currency,
	    @IdentityNo as IdentityNo,
		@SoTienVietBangChu as SoTienVietBangChu,
		@Amount as Amount,			
	    --(select Vietnamese from dbo.BCURRENCY where Code = Currency) as Vietnamese
	    '' Vietnamese
	    
	from dbo.BIMPORT_NORMAILLC
	where NormalLCCode =  @Code or AmendNo = @Code
END

GO