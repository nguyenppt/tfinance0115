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
    
    public partial class PROVISIONTRANSFER_DC
    {
        public long ProvitionTransferID { get; set; }
        public string ProvisionNo { get; set; }
        public string LCNo { get; set; }
        public string Orderedby { get; set; }
        public string DebitRef { get; set; }
        public string DebitAccount { get; set; }
        public string DebitCurrency { get; set; }
        public Nullable<double> DebitAmout { get; set; }
        public Nullable<System.DateTime> DebitDate { get; set; }
        public string CreditAccount { get; set; }
        public string CreditCurrency { get; set; }
        public string TreasuryRate { get; set; }
        public Nullable<double> CreditAmount { get; set; }
        public Nullable<System.DateTime> CreditDate { get; set; }
        public string VATSerialNo { get; set; }
        public string Type { get; set; }
        public string TypeDescription { get; set; }
        public Nullable<long> CreateBy { get; set; }
        public Nullable<System.DateTime> CreateDate { get; set; }
        public Nullable<long> UpdatedBy { get; set; }
        public Nullable<System.DateTime> UpdateDate { get; set; }
        public Nullable<long> AuthorizedBy { get; set; }
        public Nullable<System.DateTime> AuthorizedDate { get; set; }
        public string Status { get; set; }
        public string AddRemarks1 { get; set; }
        public string AddRemarks2 { get; set; }
    }
}