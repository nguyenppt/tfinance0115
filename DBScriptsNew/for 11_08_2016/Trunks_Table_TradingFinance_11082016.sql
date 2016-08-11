USE [bisolutions_vvcb]


---------------------------------------------------------------------------------
-- 23 Jan 2015 : Hien : Add Accept Remark column into BEXPORT_LC_DOCS_PROCESSING table
---------------------------------------------------------------------------------
if(Not exists(Select COLUMN_NAME  FROM  INFORMATION_SCHEMA.COLUMNS  WHERE  TABLE_NAME = 'BEXPORT_LC_DOCS_PROCESSING' and COLUMN_NAME= 'AcceptRemarks'))
BEGIN
ALTER TABLE BEXPORT_LC_AMEND
ADD	[AcceptRemarks] [nvarchar] (100) NULL;
END
GO