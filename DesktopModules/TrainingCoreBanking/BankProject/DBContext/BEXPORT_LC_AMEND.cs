//------------------------------------------------------------------------------
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
    using System.Collections.Generic;
    
    public partial class BEXPORT_LC_AMEND
    {
        public string AmendNo { get; set; }
        public string ImportLCCode { get; set; }
        public string SenderReference { get; set; }
        public string ReceiverReference { get; set; }
        public string IssuingBankReference { get; set; }
        public string IssuingBankType { get; set; }
        public string IssuingBankNo { get; set; }
        public string IssuingBankName { get; set; }
        public string IssuingBankAddr1 { get; set; }
        public string IssuingBankAddr2 { get; set; }
        public string IssuingBankAddr3 { get; set; }
        public Nullable<System.DateTime> DateOfIssue { get; set; }
        public Nullable<System.DateTime> DateOfAmendment { get; set; }
        public Nullable<int> NumberOfAmendment { get; set; }
        public string BeneficiaryNo { get; set; }
        public string BeneficiaryName { get; set; }
        public string BeneficiaryAddr1 { get; set; }
        public string BeneficiaryAddr2 { get; set; }
        public string BeneficiaryAddr3 { get; set; }
        public Nullable<System.DateTime> NewDateOfExpiry { get; set; }
        public Nullable<double> IncreaseOfDocumentaryCreditAmount { get; set; }
        public Nullable<double> DecreaseOfDocumentaryCreditAmount { get; set; }
        public Nullable<double> NewDocumentaryCreditAmountAfterAmendment { get; set; }
        public Nullable<double> PercentageCreditAmountTolerance1 { get; set; }
        public Nullable<double> PercentageCreditAmountTolerance2 { get; set; }
        public string PlaceOfTakingInCharge { get; set; }
        public string PortOfLoading { get; set; }
        public string PortOfDischarge { get; set; }
        public string PlaceOfFinalDestination { get; set; }
        public Nullable<System.DateTime> LatesDateOfShipment { get; set; }
        public string Narrative { get; set; }
        public string SenderToReceiverInformation { get; set; }
        public string WaiveCharges { get; set; }
        public string ChargeRemarks { get; set; }
        public string VATNo { get; set; }
        public string AmendStatus { get; set; }
        public string AmendBy { get; set; }
        public Nullable<System.DateTime> AmendDate { get; set; }
        public string RefAmendNo { get; set; }
        public Nullable<double> DocumentaryCreditAmount { get; set; }
    }
}
