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
    
    public partial class B_NORMALLOAN_PRINCIPLE_PAYMENT_SCHEDULE
    {
        public string Code { get; set; }
        public long Period { get; set; }
        public string CustomerID { get; set; }
        public string CustomerName { get; set; }
        public Nullable<decimal> LoanAmount { get; set; }
        public Nullable<decimal> ApproveAmount { get; set; }
        public Nullable<System.DateTime> Drawdown { get; set; }
        public string InterestKey { get; set; }
        public string Freq { get; set; }
        public Nullable<System.DateTime> BeginCircleDate { get; set; }
        public Nullable<System.DateTime> MaturityDate { get; set; }
        public Nullable<decimal> AmountOfCapitalPaid { get; set; }
        public Nullable<decimal> OutstandingLoanAmount { get; set; }
        public string Status { get; set; }
        public Nullable<long> CreateBy { get; set; }
        public Nullable<System.DateTime> CreateDate { get; set; }
        public Nullable<long> UpdatedBy { get; set; }
        public Nullable<System.DateTime> UpdatedDate { get; set; }
    }
}
