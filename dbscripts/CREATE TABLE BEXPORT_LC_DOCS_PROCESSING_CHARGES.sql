CREATE TABLE [dbo].[BEXPORT_LC_DOCS_PROCESSING_CHARGES](
	[DocsCode] [nvarchar](50) NOT NULL,
	[ChargeCode] [nvarchar](50) NOT NULL,
	[ChargeCcy] [nvarchar](50) NULL,
	[ChargeAcc] [nvarchar](50) NULL,
	[ChargeAmt] [float] NULL,
	[PartyCharged] [nvarchar](5) NULL,
	[AmortCharge] [nvarchar](5) NULL,
	[ChargeStatus] [nvarchar](50) NULL,
	[TaxCode] [nvarchar](50) NULL,
	[TaxAmt] [float] NULL,
 CONSTRAINT [PK_BEXPORT_LC_DOCS_PROCESSING_CHARGES] PRIMARY KEY CLUSTERED 
(
	[DocsCode] ASC,
	[ChargeCode] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO


