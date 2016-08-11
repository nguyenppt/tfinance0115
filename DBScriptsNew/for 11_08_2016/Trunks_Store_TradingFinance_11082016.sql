USE [bisolutions_vvcb]
/***
---------------------------------------------------------------------------------
B_BSWIFTCODE_GetByCode
---------------------------------------------------------------------------------
***/

IF EXISTS(SELECT * FROM sys.procedures WHERE NAME = 'B_BSWIFTCODE_GetByCode')
BEGIN
DROP PROCEDURE [dbo].[B_BSWIFTCODE_GetByCode]
END

GO
/****** Object:  StoredProcedure [dbo].[B_BSWIFTCODE_GetByCode]    Script Date: 8/11/2016 7:03:31 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[B_BSWIFTCODE_GetByCode]
	@Code varchar(50)
AS
BEGIN
	select * from dbo.BBANKSWIFTCODE where SwiftCode = @Code
END

/***
---------------------------------------------------------------------------------
B_DOCUMENTARYCOLLECTIONCANCEL_PHIEUXUATNGOAIBANG_REPORT
---------------------------------------------------------------------------------
***/
GO
IF EXISTS(SELECT * FROM sys.procedures WHERE NAME = 'B_DOCUMENTARYCOLLECTIONCANCEL_PHIEUXUATNGOAIBANG_REPORT')
BEGIN
DROP PROCEDURE [dbo].[B_DOCUMENTARYCOLLECTIONCANCEL_PHIEUXUATNGOAIBANG_REPORT]
END

GO
/****** Object:  StoredProcedure [dbo].[B_DOCUMENTARYCOLLECTIONCANCEL_PHIEUXUATNGOAIBANG_REPORT]    Script Date: 8/11/2016 7:04:31 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[B_DOCUMENTARYCOLLECTIONCANCEL_PHIEUXUATNGOAIBANG_REPORT]
	@Code varchar(50),
	@CurrentUserLogin nvarchar(250)
AS
BEGIN
	declare @CurrentDate varchar(12)
	set @CurrentDate = CONVERT(VARCHAR(10),GETDATE(),101);	
	----------------------------
	declare @TabCus  as table
	(
		CustomerName nvarchar(500),
		IdentityNo nvarchar(20),
		[Address] nvarchar(500),
		City nvarchar(500),
		Country nvarchar(500)
	)
	insert into @TabCus
	select CustomerName,IdentityNo, [Address],City, Country from BCUSTOMERS
	where CustomerID = (select DraweeCusNo from BDOCUMETARYCOLLECTION where DocCollectCode = @Code and (ActiveRecordFlag = 'YES' or ActiveRecordFlag is NULL))
	---------------------------
	declare @IncreaseMental float
	set @IncreaseMental = (select max(IncreaseMental) from dbo.BINCOMINGCOLLECTIONPAYMENT 
	where CollectionPaymentCode = @Code)
	----------------------------
	declare @totalAmt nvarchar
	set @totalAmt = (select case when isnull(@IncreaseMental,0) > 0 
								then CONVERT(varchar, CONVERT(money, (Amount - @IncreaseMental)), 1) 
								else CONVERT(varchar, CONVERT(money, Amount), 1) end
					from dbo.BDOCUMETARYCOLLECTION  where DocCollectCode = @Code and (ActiveRecordFlag = 'YES' or ActiveRecordFlag is NULL))
	-----------------------------
	select @CurrentDate as CurrentDate
	select
		DocCollectCode,
		@CurrentUserLogin as CurrentUserLogin,
		DraweeCusNo,
		DraweeCusName,
		DraweeAddr1,
		DraweeAddr2,
		DraweeAddr3,
		(select CustomerName from @TabCus) as CustomerName,
		(select IdentityNo from @TabCus) as IdentityNo,
	    (select [Address] from @TabCus) as [Address],
	    (select City from @TabCus) as City,
	    (select Country from @TabCus) as Country,
	    --CASE WHEN ISNULL(@IncreaseMental, 0) > 0 THEN (select dbo.fuDocSoThanhChu((Amount - @IncreaseMental))) ELSE (select dbo.fuDocSoThanhChu(Amount)) END SoTienVietBangChu,			
	    case when Currency = 'JPY' OR Currency = 'VND' 
			then (select dbo.f_CurrencyToText(CONVERT(INT, @totalAmt), Currency))
			else (select dbo.f_CurrencyToText(cast(@totalAmt as decimal(18,2)), Currency)) end as SoTienVietBangChu,

	    Currency,
	    @CurrentDate as CurrentDate,	    
	    --case when isnull(@IncreaseMental,0) > 0 then CONVERT(varchar, CONVERT(money, (Amount - @IncreaseMental)), 1) else CONVERT(varchar, CONVERT(money, Amount), 1) end as Amount,			
	    cast(@totalAmt as decimal(18,2)) as Amount,
	    (select Vietnamese from dbo.BCURRENCY where Code = Currency) as Vietnamese,
	    (SELECT DATEPART(m, GETDATE())) as [Month],
	    (SELECT DATEPART(d, GETDATE())) as [Day],
	    (SELECT DATEPART(yy, GETDATE())) as [Year]
	    
	from dbo.BDOCUMETARYCOLLECTION
	where DocCollectCode = @Code and (ActiveRecordFlag = 'YES' or ActiveRecordFlag is NULL)
	
END

/***
---------------------------------------------------------------------------------
B_BDOCUMETARYCOLLECTION_GetByDocCollectCode
---------------------------------------------------------------------------------
***/
GO
IF EXISTS(SELECT * FROM sys.procedures WHERE NAME = 'B_BDOCUMETARYCOLLECTION_GetByDocCollectCode')
BEGIN
DROP PROCEDURE [dbo].[B_BDOCUMETARYCOLLECTION_GetByDocCollectCode]
END

USE [bisolutions_vvcb]
GO
/****** Object:  StoredProcedure [dbo].[B_BDOCUMETARYCOLLECTION_GetByDocCollectCode]    Script Date: 8/11/2016 1:00:08 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[B_BDOCUMETARYCOLLECTION_GetByDocCollectCode] --'TF-14228-00612', 218
	@DocCollectCode varchar(50),
	@ViewType int
AS
BEGIN
	-- B_BDOCUMETARYCOLLECTION_GetByDocCollectCode 'TF-14274-00181', 218
	DECLARE @IncreaseMental float, @DocsCode VARCHAR(50), @AmendNo VARCHAR(50), @NewAmendNo VARCHAR(50)
	SET @IncreaseMental = 0
	IF @ViewType = 218--Amend
	BEGIN
		IF CHARINDEX('.', @DocCollectCode) > 0--Load detail by AmendNo
		BEGIN
			SET @DocsCode = SUBSTRING(@DocCollectCode, 1, CHARINDEX('.', @DocCollectCode)-1)
			SET @AmendNo = @DocCollectCode
			SET @NewAmendNo = ''
		END
		ELSE--Load Docs for amend
		BEGIN
			SET @DocsCode = @DocCollectCode
			--is amending ?
			SELECT @AmendNo = isnull(AmendNo, @DocsCode) from dbo.BDOCUMETARYCOLLECTION
			where DocCollectCode = @DocsCode AND ISNULL(ActiveRecordFlag,'Yes') = 'Yes' AND isnull(Amend_Status,'') = 'UNA'
			IF @AmendNo IS NULL
			BEGIN
				--create new AmendNo
				SELECT @NewAmendNo = max(ISNULL(AmendNo,'')) 
				from dbo.BDOCUMETARYCOLLECTION where DocCollectCode = @DocsCode 
				IF @NewAmendNo = ''
					SET @NewAmendNo = @DocsCode + '.1'
				ELSE
				BEGIN
					DECLARE @i BIGINT
					SET @i = CHARINDEX('.', @NewAmendNo)
					SET @NewAmendNo = @DocsCode + '.' + CAST((cast(SUBSTRING(@NewAmendNo, @i + 1, LEN(@NewAmendNo) - @i) AS BIGINT) + 1) AS VARCHAR)
				END
				--- get lastest record
				SELECT @AmendNo = isnull(AmendNo, @DocsCode) from dbo.BDOCUMETARYCOLLECTION
				where DocCollectCode = @DocsCode AND ISNULL(ActiveRecordFlag,'Yes') = 'Yes'
			END
		END
		---Load detail
		--PRINT @DocsCode + '^' + @AmendNo + '^' + @NewAmendNo
	END
	ELSE
	BEGIN
		SET @DocsCode = @DocCollectCode
		
		set @IncreaseMental = (select max(IncreaseMental) from dbo.BINCOMINGCOLLECTIONPAYMENT 
		where CollectionPaymentCode = @DocCollectCode)
		
		SELECT @AmendNo = AmendNo from dbo.BDOCUMETARYCOLLECTION
		where DocCollectCode = @DocCollectCode AND ISNULL(ActiveRecordFlag,'Yes') = 'Yes'		
	END
	
	-----------------
	select [Id],[DocCollectCode],[CollectionType],[RemittingBankNo],[RemittingBankAddr],[RemittingBankAcct],[RemittingBankRef],[DraweeType],[DraweeCusNo],
		[DraweeAddr1],[DraweeAddr2],[DraweeAddr3],[ReimbDraweeAcct],[DrawerType],[DrawerCusNo],[DrawerAddr],[Currency],[Amount],[DocsReceivedDate],[MaturityDate],
		[Tenor],[Tenor_New],[Days],[TracerDate],[TracerDate_New],[ReminderDays],[Commodity],[DocsCode1],[NoOfOriginals1],[NoOfCopies1],[DocsCode2],[NoOfOriginals2],
		[NoOfCopies2],[OtherDocs],[InstructionToCus],[Status],[CreateDate],[CreateBy],[UpdatedDate],[UpdatedBy],[AuthorizedBy],[AuthorizedDate],[DrawerAddr1],[DrawerAddr2],
		[Remarks],[CancelDate],[ContingentExpiryDate],[DrawerCusName],[DraweeCusName],[AccountOfficer],[ExpressNo],[InvoiceNo],[CancelRemark],[RemittingBankAddr2],
		[RemittingBankAddr3],[Cancel_Status],[CancelBy],[AcceptedDate],[AcceptRemarks],[Accept_Status],[AcceptBy],[AcceptByDate],[PaymentFullFlag],
		case when @NewAmendNo is null then [Amend_Status] else NULL end [Amend_Status],
		isnull(case 
			when @ViewType = 217 then isnull(Amount,0)
			when @ViewType = 218 then isnull(Amount,0)
			when @ViewType = 281 then isnull(Amount,0)
			when @ViewType = 219 then 
				case when isnull(@IncreaseMental,0) > 0 then (Amount - @IncreaseMental) else Amount end 
			end, 0) as B4_AUT_Amount, isnull(OldAmount,0) Amount_Old,
		DraftNo, @NewAmendNo NewAmendNo, AmendNo
	from dbo.BDOCUMETARYCOLLECTION
	where DocCollectCode = @DocsCode AND ISNULL(AmendNo, @DocsCode) = ISNULL(@AmendNo, @DocsCode) AND ISNULL(ActiveRecordFlag,'Yes') = 'Yes'	
	
	-- tab Charge
	select * from dbo.BDOCUMETARYCOLLECTIONCHARGES
	where DocCollectCode = ISNULL(@AmendNo, @DocsCode) and [Rowchages] = '1' and ViewType = @ViewType
	
	select * from dbo.BDOCUMETARYCOLLECTIONCHARGES
	where DocCollectCode = ISNULL(@AmendNo, @DocsCode) and [Rowchages] = '2' and ViewType = @ViewType
	-- tab Charge
	
	-- tab MT410
	select 'MT410' as [Identifier],* from dbo.BDOCUMETARYCOLLECTIONMT410
	where DocCollectCode = ISNULL(@AmendNo, @DocsCode)

	-- tab MT412
	select 'MT412' as [Identifier],* from dbo.BDOCUMETARYCOLLECTIONMT412
	where DocCollectCode = @DocsCode
END


GO