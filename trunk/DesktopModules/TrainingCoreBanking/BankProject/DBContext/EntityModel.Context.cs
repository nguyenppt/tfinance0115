﻿//------------------------------------------------------------------------------
// <auto-generated>
//    This code was generated from a template.
//
//    Manual changes to this file may cause unexpected behavior in your application.
//    Manual changes to this file will be overwritten if the code is regenerated.
// </auto-generated>
//------------------------------------------------------------------------------

namespace BankProject.DBContext
{
    using System;
    using System.Data.Entity;
    using System.Data.Entity.Infrastructure;
    
    public partial class VietVictoryCoreBankingEntities : DbContext
    {
        public VietVictoryCoreBankingEntities()
            : base("name=VietVictoryCoreBankingEntities")
        {
        }
    
        protected override void OnModelCreating(DbModelBuilder modelBuilder)
        {
            throw new UnintentionalCodeFirstException();
        }
    
        public DbSet<B_AccountForBuyingTC> B_AccountForBuyingTC { get; set; }
        public DbSet<B_AddConfirmInfo> B_AddConfirmInfo { get; set; }
        public DbSet<B_BATCH_MAINTENANCE> B_BATCH_MAINTENANCE { get; set; }
        public DbSet<B_BuyTravellersCheque> B_BuyTravellersCheque { get; set; }
        public DbSet<B_CashWithrawalForBuyingTC> B_CashWithrawalForBuyingTC { get; set; }
        public DbSet<B_CheckBatchRunning> B_CheckBatchRunning { get; set; }
        public DbSet<B_CustomerSignature> B_CustomerSignature { get; set; }
        public DbSet<B_DEBUG> B_DEBUG { get; set; }
        public DbSet<B_Denomination> B_Denomination { get; set; }
        public DbSet<B_ExchangeBanknotesManyDeno> B_ExchangeBanknotesManyDeno { get; set; }
        public DbSet<B_ExportLCPayment> B_ExportLCPayment { get; set; }
        public DbSet<B_ExportLCPaymentCharge> B_ExportLCPaymentCharge { get; set; }
        public DbSet<B_ExportLCPaymentMT202> B_ExportLCPaymentMT202 { get; set; }
        public DbSet<B_ExportLCPaymentMT756> B_ExportLCPaymentMT756 { get; set; }
        public DbSet<B_ForeignExchange> B_ForeignExchange { get; set; }
        public DbSet<B_ImportLCPayment> B_ImportLCPayment { get; set; }
        public DbSet<B_ImportLCPaymentCharge> B_ImportLCPaymentCharge { get; set; }
        public DbSet<B_ImportLCPaymentMT202> B_ImportLCPaymentMT202 { get; set; }
        public DbSet<B_ImportLCPaymentMT756> B_ImportLCPaymentMT756 { get; set; }
        public DbSet<B_LOAN_CREDIT_SCORING> B_LOAN_CREDIT_SCORING { get; set; }
        public DbSet<B_LOAN_DISBURSAL_SCHEDULE> B_LOAN_DISBURSAL_SCHEDULE { get; set; }
        public DbSet<B_LOAN_PROCESS_PAYMENT> B_LOAN_PROCESS_PAYMENT { get; set; }
        public DbSet<B_NORMALLOAN_PAYMENT_SCHEDULE> B_NORMALLOAN_PAYMENT_SCHEDULE { get; set; }
        public DbSet<B_SellTravellersCheque> B_SellTravellersCheque { get; set; }
        public DbSet<B_WUXOOMCashAdvance> B_WUXOOMCashAdvance { get; set; }
        public DbSet<BACCOUNTOFFICER> BACCOUNTOFFICERs { get; set; }
        public DbSet<BACCOUNT> BACCOUNTS { get; set; }
        public DbSet<BADVISINGANDNEGOTIATION> BADVISINGANDNEGOTIATIONs { get; set; }
        public DbSet<BADVISINGANDNEGOTIATION_CHARGES> BADVISINGANDNEGOTIATION_CHARGES { get; set; }
        public DbSet<BAdvisingAndNegotiationLCCharge> BAdvisingAndNegotiationLCCharges { get; set; }
        public DbSet<BBANK_BRANCH> BBANK_BRANCH { get; set; }
        public DbSet<BBANKCODE> BBANKCODEs { get; set; }
        public DbSet<BBANKING> BBANKINGs { get; set; }
        public DbSet<BBANKSWIFTCODE> BBANKSWIFTCODEs { get; set; }
        public DbSet<BBENEFICIARYBANK> BBENEFICIARYBANKs { get; set; }
        public DbSet<BCASHDEPOSIT> BCASHDEPOSITs { get; set; }
        public DbSet<BCASHWITHRAWAL> BCASHWITHRAWALs { get; set; }
        public DbSet<BCATEGORY> BCATEGORies { get; set; }
        public DbSet<BCATEGORY_COPY> BCATEGORY_COPY { get; set; }
        public DbSet<BCHARGECODE> BCHARGECODEs { get; set; }
        public DbSet<BCHEQUEISSUE> BCHEQUEISSUEs { get; set; }
        public DbSet<BCHEQUESTATU> BCHEQUESTATUS { get; set; }
        public DbSet<BCHEQUETYPE> BCHEQUETYPEs { get; set; }
        public DbSet<BCOLLATERAL> BCOLLATERALs { get; set; }
        public DbSet<BCOLLATERAL_INFOMATION> BCOLLATERAL_INFOMATION { get; set; }
        public DbSet<BCOLLATERAL_STATUS> BCOLLATERAL_STATUS { get; set; }
        public DbSet<BCOLLATERALCONTINGENT_ENTRY> BCOLLATERALCONTINGENT_ENTRY { get; set; }
        public DbSet<BCOLLATERALRIGHT> BCOLLATERALRIGHTs { get; set; }
        public DbSet<BCOLLECTCHARGESBYCASH> BCOLLECTCHARGESBYCASHes { get; set; }
        public DbSet<BCOLLECTCHARGESFROMACCOUNT> BCOLLECTCHARGESFROMACCOUNTs { get; set; }
        public DbSet<BCOLLECTION_FOR_CRE_CARD_PAYM> BCOLLECTION_FOR_CRE_CARD_PAYM { get; set; }
        public DbSet<BCOMMITMENT_CONTRACT> BCOMMITMENT_CONTRACT { get; set; }
        public DbSet<BCOMMODITY> BCOMMODITies { get; set; }
        public DbSet<BCONFIG> BCONFIGs { get; set; }
        public DbSet<BCONTINGENTACCOUNT> BCONTINGENTACCOUNTS { get; set; }
        public DbSet<BCRFROMACCOUNT> BCRFROMACCOUNTs { get; set; }
        public DbSet<BCURRENCY> BCURRENCies { get; set; }
        public DbSet<BCUSTOMER_INFO> BCUSTOMER_INFO { get; set; }
        public DbSet<BCUSTOMER_LIMIT_MAIN> BCUSTOMER_LIMIT_MAIN { get; set; }
        public DbSet<BCUSTOMER_LIMIT_SUB> BCUSTOMER_LIMIT_SUB { get; set; }
        public DbSet<BCUSTOMER> BCUSTOMERS { get; set; }
        public DbSet<BDEPOSITACCT> BDEPOSITACCTS { get; set; }
        public DbSet<BDOCUMETARYCOLLECTIONCHARGE> BDOCUMETARYCOLLECTIONCHARGES { get; set; }
        public DbSet<BDOCUMETARYCOLLECTIONMT410> BDOCUMETARYCOLLECTIONMT410 { get; set; }
        public DbSet<BDRAWTYPE> BDRAWTYPEs { get; set; }
        public DbSet<BDRFROMACCOUNT> BDRFROMACCOUNTs { get; set; }
        public DbSet<BDYNAMICCONTROL> BDYNAMICCONTROLS { get; set; }
        public DbSet<BDYNAMICDATA> BDYNAMICDATAs { get; set; }
        public DbSet<BENCOM> BENCOMs { get; set; }
        public DbSet<BENQUIRYCHECK> BENQUIRYCHECKs { get; set; }
        public DbSet<BEXPORT_DOCUMENTPROCESSING> BEXPORT_DOCUMENTPROCESSING { get; set; }
        public DbSet<BEXPORT_DOCUMENTPROCESSINGCHARGE> BEXPORT_DOCUMENTPROCESSINGCHARGE { get; set; }
        public DbSet<BEXPORT_DOCUMETARYCOLLECTION> BEXPORT_DOCUMETARYCOLLECTION { get; set; }
        public DbSet<BEXPORT_DOCUMETARYCOLLECTIONCHARGES> BEXPORT_DOCUMETARYCOLLECTIONCHARGES { get; set; }
        public DbSet<BEXPORT_LC_ADV_NEGO> BEXPORT_LC_ADV_NEGO { get; set; }
        public DbSet<BEXPORTCOLLECTIONPAYMENT> BEXPORTCOLLECTIONPAYMENTs { get; set; }
        public DbSet<BFOREIGNEXCHANGE> BFOREIGNEXCHANGEs { get; set; }
        public DbSet<BFREETEXTMESSAGE> BFREETEXTMESSAGEs { get; set; }
        public DbSet<BIMPORT_DOCUMENTPROCESSING> BIMPORT_DOCUMENTPROCESSING { get; set; }
        public DbSet<BIMPORT_DOCUMENTPROCESSING_CHARGE> BIMPORT_DOCUMENTPROCESSING_CHARGE { get; set; }
        public DbSet<BIMPORT_DOCUMENTPROCESSING_MT734> BIMPORT_DOCUMENTPROCESSING_MT734 { get; set; }
        public DbSet<BIMPORT_NORMAILLC> BIMPORT_NORMAILLC { get; set; }
        public DbSet<BIMPORT_NORMAILLC_CHARGE> BIMPORT_NORMAILLC_CHARGE { get; set; }
        public DbSet<BIMPORT_NORMAILLC_MT700> BIMPORT_NORMAILLC_MT700 { get; set; }
        public DbSet<BIMPORT_NORMAILLC_MT707> BIMPORT_NORMAILLC_MT707 { get; set; }
        public DbSet<BIMPORT_NORMAILLC_MT740> BIMPORT_NORMAILLC_MT740 { get; set; }
        public DbSet<BIMPORT_NORMAILLC_MT747> BIMPORT_NORMAILLC_MT747 { get; set; }
        public DbSet<BINCOMINGCOLLECTIONPAYMENT> BINCOMINGCOLLECTIONPAYMENTs { get; set; }
        public DbSet<BINCOMINGCOLLECTIONPAYMENTCHARGE> BINCOMINGCOLLECTIONPAYMENTCHARGES { get; set; }
        public DbSet<BINCOMINGCOLLECTIONPAYMENTMT103> BINCOMINGCOLLECTIONPAYMENTMT103 { get; set; }
        public DbSet<BINCOMINGCOLLECTIONPAYMENTMT202> BINCOMINGCOLLECTIONPAYMENTMT202 { get; set; }
        public DbSet<BINCOMINGCOLLECTIONPAYMENTMT400> BINCOMINGCOLLECTIONPAYMENTMT400 { get; set; }
        public DbSet<BINDUSTRY> BINDUSTRies { get; set; }
        public DbSet<BINTEREST_RATE> BINTEREST_RATE { get; set; }
        public DbSet<BINTEREST_TERM> BINTEREST_TERM { get; set; }
        public DbSet<BINTERNALBANKACCOUNT> BINTERNALBANKACCOUNTs { get; set; }
        public DbSet<BINTERNALBANKPAYMENTACCOUNT> BINTERNALBANKPAYMENTACCOUNTs { get; set; }
        public DbSet<BLCTYPE> BLCTYPES { get; set; }
        public DbSet<BLDACCOUNT> BLDACCOUNTs { get; set; }
        public DbSet<BLOANGROUP> BLOANGROUPs { get; set; }
        public DbSet<BLOANINTEREST_KEY> BLOANINTEREST_KEY { get; set; }
        public DbSet<BLOANPURPOSE> BLOANPURPOSEs { get; set; }
        public DbSet<BLOANWORKINGACCOUNT> BLOANWORKINGACCOUNTS { get; set; }
        public DbSet<BMACODE> BMACODEs { get; set; }
        public DbSet<BMENUTOP> BMENUTOPs { get; set; }
        public DbSet<BNewLoanControl> BNewLoanControls { get; set; }
        public DbSet<BNEWNORMALLOAN> BNEWNORMALLOANs { get; set; }
        public DbSet<BOPENACCOUNT> BOPENACCOUNTs { get; set; }
        public DbSet<BOPENACCOUNT_COPY> BOPENACCOUNT_COPY { get; set; }
        public DbSet<BOPENACCOUNT_INTEREST> BOPENACCOUNT_INTEREST { get; set; }
        public DbSet<BOUTGOINGCOLLECTIONPAYMENT> BOUTGOINGCOLLECTIONPAYMENTs { get; set; }
        public DbSet<BOUTGOINGCOLLECTIONPAYMENTCHARGE> BOUTGOINGCOLLECTIONPAYMENTCHARGES { get; set; }
        public DbSet<BOUTGOINGCOLLECTIONPAYMENTMT910> BOUTGOINGCOLLECTIONPAYMENTMT910 { get; set; }
        public DbSet<BOVERSEASTRANSFER> BOVERSEASTRANSFERs { get; set; }
        public DbSet<BOVERSEASTRANSFERMT103> BOVERSEASTRANSFERMT103 { get; set; }
        public DbSet<BPaymentFrequenceControl> BPaymentFrequenceControls { get; set; }
        public DbSet<BPAYMENTMETHOD> BPAYMENTMETHODs { get; set; }
        public DbSet<BPLACCOUNT> BPLACCOUNTs { get; set; }
        public DbSet<BPRODUCTLINE> BPRODUCTLINEs { get; set; }
        public DbSet<BPRODUCTLINE_COPY> BPRODUCTLINE_COPY { get; set; }
        public DbSet<BPRODUCTTYPE> BPRODUCTTYPEs { get; set; }
        public DbSet<BPROVINCE> BPROVINCEs { get; set; }
        public DbSet<BRELATIONCODE> BRELATIONCODEs { get; set; }
        public DbSet<BRESTRICT_TXN> BRESTRICT_TXN { get; set; }
        public DbSet<BRPODCATEGORY> BRPODCATEGORies { get; set; }
        public DbSet<BSalaryPaymentFrequency> BSalaryPaymentFrequencies { get; set; }
        public DbSet<BSalaryPaymentFrequencyDetail> BSalaryPaymentFrequencyDetails { get; set; }
        public DbSet<BSalaryPaymentFrequencyTerm> BSalaryPaymentFrequencyTerms { get; set; }
        public DbSet<BSalaryPaymentMethod> BSalaryPaymentMethods { get; set; }
        public DbSet<BSAVING_ACC_ARREAR> BSAVING_ACC_ARREAR { get; set; }
        public DbSet<BSAVING_ACC_DISCOUNTED> BSAVING_ACC_DISCOUNTED { get; set; }
        public DbSet<BSAVING_ACC_INTEREST> BSAVING_ACC_INTEREST { get; set; }
        public DbSet<BSAVING_ACC_PERIODIC> BSAVING_ACC_PERIODIC { get; set; }
        public DbSet<BSECTOR> BSECTORs { get; set; }
        public DbSet<BSWIFTCODE> BSWIFTCODEs { get; set; }
        public DbSet<BTRANSFER_4_CRE_CARD_PAYMENT> BTRANSFER_4_CRE_CARD_PAYMENT { get; set; }
        public DbSet<BTRANSFERWITHDRAWAL> BTRANSFERWITHDRAWALs { get; set; }
        public DbSet<PROVISIONTRANSFER_DC> PROVISIONTRANSFER_DC { get; set; }
        public DbSet<Sochu> Sochus { get; set; }
        public DbSet<sysdiagram> sysdiagrams { get; set; }
        public DbSet<B_CollectCharges> B_CollectCharges { get; set; }
        public DbSet<BAdvisingAndNegotiationLC> BAdvisingAndNegotiationLCs { get; set; }
        public DbSet<BEXPORT_LC> BEXPORT_LC { get; set; }
        public DbSet<BEXPORT_LC_CHARGES> BEXPORT_LC_CHARGES { get; set; }
        public DbSet<BEXPORT_LC_AMEND> BEXPORT_LC_AMEND { get; set; }
    }
}
