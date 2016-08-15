USE [bisolutions_vvcb]
/***
---------------------------------------------------------------------------------
B_INCOMINGCOLLECTIONAMENDMENT_VAT_Report
---------------------------------------------------------------------------------
***/

IF EXISTS(SELECT * FROM sys.procedures WHERE NAME = 'B_INCOMINGCOLLECTIONAMENDMENT_VAT_Report')
BEGIN
DROP PROCEDURE [dbo].[B_INCOMINGCOLLECTIONAMENDMENT_VAT_Report]
END

GO
/****** Object:  StoredProcedure [dbo].[B_INCOMINGCOLLECTIONAMENDMENT_VAT_Report]    Script Date: 8/16/2016 6:21:06 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[B_INCOMINGCOLLECTIONAMENDMENT_VAT_Report]
	@Code varchar(50),
	@UserNameLogin  nvarchar(500),
	@ViewType int
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
	where CustomerID = (select DraweeCusNo from BDOCUMETARYCOLLECTION where AmendNo = @Code)
	--------------------------------------------
	declare @Table_BDOCUMETARYCOLLECTIONCHARGES as table 
	(
		[DocCollectCode] [nvarchar](50),
		[ChargeAmt] [float],
		[ChargeCcy] [nvarchar](5),
		[Chargecode] [nvarchar](50),
		[Rowchages] [nvarchar](3),
		[ViewType] [int],
		[ChargeRemarks] [nvarchar](500) ,
		[VATNo] [nvarchar](20) ,
		[ChargeAcct] [nvarchar](20) 
	)
	insert into @Table_BDOCUMETARYCOLLECTIONCHARGES
	select
		[DocCollectCode] ,
		[ChargeAmt] ,
		[ChargeCcy] ,
		[Chargecode],
		[Rowchages] ,
		[ViewType]	,
		[ChargeRemarks]	,
		[VATNo],
		[ChargeAcct]
	from dbo.BDOCUMETARYCOLLECTIONCHARGES
	where DocCollectCode = @code and [ViewType] = @ViewType
	----------------------------------------------
	declare @TongSoTienThanhToan float
	set @TongSoTienThanhToan = (select  sum(ChargeAmt) from @Table_BDOCUMETARYCOLLECTIONCHARGES)
	
			
	declare @VAT float
	set @VAT = (@TongSoTienThanhToan * 0.1)
	set @TongSoTienThanhToan = @TongSoTienThanhToan + @VAT
	
	declare @Cot9_1 float	
	declare @Cot9_2 float
	--declare @Cot9_3 float
	
	declare @Cot9_1_ChargeCcy varchar(10)	
	declare @Cot9_2_ChargeCcy varchar(10)	
	--declare @Cot9_3_ChargeCcy varchar(10)
		
	declare @Cot9_1Name nvarchar(500)	
	declare @Cot9_2Name nvarchar(500)	
	--declare @Cot9_3Name nvarchar(500)	
	
	select 
		@Cot9_1 = ChargeAmt,
		@Cot9_1_ChargeCcy = ChargeCcy,
		@Cot9_1Name = Chargecode
	 from @Table_BDOCUMETARYCOLLECTIONCHARGES
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
	 from @Table_BDOCUMETARYCOLLECTIONCHARGES
	 where Rowchages = 2
	
	if isnull(@Cot9_2Name, '') != ''
	begin
		set @Cot9_2Name = (select Name_VN from dbo.BCHARGECODE where Code = @Cot9_2Name)
	end
	------------
	--select 
	--	@Cot9_3 = ChargeAmt,
	--	@Cot9_3_ChargeCcy = ChargeCcy,
	--	@Cot9_3Name = Chargecode
	-- from @Table_BDOCUMETARYCOLLECTIONCHARGES
	-- where Rowchages = 3	 
	
	--if isnull(@Cot9_3Name, '') != ''
	--begin
	--	set @Cot9_3Name = (select Name_VN from dbo.BCHARGECODE where Code = @Cot9_3Name)
	--end 
	
	--------------------------------------------
	select @CurrentDate as CurrentDate
	select
		doc.DocCollectCode,
		(select top 1 VATNo from @Table_BDOCUMETARYCOLLECTIONCHARGES) as VATNo,
		(select top 1 ChargeAcct from @Table_BDOCUMETARYCOLLECTIONCHARGES) as  ChargeAcct,
		@UserNameLogin as UserNameLogin,
		(select top 1 ChargeRemarks from @Table_BDOCUMETARYCOLLECTIONCHARGES) as ChargeRemarks,
		doc.DraweeCusName as CustomerName,
		doc.DraweeAddr1 + ', ' +doc.DraweeAddr2 + ', ' + doc.DraweeAddr3 as CustomerAddress,
		(select IdentityNo from @TabCus) as IdentityNo,		
		doc.DraweeCusNo as CustomerID,		
		CONVERT(varchar, CONVERT(money, @VAT), 1) + ' ' + @Cot9_1_ChargeCcy + ' PL837553' as VAT,		
		--(select dbo.fuDocSoThanhChu(@TongSoTienThanhToan)) + ' ' + (select Vietnamese from dbo.BCURRENCY where Code = @Cot9_1_ChargeCcy) as SoTienBangChu,
		
		case when isnull(@Cot9_1, 0) > 0 then CONVERT(varchar, CONVERT(money, @Cot9_1), 1) + ' ' + @Cot9_1_ChargeCcy + ' PL737869' else '' end as Cot9_1,
		case when isnull(@Cot9_2, 0) > 0 then CONVERT(varchar, CONVERT(money, @Cot9_2), 1) + ' ' + @Cot9_2_ChargeCcy + ' PL837870' else '' end as Cot9_2,
		--case when isnull(@Cot9_3, 0) > 0 then CONVERT(varchar, CONVERT(money, @Cot9_3), 1) + ' ' + @Cot9_3_ChargeCcy + 'P L837124' else '' end as Cot9_3,
		
		case when isnull(@Cot9_1, 0) > 0 then @Cot9_1Name else '' end as Cot9_1Name,
		case when isnull(@Cot9_2, 0) > 0 then @Cot9_2Name else '' end as Cot9_2Name,
		--case when isnull(@Cot9_3, 0) > 0 then @Cot9_3Name else '' end as Cot9_3Name,
		
		CONVERT(varchar, CONVERT(money, @TongSoTienThanhToan), 1) + ' ' + @Cot9_1_ChargeCcy as TongSoTienThanhToan,
		
		case when @Cot9_1_ChargeCcy = 'JPY' OR @Cot9_1_ChargeCcy = 'VND' 
			then (select dbo.f_CurrencyToText(CONVERT(INT, @TongSoTienThanhToan), @Cot9_1_ChargeCcy))
			else (select dbo.f_CurrencyToText(cast(@TongSoTienThanhToan as decimal(18,2)), @Cot9_1_ChargeCcy)) end as SoTienBangChu
		
	from dbo.BDOCUMETARYCOLLECTION doc
	--inner join dbo.BDOCUMETARYCOLLECTIONCHARGES cha on cha.DocCollectCode = doc.DocCollectCode
	where doc.AmendNo = @Code --and cha.Rowchages = 1 and cha.ViewType = @ViewType
END
GO

/***
---------------------------------------------------------------------------------
B_INCOMINGCOLLECTIONACCEPTION_VAT_REPORT
---------------------------------------------------------------------------------
***/

IF EXISTS(SELECT * FROM sys.procedures WHERE NAME = 'B_INCOMINGCOLLECTIONACCEPTION_VAT_REPORT')
BEGIN
DROP PROCEDURE [dbo].[B_INCOMINGCOLLECTIONACCEPTION_VAT_REPORT]
END

GO
/****** Object:  StoredProcedure [dbo].[B_INCOMINGCOLLECTIONACCEPTION_VAT_REPORT]    Script Date: 8/16/2016 6:22:24 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create PROCEDURE [dbo].[B_INCOMINGCOLLECTIONACCEPTION_VAT_REPORT]
	@Code varchar(50),
	@UserNameLogin  nvarchar(500),
	@ViewType int
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
	where CustomerID = (select DraweeCusNo from BDOCUMETARYCOLLECTION where DocCollectCode = @Code and ISNULL(ActiveRecordFlag,'Yes') = 'Yes')
	--------------------------------------------
	declare @Table_BDOCUMETARYCOLLECTIONCHARGES as table 
	(
		[DocCollectCode] [nvarchar](50),
		[ChargeAmt] [float],
		[ChargeCcy] [nvarchar](5),
		[Chargecode] [nvarchar](50),
		[Rowchages] [nvarchar](3),
		[ViewType] [int],
		[ChargeRemarks] [nvarchar](500) ,
		[VATNo] [nvarchar](20) ,
		[ChargeAcct] [nvarchar](20) 
	)
	insert into @Table_BDOCUMETARYCOLLECTIONCHARGES
	select
		[DocCollectCode] ,
		[ChargeAmt] ,
		[ChargeCcy] ,
		[Chargecode],
		[Rowchages] ,
		[ViewType]	,
		[ChargeRemarks]	,
		[VATNo],
		[ChargeAcct]
	from dbo.BDOCUMETARYCOLLECTIONCHARGES
	where DocCollectCode = @code and [ViewType] = @ViewType
	--------------------------------------------
	declare @TongSoTienThanhToan float
	set @TongSoTienThanhToan = (select  sum(ChargeAmt) from @Table_BDOCUMETARYCOLLECTIONCHARGES)
	-------------------------------------------
			
	declare @VAT float
	set @VAT = (@TongSoTienThanhToan * 0.1)
	set @TongSoTienThanhToan = @TongSoTienThanhToan + @VAT
	
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
	 from @Table_BDOCUMETARYCOLLECTIONCHARGES
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
	 from @Table_BDOCUMETARYCOLLECTIONCHARGES
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
	 from @Table_BDOCUMETARYCOLLECTIONCHARGES
	 where Rowchages = 3	 
	
	if isnull(@Cot9_3Name, '') != ''
	begin
		set @Cot9_3Name = (select Name_VN from dbo.BCHARGECODE where Code = @Cot9_3Name)
	end
			 
	--------------------------------------------
	select @CurrentDate as CurrentDate
	select
		doc.DocCollectCode,
		(select top 1 VATNo from @Table_BDOCUMETARYCOLLECTIONCHARGES) as VATNo,
		(select top 1 ChargeAcct from @Table_BDOCUMETARYCOLLECTIONCHARGES) as  ChargeAcct,
		@UserNameLogin as UserNameLogin,
		(select top 1 ChargeRemarks from @Table_BDOCUMETARYCOLLECTIONCHARGES) as ChargeRemarks,
		doc.DraweeCusName as CustomerName,
		doc.DraweeAddr1 + ', ' +doc.DraweeAddr2 + ', ' + doc.DraweeAddr3 as CustomerAddress,
		(select IdentityNo from @TabCus) as IdentityNo,		
		doc.DraweeCusNo as CustomerID,		
		CONVERT(varchar, CONVERT(money, @VAT), 1) + ' ' + @Cot9_1_ChargeCcy + ' PL90304' as VAT,
		--(select dbo.fuDocSoThanhChu(@TongSoTienThanhToan)) + ' ' + (select Vietnamese from dbo.BCURRENCY where Code = @Cot9_1_ChargeCcy) as SoTienBangChu,
		case when @Cot9_1_ChargeCcy = 'JPY' OR @Cot9_1_ChargeCcy = 'VND' 
			then (select dbo.f_CurrencyToText(CONVERT(INT, @TongSoTienThanhToan), @Cot9_1_ChargeCcy))
			else (select dbo.f_CurrencyToText(cast(@TongSoTienThanhToan as decimal(18,2)), @Cot9_1_ChargeCcy)) end as SoTienBangChu,
		
		case when isnull(@Cot9_1, 0) > 0 then CONVERT(varchar, CONVERT(money, @Cot9_1), 1) + ' ' + @Cot9_1_ChargeCcy + ' PL737869' else '' end as Cot9_1,
		case when isnull(@Cot9_2, 0) > 0 then CONVERT(varchar, CONVERT(money, @Cot9_2), 1) + ' ' + @Cot9_2_ChargeCcy + ' PL837870' else '' end as Cot9_2,
		case when isnull(@Cot9_3, 0) > 0 then CONVERT(varchar, CONVERT(money, @Cot9_3), 1) + ' ' + @Cot9_3_ChargeCcy + 'P L837124' else '' end as Cot9_3,
		
		case when isnull(@Cot9_1, 0) > 0 then @Cot9_1Name else '' end as Cot9_1Name,
		case when isnull(@Cot9_2, 0) > 0 then @Cot9_2Name else '' end as Cot9_2Name,
		case when isnull(@Cot9_3, 0) > 0 then @Cot9_3Name else '' end as Cot9_3Name,
		
		CONVERT(varchar, CONVERT(money, @TongSoTienThanhToan), 1) + ' ' + @Cot9_1_ChargeCcy as TongSoTienThanhToan
		
	from dbo.BDOCUMETARYCOLLECTION doc
	where doc.DocCollectCode = @Code and ISNULL(doc.ActiveRecordFlag,'Yes') = 'Yes'
END
GO

/***
---------------------------------------------------------------------------------
B_INCOMINGCOLLECTIONACCEPTION_MT412_Report
---------------------------------------------------------------------------------
***/

IF EXISTS(SELECT * FROM sys.procedures WHERE NAME = 'B_INCOMINGCOLLECTIONACCEPTION_MT412_Report')
BEGIN
DROP PROCEDURE [dbo].[B_INCOMINGCOLLECTIONACCEPTION_MT412_Report]
END

GO
/****** Object:  StoredProcedure [dbo].[B_INCOMINGCOLLECTIONACCEPTION_MT412_Report]    Script Date: 8/16/2016 6:23:38 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create PROCEDURE [dbo].[B_INCOMINGCOLLECTIONACCEPTION_MT412_Report]
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
	where (DocCollectCode = @DocCollectCode and (ActiveRecordFlag is NUll or ActiveRecordFlag= 'Yes'))
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
	where mt.DocCollectCode = @DocCollectCode and (doc.ActiveRecordFlag is NUll or doc.ActiveRecordFlag= 'Yes')
END
GO
END
