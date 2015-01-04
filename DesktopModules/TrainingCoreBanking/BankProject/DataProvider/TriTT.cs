using System;
using System.Collections.Generic;
using System.Linq;
using System.Web.Configuration;
using System.Data.SqlClient;
using System.Data;
using Microsoft.ApplicationBlocks.Data;

namespace BankProject.DataProvider
{
    public static class TriTT
    {
        private static SqlDataProvider sqldata = new SqlDataProvider();
        private static string ConnectionString()
        {
            return WebConfigurationManager.ConnectionStrings["VietVictoryCoreBanking"].ConnectionString;
        }

        #region Get Data from Sql Server

        public static string B_BMACODE_GetNewID_2(string MaCode, string refix, string flat = "-")
        {
           
            string s = sqldata.ndkExecuteDataset("B_BMACODE_GetNewID_2", refix, flat).Tables[0].Rows[0]["Code"].ToString();
            return s;
        }
        public static string B_BMACODE_GetNewID_3par(string MaCode, string refix, string flat = "/")
        {
            string chuoi = sqldata.ndkExecuteDataset("B_BMACODE_GetNewID_3par", refix, flat).Tables[0].Rows[0]["Code"].ToString();
            return chuoi;
        }
        public static string B_BMACODE_GetNewID_3part_new(string StoredProc, string MaCode, string refix, string flat)
        {
            string chuoi = sqldata.ndkExecuteDataset(StoredProc, MaCode, refix, flat).Tables[0].Rows[0]["Code"].ToString();
            return chuoi;
        }
        public static string B_BMACODE_NewID_3par_CashRepayment(string MaCode, string refix, string flat = "/")
        {
            string chuoi = sqldata.ndkExecuteDataset("B_BMACODE_NewID_3par_CashRepayment", refix, flat).Tables[0].Rows[0]["Code"].ToString();
            return chuoi;
        }
        public static string B_BMACODE_NewID_3par_PastDueLoanReference(string MaCode, string refix, string flat = "/")
        {
            string chuoi = sqldata.ndkExecuteDataset("B_BMACODE_NewID_3par_PastDueLoanReference", refix, flat).Tables[0].Rows[0]["Code"].ToString();
            return chuoi;
        }
        public static string B_BMACODE_Amend_Loan_Contract(string MaCode, string refix, string flag = "/")
        {
            string chuoi = sqldata.ndkExecuteDataset("B_BMACODE_Amend_Loan_Contract", refix, flag).Tables[0].Rows[0]["Code"].ToString();
            return chuoi;
        }
        public static string B_BMACODE_3part_varMaCode_varSP(string SP_Name, string MaCode_BMACODE, string refix, string flag = "/")
        {
            string chuoi = sqldata.ndkExecuteDataset(SP_Name, MaCode_BMACODE, refix,flag).Tables[0].Rows[0]["Code"].ToString();
            return chuoi;
        }
   

        public static DataSet B_BCOUNTRY_GetAll()
        {
            DataSet dsInfo = new DataSet();
            try
            {
                using (SqlConnection conn = new SqlConnection(ConnectionString()))
                {
                    conn.Open();
                    SqlCommand cmd = new SqlCommand("B_BCOUNTRY_GetAll", conn);
                    cmd.CommandType = CommandType.StoredProcedure;
                    //cmd.Parameters.AddWithValue("@CVID", cvid);
                    SqlDataAdapter adapt = new SqlDataAdapter(cmd);
                    adapt.Fill(dsInfo);

                    cmd.Dispose();
                    conn.Close();

                    return dsInfo;
                }
            }
            catch (Exception ex)
            {
                System.Diagnostics.Trace.WriteLine(ex);
                return null;
            }
        }
        public static DataSet B_LoadCurrency(string Cur1, string Cur2)
        {
            return sqldata.ndkExecuteDataset("B_LoadCurrency", Cur1, Cur2);
        }
        public static DataSet B_OPEN_LOANWORK_ACCT_Get_ALLCustomerID()
        {
            return sqldata.ndkExecuteDataset("B_OPEN_LOANWORK_ACCT_Get_ALLCustomerID");
        }
        public static DataSet B_BCRFROMACCOUNT_GetByCustomer(string currency)
        {
            return sqldata.ndkExecuteDataset("B_BCRFROMACCOUNT_GetByCurrency", currency);
        }

        public static DataSet B_OPEN_LOANWORK_ACCT_Get_ALLCategory(string StoredProc,string CategoryType) // lay du lieu Code Category, co variable chon STored Proc va TYPE
        {
            return sqldata.ndkExecuteDataset(StoredProc, CategoryType);
        }
        public static DataSet BCUSTOMER_SAVINGACCT()
        {
            return sqldata.ndkExecuteDataset("dbo.BCUSTOMER_SAVINGACCT");
        }

        public static string B_CHEQUE_ISSUE_NO(string MaCode)
        {
            return sqldata.ndkExecuteDataset("B_BCHEQUE_ISSUE_getNo", MaCode).Tables[0].Rows[0]["SoTT"].ToString();
        }
        public static string B_BCUSTOMER_GetID(string MaCode)  //lay soTT cho Open Individual Customer Co luu du lieu
        {
            return sqldata.ndkExecuteDataset("B_BCUSTOMER_GetID", MaCode).Tables[0].Rows[0]["SoTT"].ToString();
        }
        public static string B_BCUSTOMER_GetID_Corporate(string SP_Procedure, string MaCode) //lay soTT cho Open Corporate Customer Co luu du lieu
        {
            return sqldata.ndkExecuteDataset(SP_Procedure, MaCode).Tables[0].Rows[0]["SoTT"].ToString();
        }

        public static DataSet B_BLOANACCOUNT_getbyCurrency(string CustomerName, string Currency)
        {
            return sqldata.ndkExecuteDataset("B_BLOANACCOUNT_getbyCurrency", CustomerName, Currency);
        }


        internal static DataSet B_BCHEQUERETURN_findItem(string tbChequeReference, string tbCustomerID, string tbCustomerName, string IssueDate)
        {
            return sqldata.ndkExecuteDataset("B_BCHEQUERETURN_findItem", tbChequeReference, tbCustomerID, tbCustomerName, IssueDate);
        }
       
        public static DataSet B_BPastDueLoanRepayment_FindItem(string LoanContractReference, string CustomerID, string CustomerName)
        {
            return sqldata.ndkExecuteDataset("B_BPastDueLoanRepayment_FindItem", LoanContractReference, CustomerID, CustomerName);
        }
        #endregion
        #region cac ham luu du lieu xuong Database
        public static void OPEN_CORPORATE_CUSTOMER_Insert_Account
            (string CustomerID, string Status, string GBShortName, string GBFullName, DateTime? IncorpDate, string GBStreet, string GBDist, string MaTinhThanh,
            string TenTinhThanh, string CountryCode, string CountryName, string NationalityCode, string NationalityName, string ResidenceCode, string ResidenceName
            , string DocType, string DocID, string DocIssuePlace, DateTime? DocIssueDate, DateTime? DocExpiryDate,
            string ContactPerson, string Position, string Telephone, string EmailAddress, string Remarks
            , string SectorCode, string SectorName, string SubSectorCode, string SubSectorName, string IndustryCode, string IndustryName, string SubIndustryCode
            , string SubIndustryName, string TargetCode, string AccountOfficer, DateTime? ContactDate, string RelationCode, string OfficeNumber
            , string TotalCapital, string NoOfEmployee, string TotalAssets, string TotalRevenue, string CustomerLiability, string LegacyRef, string ApprovedUser)
        {
            sqldata.ndkExecuteNonQuery("OPEN_CORPORATE_CUSTOMER_Insert_Account", CustomerID, Status, GBShortName, GBFullName, IncorpDate, GBStreet, GBDist, MaTinhThanh, TenTinhThanh,
                CountryCode, CountryName, NationalityCode, NationalityName, ResidenceCode, ResidenceName
            , DocType, DocID, DocIssuePlace, DocIssueDate, DocExpiryDate, ContactPerson, Position, Telephone, EmailAddress, Remarks
            , SectorCode, SectorName, SubSectorCode, SubSectorName, IndustryCode, IndustryName, SubIndustryCode
            , SubIndustryName, TargetCode, AccountOfficer, ContactDate, RelationCode, OfficeNumber
            , TotalCapital, NoOfEmployee, TotalAssets, TotalRevenue, CustomerLiability, LegacyRef, ApprovedUser);
        }
        public static void B_OPEN_LOANWORK_ACCT_Insert_Update_Acct(string RefID, string CustomerID, string Status, string GBFullName, string DocType, string DocID, string DocIssuePlace
            , DateTime? DocIssueDate, DateTime? DocExpiryDate, string CategoryCode, string CategoryName, string AccountName, string ShortTittle, string Mnemonic
            , string CurrencyCode, string CurrencyDescr, string ProductLineCode, string ProductLineDescr, string AlternateAcct, string CreatedUser)
        {
            sqldata.ndkExecuteNonQuery("B_OPEN_LOANWORK_ACCT_Insert_Update_Acct", RefID, CustomerID, Status, GBFullName, DocType, DocID, DocIssuePlace
            , DocIssueDate, DocExpiryDate, CategoryCode, CategoryName, AccountName, ShortTittle, Mnemonic
            , CurrencyCode, CurrencyDescr, ProductLineCode, ProductLineDescr, AlternateAcct, CreatedUser);
        }
        public static DataSet OPEN_CORPORATE_CUSTOMER_review_Account(string CustomerID, string Status, string CustomerType, string LoadFor_List1_review2)
        {
            return sqldata.ndkExecuteDataset("OPEN_CORPORATE_CUSTOMER_review_Account", CustomerID, Status, CustomerType, LoadFor_List1_review2);
        }
        public static DataSet OPEN_CORPORATE_CUSTOMER_review_Account_search_tai_Form(string CustomerID,string CustomerType)
        {
            return sqldata.ndkExecuteDataset("OPEN_CORPORATE_CUSTOMER_review_Account_search_tai_Form", CustomerID, CustomerType);
        }
        public static void OPEN_CORPORATE_CUSTOMER_Authorize_Account(string CustomerID, String Status)
        {
            sqldata.ndkExecuteNonQuery("OPEN_CORPORATE_CUSTOMER_Authorize_Account", CustomerID, Status);
        }
        #endregion
        #region B_OPEN_LOAN_WORKING_ACCOUNT
        public static void B_OPEN_LOANWORK_ACCT_Update_Status(string RefID, string CustomerID, string Status)
        {
            sqldata.ndkExecuteNonQuery("B_OPEN_LOANWORK_ACCT_Update_Status", RefID, CustomerID, Status);
        }
        public static DataSet B_OPEN_LOANWORK_ACCT_List_Preview(string status)
        {
            return sqldata.ndkExecuteDataset("B_OPEN_LOANWORK_ACCT_List_Preview", status);
        }
        public static DataSet B_OPEN_LOANWORK_ACCT_Load_Account(string RefID)
        {
            return sqldata.ndkExecuteDataset("B_OPEN_LOANWORK_ACCT_Load_Account", RefID);
        }
        public static DataSet B_OPEN_LOANWORK_ACCT_Enquiry_Customer(string AccountID, string CustomerID, string GBFullName, string Currency, string ProductLineCode
            ,string CategoryCode, string DocID)
        {
            return sqldata.ndkExecuteDataset("B_OPEN_LOANWORK_ACCT_Enquiry_Customer", AccountID, CustomerID, GBFullName, Currency, ProductLineCode, CategoryCode, DocID);
        }
        public static DataSet B_OPEN_LOANWORK_ACCT_Check_Acct_Exist(string CustomerID,string Currency)
        {
            return sqldata.ndkExecuteDataset("B_OPEN_LOANWORK_ACCT_Check_Acct_Exist",CustomerID,Currency);
        }
#endregion 
        #region B_OPEN_COMMITMENT_CONTRACT
        public static DataSet B_OPEN_COMMITMENT_CONT_Load_ALLRepayAcct(string CustomerID, string Currency, string CategoryType)
        {
            return sqldata.ndkExecuteDataset("B_OPEN_COMMITMENT_CONT_Load_ALLRepayAcct",CustomerID, Currency, CategoryType);
        }
        public static void B_OPEN_COMMITMENT_CONT_Insert_Update_Acct(string ID, string Status,string CategoryCode, string CategoryName, string CustomerID, string GBFullName
            , string DocType, string DocID, string DocIssuePlace, DateTime? DocIssueDate, string CurrencyCode, string CommitmentAmt, DateTime? StartDate
            , DateTime? EndDate, string CommitmentFeeStart, string CommitmentFeeEnd, string AvailableAmt, string TrancheAmt, DateTime? DDStartDate, DateTime? DDEndDate, string IntRepayAcctID
            , string IntRepayAcctName, string Secured, string CustomerRemark,string AccountOfficeID, string AccountOfficerName, string ApproveUser)
        {
            sqldata.ndkExecuteNonQuery("B_OPEN_COMMITMENT_CONT_Insert_Update_Acct", ID, Status, CategoryCode, CategoryName, CustomerID, GBFullName
            , DocType, DocID, DocIssuePlace, DocIssueDate, CurrencyCode, CommitmentAmt, StartDate
            , EndDate, CommitmentFeeStart, CommitmentFeeEnd, AvailableAmt, TrancheAmt, DDStartDate, DDEndDate, IntRepayAcctID
            , IntRepayAcctName, Secured, CustomerRemark, AccountOfficeID, AccountOfficerName, ApproveUser);
        }
        public static DataSet B_OPEN_COMMITMENT_CONT_Check_Acct_Exist(string CategoryCode,string CustomerID, string Currency)
        {
            return sqldata.ndkExecuteDataset("B_OPEN_COMMITMENT_CONT_Check_Acct_Exist", CategoryCode, CustomerID, Currency);
        }
        public static DataSet ENQUIRY_CUSTOMER_Search_Account_Customer(string CustomerType, string CustomerID, string CellPhone, string GBFullName, string DocID,
                string MainSectorCode, string SubSectorCode, string MainIndustryCode, string SubIndustryCode)
        {
            return sqldata.ndkExecuteDataset("ENQUIRY_CUSTOMER_Search_Account_Customer", CustomerType, CustomerID, CellPhone, GBFullName, DocID, MainSectorCode,
                SubSectorCode, MainIndustryCode, SubIndustryCode);
        }
        public static void B_OPEN_COMMITMENT_CONT_Update_Status(string RefID, string CustomerID, string Status)
        {
            sqldata.ndkExecuteNonQuery("B_OPEN_COMMITMENT_CONT_Update_Status", RefID, CustomerID, Status);
        }
        public static DataSet B_OPEN_COMMITMENT_CONT_Load_Acct(string RefID)
        {
            return sqldata.ndkExecuteDataset("B_OPEN_COMMITMENT_CONT_Load_Acct", RefID);
        }
        public static DataSet B_OPEN_COMMITMENT_CONT_Enquiry_Account(string ID, string CustomerID, string GBFullName, string Currency, string Category, string DocID
            , string IntRepayAcc)
        {
            return sqldata.ndkExecuteDataset("B_OPEN_COMMITMENT_CONT_Enquiry_Account", ID, CustomerID, GBFullName, Currency, Category, DocID, IntRepayAcc);
        }
        #endregion
        #region B_DEFINE_CUSTOMER_LIMIT
        public static void B_CUSTOMER_LIMIT_Insert_Update(string MainLimitID, string CustomerID, string CommitmentType, string CurrencyCode, string CountryCode, string CountryName
            , DateTime? ApprovedDate, DateTime? OfferedUntil, DateTime? ExpiryDate, DateTime? Proposaldate, DateTime? AvailableDate, string InternalLimitAmt
            , string AdvisedAmt, string OriginalLimit, string Note, string Mode, string MaxTotal, string ApprovedUser)
        {
             sqldata.ndkExecuteNonQuery("B_CUSTOMER_LIMIT_Insert_Update", MainLimitID, CustomerID, CommitmentType, CurrencyCode, CountryCode, CountryName
            , ApprovedDate, OfferedUntil, ExpiryDate, Proposaldate, AvailableDate, InternalLimitAmt, AdvisedAmt, OriginalLimit, Note, Mode, MaxTotal, ApprovedUser);
        }
        public static string B_CUSTOMER_LIMIT_Check_CustomerID(string CustomerID)
        {
            return sqldata.ndkExecuteDataset("B_CUSTOMER_LIMIT_Check_CustomerID", CustomerID).Tables[0].Rows[0]["CustomerID"].ToString();
        }
        public static DataSet B_CUSTOMER_LIMIT_Load_CollateralType()
        {
            return sqldata.ndkExecuteDataset("B_CUSTOMER_LIMIT_Load_CollateralType");
        }
        public static DataSet B_CUSTOMER_LIMIT_Load_CollateralCode(string CollateralTypeCode)
        {
            return sqldata.ndkExecuteDataset("B_CUSTOMER_LIMIT_Load_CollateralCode", CollateralTypeCode);
        }
        public static DataSet B_CUSTOMER_LIMIT_Load_Customer_Limit(string CustomerLimitID)
        {
            return sqldata.ndkExecuteDataset("B_CUSTOMER_LIMIT_Load_Customer_Limit", CustomerLimitID);
        }
        public static void B_CUSTOMER_LIMIT_SUB_Insert_Update(string MainLimitID,string SubLimitID, string CustomerID,string SubCommitmentType, string STTSub, string mode, string CollateralTypeCode
            , string CollateralTypeName, string CollateralCode, string CollateralName, string CollReqdAmt, string CollReqdPct, string UptoPeriod, string PeriodAmt
            , string PeriodPct, string MaxSecured, string MaxUnSecured, string MaxTotal, string OtherSecured, string CollateralRight, string AmtSecured
            , string Onlinelimit, string AvailableAmt, string TotalOutstand, string ApprovedUser, string MainComtType)
        {
            sqldata.ndkExecuteNonQuery("B_CUSTOMER_LIMIT_SUB_Insert_Update",MainLimitID, SubLimitID, CustomerID, SubCommitmentType, STTSub, mode, CollateralTypeCode
                                        , CollateralTypeName, CollateralCode, CollateralName, CollReqdAmt, CollReqdPct, UptoPeriod, PeriodAmt
                                        , PeriodPct, MaxSecured, MaxUnSecured, MaxTotal, OtherSecured, CollateralRight, AmtSecured
                                        , Onlinelimit, AvailableAmt, TotalOutstand, ApprovedUser, MainComtType);
        }
        public static DataSet B_CUSTOMER_LIMIT_SUB_check_SubLimitID(string SubLimitID)
        {
            return sqldata.ndkExecuteDataset("B_CUSTOMER_LIMIT_SUB_check_SubLimitID", SubLimitID);
        }
        public static DataSet B_CUSTOMER_LIMIT_SUB_Load_for_tab_ORTHER_DETAILS(string SubLimitID)
        {
            return sqldata.ndkExecuteDataset("B_CUSTOMER_LIMIT_SUB_Load_for_tab_ORTHER_DETAILS", SubLimitID);
        }
        public static DataSet B_CUSTOMER_LIMIT_ENQUIRY(string MaHanMucCha, string MaHanMucCon, string CustomerName, string CustomerID, string CollateralType,
            string CollateralCode, string Currency, double FromIntLimitAmt, double ToItnLimitAmt)
        {
            return sqldata.ndkExecuteDataset("B_CUSTOMER_LIMIT_ENQUIRY", MaHanMucCha, MaHanMucCon, CustomerName, CustomerID, CollateralType, CollateralCode,
                Currency, FromIntLimitAmt, ToItnLimitAmt);
        }
        public static string B_CUSTOMER_LIMIT_LoadCustomerName(string CustomerID)
        {
            if (sqldata.ndkExecuteDataset("B_CUSTOMER_LIMIT_LoadCustomerName", CustomerID).Tables[0].Rows.Count > 0)

            { return sqldata.ndkExecuteDataset("B_CUSTOMER_LIMIT_LoadCustomerName", CustomerID).Tables[0].Rows[0]["CustomerName"].ToString(); }
            else return null;
        }
        #endregion
        #region INPUT CUSTOMER_RIGHT_Load_SubLimitID
        public static DataSet B_CUSTOMER_RIGHT_Load_SubLimitID(string CustomerID)
        {
            return sqldata.ndkExecuteDataset("B_CUSTOMER_RIGHT_Load_SubLimitID", CustomerID);
        }
        public static DataSet B_CUSTOMER_RIGHT_Load_CollateralTYpe(string SublimitID)
        {
            return sqldata.ndkExecuteDataset("B_CUSTOMER_RIGHT_Load_CollateralTYpe", SublimitID);
        }
        public static void B_CUSTOMER_LIMIT_Insert_Update(string RightID, string RightNo, string CustomerID, string CustomerName, string MainLimitID, string SubLimitID, string CollateralTypeCode, string CollateralTypeName, string CollateralCode, string CollateralName
      , DateTime? ValidityDate, DateTime? ExpiryDate, string Notes, string ApprovedUser)
        {
            sqldata.ndkExecuteNonQuery("B_CUSTOMER_LIMIT_Insert_Update", RightID, RightNo, CustomerID, CustomerName, MainLimitID, SubLimitID, CollateralTypeCode, CollateralTypeName, CollateralCode, CollateralName
      , ValidityDate, ExpiryDate, Notes, ApprovedUser);
        }
        public static DataSet B_CUSTOMER_LIMIT_Load_RightID(string RightID)
        {
            return sqldata.ndkExecuteDataset("B_CUSTOMER_LIMIT_Load_RightID", RightID);
        }
        #endregion
    }
}