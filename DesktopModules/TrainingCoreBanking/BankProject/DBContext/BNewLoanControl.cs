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
    
    public partial class BNewLoanControl
    {
        public int ID { get; set; }
        public string Type { get; set; }
        public Nullable<System.DateTime> Date { get; set; }
        public Nullable<double> AmountAction { get; set; }
        public Nullable<double> Rate { get; set; }
        public string Chrg { get; set; }
        public Nullable<double> No { get; set; }
        public string Freq { get; set; }
        public string Code { get; set; }
        public int PeriodRepaid { get; set; }
    }
}