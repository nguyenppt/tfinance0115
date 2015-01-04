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
    
    public partial class BEXPORT_DOCUMETARYCOLLECTION_BK_27082014
    {
        public long Id { get; set; }
        public string DocCollectCode { get; set; }
        public string DrawerType { get; set; }
        public string DrawerCusNo { get; set; }
        public string DrawerCusName { get; set; }
        public string DrawerAddr1 { get; set; }
        public string DrawerAddr2 { get; set; }
        public string DrawerAddr3 { get; set; }
        public string DrawerRefNo { get; set; }
        public string CollectingBankNo { get; set; }
        public string CollectingBankName { get; set; }
        public string CollectingBankAddr1 { get; set; }
        public string CollectingBankAddr2 { get; set; }
        public string CollectingBankAddr3 { get; set; }
        public string CollectingBankAcct { get; set; }
        public string DraweeType { get; set; }
        public string DraweeCusNo { get; set; }
        public string DraweeCusName { get; set; }
        public string DraweeAddr1 { get; set; }
        public string DraweeAddr2 { get; set; }
        public string DraweeAddr3 { get; set; }
        public string NostroCusNo { get; set; }
        public string Currency { get; set; }
        public Nullable<double> Amount { get; set; }
        public Nullable<System.DateTime> DocsReceivedDate { get; set; }
        public Nullable<System.DateTime> MaturityDate { get; set; }
        public string Tenor { get; set; }
        public Nullable<long> Days { get; set; }
        public Nullable<System.DateTime> TracerDate { get; set; }
        public Nullable<long> ReminderDays { get; set; }
        public string Commodity { get; set; }
        public string DocsCode1 { get; set; }
        public Nullable<int> NoOfOriginals1 { get; set; }
        public Nullable<int> NoOfCopies1 { get; set; }
        public string DocsCode2 { get; set; }
        public Nullable<int> NoOfOriginals2 { get; set; }
        public Nullable<int> NoOfCopies2 { get; set; }
        public string OtherDocs { get; set; }
        public string InstructionToCus { get; set; }
        public string Remarks { get; set; }
        public string ExpressNo { get; set; }
        public string InvoiceNo { get; set; }
        public string Status { get; set; }
        public Nullable<System.DateTime> CreateDate { get; set; }
        public string CreateBy { get; set; }
        public Nullable<System.DateTime> UpdatedDate { get; set; }
        public string UpdatedBy { get; set; }
        public string AuthorizedBy { get; set; }
        public Nullable<System.DateTime> AuthorizedDate { get; set; }
        public string CollectionType { get; set; }
        public string Amend_Status { get; set; }
        public string Cancel_Status { get; set; }
        public string CancelBy { get; set; }
        public Nullable<System.DateTime> AcceptedDate { get; set; }
        public string AcceptRemarks { get; set; }
        public string Accept_Status { get; set; }
        public string AcceptBy { get; set; }
        public Nullable<System.DateTime> AcceptByDate { get; set; }
        public Nullable<int> PaymentFullFlag { get; set; }
    }
}
