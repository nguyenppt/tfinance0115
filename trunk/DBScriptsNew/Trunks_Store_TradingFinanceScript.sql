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