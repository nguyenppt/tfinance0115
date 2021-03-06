USE [bisolutions_vvcb]
GO
/****** Object:  StoredProcedure [dbo].[P_BEXPORTDOCUMETARYCOLLECTION_AMEND_PHIEUXUATNGOAIBANG_Report]    Script Date: 1/11/2015 11:13:11 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[P_BEXPORTDOCUMETARYCOLLECTION_AMEND_PHIEUXUATNGOAIBANG_Report]
	@Code varchar(50),
	@CurrentUserLogin nvarchar(250)
AS
BEGIN
--[P_BEXPORTDOCUMETARYCOLLECTION_AMEND_PHIEUXUATNGOAIBANG_Report] 'TF-14245-00110', 'a'
	
	declare @CurrentDate varchar(12)
	set @CurrentDate = CONVERT(VARCHAR(10),GETDATE(),101);	
	select @CurrentDate as CurrentDate
	select e.DocCollectCode,
		@CurrentUserLogin CurrentUserLogin,
		c.CustomerName,
		c.IdentityNo,
		c.[Address],
		c.City,
		c.Country,
		e.DrawerCusNo,
		e.DraweeCusName,
		e.Currency,
		dbo.f_CurrencyToText(cast(
								case when Amend_Status = 'AUT' 
									then abs(Amount - isnull(OldAmount,0))
								else  
									abs(isnull(OldAmount,0) - Amount)
								 end 
									as nvarchar(4000)),cc.Code)  SoTienVietBangChu,

		CONVERT(varchar, CONVERT(money,
										case when Amend_Status = 'AUT' 
											then abs(Amount - isnull(OldAmount,0))
										else  abs(isnull(OldAmount,0) - Amount) end), 1) Amount,
		
		CONVERT(VARCHAR(10),GETDATE(),101) CurrentDate,
	    cc.Vietnamese,
	    DATEPART(m, GETDATE()) as [Month],
	    DATEPART(d, GETDATE()) as [Day],
	    DATEPART(yy, GETDATE()) as [Year]
	from BEXPORT_DOCUMETARYCOLLECTION e
		left join BCUSTOMERS c on e.DrawerCusNo = c.CustomerID
		left Join BCURRENCY cc on cc.Code = Currency
	where (DocCollectCode = @Code OR AmendNo=@Code)
	AND (ActiveRecordFlag is null OR ActiveRecordFlag='YES')
END