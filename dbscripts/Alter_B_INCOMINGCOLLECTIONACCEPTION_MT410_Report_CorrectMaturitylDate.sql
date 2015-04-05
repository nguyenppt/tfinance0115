USE [bisolutions_vvcb]
GO
/****** Object:  StoredProcedure [dbo].[B_INCOMINGCOLLECTIONACCEPTION_MT410_Report]    Script Date: 4/5/2015 6:02:01 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER PROCEDURE [dbo].[B_INCOMINGCOLLECTIONACCEPTION_MT410_Report]
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
		
	from dbo.BDOCUMETARYCOLLECTIONMT410 mt
	inner join dbo.BDOCUMETARYCOLLECTION doc on doc.DocCollectCode = mt.DocCollectCode
	where mt.DocCollectCode = @DocCollectCode
END

