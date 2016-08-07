USE [bisolutions_vvcb]

/***
---------------------------------------------------------------------------------
f_Num2TextVn
---------------------------------------------------------------------------------
***/
IF EXISTS ( SELECT  1
            FROM    Information_schema.Routines
            WHERE   Specific_schema = 'dbo'
                    AND specific_name = 'f_Num2TextVn'
                    AND Routine_Type = 'FUNCTION' ) 
BEGIN
DROP FUNCTION [dbo].[f_Num2TextVn]
END

GO
/****** Object:  UserDefinedFunction [dbo].[f_Num2TextVn]    Script Date: 8/7/2016 4:42:25 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[f_Num2TextVn](@sNumber nvarchar(4000))
RETURNS nvarchar(4000) AS
BEGIN
--DECLARE @sNumber nvarchar(4000)
DECLARE @Return nvarchar(4000)
DECLARE @mLen bigint
DECLARE @i bigint
DECLARE @mDigit bigint
DECLARE @mGroup bigint
DECLARE @mTemp nvarchar(4000)
DECLARE @mNumText nvarchar(4000)
--SELECT @sNumber=LTRIM(STR(@Number))
SELECT @mLen = Len(@sNumber)
SELECT @i=1
SELECT @mTemp=''
WHILE @i <= @mLen
BEGIN
SELECT @mDigit=SUBSTRING(@sNumber, @i, 1)
IF @mDigit=0 SELECT @mNumText=N'khong'
ELSE
BEGIN
    IF @mDigit=1 SELECT @mNumText=N'mot'
    ELSE
    IF @mDigit=2 SELECT @mNumText=N'hai'
    ELSE
    IF @mDigit=3 SELECT @mNumText=N'ba'
    ELSE
    IF @mDigit=4 SELECT @mNumText=N'bon'
    ELSE
    IF @mDigit=5 SELECT @mNumText=N'nam'
    ELSE
    IF @mDigit=6 SELECT @mNumText=N'sau'
    ELSE
    IF @mDigit=7 SELECT @mNumText=N'bay'
    ELSE
    IF @mDigit=8 SELECT @mNumText=N'tam'
    ELSE
    IF @mDigit=9 SELECT @mNumText=N'chin'
END
SELECT @mTemp = @mTemp + ' ' + @mNumText
IF (@mLen = @i) BREAK
Select @mGroup=(@mLen - @i) % 9
IF @mGroup=0
BEGIN
    SELECT @mTemp = @mTemp + N' ty'
    If SUBSTRING(@sNumber, @i + 1, 3) = N'000'
    SELECT @i = @i + 3
    If SUBSTRING(@sNumber, @i + 1, 3) = N'000'
    SELECT @i = @i + 3
    If SUBSTRING(@sNumber, @i + 1, 3) = N'000'
    SELECT @i = @i + 3
END
ELSE
IF @mGroup=6
BEGIN
    SELECT @mTemp = @mTemp + N' trieu'
    If SUBSTRING(@sNumber, @i + 1, 3) = N'000'
    SELECT @i = @i + 3
    If SUBSTRING(@sNumber, @i + 1, 3) = N'000'
    SELECT @i = @i + 3
END
ELSE
IF @mGroup=3
BEGIN
    SELECT @mTemp = @mTemp + N' nghin'
    If SUBSTRING(@sNumber, @i + 1, 3) = N'000'
    SELECT @i = @i + 3
END
ELSE
BEGIN
    Select @mGroup=(@mLen - @i) % 3
    IF @mGroup=2   
    SELECT @mTemp = @mTemp + N' tram'
    ELSE
    IF @mGroup=1
    SELECT @mTemp = @mTemp + N' muoi'  
END
SELECT @i=@i+1
END
--'Loại bỏ trường hợp x00
SELECT @mTemp = Replace(@mTemp, N'khong muoi khong', '')
--'Loại bỏ trường hợp 00x
SELECT @mTemp = Replace(@mTemp, N'khong muoi ', N'linh ')
--'Loại bỏ trường hợp x0, x>=2
SELECT @mTemp = Replace(@mTemp, N'muoi khong', N'muoi')
--'Fix trường hợp 10
SELECT @mTemp = Replace(@mTemp, N'mot muoi', N'muoi')
--'Fix trường hợp x4, x>=2
SELECT @mTemp = Replace(@mTemp, N'muoi bon', N'muoi tu')
--'Fix trường hợp x04
SELECT @mTemp = Replace(@mTemp, N'linh bon', N'linh tu')
--'Fix trường hợp x5, x>=2
SELECT @mTemp = Replace(@mTemp, N'muoi nam', N'muoi lam')
--'Fix trường hợp x1, x>=2
SELECT @mTemp = Replace(@mTemp, N'muoi mot', N'muoi mot')
--'Fix trường hợp x15
SELECT @mTemp = Replace(@mTemp, N'muoi nam', N'muoi lam')
--'Bỏ ký tự space
SELECT @mTemp = LTrim(@mTemp)
--'Ucase ký tự đầu tiên
SELECT @Return=UPPER(Left(@mTemp, 1)) + SUBSTRING(@mTemp,2, 4000)
RETURN @Return
END

GO
/***
---------------------------------------------------------------------------------
fnNumberToWords_VN
---------------------------------------------------------------------------------
***/
IF EXISTS ( SELECT  1
            FROM    Information_schema.Routines
            WHERE   Specific_schema = 'dbo'
                    AND specific_name = 'fnNumberToWords_VN'
                    AND Routine_Type = 'FUNCTION' ) 
BEGIN
DROP FUNCTION [dbo].[fnNumberToWords_VN]
END

GO
/****** Object:  UserDefinedFunction [dbo].[fnNumberToWords_VN]    Script Date: 8/7/2016 5:01:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[fnNumberToWords_VN] ( 
@Number AS BIGINT, 
@Exception AS INT)
 RETURNS NVARCHAR(MAX) AS BEGIN 
 DECLARE @Below20 TABLE (ID INT IDENTITY(0,1), Word NVARCHAR(32)) 
 DECLARE @Below100 TABLE (ID INT IDENTITY(2,1), Word NVARCHAR(32)) 
 DECLARE @Below20_VN TABLE (ID INT IDENTITY(0,1), Word NVARCHAR(32)) 
 DECLARE @BelowHundred AS NVARCHAR(MAX) INSERT @Below20 (Word) VALUES (N'khong') 
 INSERT @Below20 (Word) VALUES (N'mot') INSERT @Below20 (Word) VALUES (N'hai') 
 INSERT @Below20 (Word) VALUES (N'ba') INSERT @Below20 (Word) VALUES (N'bon') 
 INSERT @Below20 (Word) VALUES (N'nam') INSERT @Below20 (Word) VALUES (N'sau') 
 INSERT @Below20 (Word) VALUES (N'bay') INSERT @Below20 (Word) VALUES (N'tam') 
 INSERT @Below20 (Word) VALUES (N'chin') INSERT @Below20 (Word) VALUES (N'muoi') 
 INSERT @Below20 (Word) VALUES (N'muoi mot') INSERT @Below20 (Word) VALUES (N'muoi hai') 
 INSERT @Below20 (Word) VALUES (N'muoi ba') INSERT @Below20 (Word) VALUES (N'muoi bon') 
 INSERT @Below20 (Word) VALUES (N'muoi lam') INSERT @Below20 (Word) VALUES (N'muoi sau') 
 INSERT @Below20 (Word) VALUES (N'muoi bay') INSERT @Below20 (Word) VALUES (N'muoi tam') 
 INSERT @Below20 (Word) VALUES (N'muoi chin') INSERT @Below100 VALUES (N'hai muoi') 
 INSERT @Below100 VALUES (N'ba muoi') INSERT @Below100 VALUES (N'bon muoi') 
 INSERT @Below100 VALUES (N'nam muoi') INSERT @Below100 VALUES (N'sau muoi') 
 INSERT @Below100 VALUES (N'bay muoi') INSERT @Below100 VALUES (N'tam muoi') 
 INSERT @Below100 VALUES (N'chin muoi') INSERT @Below20_VN (Word) VALUES (N'khong') 
 INSERT @Below20_VN (Word) VALUES (N'mot')	
  INSERT @Below20_VN (Word) VALUES (N'hai') 
  INSERT @Below20_VN (Word) VALUES (N'ba') 
  INSERT @Below20_VN (Word) VALUES (N'tu')	
  	INSERT @Below20_VN (Word) VALUES (N'lam')

IF @Number > 99 
BEGIN SELECT @belowHundred = dbo.fnNumberToWords_VN(@Number % 100, 0) 
END 
DECLARE @NumberInWords NVARCHAR(MAX)

SET @NumberInWords = ( SELECT CASE WHEN @Number = 0 THEN '' 
WHEN @Number BETWEEN 1 AND 19 THEN ( CASE WHEN @Exception = 0 THEN (SELECT Word FROM @Below20 WHERE ID = @Number) 
ELSE (SELECT Word FROM @Below20_VN WHERE ID = @Number) END ) 
WHEN @Number BETWEEN 20 AND 99 THEN (SELECT Word FROM @Below100 
WHERE ID = @Number/10) + ' ' + dbo.fnNumberToWords_VN(@Number % 10, 1) 
WHEN @Number BETWEEN 100 AND 999 THEN (dbo.fnNumberToWords_VN(@Number / 100, 0)) + N' tram ' + ( CASE WHEN (@Number % 100) < 10 THEN N'linh ' ELSE '' END ) + @belowHundred 
WHEN @Number BETWEEN 1000 AND 999999 THEN (dbo.fnNumberToWords_VN(@Number / 1000, 0))+ N' nghin '+ dbo.fnNumberToWords_VN(@Number % 1000, 0) 
WHEN @Number BETWEEN 1000000 AND 999999999 THEN (dbo.fnNumberToWords_VN(@Number / 1000000, 0)) + N' trieu '+ dbo.fnNumberToWords_VN(@Number % 1000000, 0)
 WHEN @Number BETWEEN 1000000000 AND 999999999999 THEN (dbo.fnNumberToWords_VN(@Number / 1000000000, 0))+ N' ty '+ dbo.fnNumberToWords_VN(@Number % 1000000000, 0) ELSE N' INVALID INPUT' END ) 
 RETURN (@NumberInWords)

END
GO
/***
---------------------------------------------------------------------------------
fuDocSoThanhChu
---------------------------------------------------------------------------------
***/
IF EXISTS ( SELECT  1
            FROM    Information_schema.Routines
            WHERE   Specific_schema = 'dbo'
                    AND specific_name = 'fuDocSoThanhChu'
                    AND Routine_Type = 'FUNCTION' ) 
BEGIN
DROP FUNCTION [dbo].[fuDocSoThanhChu]
END

GO
/****** Object:  UserDefinedFunction [dbo].[fuDocSoThanhChu]    Script Date: 8/7/2016 5:02:53 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[fuDocSoThanhChu](@SoCanDoc bigint)
RETURNS nvarchar(200)
AS
BEGIN
DECLARE @DocThanhChu nvarchar(200)
DECLARE @String nvarchar(50)
IF len(@SoCanDoc)>15
BEGIN
SET @DocThanhChu=N'So qua lon, khong doc duoc'
END
ELSE
SET @String =Replace(Convert(VARCHAR,CAST(@SoCanDoc AS MONEY),1 ),'.00','')
BEGIN
DECLARE @Count int
SELECT @Count = COUNT(*) FROM dbo.SplitString(@String,',')
DECLARE @tram nvarchar(10)
DECLARE @Nghin nvarchar(10)
DECLARE @Trieu nvarchar(10)
DECLARE @ty nvarchar(10)
DECLARE @nghinty nvarchar(10)
DECLARE @trieuty nvarchar(10)
IF @Count=1
BEGIN
SET @DocThanhChu=dbo.fuDocBaSo(@SoCanDoc)
END
IF @Count=2
BEGIN
SELECT @Nghin=part FROM dbo.SplitString(@String,',') WHERE id=1
SELECT @tram=part FROM dbo.SplitString(@String,',') WHERE id=2
SET @DocThanhChu=dbo.fuDocBaSo(@Nghin)+N' nghin '+ dbo.fuDocBaSo_Ben(@tram)
END
IF @Count=3
BEGIN
SELECT @Trieu=part FROM dbo.SplitString(@String,',') WHERE id=1
SELECT @Nghin=part FROM dbo.SplitString(@String,',') WHERE id=2
SELECT @tram = part FROM dbo.SplitString(@String,',') WHERE id=3
IF Cast(@Nghin as int)>0
BEGIN
IF Cast(@tram as int)>0
BEGIN
SET @DocThanhChu=dbo.fuDocBaSo(@Trieu) +N' trieu' + 
dbo.fuDocBaSo_Ben(@Nghin) + N' nghin'+ dbo.fuDocBaSo_Ben(@tram)
END
ELSE
BEGIN
SET @DocThanhChu=dbo.fuDocBaSo(@Trieu) +N' trieu' + 
dbo.fuDocBaSo_Ben(@Nghin) + N' nghin'
END
End 
ELSE
BEGIN
if Cast(@tram as int) =0
SET @DocThanhChu=dbo.fuDocBaSo(@Trieu) +N' trieu'
else
SET @DocThanhChu=dbo.fuDocBaSo(@Trieu) +N' trieu' + 
dbo.fuDocBaSo_Ben(@tram)
END
END
IF @Count=4
BEGIN
SELECT @ty=part FROM dbo.SplitString(@String,',') WHERE id=1
SELECT @Trieu=part FROM dbo.SplitString(@String,',') WHERE id=2
SELECT @Nghin=part FROM dbo.SplitString(@String,',') WHERE id=3
SELECT @tram = part FROM dbo.SplitString(@String,',') WHERE id=4
if cast(@Trieu as int)>0
BEGIN
IF cast(@Nghin as int)>0
BEGIN
if cast(@tram as int)>0
BEGIN
SET @DocThanhChu=dbo.fuDocBaSo(@ty) +N' ty' 
+ dbo.fuDocBaSo_Ben(@Trieu) + N' trieu '
+ dbo.fuDocBaSo_Ben(@Nghin) + N' nghin ' 
+ dbo.fuDocBaSo_Ben(@tram)
END
else
BEGIN
SET @DocThanhChu=dbo.fuDocBaSo(@ty) +N' ty' 
+ dbo.fuDocBaSo_Ben(@Trieu) + N' trieu'
+ dbo.fuDocBaSo_Ben(@Nghin) + N' nghin' 
END
END
ELSE
BEGIN
IF cast(@tram as int)>0
BEGIN
SET @DocThanhChu=dbo.fuDocBaSo(@ty) +N' ty' 
+ dbo.fuDocBaSo_Ben(@Trieu) + N' trieu '
+ dbo.fuDocBaSo_Ben(@Nghin) + N' nghin ' 
+ dbo.fuDocBaSo_Ben(@tram)
END
ELSE
BEGIN
SET @DocThanhChu=dbo.fuDocBaSo(@ty) +N' ty' 
+ dbo.fuDocBaSo_Ben(@Trieu) + N' trieu '
END
END
END 
ELSE
BEGIN
if cast(@Nghin as int)>0
BEGIN
if Cast(@tram as int)>0
BEGIN
SET @DocThanhChu=dbo.fuDocBaSo(@ty) +N' ty' 
+ dbo.fuDocBaSo_Ben(@Nghin) + N' nghin ' 
+ dbo.fuDocBaSo_Ben(@tram)
END
else
BEGIN
SET @DocThanhChu=dbo.fuDocBaSo(@ty) +N' ty' 
+ dbo.fuDocBaSo_Ben(@Nghin) + N' nghin ' 
END
END
else
if cast(@tram as int)>0
BEGIN
SET @DocThanhChu=dbo.fuDocBaSo(@ty) +N' ty' 
+ dbo.fuDocBaSo_Ben(@tram)
END
else
BEGIN
SET @DocThanhChu=dbo.fuDocBaSo(@ty) +N' ty' 
END
END
END
IF @Count=5
BEGIN
SELECT @nghinty =part FROM dbo.SplitString(@String,',') WHERE id=1
SELECT @ty=part FROM dbo.SplitString(@String,',') WHERE id=2
SELECT @Trieu=part FROM dbo.SplitString(@String,',') WHERE id=3
SELECT @Nghin=part FROM dbo.SplitString(@String,',') WHERE id=4
SELECT @tram = part FROM dbo.SplitString(@String,',') WHERE id=5
if cast(@ty as int)>0
BEGIN
if cast(@Trieu as int)>0
BEGIN
if cast(@Nghin as int)>0
BEGIN
if cast(@tram as int)>0
SET @DocThanhChu= dbo.fuDocBaSo(@nghinty) +N' nghin' 
+dbo.fuDocBaSo_Ben(@ty) +N' ty' 
+dbo.fuDocBaSo_Ben(@Trieu) + N' trieu'
+ dbo.fuDocBaSo_Ben(@Nghin) + N' nghin' 
+ dbo.fuDocBaSo_Ben(@tram)
else
SET @DocThanhChu= dbo.fuDocBaSo(@nghinty) +N' nghin' 
+dbo.fuDocBaSo_Ben(@ty) +N' ty' 
+dbo.fuDocBaSo_Ben(@Trieu) + N' trieu'
+ dbo.fuDocBaSo_Ben(@Nghin) + N' nghin' 
END
else
BEGIN
if cast(@tram as int)>0
SET @DocThanhChu= dbo.fuDocBaSo(@nghinty) +N' nghin' 
+dbo.fuDocBaSo_Ben(@ty) +N' ty' 
+dbo.fuDocBaSo_Ben(@Trieu) + N' trieu'
+ dbo.fuDocBaSo_Ben(@tram)
else
SET @DocThanhChu= dbo.fuDocBaSo(@nghinty) +N' nghin' 
+dbo.fuDocBaSo_Ben(@ty) +N' ty' 
+dbo.fuDocBaSo_Ben(@Trieu) + N' trieu'
END
END
else
BEGIN
if cast(@Nghin as int)>0
BEGIN
if cast(@tram as int)>0
SET @DocThanhChu= dbo.fuDocBaSo(@nghinty) +N' nghin' 
+dbo.fuDocBaSo_Ben(@ty) +N' ty' 
+ dbo.fuDocBaSo_Ben(@Nghin) + N' nghin' 
+ dbo.fuDocBaSo_Ben(@tram)
else
SET @DocThanhChu= dbo.fuDocBaSo(@nghinty) +N' nghin' 
+dbo.fuDocBaSo_Ben(@ty) +N' ty' 
+ dbo.fuDocBaSo_Ben(@Nghin) + N' nghin' 
END
else
BEGIN
if cast(@tram as int)>0
SET @DocThanhChu= dbo.fuDocBaSo(@nghinty) +N' nghin' 
+dbo.fuDocBaSo_Ben(@ty) +N' ty' 
+ dbo.fuDocBaSo_Ben(@tram)
else
SET @DocThanhChu= dbo.fuDocBaSo(@nghinty) +N' nghin' 
+dbo.fuDocBaSo_Ben(@ty) +N' ty' 
END
END
END
else
BEGIN


if cast(@Trieu as int)>0
BEGIN
if cast(@Nghin as int)>0
BEGIN
if cast(@tram as int)>0
SET @DocThanhChu= dbo.fuDocBaSo(@nghinty) +N' nghin ty' 
+dbo.fuDocBaSo_Ben(@Trieu) + N' trieu'
+ dbo.fuDocBaSo_Ben(@Nghin) + N' nghin' 
+ dbo.fuDocBaSo_Ben(@tram)
else
SET @DocThanhChu= dbo.fuDocBaSo(@nghinty) +N' nghin ty' 
+dbo.fuDocBaSo_Ben(@Trieu) + N' trieu'
+ dbo.fuDocBaSo_Ben(@Nghin) + N' nghin' 
END
else
BEGIN
if cast(@tram as int)>0
SET @DocThanhChu= dbo.fuDocBaSo(@nghinty) +N' nghin ty' 
+dbo.fuDocBaSo_Ben(@Trieu) + N' trieu'
+ dbo.fuDocBaSo_Ben(@tram)
else
SET @DocThanhChu= dbo.fuDocBaSo(@nghinty) +N' nghin ty' 
+dbo.fuDocBaSo_Ben(@Trieu) + N' trieu'
END
END
else
BEGIN
if cast(@Nghin as int)>0
BEGIN
if cast(@tram as int)>0
SET @DocThanhChu= dbo.fuDocBaSo(@nghinty) +N' nghin ty' 
+ dbo.fuDocBaSo_Ben(@Nghin) + N' nghin' 
+ dbo.fuDocBaSo_Ben(@tram)
else
SET @DocThanhChu= dbo.fuDocBaSo(@nghinty) +N' nghin ty' 
+ dbo.fuDocBaSo_Ben(@Nghin) + N' nghin' 
END
else
BEGIN
if cast(@tram as int)>0
SET @DocThanhChu= dbo.fuDocBaSo(@nghinty) +N' nghin ty' 
+ dbo.fuDocBaSo_Ben(@tram)
else
SET @DocThanhChu= dbo.fuDocBaSo(@nghinty) +N' nghin ty' 
END
END
END
END
END 
RETURN @DocThanhChu
END

GO