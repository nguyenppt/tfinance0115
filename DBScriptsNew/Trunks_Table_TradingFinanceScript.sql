SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
---------------------------------------------------------------------------------
-- 24 June 2015 : Nghia : Add BDOCUMETARYCOLLECTIONMT412 table for internal Bug4
---------------------------------------------------------------------------------


if(Not exists(Select 1  FROM  INFORMATION_SCHEMA.COLUMNS  WHERE  TABLE_NAME = 'BDOCUMETARYCOLLECTIONMT412'))
BEGIN

CREATE TABLE [dbo].[BDOCUMETARYCOLLECTIONMT412](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[DocCollectCode] [varchar](50) NULL,
	[GeneralMT412_1] [nvarchar](500) NULL,
	[GeneralMT412_2] [nvarchar](500) NULL,
	[SendingBankTRN] [nvarchar](500) NULL,
	[RelatedReference] [nvarchar](500) NULL,
	[Currency] [varchar](50) NULL,
	[Amount] [float] NULL,
	[SenderToReceiverInfo1] [nvarchar](500) NULL,
	[SenderToReceiverInfo2] [nvarchar](500) NULL,
	[SenderToReceiverInfo3] [nvarchar](500) NULL,
 CONSTRAINT [PK_BDOCUMETARYCOLLECTIONMT412] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

END

GO

---------------------------------------------------------------------------------
-- 2 July 2015 : Nghia : Add 7 others doc to table [BEXPORT_LC_DOCS_PROCESSING] for internal Bug25
---------------------------------------------------------------------------------
print 'Alter BEXPORT_LC_DOCS_PROCESSING'

ALTER TABLE BEXPORT_LC_DOCS_PROCESSING
ADD [OtherDocs4] [nvarchar](100) NULL;
GO
ALTER TABLE BEXPORT_LC_DOCS_PROCESSING
ADD	[OtherDocs5] [nvarchar](100) NULL;
GO
ALTER TABLE BEXPORT_LC_DOCS_PROCESSING
ADD	[OtherDocs6] [nvarchar](100) NULL;
GO
ALTER TABLE BEXPORT_LC_DOCS_PROCESSING
ADD	[OtherDocs7] [nvarchar](100) NULL;
GO
ALTER TABLE BEXPORT_LC_DOCS_PROCESSING
ADD	[OtherDocs8] [nvarchar](100) NULL;
GO
ALTER TABLE BEXPORT_LC_DOCS_PROCESSING
ADD	[OtherDocs9] [nvarchar](100) NULL;
GO
ALTER TABLE BEXPORT_LC_DOCS_PROCESSING
ADD	[OtherDocs10] [nvarchar](100) NULL;
GO
ALTER TABLE BEXPORT_LC_DOCS_PROCESSING
ADD	[AcceptanceDate] date NULL;
GO
ALTER TABLE BEXPORT_LC_DOCS_PROCESSING
ADD	[MaturityDate] date NULL;
GO

---------------------------------------------------------------------------------
-- 6 July 2015 : Nghia : Add 3 remarks Bug40
---------------------------------------------------------------------------------
print 'Alter BEXPORT_DOCUMETARYCOLLECTION'

ALTER TABLE BEXPORT_DOCUMETARYCOLLECTION
ADD	[Remarks1] [nvarchar](100) NULL;
GO
ALTER TABLE BEXPORT_DOCUMETARYCOLLECTION
ADD	[Remarks2] [nvarchar](100) NULL;
GO
ALTER TABLE BEXPORT_DOCUMETARYCOLLECTION
ADD	[Remarks3] [nvarchar](100) NULL;
GO
ALTER TABLE BEXPORT_DOCUMETARYCOLLECTION
ADD	[DraweeAddr4] [nvarchar](500) NULL;
GO

---------------------------------------------------------------------------------
-- 15 Oct 2015 : Hien : Add BEXPORT_DOCS_PROCESSING_SETTLEMENT table
---------------------------------------------------------------------------------
if(Not exists(Select 1  FROM  INFORMATION_SCHEMA.COLUMNS  WHERE  TABLE_NAME = 'BEXPORT_DOCS_PROCESSING_SETTLEMENT'))
BEGIN

CREATE TABLE [dbo].[BEXPORT_DOCS_PROCESSING_SETTLEMENT](
	[Id] [uniqueidentifier] NOT NULL,
	[CollectionPaymentCode] [varchar](50) NULL,
	[DrawType] [varchar](250) NULL,
	[Currency] [varchar](50) NULL,
	[DrawingAmount] [float] NULL,
	[ValueDate] [datetime] NULL,
	[ExchRate] [float] NULL,
	[PaymentMethod] [varchar](250) NULL,
	[AmtCredited] [float] NULL,
	[PaymentRemarks1] [nvarchar](500) NULL,
	[PaymentRemarks2] [nvarchar](500) NULL,
	[PaymentRemarks3] [nvarchar](500) NULL,
	[Status] [varchar](50) NULL,
	[CreateDate] [datetime] NULL,
	[CreateBy] [nvarchar](50) NULL,
	[UpdatedDate] [datetime] NULL,
	[UpdatedBy] [nvarchar](50) NULL,
	[AuthorizedBy] [nvarchar](50) NULL,
	[AuthorizedDate] [datetime] NULL,
	[PresentorCusNo] [nvarchar](250) NULL,
	[CountryCode] [nvarchar](250) NULL,
	[PaymentNo] [bigint] NULL,
	[PaymentId] [varchar](100) NULL,
	[PaymentAmount] [float] NULL,
	[IncreaseMental] [float] NULL,
	[PaymentFullFlag] [int] NULL,
	[IncreaseMentalB4Aut] [float] NULL,
	[CreditAccount] [nvarchar](250) NULL,
	[LCType] [nvarchar] (50) NULL,
 CONSTRAINT [PK_BEXPORT_DOCS_PROCESSING_SETTLEMENT] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO

ALTER TABLE [dbo].[BEXPORT_DOCS_PROCESSING_SETTLEMENT] ADD  CONSTRAINT [DF_BEXPORT_DOCS_PROCESSING_SETTLEMENT_PaymentNo]  DEFAULT ((0)) FOR [PaymentNo]
GO

ALTER TABLE [dbo].[BEXPORT_DOCS_PROCESSING_SETTLEMENT] ADD  CONSTRAINT [DF_BEXPORT_DOCS_PROCESSING_SETTLEMENTT_PaymentFullFlag]  DEFAULT ((0)) FOR [PaymentFullFlag]
GO

---------------------------------------------------------------------------------
-- 15 Oct 2015 : Hien : Add BEXPORT_DOCS_PROCESSING_SETTLEMENT_CHARGES table
---------------------------------------------------------------------------------
if(Not exists(Select 1  FROM  INFORMATION_SCHEMA.COLUMNS  WHERE  TABLE_NAME = 'BEXPORT_DOCS_PROCESSING_SETTLEMENT_CHARGES'))
BEGIN

CREATE TABLE [dbo].[BEXPORT_DOCS_PROCESSING_SETTLEMENT_CHARGES](
	[Id] [uniqueidentifier] NOT NULL,
	[CollectionPaymentCode] [nvarchar](50) NULL,
	[WaiveCharges] [nvarchar](50) NULL,
	[Chargecode] [nvarchar](50) NULL,
	[ChargeAcct] [nvarchar](500) NULL,
	[ChargePeriod] [nvarchar](500) NULL,
	[ChargeCcy] [nvarchar](500) NULL,
	[ExchRate] [nvarchar](500) NULL,
	[ChargeAmt] [nvarchar](500) NULL,
	[PartyCharged] [nvarchar](500) NULL,
	[OmortCharges] [nvarchar](500) NULL,
	[AmtInLocalCCY] [nvarchar](500) NULL,
	[AmtDRfromAcct] [nvarchar](500) NULL,
	[ChargeStatus] [nvarchar](500) NULL,
	[ChargeRemarks] [nvarchar](500) NULL,
	[VATNo] [nvarchar](500) NULL,
	[TaxCode] [nvarchar](500) NULL,
	[TaxCcy] [nvarchar](500) NULL,
	[TaxAmt] [nvarchar](500) NULL,
	[TaxinLCCYAmt] [nvarchar](500) NULL,
	[TaxDate] [nvarchar](500) NULL,
	[Rowchages] [nvarchar](50) NULL,
 CONSTRAINT [PK_BEXPORT_DOCS_PROCESSING_SETTLEMENT_CHARGES] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

---------------------------------------------------------------------------------
-- 15 Oct 2015 : Hien : Add BEXPORT_DOCS_PROCESSING_SETTLEMENT_MT910 table
---------------------------------------------------------------------------------
if(Not exists(Select 1  FROM  INFORMATION_SCHEMA.COLUMNS  WHERE  TABLE_NAME = 'BEXPORT_DOCS_PROCESSING_SETTLEMENT_MT910'))
BEGIN

CREATE TABLE [dbo].[BEXPORT_DOCS_PROCESSING_SETTLEMENT_MT910](
	[Id] [uniqueidentifier] NOT NULL,
	[PaymentId] [nvarchar](50) NOT NULL,
	[TransactionReferenceNumber] [nvarchar](100) NULL,
	[RelatedReference] [nvarchar](100) NULL,
	[AccountIndentification] [nvarchar](500) NULL,
	[NostroAccount] [nvarchar](50) NULL,
	[ValueDate] [datetime] NULL,
	[Currency] [nvarchar](3) NULL,
	[Amount] [decimal](20, 4) NULL,
	[OrderingInstitutionName] [nvarchar](500) NULL,
	[OrderingInstitutionAddress1] [nvarchar](500) NULL,
	[OrderingInstitutionAddress2] [nvarchar](500) NULL,
	[OrderingInstitutionAddress3] [nvarchar](500) NULL,
	[IntermediaryName] [nvarchar](500) NULL,
	[IntermediaryAddress1] [nvarchar](500) NULL,
	[IntermediaryAddress2] [nvarchar](500) NULL,
	[IntermediaryAddress3] [nvarchar](500) NULL,
	[SendMessage] [nvarchar](2000) NULL,
 CONSTRAINT [PK_BEXPORT_DOCS_PROCESSING_SETTLEMENT_MT910] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO