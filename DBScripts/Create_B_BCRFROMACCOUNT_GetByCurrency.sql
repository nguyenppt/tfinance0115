USE [bisolutions_vvcb]
GO

/****** Object:  StoredProcedure [dbo].[B_BDRFROMACCOUNT_GetByCurrency]    Script Date: 1/15/2015 10:09:49 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[B_BCRFROMACCOUNT_GetByCurrency] 
	@Name varchar(50),
	@Currency varchar(10)
AS
BEGIN
	select *,  Currency + ' - ' + Id + ' - ' + Name as Display
	from dbo.BCRFROMACCOUNT
	where [Currency] = @Currency and Name = @Name
END

GO


