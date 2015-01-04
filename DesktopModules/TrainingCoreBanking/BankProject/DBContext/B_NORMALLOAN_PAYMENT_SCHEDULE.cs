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
    
    public partial class B_NORMALLOAN_PAYMENT_SCHEDULE
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
        public Nullable<decimal> Interest { get; set; }
        public Nullable<System.DateTime> StartDate { get; set; }
        public Nullable<System.DateTime> DueDate { get; set; }
        public Nullable<decimal> PrincipalAmount { get; set; }
        public Nullable<decimal> InterestAmount { get; set; }
        public Nullable<decimal> PrinOS { get; set; }
        public string Status { get; set; }
        public Nullable<long> CreateBy { get; set; }
        public Nullable<System.DateTime> CreateDate { get; set; }
        public Nullable<long> UpdatedBy { get; set; }
        public Nullable<System.DateTime> UpdatedDate { get; set; }
        public Nullable<decimal> AmountOfCapitalPaid { get; set; }
        public Nullable<decimal> OutstandingLoanAmount { get; set; }
        public Nullable<decimal> InterestedAmount { get; set; }
        public Nullable<decimal> OverdueCapitalAmount { get; set; }
        public Nullable<decimal> OverdueInterestAmount { get; set; }
        public Nullable<decimal> PaidAmount { get; set; }
        public Nullable<decimal> PaidInterestAmount { get; set; }
        public int ID { get; set; }
        public long PeriodRepaid { get; set; }
    }
}
