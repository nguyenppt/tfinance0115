CREATE TABLE [dbo].[BEXPORT_LC_DOCS_SETTLEMENT](
	[PaymentCode] [nvarchar](50) NOT NULL,
	[DocsCode] [nvarchar](50) NULL,
	[InvoiceAmount] [float] NULL,
	[ReceiveAmount] [float] NULL,
	[DeductedAmount] [float] NULL,
	[ValueDate] [date] NULL,
	[WaiveCharges] [nvarchar](3) NULL,
	[ChargeRemarks] [nvarchar](100) NULL,
	[VATNo] [nvarchar](50) NULL,
	[Status] [nvarchar](50) NULL,
	[CreateBy] [nvarchar](50) NULL,
	[CreateDate] [datetime] NULL,
	[UpdatedBy] [nvarchar](50) NULL,
	[UpdateDate] [datetime] NULL,
	[AuthorizedBy] [nvarchar](50) NULL,
	[AuthorizedDate] [datetime] NULL,
 CONSTRAINT [PK_BEXPORT_LC_DOCS_SETTLEMENT] PRIMARY KEY CLUSTERED 
(
	PaymentCode ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO


