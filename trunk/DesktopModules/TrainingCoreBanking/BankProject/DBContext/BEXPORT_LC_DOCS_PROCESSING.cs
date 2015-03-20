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
    
    public partial class BEXPORT_LC_DOCS_PROCESSING
    {
        public string DocCode { get; set; }
        public string BeneficiaryNo { get; set; }
        public string BeneficiaryName { get; set; }
        public string BeneficiaryAddr1 { get; set; }
        public string BeneficiaryAddr2 { get; set; }
        public string BeneficiaryAddr3 { get; set; }
        public string ApplicantName { get; set; }
        public string ApplicantAddr1 { get; set; }
        public string ApplicantAddr2 { get; set; }
        public string ApplicantAddr3 { get; set; }
        public string IssuingBankNo { get; set; }
        public string IssuingBankName { get; set; }
        public string IssuingBankAddr1 { get; set; }
        public string IssuingBankAddr2 { get; set; }
        public string IssuingBankAddr3 { get; set; }
        public string NostroAgentBankNo { get; set; }
        public string NostroAgentBankName { get; set; }
        public string NostroAgentBankAddr1 { get; set; }
        public string NostroAgentBankAddr2 { get; set; }
        public string NostroAgentBankAddr3 { get; set; }
        public string ReceivingBankName { get; set; }
        public string ReceivingBankAddr1 { get; set; }
        public string ReceivingBankAddr2 { get; set; }
        public string ReceivingBankAddr3 { get; set; }
        public string DocumentaryCreditNo { get; set; }
        public string Commodity { get; set; }
        public string Currency { get; set; }
        public Nullable<double> Amount { get; set; }
        public Nullable<System.DateTime> DocumentReceivedDate { get; set; }
        public Nullable<System.DateTime> ProccessingDate { get; set; }
        public string Tenor { get; set; }
        public string InvoiceNo { get; set; }
        public string DocsCode1 { get; set; }
        public Nullable<int> NoOfOriginals1 { get; set; }
        public Nullable<int> NoOfCopies1 { get; set; }
        public string DocsCode2 { get; set; }
        public Nullable<int> NoOfOriginals2 { get; set; }
        public Nullable<int> NoOfCopies2 { get; set; }
        public string DocsCode3 { get; set; }
        public Nullable<int> NoOfOriginals3 { get; set; }
        public Nullable<int> NoOfCopies3 { get; set; }
        public string Remark { get; set; }
        public string SettlementInstruction { get; set; }
        public string WaiveCharges { get; set; }
        public string ChargeRemarks { get; set; }
        public string VATNo { get; set; }
        public Nullable<bool> PaymentFull { get; set; }
        public string Status { get; set; }
        public string CreateBy { get; set; }
        public Nullable<System.DateTime> CreateDate { get; set; }
        public string UpdatedBy { get; set; }
        public Nullable<System.DateTime> UpdateDate { get; set; }
        public string AuthorizedBy { get; set; }
        public Nullable<System.DateTime> AuthorizedDate { get; set; }
        public string AmendStatus { get; set; }
        public string AmendBy { get; set; }
        public Nullable<System.DateTime> AmendDate { get; set; }
        public string AmendNo { get; set; }
        public string AmendNoOriginal { get; set; }
        public string ActiveRecordFlag { get; set; }
        public string RejectStatus { get; set; }
        public Nullable<System.DateTime> RejectDate { get; set; }
        public string AcceptStatus { get; set; }
        public Nullable<System.DateTime> AcceptDate { get; set; }
        public Nullable<double> PaymentAmount { get; set; }
        public string OtherDocs1 { get; set; }
        public string OtherDocs2 { get; set; }
        public string OtherDocs3 { get; set; }
    }
}
