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
    
    public partial class BOVERSEASTRANSFER
    {
        public int Id { get; set; }
        public string OverseasTransferCode { get; set; }
        public string TransactionType { get; set; }
        public string ProductLine { get; set; }
        public string CountryCode { get; set; }
        public string CommoditySer { get; set; }
        public string OtherInfo { get; set; }
        public string OtherBy { get; set; }
        public string DebitRef { get; set; }
        public string DebitAcctNo { get; set; }
        public string DebitCurrency { get; set; }
        public Nullable<double> DebitAmount { get; set; }
        public Nullable<System.DateTime> DebitDate { get; set; }
        public Nullable<double> AmountDebited { get; set; }
        public string TPKT { get; set; }
        public string CreditAccount { get; set; }
        public string CreditCurrency { get; set; }
        public Nullable<double> TreasuryRate { get; set; }
        public Nullable<double> CreditAmount { get; set; }
        public Nullable<System.DateTime> CreditDate { get; set; }
        public Nullable<System.DateTime> ProcessingDate { get; set; }
        public Nullable<double> AmountCredited { get; set; }
        public string VATSend { get; set; }
        public string AddRemarks { get; set; }
        public string Status { get; set; }
        public Nullable<System.DateTime> CreateDate { get; set; }
        public string CreateBy { get; set; }
        public Nullable<System.DateTime> UpdatedDate { get; set; }
        public string UpdatedBy { get; set; }
        public string AuthorizedBy { get; set; }
        public Nullable<System.DateTime> AuthorizedDate { get; set; }
        public string OtherBy2 { get; set; }
        public string OtherBy3 { get; set; }
        public string OtherBy4 { get; set; }
        public string OtherBy5 { get; set; }
    }
}