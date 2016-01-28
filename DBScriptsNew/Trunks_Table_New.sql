---------------------------------------------------------------------------------
-- 23 Jan 2015 : Hien : Add Currency column into BEXPORT_LC_AMEND table
---------------------------------------------------------------------------------
if(Not exists(Select COLUMN_NAME  FROM  INFORMATION_SCHEMA.COLUMNS  WHERE  TABLE_NAME = 'BEXPORT_LC_AMEND' and COLUMN_NAME= 'Currency'))
BEGIN
ALTER TABLE BEXPORT_LC_AMEND
ADD	[Currency] [nvarchar] (3) NULL;
END
GO