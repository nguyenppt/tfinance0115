/****** Object:  StoredProcedure [dbo].[B_BCRFROMACCOUNT_GetByCurrency_Name]    Script Date: 1/23/2015 11:03:12 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


ALTER PROCEDURE [dbo].[B_BCRFROMACCOUNT_GetByCurrency_Name] 
	@Name varchar(50),
	@Currency varchar(10)
AS
BEGIN
	select Id, name,  Currency + ' - ' + Id + ' - ' + Name as Display
	from dbo.BCRFROMACCOUNT
	where [Currency] = @Currency and Name = @Name
	Union
	Select [ThuChiHoAccount] as Id, [Currency] + ' - ' + [ThuChiHoAccount] AS Name, [Currency] + ' - ' + [ThuChiHoAccount] AS Display
	FROM [BINTERNALBANKACCOUNT]
	WHERE [Currency] Not In ('VND','EUR','USD') 
    AND [Currency] = @Currency

END
