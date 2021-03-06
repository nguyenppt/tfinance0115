USE [bisolutions_vvcb]
GO
/****** Object:  StoredProcedure [dbo].[B_BMACODE_GetNewID_3par]    Script Date: 1/8/2015 12:13:44 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER PRocedure [dbo].[B_BMACODE_GetNewID_3par]
@refix nvarchar(50), @flat char(1)
 as

 BEGIN
 DECLARE @MaxValue varchar(10), @NEWValue varchar(10), @NEW_ID nvarchar(10)

 SELECT @MaxValue=( SELECT SoTT from BMACODE WHERE MaCode='CHEQUE_WITHRAWAL')
 update BMACODE set SoTT = SoTT + 1 where MaCode='CHEQUE_WITHRAWAL'

 SET @NEWValue = Replace(@MaxValue,'03.','') +1
 SET @NEW_ID = ''+
    CASE
       WHEN LEN(@NEWValue)<6
          THEN REPLICATE('0',6-LEN(@newValue))
          ELSE ''
       END +
       @NEWValue

DECLARE @NumberOfDay int
SET @NumberOfDay = DATEDIFF(Day,CONVERT(datetime,'1/1/' + convert(nvarchar,YEAR(getdate()),103)),getdate());
DECLARE @NumberOfDayStr nvarchar(3)
SET @NumberOfDayStr = replicate('0', 3 - len(@NumberOfDay)) + cast (@NumberOfDay as varchar)

select @refix + @flat + CONVERT(nvarchar,right(YEAR(getdate()),2))+ @NumberOfDayStr + @flat +  @NEW_ID as Code
END
