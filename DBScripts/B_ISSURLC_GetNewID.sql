ALTER Procedure [dbo].[B_ISSURLC_GetNewID] 

as
DECLARE @MAXValue VARCHAR(10),@NEWValue VARCHAR(10),@NEW_ID VARCHAR(10);
SELECT @MAXValue=(select SoTT from BMACODE where MaCode='ISSURLC' )
update BMACODE set SoTT = SoTT + 1 where MaCode = 'ISSURLC'
SET @NEWValue= REPLACE(@MaxValue,'03.','')+1
SET @NEW_ID = ''+
    CASE
       WHEN LEN(@NEWValue)<5
          THEN REPLICATE('0',5-LEN(@newValue))
          ELSE ''
       END +
       @NEWValue
DECLARE @NumberOfDay int
SET @NumberOfDay = DATEDIFF(Day,CONVERT(datetime,'1/1/' + convert(nvarchar,YEAR(getdate()),103)),getdate());
DECLARE @NumberOfDayStr nvarchar(3)
SET @NumberOfDayStr = replicate('0', 3 - len(@NumberOfDay)) + cast (@NumberOfDay as varchar)
--select 'TF-'+CONVERT(nvarchar,right(YEAR(getdate()),2))+CONVERT(nvarchar,DATEDIFF(Day,CONVERT(datetime,'1/1/' + convert(nvarchar,YEAR(getdate()),103)),getdate())) +'-' + @NEW_ID as Code
select 'TF-'+CONVERT(nvarchar,right(YEAR(getdate()),2))+@NumberOfDayStr +'-' + @NEW_ID as Code