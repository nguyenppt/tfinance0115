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
