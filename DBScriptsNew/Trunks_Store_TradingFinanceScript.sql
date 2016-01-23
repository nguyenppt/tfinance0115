SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


/***
---------------------------------------------------------------------------------
-- 24 June 2015 : Nghia : Add Insert Script for [BDOCUMETARYCOLLECTIONMT412] table for internal Bug4
				Copy from 410
---------------------------------------------------------------------------------
***/
IF EXISTS(SELECT * FROM sys.procedures WHERE NAME = 'B_BDOCUMETARYCOLLECTIONMT412_Insert')
BEGIN
DROP PROCEDURE [dbo].[B_BDOCUMETARYCOLLECTIONMT412_Insert]
END
GO

CREATE PROCEDURE [dbo].[B_BDOCUMETARYCOLLECTIONMT412_Insert]
	@DocCollectCode varchar(50),
	@GeneralMT412_1 nvarchar(500),
	@GeneralMT412_2 nvarchar(500),
	@SendingBankTRN nvarchar(500),
	@RelatedReference nvarchar(500),
	@Currency varchar(50),
	@Amount varchar(10),
	@SenderToReceiverInfo1 nvarchar(500),
	@SenderToReceiverInfo2 nvarchar(500),
	@SenderToReceiverInfo3 nvarchar(500)
AS
BEGIN
	IF NOT EXISTS(SELECT * FROM BDOCUMETARYCOLLECTIONMT412 WHERE DocCollectCode = @DocCollectCode)
	begin
		INSERT INTO [dbo].[BDOCUMETARYCOLLECTIONMT412]
			   ([DocCollectCode]
			   ,[GeneralMT412_1]
			   ,[GeneralMT412_2]
			   ,[SendingBankTRN]
			   ,[RelatedReference]
			   ,[Currency]
			   ,[Amount]
			   , SenderToReceiverInfo1
			   , SenderToReceiverInfo2
			   , SenderToReceiverInfo3)
		 VALUES
			   (@DocCollectCode
			   ,@GeneralMT412_1
			   ,@GeneralMT412_2
			   ,@SendingBankTRN
			   ,@RelatedReference
			   ,@Currency
			   ,@Amount
			   , @SenderToReceiverInfo1
			   , @SenderToReceiverInfo2
			   , @SenderToReceiverInfo3)
	end
	else 
	begin
		UPDATE [dbo].[BDOCUMETARYCOLLECTIONMT412]
		SET [GeneralMT412_1] = @GeneralMT412_1
		  ,[GeneralMT412_2] = @GeneralMT412_2
		  ,[SendingBankTRN] = @SendingBankTRN
		  ,[RelatedReference] = @RelatedReference
		  ,[Currency] = @Currency
		  ,[Amount] = @Amount
		  , SenderToReceiverInfo1 = @SenderToReceiverInfo1
		, SenderToReceiverInfo2 = @SenderToReceiverInfo2
		, SenderToReceiverInfo3 = @SenderToReceiverInfo3
	 WHERE DocCollectCode = @DocCollectCode
	end

END
GO



/***
---------------------------------------------------------------------------------
-- 24 June 2015 : Nghia : Add Get data Script for [BDOCUMETARYCOLLECTIONMT412] table for internal Bug4
				Copy from 410
---------------------------------------------------------------------------------
***/
IF EXISTS(SELECT * FROM sys.procedures WHERE NAME = 'B_BDOCUMETARYCOLLECTIONMT412_Report')
BEGIN
DROP PROCEDURE [dbo].[B_BDOCUMETARYCOLLECTIONMT412_Report]
END
GO

CREATE PROCEDURE [dbo].[B_BDOCUMETARYCOLLECTIONMT412_Report]
	@DocCollectCode varchar(50)
AS
BEGIN
	select (select CONVERT(VARCHAR(10),GETDATE(),101)) as CurrentDate
	
	declare @RemittingBankNo nvarchar(500), @RemittingBankAddr nvarchar(250), @RemittingBankAddr2 nvarchar(500),
			@RemittingBankAddr3 nvarchar(500), @RemittingBankName nvarchar(1000), @AmendNo varchar(50)
	select @RemittingBankNo = RemittingBankNo, @RemittingBankAddr = RemittingBankAddr,
			@RemittingBankAddr2 = RemittingBankAddr2, @RemittingBankAddr3 = RemittingBankAddr3,
			@AmendNo = isnull(AmendNo, @DocCollectCode)
	from dbo.BDOCUMETARYCOLLECTION
	where DocCollectCode = @DocCollectCode and ISNULL(ActiveRecordFlag,'Yes') = 'Yes'
	------------------------------------------
	--DECLARE @Field72 NVARCHAR(4000) 
	--SELECT @Field72 = COALESCE(@Field72 + ', ', '') + 
	--	ISNULL(Datavalue, '')
	--FROM dbo.BDYNAMICCONTROLS
	--where ModuleID = 217 and DataKey = @DocCollectCode
	------------------------------------------
	IF EXISTS(SELECT SwiftCode FROM BBANKSWIFTCODE WHERE SwiftCode = @RemittingBankNo)
	begin
		set @RemittingBankName = @RemittingBankNo + ' - ' +(SELECT BankName FROM BBANKSWIFTCODE WHERE SwiftCode = @RemittingBankNo)
	end		
	
	select
		@RemittingBankNo as RemittingBankNo,
		@RemittingBankName as RemittingBankName,
		(select City from BBANKSWIFTCODE where SwiftCode  = @RemittingBankNo) as RemittingBankAddr1,
		(select Country from BBANKSWIFTCODE where SwiftCode  = @RemittingBankNo)  as RemittingBankAddr2,
		@RemittingBankAddr3 as RemittingBankAddr3,
		--@Field72 as Field72,
		SendingBankTRN,
		RelatedReference,
		Currency,
		CONVERT(varchar, CONVERT(money, Amount), 1)as Amount,
		SenderToReceiverInfo1,
		SenderToReceiverInfo2,
		SenderToReceiverInfo3
		
	from dbo.BDOCUMETARYCOLLECTIONMT412
	where DocCollectCode = @AmendNo	
	
END
GO


/***
---------------------------------------------------------------------------------
-- 24 June 2015 : Nghia : Add Get data Script for [BDOCUMETARYCOLLECTIONMT412] table for internal Bug4
				Copy from 410
---------------------------------------------------------------------------------
***/
IF EXISTS(SELECT * FROM sys.procedures WHERE NAME = 'B_INCOMINGCOLLECTIONAMENDMENT_MT412_Report')
BEGIN
DROP PROCEDURE [dbo].[B_INCOMINGCOLLECTIONAMENDMENT_MT412_Report]
END
GO
CREATE PROCEDURE [dbo].[B_INCOMINGCOLLECTIONAMENDMENT_MT412_Report]
	@DocCollectCode varchar(50)
AS
BEGIN
	select (select CONVERT(VARCHAR(10),GETDATE(),101)) as CurrentDate
	
	declare @RemittingBankNo nvarchar(500)
	declare @RemittingBankAddr nvarchar(250)
	declare @RemittingBankAddr2 nvarchar(500)
	declare @RemittingBankAddr3 nvarchar(500)

	select		
		@RemittingBankNo = RemittingBankNo,
		@RemittingBankAddr = RemittingBankAddr,
		@RemittingBankAddr2 = RemittingBankAddr2,
		@RemittingBankAddr3 = RemittingBankAddr3		
	from dbo.BDOCUMETARYCOLLECTION
	where DocCollectCode = @DocCollectCode
	------------------------------------------
	DECLARE @Field72 NVARCHAR(4000) 
	SELECT @Field72 = COALESCE(@Field72 + ', ', '') + 
		ISNULL(Datavalue, '')
	FROM dbo.BDYNAMICCONTROLS
	where ModuleID = 217 and DataKey = @DocCollectCode
	------------------------------------------
	IF EXISTS(SELECT SwiftCode FROM BBANKSWIFTCODE WHERE SwiftCode = @RemittingBankNo)
	begin
		set @RemittingBankNo = @RemittingBankNo + ' - ' +(SELECT BankName FROM BBANKSWIFTCODE WHERE SwiftCode = @RemittingBankNo)
	end		
	
	select
		@RemittingBankNo as RemittingBankName,
		@RemittingBankAddr as RemittingBankAddr1,
		@RemittingBankAddr2 as RemittingBankAddr2,
		@RemittingBankAddr3 as RemittingBankAddr3,
		@Field72 as Field72,
		SendingBankTRN,
		RelatedReference,
		Currency,
		CONVERT(varchar, CONVERT(money, Amount), 1)as Amount
		
	from dbo.BDOCUMETARYCOLLECTIONMT412
	where DocCollectCode = @DocCollectCode
	
END
GO


/***
---------------------------------------------------------------------------------
-- 24 June 2015 : Nghia : Add Get data Script for [BDOCUMETARYCOLLECTIONMT412] table for internal Bug4
				Copy from 410
---------------------------------------------------------------------------------
***/
IF EXISTS(SELECT * FROM sys.procedures WHERE NAME = 'B_INCOMINGCOLLECTIONACCEPTION_MT412_Report')
BEGIN
DROP PROCEDURE [dbo].[B_INCOMINGCOLLECTIONACCEPTION_MT412_Report]
END
GO
CREATE PROCEDURE [dbo].[B_INCOMINGCOLLECTIONACCEPTION_MT412_Report]
	@DocCollectCode varchar(50)
AS
BEGIN
	select (select CONVERT(VARCHAR(10),GETDATE(),101)) as CurrentDate
	
	declare @RemittingBankNo nvarchar(500)
	declare @RemittingBankAddr nvarchar(250)
	declare @RemittingBankAddr2 nvarchar(500)
	declare @RemittingBankAddr3 nvarchar(500)
declare @RemittingBankName nvarchar(1000)

	select		
		@RemittingBankNo = RemittingBankNo,
		@RemittingBankAddr = RemittingBankAddr,
		@RemittingBankAddr2 = RemittingBankAddr2,
		@RemittingBankAddr3 = RemittingBankAddr3		
	from dbo.BDOCUMETARYCOLLECTION
	where DocCollectCode = @DocCollectCode
	------------------------------------------
	--declare @Table_BDYNAMICCONTROLS as table
	--(
	--	RownIndex INT,
	--	ModuleID bigint,
	--	ControlID varchar(250),
	--	Datavalue nvarchar(250),
	--	DataKey varchar(250)
	--)
	--insert into @Table_BDYNAMICCONTROLS
	--select
	--	ROW_NUMBER() OVER(ORDER BY DataControlID DESC) as RownIndex,
	--	ModuleID,
	--	ControlID,
	--	Datavalue,
	--	DataKey
	--FROM dbo.BDYNAMICCONTROLS
	--where ModuleID = 281 
	--	and DataKey = @DocCollectCode
	--	and ControlID = 'txtSenderToReceiverInfo'
	--	and isnull(Datavalue, '') != ''
		
	------------------------------------------
	IF EXISTS(SELECT SwiftCode FROM BBANKSWIFTCODE WHERE SwiftCode = @RemittingBankNo)
	begin
		set @RemittingBankName = @RemittingBankNo + ' - ' +(SELECT BankName FROM BBANKSWIFTCODE WHERE SwiftCode = @RemittingBankNo)
	end		
	
	select
	@RemittingBankNo as RemittingBankNo,
		@RemittingBankName as RemittingBankName,
		(select City from BBANKSWIFTCODE where SwiftCode  = @RemittingBankNo) as RemittingBankAddr1,
		(select Country from BBANKSWIFTCODE where SwiftCode  = @RemittingBankNo)  as RemittingBankAddr2,
		@RemittingBankAddr3 as RemittingBankAddr3,
		--(select Datavalue from @Table_BDYNAMICCONTROLS where RownIndex = 1) as Field72_1,
		--(select Datavalue from @Table_BDYNAMICCONTROLS where RownIndex = 2) as Field72_2,
		--(select Datavalue from @Table_BDYNAMICCONTROLS where RownIndex = 3) as Field72_3,
		--(select Datavalue from @Table_BDYNAMICCONTROLS where RownIndex = 3) as Field72_4,
		mt.SendingBankTRN,
		mt.RelatedReference,
		mt.Currency,
		CONVERT(varchar, CONVERT(money, mt.Amount), 1)as Amount,
		case when doc.MaturityDate IS NULL OR doc.MaturityDate = '1900-01-01 00:00:00.000' 
		Then NULL ELSE (CONVERT(VARCHAR(10),doc.MaturityDate,101)) END AS MaturityDate,
		SenderToReceiverInfo1,
		SenderToReceiverInfo2,
		SenderToReceiverInfo3
		
	from dbo.BDOCUMETARYCOLLECTIONMT412 mt
	inner join dbo.BDOCUMETARYCOLLECTION doc on doc.DocCollectCode = mt.DocCollectCode
	where mt.DocCollectCode = @DocCollectCode
END
GO

/***
---------------------------------------------------------------------------------
-- 24 June 2015 : Nghia : Add Get data Script for [BDOCUMETARYCOLLECTIONMT412] table for internal Bug4
				Copy from 410
---------------------------------------------------------------------------------
***/
IF EXISTS(SELECT * FROM sys.procedures WHERE NAME = 'B_BDOCUMETARYCOLLECTION_GetByDocCollectCode')
BEGIN
DROP PROCEDURE [dbo].[B_BDOCUMETARYCOLLECTION_GetByDocCollectCode]
END
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
	where DocCollectCode = ISNULL(@AmendNo, @DocsCode) and [Rowchages] = '1' --and ViewType = @ViewType
	
	select * from dbo.BDOCUMETARYCOLLECTIONCHARGES
	where DocCollectCode = ISNULL(@AmendNo, @DocsCode) and [Rowchages] = '2' --and ViewType = @ViewType
	-- tab Charge
	
	-- tab MT410
	select 'MT410' as [Identifier],* from dbo.BDOCUMETARYCOLLECTIONMT410
	where DocCollectCode = ISNULL(@AmendNo, @DocsCode)

	-- tab MT412
	select 'MT412' as [Identifier],* from dbo.BDOCUMETARYCOLLECTIONMT412
	where DocCollectCode = @DocsCode
END
GO

/***
---------------------------------------------------------------------------------
-- 6 July 2015 : Nghia : Alter [P_BEXPORT_DOCUMETARYCOLLECTION_COVER_Report] for Bug38		"Export - Documentary Collections - Register
Format lai Cover"

---------------------------------------------------------------------------------
***/
IF EXISTS(SELECT * FROM sys.procedures WHERE NAME = 'P_BEXPORT_DOCUMETARYCOLLECTION_COVER_Report')
BEGIN
DROP PROCEDURE [dbo].[P_BEXPORT_DOCUMETARYCOLLECTION_COVER_Report]
END
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[P_BEXPORT_DOCUMETARYCOLLECTION_COVER_Report]
	@Code varchar(50),
	@UserNameLogin  nvarchar(500)
AS
BEGIN
	declare @newLine nvarchar(50)
	set @newLine = char(10)--'\f'--'\r\n'
	---
	select CONVERT(VARCHAR(10),GETDATE(),101) CurrentDate,
		CollectingBankNo + @newLine + CollectingBankName CollectingBankDetail,	
		CollectingBankName  + @newLine + CollectingBankAddr1  + @newLine + CollectingBankAddr2 + @newLine + CollectingBankAddr3  CollectingBankDetail2,		
		doc.DocCollectCode CollectionNo,
		DrawerCusName + @newLine + DrawerAddr1 + @newLine + DrawerAddr2 + @newLine + DrawerAddr3 DrawerInfo,
		DraweeCusName + @newLine + DraweeAddr1 + @newLine + DraweeAddr2 + @newLine + DraweeAddr3 + @newLine + DraweeAddr4 DraweeInfo,
		--cast(Amount as nvarchar) + ' ' + doc.Currency Amount,
		case when doc.Currency = 'JPY' OR doc.Currency = 'VND' 
				then (REPLACE(CONVERT(varchar, CONVERT(money, cast(Amount as decimal(18,0))), 1),'.00','') + ' ' + doc.Currency)
				else (CONVERT(varchar, CONVERT(money, cast(Amount as decimal(18,2))), 1) + ' ' + doc.Currency) end as Amount,
		Tenor,
		case when isnull(DocsCode1,'') <> '' then '+ ' + DocsCode1 + ' : ' + cast(NoOfOriginals1 as varchar) + ' + ' + cast(NoOfCopies1 as varchar) + ' C' + @newLine else '' end +
		case when isnull(DocsCode2,'') <> '' then '+ ' + DocsCode2 + ' : ' + cast(NoOfOriginals2 as varchar) + ' + ' + cast(NoOfCopies2 as varchar) + ' C' + @newLine else '' end +
		case when isnull(DocsCode3,'') <> '' then '+ ' + DocsCode3 + ' : ' + cast(NoOfOriginals3 as varchar) + ' + ' + cast(NoOfCopies3 as varchar) + ' C' else '' end
		DocsCode,
		case when isnull(OtherDocs,'') <> '' then '+ ' + OtherDocs else '' end OtherDocs,
		case isnull(CollectionType,'') when 'DP' then 'X' else '' end CollectionTypeDP,
		case isnull(CollectionType,'') when 'DA' then 'X' else '' end CollectionTypeDA,
		NostroCusNo,
		sw.Description NostroCusNoDesc,
		isnull(Remarks,'') + @newLine + isnull(Remarks1,'')  + @newLine + isnull(Remarks2,'')  + @newLine + isnull(Remarks3,'')  as [Remarks]
	from dbo.BEXPORT_DOCUMETARYCOLLECTION doc left join BSWIFTCODE sw on sw.Code = NostroCusNo
	where doc.DocCollectCode = @Code
END
GO

/***
---------------------------------------------------------------------------------
-- 6 July 2015 : Nghia : Alter [[B_BEXPORT_DOCUMETARYCOLLECTION_Insert]] for Bug40		"Export - Documentary Collections - Register
Field18:
Cho thêm 3 trường nữa để nhập liệu"


---------------------------------------------------------------------------------
***/
IF EXISTS(SELECT * FROM sys.procedures WHERE NAME = 'B_BEXPORT_DOCUMETARYCOLLECTION_Insert')
BEGIN
DROP PROCEDURE [dbo].[B_BEXPORT_DOCUMETARYCOLLECTION_Insert]
END
GO
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[B_BEXPORT_DOCUMETARYCOLLECTION_Insert]
	  @DocCollectCode varchar(50) 
	, @DrawerCusNo varchar(50) 
	, @DrawerCusName nvarchar(500) 
	, @DrawerAddr1 nvarchar(500) 
	, @DrawerAddr2 nvarchar(500) 
	, @DrawerAddr3 nvarchar(500) 
	, @DrawerRefNo nvarchar(500) 
	, @CollectingBankNo nvarchar(500) 
	, @CollectingBankName varchar(50) 
	, @CollectingBankAddr1 nvarchar(500) 
	, @CollectingBankAddr2 nvarchar(500) 
	, @CollectingBankAddr3 nvarchar(500) 
	, @CollectingBankAcct varchar(50) 
	, @DraweeCusNo varchar(50) 
	, @DraweeCusName nvarchar(500) 
	, @DraweeAddr1 nvarchar(500) 
	, @DraweeAddr2 nvarchar(500) 
	, @DraweeAddr3 nvarchar(500) 
	, @DraweeAddr4 nvarchar(500) 
	, @NostroCusNo nvarchar(500) 
	, @Currency varchar(50) 
	, @Amount varchar(50)  
	, @DocsReceivedDate varchar(50)  
	, @MaturityDate varchar(50)  
	, @Tenor nvarchar(250) 
	, @Days varchar(50)  
	, @TracerDate varchar(50)  
	, @ReminderDays varchar(50)  
	, @Commodity nvarchar(250) 
	, @DocsCode1 nvarchar(250) 
	, @NoOfOriginals1 varchar(50)  
	, @NoOfCopies1 varchar(50)  
	, @DocsCode2 nvarchar(250) 
	, @NoOfOriginals2 varchar(50)  
	, @NoOfCopies2 varchar(50)  
	, @DocsCode3 nvarchar(250) 
	, @NoOfOriginals3 varchar(50)  
	, @NoOfCopies3 varchar(50) 
	, @OtherDocs nvarchar(4000) 
	, @Remarks nvarchar(500) 
	, @Remarks1 nvarchar(100) 
	, @Remarks2 nvarchar(100) 
	, @Remarks3 nvarchar(100) 
	, @CurrentUserId varchar(50) 
	, @CollectionType varchar(50)
	, @CancelDate varchar(50)
	, @ContingentExpiryDate varchar(50)
	, @CancelRemark varchar(500)
	, @Accountofficer varchar(50)
	, @DocsType nvarchar(50)
	, @AcceptedlDate varchar(50)
	, @AcceptedRemark varchar(500)
	, @ScreenType varchar(50)
	
AS
BEGIN
	if not exists(select DocCollectCode from dbo.BEXPORT_DOCUMETARYCOLLECTION where DocCollectCode = @DocCollectCode)
	begin
		INSERT INTO [dbo].[BEXPORT_DOCUMETARYCOLLECTION]
			   ([DocCollectCode]
			   ,[DrawerCusNo]
			   ,[DrawerCusName]
			   ,[DrawerAddr1]
			   ,[DrawerAddr2]
			   ,[DrawerAddr3]
			   ,[DrawerRefNo]
			   ,[CollectingBankNo]
			   ,[CollectingBankName]
			   ,[CollectingBankAddr1]
			   ,[CollectingBankAddr2]
			   ,[CollectingBankAddr3]
			   ,[CollectingBankAcct]
			   ,[DraweeCusNo]
			   ,[DraweeCusName]
			   ,[DraweeAddr1]
			   ,[DraweeAddr2]
			   ,[DraweeAddr3]
			   ,[DraweeAddr4]
			   ,[NostroCusNo]
			   ,[Currency]
			   ,[Amount]
			   ,[AmountNew]
			   ,[DocsReceivedDate]
			   ,[MaturityDate]
			   ,[Tenor]
			   ,[Days]
			   ,[TracerDate]
			   ,[ReminderDays]
			   ,[Commodity]
			   ,[DocsCode1]
			   ,[NoOfOriginals1]
			   ,[NoOfCopies1]
			   ,[DocsCode2]
			   ,[NoOfOriginals2]
			   ,[NoOfCopies2]
			   ,[DocsCode3]
			   ,[NoOfOriginals3]
			   ,[NoOfCopies3]
			   ,[OtherDocs]
			   ,[Remarks]
			   ,[Remarks1]
			   ,[Remarks2]
			   ,[Remarks3]
			   ,[Status]
			   ,[CreateDate]
			   ,[CreateBy]
			   ,CollectionType
			   ,CancelDate
			   ,ContingentExpiryDate
			   ,CancelRemark
			   ,Accountofficer
			   ,DocsType
			   )
		 VALUES
			   (@DocCollectCode
				, @DrawerCusNo
				, @DrawerCusName
				, @DrawerAddr1
				, @DrawerAddr2 
				, @DrawerAddr3
				, @DrawerRefNo
				, @CollectingBankNo
				, @CollectingBankName
				, @CollectingBankAddr1
				, @CollectingBankAddr2
				, @CollectingBankAddr3
				, @CollectingBankAcct 
				, @DraweeCusNo
				, @DraweeCusName
				, @DraweeAddr1
				, @DraweeAddr2
				, @DraweeAddr3
				, @DraweeAddr4 
				, @NostroCusNo
				, @Currency
				, @Amount
				, @Amount
				, @DocsReceivedDate 
				, @MaturityDate
				, @Tenor
				, @Days
				, @TracerDate
				, @ReminderDays
				, @Commodity
				, @DocsCode1
				, @NoOfOriginals1 
				, @NoOfCopies1
				, @DocsCode2 
				, @NoOfOriginals2
				, @NoOfCopies2
				, @DocsCode3
				, @NoOfOriginals3
				, @NoOfCopies3
				, @OtherDocs 
				, @Remarks
				, @Remarks1
				, @Remarks2
				, @Remarks3
				, 'UNA'
				, getdate()
				, @CurrentUserId   
				, @CollectionType
			    , @CancelDate
			    , @ContingentExpiryDate
			    , @CancelRemark
			    , @Accountofficer
			    , case when ltrim(isnull(@DocsType,''))='' then null else @DocsType end
			)
	end
	else 
	begin
		-- get old values
		declare @Amount_old float;
		declare @Tenor_old nvarchar(250);
		declare @TracerDate_old date;
		
		select 
			@Amount_old = isnull(Amount, 0),
			@Tenor_old = Tenor,
			@TracerDate_old = TracerDate
		from [BEXPORT_DOCUMETARYCOLLECTION]
		where DocCollectCode = @DocCollectCode
		and isnull(ActiveRecordFlag,'YES')='YES'
		if @Tenor_old <> @Tenor
		begin
			UPDATE [dbo].[BEXPORT_DOCUMETARYCOLLECTION]
				set Tenor_New = @Tenor_old
			where DocCollectCode = @DocCollectCode
			and isnull(ActiveRecordFlag,'YES')='YES'
		end
		
		if CAST(@TracerDate_old AS DATE) <> CAST(@TracerDate AS DATE)
		begin
			UPDATE [dbo].[BEXPORT_DOCUMETARYCOLLECTION]
				set TracerDate_New = @TracerDate_old
			where DocCollectCode = @DocCollectCode
			and isnull(ActiveRecordFlag,'YES')='YES'
		end		
		--- update new Values
		UPDATE [dbo].[BEXPORT_DOCUMETARYCOLLECTION]
		   SET [DrawerCusNo] = @DrawerCusNo  
			  ,[DrawerCusName] = @DrawerCusName  
			  ,[DrawerAddr1] = @DrawerAddr1  
			  ,[DrawerAddr2] = @DrawerAddr2  
			  ,[DrawerAddr3] = @DrawerAddr3  
			  ,[DrawerRefNo] = @DrawerRefNo  
			  ,[CollectingBankNo] = @CollectingBankNo  
			  ,[CollectingBankName] = @CollectingBankName  
			  ,[CollectingBankAddr1] = @CollectingBankAddr1  
			  ,[CollectingBankAddr2] = @CollectingBankAddr2  
			  ,[CollectingBankAddr3] = @CollectingBankAddr3  
			  ,[CollectingBankAcct] = @CollectingBankAcct  
			  ,[DraweeCusNo] = @DraweeCusNo  
			  ,[DraweeCusName] = @DraweeCusName  
			  ,[DraweeAddr1] = @DraweeAddr1  
			  ,[DraweeAddr2] = @DraweeAddr2  
			  ,[DraweeAddr3] = @DraweeAddr3 
			  ,[DraweeAddr4] = @DraweeAddr4 
			  ,[NostroCusNo] = @NostroCusNo  
			  ,[Currency] = @Currency  
			  ,[DocsReceivedDate] = @DocsReceivedDate  
			  ,[MaturityDate] = @MaturityDate  
			  ,[Tenor] = @Tenor  
			  ,[Days] = @Days
			  ,[TracerDate] = @TracerDate  
			  ,[ReminderDays] = @ReminderDays 
			  ,[Commodity] = @Commodity  
			  ,[DocsCode1] = @DocsCode1  
			  ,[NoOfOriginals1] = @NoOfOriginals1
			  ,[NoOfCopies1] = @NoOfCopies1
			  ,[DocsCode2] = @DocsCode2  
			  ,[NoOfOriginals2] = @NoOfOriginals2 
			  ,[NoOfCopies2] = @NoOfCopies2 
			  ,[DocsCode3] = @DocsCode3  
			  ,[NoOfOriginals3] = @NoOfOriginals3
			  ,[NoOfCopies3] = @NoOfCopies3
			  ,[OtherDocs] = @OtherDocs 
			  ,[Remarks] = @Remarks  
			  ,[Remarks1] = @Remarks1  
			  ,[Remarks2] = @Remarks2  
			  ,[Remarks3] = @Remarks3  
			  ,[UpdatedDate] = getdate()  
			  ,[UpdatedBy] = @CurrentUserId 
			  , CollectionType = @CollectionType
			  , CancelDate = @CancelDate
			  , ContingentExpiryDate =  @ContingentExpiryDate
			  , CancelRemark = @CancelRemark
			  , Accountofficer=@Accountofficer
			  , AcceptedDate = @AcceptedlDate
			  , AcceptedRemarks = @AcceptedRemark
		 WHERE DocCollectCode = @DocCollectCode
		and isnull(ActiveRecordFlag,'YES')='YES';
		 if @ScreenType = 'Amend' -- Incoming Collection Amendments
		begin
			UPDATE [dbo].[BEXPORT_DOCUMETARYCOLLECTION]
			SET 
			  Amend_Status = 'UNA',
			  --AmountAut = @Amount,
			  AmountNew = @Amount
			  --Amount = 0
			WHERE DocCollectCode = @DocCollectCode
			and isnull(ActiveRecordFlag,'YES')='YES'
		end
		else if @ScreenType = 'Cancel'
		begin
			UPDATE [dbo].[BEXPORT_DOCUMETARYCOLLECTION]
			SET 
			  Cancel_Status = 'UNA'
			  --[Amount] = @Amount
			WHERE DocCollectCode = @DocCollectCode
			and isnull(ActiveRecordFlag,'YES')='YES'
		end
		else if @ScreenType = 'Acception'
		begin
			UPDATE [dbo].[BEXPORT_DOCUMETARYCOLLECTION]
			SET 
			  AcceptStatus = 'UNA'
			  --[Amount] = @Amount
			WHERE DocCollectCode = @DocCollectCode
			and isnull(ActiveRecordFlag,'YES')='YES'
		end
		else -- Register Documetary Collection
		begin
			UPDATE [dbo].[BEXPORT_DOCUMETARYCOLLECTION]
			SET 
			  [Status] = 'UNA',
			  [Amount] = @Amount,
			  AmountNew = @Amount,
			  AmountOld = 0
			WHERE DocCollectCode = @DocCollectCode
			and isnull(ActiveRecordFlag,'YES')='YES'
		end

	end
END
GO

/***
---------------------------------------------------------------------------------
-- 6 July 2015 : Nghia : Alter [[B_BEXPORT_DOCUMETARYCOLLECTION_Insert]] for Bug40		"Export - Documentary Collections - Register
Field18:
Cho thêm 3 trường nữa để nhập liệu"


---------------------------------------------------------------------------------
***/
IF EXISTS(SELECT * FROM sys.procedures WHERE NAME = 'P_ExportLCPaymentReport')
BEGIN
DROP PROCEDURE [dbo].[P_ExportLCPaymentReport]
END
GO
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
				then (REPLACE(CONVERT(varchar, CONVERT(money, cast((DrawingAmount) as decimal(18,0))), 1),'.00','') + ' ' + Currency)
				else (CONVERT(varchar, CONVERT(money, cast((DrawingAmount) as decimal(18,2))), 1) + ' ' + Currency) end as SoTienTaiKhoanNo,

			--REPLACE(CONVERT(varchar, CONVERT(money, cast(isnull(DrawingAmount,0) as decimal(18,2))), 1) , '.00', '')+ ' ' + Currency AS SoTienTaiKhoanNo,
			dbo.f_CurrencyToTextVn((DrawingAmount), Currency) SoTienTaiKhoanNoBangChu,
			--Currency + cast(DrawingAmount AS VARCHAR) SoTienTaiKhoanCo, 
			
			case when Currency = 'JPY' OR Currency = 'VND' 
				then (REPLACE(CONVERT(varchar, CONVERT(money, cast((DrawingAmount) as decimal(18,0))), 1),'.00','') + ' ' + Currency)
				else (CONVERT(varchar, CONVERT(money, cast((DrawingAmount) as decimal(18,2))), 1) + ' ' + Currency) end as SoTienTaiKhoanCo,
			
			--REPLACE(CONVERT(varchar, CONVERT(money, cast(isnull(DrawingAmount,0) as decimal(18,2))), 1), '.00', '') + ' ' + Currency AS SoTienTaiKhoanCo,

			dbo.f_CurrencyToTextVn((DrawingAmount), Currency) SoTienTaiKhoanCoBangChu,
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
			@CustomerBankAcc BankAccount, @TaiKhoanNo DebitAccount, @TaiKhoanCo CreaditAccount, @VATNo VATNo,
			SUBSTRING(a.Currency,1,3) + ' ' + CONVERT(varchar, CONVERT(money, @TongSoTienThanhToan), 1) TongSoTienThanhToan, 
			dbo.f_CurrencyToTextVn(@TongSoTienThanhToan, SUBSTRING(a.Currency,1,3)) SoTienBangChu,
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

		select (SELECT DATEPART(d, GETDATE())) as [Day], (SELECT DATEPART(m, GETDATE())) as [Month], (SELECT DATEPART(yy, GETDATE())) as [Year], @UserId CurrentUserLogin,
		@PaymentId DocCollectCode, @CustomerName CustomerName, @CustomerID IdentityNo, 
		@Address1 [Address], @Address2 City, @Address3 Country, @Amount Amount, @currency Currency,
		dbo.f_CurrencyToTextVn(@Amount, SUBSTRING(a.Currency,1,3)) SoTienVietBangChu
		from BOUTGOINGCOLLECTIONPAYMENT a where PaymentId = @PaymentId
	end 
end
GO

/***
---------------------------------------------------------------------------------
-- 15 Oct 2015 : Hien : Add Script for [P_ExportLCPaymentReport] for expport function in settlement 
---------------------------------------------------------------------------------
***/

IF EXISTS(SELECT * FROM sys.procedures WHERE NAME = 'P_ExportLCSettlementReport')
BEGIN
DROP PROCEDURE [dbo].[P_ExportLCSettlementReport]
END

GO

/****** Object:  StoredProcedure [dbo].[P_ExportLCSettlementReport]    Script Date: 14/10/2015 8:50:57 CH ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

IF EXISTS(SELECT * FROM sys.procedures WHERE NAME = 'P_ExportLCSettlementReport')
BEGIN
DROP PROCEDURE [dbo].[P_ExportLCSettlementReport]
END

GO

CREATE PROCEDURE [dbo].[P_ExportLCSettlementReport](
	@ReportType smallint,--1 : PhieuChuyenKhoan, 2 : VAT
	@PaymentId VARCHAR(50),
	@UserId varchar(50))
as
-- P_ExportLCSettlementReport 2, 'TF-14250-00149.1', 'a'
begin
	declare @DocId bigint, @VATNo varchar(50), @LCCode varchar(50)
	declare @CustomerID varchar(50), @CustomerName nvarchar(250), @CustomerIDNo varchar(50), @Address1 nvarchar(500), @Address2 nvarchar(500), @Address3 nvarchar(500), @CustomerBankAcc NVARCHAR(50), @CollectionType nvarchar(10)	
	declare @TaiKhoanNo nvarchar(50), @TenTaiKhoanNo nvarchar(max), @TenTaiKhoanCo nvarchar(max), @currency nvarchar(10)
	declare @OverseasMinus float, @OverseasPlus float, @Amount float
	---1 : PhieuChuyenKhoan
	if @ReportType = 1
	begin			
		
		select  top 1 @LCCode = CollectionPaymentCode, @currency = Currency from BEXPORT_DOCS_PROCESSING_SETTLEMENT where PaymentId = @PaymentId
		set @VATNo = (SELECT top 1 VATNo FROM BEXPORT_DOCS_PROCESSING_SETTLEMENT_CHARGES WHERE CollectionPaymentCode = @PaymentId)
		(SELECT top 1 @OverseasMinus = ChargeAmt FROM BEXPORT_DOCS_PROCESSING_SETTLEMENT_CHARGES WHERE CollectionPaymentCode = @PaymentId and Chargecode = 'ELC.OVERSEASMINUS')
		(SELECT top 1 @OverseasPlus = ChargeAmt FROM BEXPORT_DOCS_PROCESSING_SETTLEMENT_CHARGES WHERE CollectionPaymentCode = @PaymentId and Chargecode = 'ELC.OVERSEASPLUS')

		set @TaiKhoanNo = (select  top 1  NostroAccount from BEXPORT_DOCS_PROCESSING_SETTLEMENT_MT910 where PaymentId = @PaymentId)
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
		from BEXPORT_DOCS_PROCESSING_SETTLEMENT where PaymentId = @PaymentId
		
		return
	end
	---2 : VAT
	if @ReportType = 2
	begin
		Declare @TaiKhoanCo nvarchar(50);
		Declare @collType nvarchar(10);
		set @TaiKhoanCo = (select  top 1  CreditAccount from BEXPORT_DOCS_PROCESSING_SETTLEMENT where PaymentId = @PaymentId) 
		set @TaiKhoanNo = (select  top 1  NostroAccount from BEXPORT_DOCS_PROCESSING_SETTLEMENT_MT910 where PaymentId = @PaymentId)
		set @TenTaiKhoanNo = (select  top 1  [Description] from BSWIFTCODE where AccountNo = @TaiKhoanNo)
		--set @TenTaiKhoanCo = (select  top 1  DrawerCusName + ' - ' + DrawerAddr1 + ' ' + DrawerAddr2 + ' ' + DrawerAddr3 from BEXPORT_DOCUMETARYCOLLECTION where DocCollectCode = @LCCode)
		

		set @VATNo = (SELECT top 1 VATNo FROM BEXPORT_DOCS_PROCESSING_SETTLEMENT_CHARGES WHERE CollectionPaymentCode = @PaymentId)
		
		select @LCCode =  CollectionPaymentCode from BEXPORT_DOCS_PROCESSING_SETTLEMENT where PaymentId = @PaymentId
		---
		select @CustomerID = DrawerCusNo, @CustomerName = DrawerCusName, @collType = CollectionType
		from BEXPORT_DOCUMETARYCOLLECTION where DocCollectCode = @LCCode
		---
		select @CustomerIDNo = IdentityNo, @CustomerBankAcc = BankAccount, @Address1 = [Address]
		from dbo.BCUSTOMERS where CustomerID = @CustomerID
		---
		declare @TongSoTienThanhToan float, @TongVAT float
		select @TongSoTienThanhToan = sum(cast(isnull(ChargeAmt,'0') as float) + cast(isnull(TaxAmt,'0') as float)), @TongVAT = sum(cast(isnull(TaxAmt,'0') as float))
		from dbo.BEXPORT_DOCS_PROCESSING_SETTLEMENT_CHARGES where CollectionPaymentCode = @PaymentId and PartyCharged = 'A' and Chargecode NOT IN ('ELC.OVERSEASPLUS', 'ELC.OVERSEASMINUS')
		---
		select a.CollectionPaymentCode PaymentId, a.Chargecode ChargeTab, b.Name_vn ChargeName, ChargeAmt, TaxAmt, b.PLAccount, a.ChargeCcy, rowchages
		into #tblCharge
		from BEXPORT_DOCS_PROCESSING_SETTLEMENT_CHARGES a
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
		from BEXPORT_DOCS_PROCESSING_SETTLEMENT a where PaymentId = @PaymentId
		---
		select a.*, 
			  b1.ChargeName ChargeName_1, b1.ChargeCcy + ' ' + CONVERT(varchar, CONVERT(money, (b1.ChargeAmt )) + CONVERT(money,  ISNULL(b1.TaxAmt,0)), 1) + ' ' + b1.PLAccount ChargeInfo_1
			, b2.ChargeName ChargeName_2, b2.ChargeCcy + ' ' + CONVERT(varchar, CONVERT(money, (b2.ChargeAmt )) + CONVERT(money,  ISNULL(b2.TaxAmt,0)), 1) + ' ' + b2.PLAccount ChargeInfo_2
			, b3.ChargeName ChargeName_3, b3.ChargeCcy + ' ' + CONVERT(varchar, CONVERT(money, (b3.ChargeAmt )) + CONVERT(money,  ISNULL(b3.TaxAmt,0)), 1) + ' ' + b3.PLAccount ChargeInfo_3
			, b4.ChargeName ChargeName_4, b4.ChargeCcy + ' ' + CONVERT(varchar, CONVERT(money, (b4.ChargeAmt )) + CONVERT(money,  ISNULL(b4.TaxAmt,0)), 1) + ' ' + b4.PLAccount ChargeInfo_4
		from #tblPayment a
			left join #tblCharge b1 on a.Id = b1.PaymentId and b1.ChargeTab = 'ELC.CABLE' and b1.rowchages = 1--'ELC.RECEIVE'
			left join #tblCharge b2 on a.Id = b2.PaymentId and b2.ChargeTab = 'ELC.CABLE' and b2.rowchages = 2--'ELC.COURIER'
			left join #tblCharge b3 on a.Id = b3.PaymentId and b3.ChargeTab = 'ELC.OTHER'
			left join #tblCharge b4 on a.Id = b4.PaymentId and b4.ChargeTab = 'ELC.PAYMENT'
		
		return
	END

	---3: phieu xuat ngoai bang
	if @ReportType=3
	begin	
		select @LCCode =  CollectionPaymentCode from BEXPORT_DOCS_PROCESSING_SETTLEMENT where PaymentId = @PaymentId
		---
		select @CustomerID = DrawerCusNo, @CustomerName = DrawerCusName, @Address1 = DrawerAddr1, 
		@Address2 = DrawerAddr2, @Address3 = DrawerAddr3, @Amount = Amount, @currency = Currency
		from BEXPORT_DOCUMETARYCOLLECTION where DocCollectCode = @LCCode

		select (SELECT DATEPART(d, GETDATE())) as [Day], (SELECT DATEPART(m, GETDATE())) as [Month], (SELECT DATEPART(yy, GETDATE())) as [Year], @UserId CurrentUserLogin,
		@PaymentId DocCollectCode, @CustomerName CustomerName, @CustomerID IdentityNo, 
		@Address1 [Address], @Address2 City, @Address3 Country, @Amount Amount, @currency Currency,
		dbo.f_CurrencyToTextVn(@Amount, SUBSTRING(a.Currency,1,3)) SoTienVietBangChu
		from BEXPORT_DOCS_PROCESSING_SETTLEMENT a where PaymentId = @PaymentId
	end 
end
GO
/***
---------------------------------------------------------------------------------
-- 15 Oct 2015 : Hien : Add Script for [B_BDRFROMACCOUNT_GetByCusIDAndCurrency] for fix bug 83
---------------------------------------------------------------------------------
***/

IF EXISTS(SELECT * FROM sys.procedures WHERE NAME = 'B_BDRFROMACCOUNT_GetByCusIDAndCurrency')
BEGIN
DROP PROCEDURE [dbo].[B_BDRFROMACCOUNT_GetByCusIDAndCurrency]
END

GO
/****** Object:  StoredProcedure [dbo].[B_BDRFROMACCOUNT_GetByCusIDAndCurrency]    Script Date: 22/10/2015 7:56:08 SA ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[B_BDRFROMACCOUNT_GetByCusIDAndCurrency] 
	@CusId varchar(50),
	@Currency varchar(10)
AS
BEGIN
	select *,  Currency + ' - ' + Id + ' - ' + Name as Display
	from dbo.BDRFROMACCOUNT
	where [Currency] = @Currency and CustomerID = @CusId
END
GO
/***
---------------------------------------------------------------------------------
-- 15 Oct 2015 : Hien : Add Script for [P_BEXPORT_DOCUMETARYCOLLECTION_VAT_Report] for fix bug 84, 87
---------------------------------------------------------------------------------
***/

IF EXISTS(SELECT * FROM sys.procedures WHERE NAME = 'P_BEXPORT_DOCUMETARYCOLLECTION_VAT_Report')
BEGIN
DROP PROCEDURE [dbo].[P_BEXPORT_DOCUMETARYCOLLECTION_VAT_Report]
END

GO
/****** Object:  StoredProcedure [dbo].[P_BEXPORT_DOCUMETARYCOLLECTION_VAT_Report]    Script Date: 22/10/2015 2:06:15 SA ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[P_BEXPORT_DOCUMETARYCOLLECTION_VAT_Report]
	@Code varchar(50),
	@UserNameLogin  nvarchar(500),
	@Currency nvarchar(10),
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
		City nvarchar(500),
		Country nvarchar(500)
	)
	insert into @TabCus
	select CustomerName,IdentityNo, [Address],City, Country from BCUSTOMERS
	where CustomerID = (select DrawerCusNo from BEXPORT_DOCUMETARYCOLLECTION where DocCollectCode = @Code and Currency = @Currency
								and ActiveRecordFlag = 'YES'
						)
	--------------------------------------------
	declare @TongSoTienThanhToan decimal(20,2)
	set @TongSoTienThanhToan = (select  sum(ChargeAmt)
		from dbo.BEXPORT_DOCUMETARYCOLLECTIONCHARGES 
		where DocCollectCode = @Code and ChargeCcy = @Currency and TabId = @TabID and Chargecode IN ('EC.ACCEPT', 'EC.CABLE', 'EC.OTHER'))
			
	declare @VAT float
	set @VAT = (@TongSoTienThanhToan * 0.1)
	set @TongSoTienThanhToan = @TongSoTienThanhToan + @VAT
	
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
		[ChargeRemarks]	,
		[VATNo],
		[ChargeAcct]
	from dbo.BEXPORT_DOCUMETARYCOLLECTIONCHARGES
	where DocCollectCode = @Code and ChargeCcy = @Currency and TabId = @TabID;
	------------------------------------------------------
	
	declare @Cot9_1 float	
	declare @Cot9_2 float
	declare @Cot9_3 float
	
	declare @Cot9_1_ChargeCcy varchar(10)	
	declare @Cot9_2_ChargeCcy varchar(10)	
	declare @Cot9_3_ChargeCcy varchar(10)
		
	declare @Cot9_1Name nvarchar(500)	
	declare @Cot9_2Name nvarchar(500)	
	declare @Cot9_3Name nvarchar(500)	
	
	select 
		@Cot9_1 = ChargeAmt,
		@Cot9_1_ChargeCcy = ChargeCcy,
		@Cot9_1Name = Chargecode
	 from @Table_CHARGE
	 where Rowchages = 1
	
	if isnull(@Cot9_1Name, '') != ''
	begin
		set @Cot9_1Name = (select Name_VN from dbo.BCHARGECODE where Code = @Cot9_1Name)
	end 	
	------------
	select 
		@Cot9_2 = ChargeAmt,
		@Cot9_2_ChargeCcy = ChargeCcy,
		@Cot9_2Name = Chargecode
	 from @Table_CHARGE
	 where Rowchages = 2
	
	if isnull(@Cot9_2Name, '') != ''
	begin
		set @Cot9_2Name = (select Name_VN from dbo.BCHARGECODE where Code = @Cot9_2Name)
	end
	------------
	select 
		@Cot9_3 = ChargeAmt,
		@Cot9_3_ChargeCcy = ChargeCcy,
		@Cot9_3Name = Chargecode
	 from @Table_CHARGE
	 where Rowchages = 3	 
	
	if isnull(@Cot9_3Name, '') != ''
	begin
		set @Cot9_3Name = (select Name_VN from dbo.BCHARGECODE where Code = @Cot9_3Name)
	end 
	
	--------------------------------------------
	select @CurrentDate as CurrentDate
	select
		doc.DocCollectCode,
		(select top 1 VATNo from @Table_CHARGE) as VATNo,
		(select top 1 ChargeAcct from @Table_CHARGE) as  ChargeAcct,
		(select top 1 ChargeRemarks from @Table_CHARGE) as ChargeRemarks,
		Remarks,
		
		@UserNameLogin as UserNameLogin,
		doc.DrawerCusName as CustomerName,
		doc.DrawerAddr1 + ', ' +doc.DrawerAddr2 + ', ' + doc.DrawerAddr3 as CustomerAddress,
		(select IdentityNo from @TabCus) as IdentityNo,		
		doc.DrawerCusNo as CustomerID,				
		dbo.f_CurrencyToTextVn(cast(@TongSoTienThanhToan as nvarchar),@Cot9_1_ChargeCcy) as SoTienVietBangChu,
		CONVERT(varchar, CONVERT(money,@TongSoTienThanhToan), 1) as TongSoTienThanhToan,
		@Cot9_1_ChargeCcy Currency,
		CONVERT(varchar, CONVERT(money, @VAT), 1) + ' ' + @Cot9_1_ChargeCcy + ' PL90304' as VAT,
		case when isnull(@Cot9_1, 0) > 0 then CONVERT(varchar, CONVERT(money, @Cot9_1), 1) + ' ' + @Cot9_1_ChargeCcy + ' PL737869' else '' end as Cot9_1,
		case when isnull(@Cot9_2, 0) > 0 then CONVERT(varchar, CONVERT(money, @Cot9_2), 1) + ' ' + @Cot9_2_ChargeCcy + ' PL837870' else '' end as Cot9_2,
		case when isnull(@Cot9_3, 0) > 0 then CONVERT(varchar, CONVERT(money, @Cot9_3), 1) + ' ' + @Cot9_3_ChargeCcy + ' PL837304' else '' end as Cot9_3,
		
		case when isnull(@Cot9_1, 0) > 0 then @Cot9_1Name else '' end as Cot9_1Name,
		case when isnull(@Cot9_2, 0) > 0 then @Cot9_2Name else '' end as Cot9_2Name,
		case when isnull(@Cot9_3, 0) > 0 then @Cot9_3Name else '' end as Cot9_3Name	
		
		
	from dbo.BEXPORT_DOCUMETARYCOLLECTION doc
	where doc.DocCollectCode = @Code and Currency = @Currency and ActiveRecordFlag = 'YES'
END
GO

/***
---------------------------------------------------------------------------------
-- 15 Oct 2015 : Hien : Add Script for [P_BEXPORT_DOCUMETARYCOLLECTION_VAT_Register_Report]
---------------------------------------------------------------------------------
***/

IF EXISTS(SELECT * FROM sys.procedures WHERE NAME = 'P_BEXPORT_DOCUMETARYCOLLECTION_VAT_Register_Report')
BEGIN
DROP PROCEDURE [dbo].[P_BEXPORT_DOCUMETARYCOLLECTION_VAT_Register_Report]
END

GO
/****** Object:  StoredProcedure [dbo].[P_BEXPORT_DOCUMETARYCOLLECTION_VAT_Register_Report]    Script Date: 22/10/2015 2:06:15 SA ******/
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
	 where Chargecode = 'EC.CABLE'
	
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
	from dbo.BEXPORT_DOCUMETARYCOLLECTIONCHARGES where DocCollectCode = @code and Chargecode IN ('EC.CABLE', 'EC.COURIER', 'EC.OTHER')
	
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
		doc.Currency Currency,
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
GO

/***
---------------------------------------------------------------------------------
-- 15 Jan 2015 : Hien : Add Script for [B_BMACODE_GetNewID]
---------------------------------------------------------------------------------
***/

IF EXISTS(SELECT * FROM sys.procedures WHERE NAME = 'B_BMACODE_GetNewID')
BEGIN
DROP PROCEDURE [dbo].[B_BMACODE_GetNewID]
END

GO
/****** Object:  StoredProcedure [dbo].[B_BMACODE_GetNewID]    Script Date: 15/01/2015 2:06:15 SA ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[B_BMACODE_GetNewID]
	@MaCode varchar(50),
	@Refix varchar(10) = null,
	@Flat varchar(2) = null 
AS
BEGIN

if @Refix is null
begin
set @Refix = 'TF'
end

if @Refix is null
begin
set @Flat = '-'
end

if not exists(select MaCode from BMACODE where MaCode= @MaCode)
begin
	insert into BMACODE(MaCode, SoTT)
	values(@MaCode, 0)
end

DECLARE @MAXValue VARCHAR(10),@NEWValue VARCHAR(10),@NEW_ID VARCHAR(10);

SELECT @MAXValue=(select SoTT from BMACODE where MaCode= @MaCode )
update BMACODE set SoTT = SoTT + 1 where MaCode = @MaCode

SET @NEWValue= REPLACE(@MaxValue,'03.','')+1
SET @NEW_ID = ''+
    CASE
       WHEN LEN(@NEWValue)<5
          THEN REPLICATE('0',5-LEN(@newValue))
          ELSE ''
       END +
       @NEWValue

DECLARE @NumberOfDay int
--day is counted from 0 hence after getting day from system, add "1" to returned value
SET @NumberOfDay = DATEDIFF(Day,CONVERT(datetime,'1/1/' + convert(nvarchar,YEAR(getdate()),103)),getdate()) + 1;
DECLARE @NumberOfDayStr nvarchar(3)
SET @NumberOfDayStr = replicate('0', 3 - len(@NumberOfDay)) + cast (@NumberOfDay as varchar)

select @Refix + @Flat + CONVERT(nvarchar,right(YEAR(getdate()),2))+ @NumberOfDayStr + @Flat + @NEW_ID as Code
--select @Refix + @Flat + CONVERT(nvarchar,right(YEAR(getdate()),2))+CONVERT(nvarchar,DATEDIFF(Day,CONVERT(datetime,'1/1/' + convert(nvarchar,YEAR(getdate()),103)),getdate())) + @Flat + @NEW_ID as Code
END
GO

/***
---------------------------------------------------------------------------------
-- 15 Jan 2015 : Hien : Add Script for [P_BEXPORTDOCUMETARYCOLLECTION_AMEND_PHIEUNHAPNGOAIBANG_Report]
---------------------------------------------------------------------------------
***/

IF EXISTS(SELECT * FROM sys.procedures WHERE NAME = 'P_BEXPORTDOCUMETARYCOLLECTION_AMEND_PHIEUNHAPNGOAIBANG_Report')
BEGIN
DROP PROCEDURE [dbo].[P_BEXPORTDOCUMETARYCOLLECTION_AMEND_PHIEUNHAPNGOAIBANG_Report]
END

GO
/****** Object:  StoredProcedure [dbo].[P_BEXPORTDOCUMETARYCOLLECTION_AMEND_PHIEUNHAPNGOAIBANG_Report]    Script Date: 15/01/2015 2:06:15 SA ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[P_BEXPORTDOCUMETARYCOLLECTION_AMEND_PHIEUNHAPNGOAIBANG_Report]
	@Code varchar(50),
	@CurrentUserLogin nvarchar(250)
AS
BEGIN

	
	declare @CurrentDate varchar(12)
	set @CurrentDate = CONVERT(VARCHAR(10),GETDATE(),101);	
	select @CurrentDate as CurrentDate
	select e.DocCollectCode,
		@CurrentUserLogin CurrentUserLogin,
		c.CustomerName,
		c.IdentityNo,
		c.[Address],
		c.City,
		c.Country,
		e.DrawerCusNo,
		e.DraweeCusName,
		e.Currency,
		dbo.f_CurrencyToText(cast(case when Amend_Status = 'AUT' then abs(Amount - isnull(OldAmount,0))
		else  abs(isnull(OldAmount,0) - Amount) end as nvarchar(4000)),cc.Code)  SoTienVietBangChu,
		CONVERT(varchar, CONVERT(money,case when Amend_Status = 'AUT' then abs(Amount - isnull(OldAmount,0))
		else  abs(isnull(OldAmount,0) - Amount) end), 1) Amount,
	    cc.Vietnamese,
	    DATEPART(m, GETDATE()) as [Month],
	    DATEPART(d, GETDATE()) as [Day],
	    DATEPART(yy, GETDATE()) as [Year]
	from BEXPORT_DOCUMETARYCOLLECTION e
		left join BCUSTOMERS c on e.DrawerCusNo = c.CustomerID
		left Join BCURRENCY cc on cc.Code = Currency
	where (DocCollectCode = @Code Or AmendNo=@Code)
	AND (ActiveRecordFlag is null OR ActiveRecordFlag='YES')
END
GO

/***
---------------------------------------------------------------------------------
-- 15 Jan 2015 : Hien : Add Script for [B_BEXPORT_DOCUMETARYCOLLECTION_GetByAmendmentt]
---------------------------------------------------------------------------------
***/

IF EXISTS(SELECT * FROM sys.procedures WHERE NAME = 'B_BEXPORT_DOCUMETARYCOLLECTION_GetByAmendment')
BEGIN
DROP PROCEDURE [dbo].[B_BEXPORT_DOCUMETARYCOLLECTION_GetByAmendment]
END

GO
/****** Object:  StoredProcedure [dbo].[B_BEXPORT_DOCUMETARYCOLLECTION_GetByAmendment]    Script Date: 15/01/2015 2:06:15 SA ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[B_BEXPORT_DOCUMETARYCOLLECTION_GetByAmendment]
	@DocCollectCode varchar(50),
	@Drawee varchar(250),
	@DraweeAddr nvarchar(500),
	@Drawer varchar(250),
	@DraweerAddr nvarchar(500),
	@Amend_Status varchar(50),
	@currentUserId varchar(50)
AS
BEGIN
	select 
		Id, 
		DocCollectCode, 
		CollectionType, 
		Currency, 
		CONVERT(varchar, CONVERT(money, Amount), 1) as Amount, 
		[Status]
		 
	from dbo.BEXPORT_DOCUMETARYCOLLECTION
	where 
		CreateBy = @currentUserId
		AND (isnull(@DocCollectCode,'') = '' or DocCollectCode like  '%' + @DocCollectCode  + '%')
		AND (isnull(@Drawee,'') = '' or DraweeCusName like  '%' + @Drawee  + '%')
		AND (isnull(@Drawee,'') = '' or DraweeCusName like  '%' + @Drawee  + '%')
		AND (isnull(@DraweeAddr,'') = '' or 
			(DraweeAddr1 like  '%' + @DraweeAddr  + '%'
			or DraweeAddr2 like  '%' + @DraweeAddr  + '%'
			or DraweeAddr3 like  '%' + @DraweeAddr  + '%')
		)
		AND (isnull(@Drawer,'') = '' or DrawerCusNo like  '%' + @Drawer  + '%')
		AND (isnull(@DraweerAddr,'') = '' or 
			(DrawerAddr1 like  '%' + @DraweerAddr  + '%'
			or DrawerAddr2 like  '%' + @DraweerAddr  + '%'
			or DrawerAddr3 like  '%' + @DraweerAddr  + '%')
		)
		AND (UpdatedDate in (select max(UpdatedDate)
							 FROM dbo.BEXPORT_DOCUMETARYCOLLECTION GROUP BY DocCollectCode
							 )
		)
		
END
GO

/***
---------------------------------------------------------------------------------
-- 15 Jan 2015 : Hien : Add Script for [B_BCRFROMACCOUNT_GetByCurrency_Name]
---------------------------------------------------------------------------------
***/

IF EXISTS(SELECT * FROM sys.procedures WHERE NAME = 'B_BCRFROMACCOUNT_GetByCurrency_Name')
BEGIN
DROP PROCEDURE [dbo].[B_BCRFROMACCOUNT_GetByCurrency_Name]
END

GO
/****** Object:  StoredProcedure [dbo].[B_BCRFROMACCOUNT_GetByCurrency_Name]    Script Date: 15/01/2015 2:06:15 SA ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE  PROCEDURE [dbo].[B_BCRFROMACCOUNT_GetByCurrency_Name] 
	@Name varchar(50),
	@Currency varchar(10)
AS
BEGIN
	select Id, name,  Currency + ' - ' + Id + ' - ' + Name as Display
	from dbo.BCRFROMACCOUNT
	where [Currency] = @Currency and Name = @Name
	Union
	Select [ThuChiHoAccount] as Id, [Currency] + ' - ' + [ThuChiHoAccount] AS Name, [Currency] + ' - ' + [ThuChiHoAccount] AS Display
	FROM [BINTERNALBANKACCOUNT]
	WHERE /*[Currency] Not In ('VND','EUR','USD') 
    AND*/ [Currency] = @Currency

END
GO

/***
---------------------------------------------------------------------------------
-- 15 Jan 2015 : Hien : Add Script for [P_BEXPORT_DOCUMETARYCOLLECTION_VAT_Amend_Report]
---------------------------------------------------------------------------------
***/

IF EXISTS(SELECT * FROM sys.procedures WHERE NAME = 'P_BEXPORT_DOCUMETARYCOLLECTION_VAT_Amend_Report')
BEGIN
DROP PROCEDURE [dbo].[P_BEXPORT_DOCUMETARYCOLLECTION_VAT_Amend_Report]
END

GO
/****** Object:  StoredProcedure [dbo].[P_BEXPORT_DOCUMETARYCOLLECTION_VAT_Amend_Report]    Script Date: 15/01/2015 2:06:15 SA ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE  PROCEDURE [dbo].[P_BEXPORT_DOCUMETARYCOLLECTION_VAT_Amend_Report] 
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
	where AmendNo = @code;
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
	declare @TongSoTienThanhToan float, @TongVAT float
	select @TongSoTienThanhToan =  sum(cast(isnull(ChargeAmt,'0') as float) + cast(isnull(TaxAmt,'0') as float)), @TongVAT = sum(cast(isnull(TaxAmt,'0') as float))
	from dbo.BEXPORT_DOCUMETARYCOLLECTIONCHARGES where AmendNo = @code and Chargecode IN ('EC.AMEND', 'EC.CABLE', 'EC.COURIER', 'EC.OTHER')
	
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
		doc.Currency Currency,
		doc.DrawerCusNo as DebitAccount,	
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
-- 15 Jan 2015 : Hien : Add Script for [P_BEXPORT_DOCUMETARYCOLLECTION_VAT_Cancel_Report]
---------------------------------------------------------------------------------
***/

IF EXISTS(SELECT * FROM sys.procedures WHERE NAME = 'P_BEXPORT_DOCUMETARYCOLLECTION_VAT_Cancel_Report')
BEGIN
DROP PROCEDURE [dbo].[P_BEXPORT_DOCUMETARYCOLLECTION_VAT_Cancel_Report]
END

GO
/****** Object:  StoredProcedure [dbo].[P_BEXPORT_DOCUMETARYCOLLECTION_VAT_Cancel_Report]    Script Date: 15/01/2015 2:06:15 SA ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[P_BEXPORT_DOCUMETARYCOLLECTION_VAT_Cancel_Report] 
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
	 where Chargecode = 'EC.CABLE'
	
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
	 where Chargecode = 'EC.CANCEL'
	
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
	from dbo.BEXPORT_DOCUMETARYCOLLECTIONCHARGES where DocCollectCode = @code and Chargecode IN ('EC.CABLE', 'EC.CANCEL', 'EC.OTHER')
	
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
		doc.Currency Currency,
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
GO

/***
---------------------------------------------------------------------------------
-- 23 Jan 2015 : Hien : Add Script for [B_ISSURLC_GetNewID]
---------------------------------------------------------------------------------
***/

IF EXISTS(SELECT * FROM sys.procedures WHERE NAME = 'B_ISSURLC_GetNewID')
BEGIN
DROP PROCEDURE [dbo].[B_ISSURLC_GetNewID]
END

GO
/****** Object:  StoredProcedure [dbo].[B_ISSURLC_GetNewID]    Script Date: 15/01/2015 2:06:15 SA ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE  Procedure [dbo].[B_ISSURLC_GetNewID] 

as
DECLARE @MAXValue VARCHAR(10),@NEWValue VARCHAR(10),@NEW_ID VARCHAR(10);
SELECT @MAXValue=(select SoTT from BMACODE where MaCode='ISSURLC' )
update BMACODE set SoTT = SoTT + 1 where MaCode = 'ISSURLC'
SET @NEWValue= REPLACE(@MaxValue,'03.','')+1
SET @NEW_ID = ''+
    CASE
       WHEN LEN(@NEWValue)<5
          THEN REPLICATE('0',5-LEN(@newValue))
          ELSE ''
       END +
       @NEWValue
DECLARE @NumberOfDay int
SET @NumberOfDay = DATEDIFF(Day,CONVERT(datetime,'1/1/' + convert(nvarchar,YEAR(getdate()),103)),getdate()) + 1;
DECLARE @NumberOfDayStr nvarchar(3)
SET @NumberOfDayStr = replicate('0', 3 - len(@NumberOfDay)) + cast (@NumberOfDay as varchar)
--select 'TF-'+CONVERT(nvarchar,right(YEAR(getdate()),2))+CONVERT(nvarchar,DATEDIFF(Day,CONVERT(datetime,'1/1/' + convert(nvarchar,YEAR(getdate()),103)),getdate())) +'-' + @NEW_ID as Code
select 'TF-'+CONVERT(nvarchar,right(YEAR(getdate()),2))+@NumberOfDayStr +'-' + @NEW_ID as Code
GO