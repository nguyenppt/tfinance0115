---------------------------------------------------------------------------------
-- 23 Jan 2015 : Hien : Add Currency column into BEXPORT_LC_AMEND table
---------------------------------------------------------------------------------
if(Not exists(Select COLUMN_NAME  FROM  INFORMATION_SCHEMA.COLUMNS  WHERE  TABLE_NAME = 'BEXPORT_LC_AMEND' and COLUMN_NAME= 'Currency'))
BEGIN
ALTER TABLE BEXPORT_LC_AMEND
ADD	[Currency] [nvarchar] (3) NULL;
END
GO

---------------------------------------------------------------------------------
-- 23 Jan 2015 : Hien : Add ELC.SETTLEMENT row into BCHARGECODE table
---------------------------------------------------------------------------------
if(Not exists(Select Code  FROM BCHARGECODE where Code= 'ELC.SETTLEMENT'))
BEGIN
INSERT INTO [dbo].[BCHARGECODE]
           ([Code]
           ,[Name_EN]
           ,[Name_VN]
           ,[PLAccount]
           ,[IssueLC]
           ,[AmmendC]
           ,[CancelLC]
           ,[AcceptLC]
           ,[PaymentLC]
           ,[InformIC]
           ,[AmmendIC]
           ,[CancelIC]
           ,[AcceptIC]
           ,[PaymentIC]
           ,[AdviseELC]
           ,[AmendELC]
           ,[ConfirmELC]
           ,[CancelELC]
           ,[RejectELC]
           ,[SettlementELC]
           ,[RegisterEC]
           ,[CancelEC]
           ,[PaymentEC]
           ,[DocWithDisc]
           ,[DocWithNoDisc]
           ,[RejectedDoc]
           ,[AmendEC]
           ,[AcceptEC])
     VALUES
           ('ELC.SETTLEMENT',
            'SETTLEMENT EXPORT LC',
            'Phí thanh toán BCT nhờ thu xuất',
            'PL70044',
			null, null, null, null, null, null, null, null,
            null, null, null, null, null, null, null, null,
            null, null, null, null, null, null, null, null)
End

BEGIN
UPDATE [dbo].[BCHARGECODE]
   SET 
      [SettlementELC] = NULL
 WHERE Code = 'ELC.PAYMENT'

UPDATE [dbo].[BCHARGECODE]
   SET 
      [SettlementELC] = 'x'
 WHERE Code = 'ELC.SETTLEMENT'
END

GO