USE [bisolutions_vvcb]
GO
/****** Object:  StoredProcedure [dbo].[B_BMACODE_GetNewID_2]    Script Date: 1/8/2015 12:09:09 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[B_BMACODE_GetNewID_2]
	@refix nvarchar(100),
	@flat varchar(1)
AS
BEGIN

DECLARE @MAXValue VARCHAR(10),@NEWValue VARCHAR(10),@NEW_ID VARCHAR(10);

SELECT @MAXValue=(select SoTT from BMACODE where MaCode= 'COLL_CONTIN_ENTRY' )
update BMACODE set SoTT = SoTT + 1 where MaCode = 'COLL_CONTIN_ENTRY'

SET @NEWValue= REPLACE(@MaxValue,'03.','')+1
SET @NEW_ID = ''+
    CASE
       WHEN LEN(@NEWValue)<3
          THEN REPLICATE('0',3-LEN(@newValue))
          ELSE ''
       END +
       @NEWValue

DECLARE @NumberOfDay int
SET @NumberOfDay = DATEDIFF(Day,CONVERT(datetime,'1/1/' + convert(nvarchar,YEAR(getdate()),103)),getdate());
DECLARE @NumberOfDayStr nvarchar(3)
SET @NumberOfDayStr = replicate('0', 3 - len(@NumberOfDay)) + cast (@NumberOfDay as varchar)

select @refix + @flat + CONVERT(nvarchar,right(YEAR(getdate()),2))+ @NumberOfDayStr + '-001-963'+ '-' + @NEW_ID as Code
END
