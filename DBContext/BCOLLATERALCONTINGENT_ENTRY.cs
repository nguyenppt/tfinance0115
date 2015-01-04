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
    
    public partial class BCOLLATERALCONTINGENT_ENTRY
    {
        public string CollateralInfoID { get; set; }
        public string ContingentEntryID { get; set; }
        public string CustomerID { get; set; }
        public string CustomerAddress { get; set; }
        public string DocIDTaxCode { get; set; }
        public Nullable<System.DateTime> DateOfIssue { get; set; }
        public string TransactionCode { get; set; }
        public string TransactionName { get; set; }
        public string Currency { get; set; }
        public string AccountNo { get; set; }
        public string AccountName { get; set; }
        public Nullable<decimal> Amount { get; set; }
        public Nullable<decimal> DealRate { get; set; }
        public Nullable<System.DateTime> ValueDate { get; set; }
        public string Narrative { get; set; }
        public Nullable<System.DateTime> CreatedDate { get; set; }
        public string ApprovedUser { get; set; }
        public string ActiveFlag { get; set; }
        public string DCTypeCode { get; set; }
        public string DCTypeName { get; set; }
    }
}
