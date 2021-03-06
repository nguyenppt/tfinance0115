USE [bisolutions_vvcb]
GO
/****** Object:  StoredProcedure [dbo].[B_BOVERSEASTRANSFER_Report]    Script Date: 1/12/2015 11:09:38 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[B_BOVERSEASTRANSFER_Report]
	@OverseasTransferCode varchar(50)
AS
BEGIN-- B_BOVERSEASTRANSFER_Report 'FT-14340-00694'
   declare @AccountType varchar(50), @AccountWithInstitution nvarchar(250), @AccountWithBankAcct nvarchar(250), @AccountWithBankAcct2 nvarchar(250)
   
   declare @AccountWithInstitutionReturn nvarchar(250), @AccountWithInstitutionNameReturn nvarchar(1000), @AccountWithInstitutionCity nvarchar(250), @AccountWithInstitutionCountry nvarchar(250)

   declare @DetailOfCharges varchar(50), @CreditAccount varchar(50), @IntermediaryInstruction varchar(50)
   ---------------------------------------------------
   select @AccountType = AccountType, @AccountWithInstitution = AccountWithInstitution, @AccountWithBankAcct = AccountWithBankAcct,
		@AccountWithBankAcct2 = AccountWithBankAcct2, @DetailOfCharges = DetailOfCharges, @IntermediaryInstruction = IntermediaryInstruction
   from dbo.BOVERSEASTRANSFERMT103 where OverseasTransferCode = @OverseasTransferCode

   select @CreditAccount = CreditAccount
   from dbo.BOVERSEASTRANSFER bo where bo.OverseasTransferCode = @OverseasTransferCode 
   
   if @AccountType = 'A'
   begin
	   select 
			@AccountWithInstitutionReturn = SwiftCode,
			@AccountWithInstitutionNameReturn = [BankName],
			@AccountWithInstitutionCity = City,
			@AccountWithInstitutionCountry = Country
	   from dbo.BBANKSWIFTCODE bak left join dbo.BSWIFTCODE swi on bak.SwiftCode = swi.Code 
	   where SwiftCode = @AccountWithInstitution
   end
   if @AccountType = 'B' OR @AccountType = 'D'
   begin
		set @AccountWithInstitutionReturn = ''
		set @AccountWithInstitutionNameReturn = @AccountWithBankAcct2
		set @AccountWithInstitutionCity = ''
		set @AccountWithInstitutionCountry = ''
   end
   ---
   declare @CreditAccountName varchar(100), @CreditAccountCity varchar(100), @CreditAccountCountry varchar(100)
   select @CreditAccount = SwiftCode, @CreditAccountName = BankName, @CreditAccountCity = City, @CreditAccountCountry = Country
   from dbo.BBANKSWIFTCODE bak left join dbo.BSWIFTCODE swi on bak.SwiftCode = swi.Code 
   where AccountNo = @CreditAccount

   declare @IntermediaryInstructionName varchar(100), @IntermediaryInstructionCity varchar(100), @IntermediaryInstructionCountry varchar(100)
   select @IntermediaryInstructionName = BankName, @IntermediaryInstructionCity = City, @IntermediaryInstructionCountry = Country
   from dbo.BBANKSWIFTCODE bak left join dbo.BSWIFTCODE swi on bak.SwiftCode = swi.Code 
   where SwiftCode = @IntermediaryInstruction
   ---
   select SUBSTRING(CONVERT(VARCHAR(10),GETDATE(),112),3,6)   as CurrentDate
	
	select 
		 OverseasTransferCode
		,mt103.OrderingCustAcc
		,mt103.OrderingCustAccName
		,mt103.OrderingCustAccAddr1
		,mt103.OrderingCustAccAddr2
		,mt103.OrderingCustAccAddr3
		,SUBSTRING(CONVERT(VARCHAR(10),GETDATE(),112),3,6) as CurrentDate
		, CONVERT(varchar, CONVERT(money, mt103.InterBankSettleAmount), 1) InterBankSettleAmount
		, case when isnull(mt103.BeneficiaryCustomer1,'') != '' or isnull(mt103.BeneficiaryCustomer2,'') != '' or
					isnull(mt103.BeneficiaryCustomer3,'') != '' or isnull(mt103.BeneficiaryCustomer4,'') != '' or 
					isnull(mt103.BeneficiaryCustomer5,'') != ''
			then '59: Beneficiary Customer-Name & Addr' else '' end [59]
		, mt103.BeneficiaryCustomer1
		, mt103.BeneficiaryCustomer2
		, mt103.BeneficiaryCustomer3
		, mt103.BeneficiaryCustomer4
		, mt103.BeneficiaryCustomer5
		, mt103.RemittanceInformation
		, mt103.DetailOfCharges
		
		--, case when @DetailOfCharges = 'BEN' then CONVERT(varchar, CONVERT(money, mt103.InstancedAmount), 1) else '' end as InstancedAmount
		--, case when @DetailOfCharges = 'BEN' then CONVERT(varchar, CONVERT(money, mt103.SenderCharges), 1) else '' end  as SenderCharges
		--, case when @DetailOfCharges = 'SHA' then mt103.SenderToReceiveInfo else '' end  as SenderToReceiveInfo
		,CONVERT(varchar, CONVERT(money, mt103.InstancedAmount), 1) as InstancedAmount
		
		,mt103.SenderToReceiveInfo as SenderToReceiveInfo,
		mt103.Currency,
		mt103.Currency + ' (' +(select Description from BCURRENCY where Code = mt103.Currency) + ')' as CurrencyDisplay,
		@CreditAccount as CreditAccount,
		@CreditAccountName as CreditAccountName,
		@CreditAccountCity as CreditAccountCity,
		@CreditAccountCountry as CreditAccountCountry,
		--
		case when isnull(mt103.IntermediaryInstruction1,'') != '' or isnull(mt103.PartyIdentifyForInter,'') != '' or
					isnull(mt103.IntermediaryInstruction,'') != '' or isnull(@IntermediaryInstructionName,'') != '' or 
					isnull(@IntermediaryInstructionCity,'') != '' or isnull(@IntermediaryInstructionCountry,'') != '' 
			then '56' + mt103.IntermediaryType + ': Intermediary Institution – FI BIC' else '' end [56],
		mt103.IntermediaryType,
		mt103.IntermediaryInstruction1,
		mt103.PartyIdentifyForInter,
		mt103.IntermediaryInstruction,		
		@IntermediaryInstructionName as IntermediaryInstructionName,
		@IntermediaryInstructionCity as IntermediaryInstructionCity,
		@IntermediaryInstructionCountry as IntermediaryInstructionCountry,
		---
		case when isnull(mt103.AccountWithBankAcct,'') != '' or isnull(mt103.PartyIdentifyForInsti,'') != '' or
					isnull(@AccountWithInstitutionReturn,'') != '' or isnull(@AccountWithInstitutionNameReturn,'') != '' or 
					isnull(@AccountWithInstitutionCity,'') != '' or isnull(@AccountWithInstitutionCountry,'') != '' 
			then '57' + mt103.AccountType + ': Account With Institution – FI BIC' else '' end [57],
		 mt103.AccountType,
		 mt103.AccountWithBankAcct,		
		 mt103.PartyIdentifyForInsti + '   .'   as [PartyIdentifyForInsti]
		, @AccountWithInstitutionReturn as AccountWithInstitution
		, @AccountWithInstitutionNameReturn as AccountWithInstitutionName
		, @AccountWithInstitutionCity as AccountWithInstitutionCity
		, @AccountWithInstitutionCountry as AccountWithInstitutionCountry,
		
		--,CONVERT(nvarchar, CONVERT(money, mt103.SenderCharges), 1) as SenderCharges  
		case when mt103.DetailOfCharges = 'SHA' OR mt103.DetailOfCharges = 'OUR' THEN '' ELSE 'Currency: ' + mt103.Currency + ' (' +(select Description from BCURRENCY where Code = mt103.Currency) + ')' END as Currency_SenderCharges,
		case when mt103.DetailOfCharges = 'SHA' OR mt103.DetailOfCharges = 'OUR' THEN '' ELSE 'Amount: ' + CONVERT(nvarchar, CONVERT(money, mt103.SenderCharges), 1) END as SenderCharges,
		
		case when mt103.DetailOfCharges = 'SHA' OR mt103.DetailOfCharges = 'OUR' THEN '' ELSE '71F: Sender''s Charges' end as SenderCharges71F
		
	from dbo.BOVERSEASTRANSFERMT103 mt103 where OverseasTransferCode = @OverseasTransferCode 
END


