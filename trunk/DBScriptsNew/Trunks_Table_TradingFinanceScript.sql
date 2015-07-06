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