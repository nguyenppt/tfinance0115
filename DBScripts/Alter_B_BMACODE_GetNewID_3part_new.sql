USE [bisolutions_vvcb]
GO
/****** Object:  StoredProcedure [dbo].[B_BMACODE_GetNewID_3part_new]    Script Date: 1/8/2015 12:14:50 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



ALTER PROCEDURE [dbo].[B_BMACODE_GetNewID_3part_new]
	@MaCode varchar(50),
	@Refix varchar(10) = null,
	@Flat varchar(2) = null 
AS
BEGIN

if @Refix is null
begin
set @Refix = 'TF'
end

if @Refix is null
begin
set @Flat = '-'
end


DECLARE @MAXValue VARCHAR(10),@NEWValue VARCHAR(10),@NEW_ID VARCHAR(10);

SELECT @MAXValue=(select SoTT from BMACODE where MaCode= @MaCode )
update BMACODE set SoTT = SoTT + 1 where MaCode = @MaCode

SET @NEWValue= REPLACE(@MaxValue,'03.','')+1
SET @NEW_ID = ''+
    CASE
       WHEN LEN(@NEWValue)<4
          THEN REPLICATE('0',4-LEN(@newValue))
          ELSE ''
       END +
       @NEWValue

DECLARE @NumberOfDay int
SET @NumberOfDay = DATEDIFF(Day,CONVERT(datetime,'1/1/' + convert(nvarchar,YEAR(getdate()),103)),getdate());
DECLARE @NumberOfDayStr nvarchar(3)
SET @NumberOfDayStr = replicate('0', 3 - len(@NumberOfDay)) + cast (@NumberOfDay as varchar)

select @Refix + @Flat + CONVERT(nvarchar,right(YEAR(getdate()),2))+ @NumberOfDayStr + @Flat + @NEW_ID as Code
END


