using DotNetNuke.Entities.Modules;
using System;
using Telerik.Web.UI;
using System.Data;
using BankProject.DataProvider;


namespace BankProject.Views.TellerApplication
{
    public partial class ChequeTransferDrawnOnUs : PortalModuleBase
    {

        protected string B_MACODE()
        {
            return "TT";
        }
        private void LoadToolBar(bool isauthorize)
        {
            RadToolBar1.FindItemByValue("btCommitData").Enabled = !isauthorize;
            RadToolBar1.FindItemByValue("btPreview").Enabled = !isauthorize;
            RadToolBar1.FindItemByValue("btAuthorize").Enabled = isauthorize;
            RadToolBar1.FindItemByValue("btReverse").Enabled = isauthorize;
            RadToolBar1.FindItemByValue("btSearch").Enabled = false;
            RadToolBar1.FindItemByValue("btPrint").Enabled = false;
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!this.IsPostBack)
            {
                this.tbID.Text = DataProvider.TriTT.B_BMACODE_GetNewID_3par("TRS_CRED_CARD_PAYM", B_MACODE());
                this.rcbDebitCurrency.Focus();
                
              rdpCreditValueDate.SelectedDate= rdpValueDate.SelectedDate = this.rdpExposureDate.SelectedDate = DateTime.Now;

                if (Request.QueryString["IsAuthorize"] != null)
                {
                    LoadToolBar(true);
                    LoadDataPreview();
                    BankProject.Controls.Commont.SetTatusFormControls(this.Controls, false);
                }
                else
                {
                    LoadToolBar(false);
                }
            }

        }
        private void LoadDataPreview()
        {
            if (Request.QueryString["LCCode"] != null)
            {
                string LCCode = Request.QueryString["LCCode"].ToString();
                switch (LCCode)
                {
                    case "0":
                        LoadDetailPreview("TT/14195/08279", "1100001", "VU THI MY HANH", "VND", "0", 10000000, 60000000, "03/15/2014");
                        break;
                    case "1":
                        LoadDetailPreview("TT/14195/08261", "1100002", "DINH TIEN HOANG", "VND", "1", 12000000, 60000000, "10/07/2014");
                        break;
                    case "2":
                        LoadDetailPreview("TT/14195/08262", "1100003", "PHAM NGOC THACH", "VND", "2", 14000000, 60000000, "01/19/2014");
                        break;
                    case "3":
                        LoadDetailPreview("TT/14195/08263", "1100004", "VO THI SAU", "VND", "3", 16000000, 60000000, "09/02/2014");
                        break;

                    case "4":
                        LoadDetailPreview("TT/14195/08264", "1100005", "TRUONG CONG DINH", "VND", "0", 20000000, 60000000, "03/03/2014");
                        break;
                    case "5":
                        LoadDetailPreview("TT/14195/08265", "2102925", "CTY TNHH SONG HONG", "VND", "1", 22000000, 60000000, "11/01/2014");
                        break;
                    case "6":
                        LoadDetailPreview("TT/14195/08266", "2102926", "CTY TNHH BAS", "VND", "2", 24000000, 60000000, "12/02/2014");
                        break;

                    case "7":
                        LoadDetailPreview("TT/14195/08267", "2102927", "TRADE CORP", "VND", "3", 26000000, 60000000, "01/03/2014");
                        break;
                    case "8":
                        LoadDetailPreview("TT/14195/08269", "2102928", "CTY MINH ANH", "VND", "0", 30000000, 60000000, "01/04/2014");
                        break;
                    case "9":
                        LoadDetailPreview("TT/14195/08270", "2102929", "CTY HOANG VU", "VND", "1", 40000000, 60000000, "09/07/2014");
                        break;
                }
            }
        }
        private void LoadDetailPreview(string fillID, string CustomerID, string CustomerName, string Currency, string DebitAccount, Int32 DebitAmount, Int32 OldCustBal, string ValueDate)
        {
            Random AutoCheNo = new Random();
            tbID.Text = fillID;
            lblCustomerID.Text = CustomerID;
            lblCustomerName.Text = CustomerName;
            rcbCreditCurrency.SelectedValue = rcbDebitCurrency.SelectedValue = Currency;
            loadDebitAccount(CustomerName);
            rcbDebitAccount.SelectedIndex = 1;
            lblAmtCreditForCust.Text = tbDebitAmountLCY.Text = DebitAmount.ToString();
            rcbChequeType.SelectedValue = "AB";
            tbChequeNo.Text = Convert.ToString(AutoCheNo.Next(50000000, 900000000));
            lblOldCustBal.Text = OldCustBal.ToString();
            lblNewCustBal.Text = Convert.ToString(OldCustBal - DebitAmount);
            rdpCreditValueDate.SelectedDate=  rdpExposureDate.SelectedDate = rdpValueDate.SelectedDate = Convert.ToDateTime(ValueDate);
            rcbSmartBankBranch.SelectedValue = "0";
            LoadCreidtAccount();
            lblCreditCustomerName.Text = "Wall Street Corp.";
            lblCreditCustomerID.Text = "2102928";
            rcbCreditAccount.SelectedIndex = 1;
            rcbWaiveCharges.SelectedValue = "NO";
            tbNarrative.Text = "CHI TRA SEC BANG CHUYEN KHOANG";
        }

        protected void OnRadToolBarClick(object sender, RadToolBarEventArgs e)
        {
            var toolbarButton = e.Item as RadToolBarButton;
            var CommandName = toolbarButton.CommandName;
            if (CommandName == "commit")
            {
                DefaultSetting();
            }
            if (CommandName == "Preview")
            {
                Response.Redirect(EditUrl("ChequeTransferDrawnOnUs_PL"));
            }
            if (CommandName == "authorize" || CommandName == "reverse")
            {
                LoadToolBar(false);
                BankProject.Controls.Commont.SetTatusFormControls(this.Controls, true);
                DefaultSetting();
            }
        }

        protected void DefaultSetting()
        {
            this.tbID.Text = DataProvider.TriTT.B_BMACODE_GetNewID_3par("TRS_CRED_CARD_PAYM", B_MACODE());
            this.rcbDebitCurrency.Focus();
            lblCustomerID.Text = lblCustomerName.Text = "";
            rcbCreditCurrency.SelectedValue = rcbDebitCurrency.SelectedValue = "";
            rcbDebitAccount.SelectedValue = "";
            lblAmtCreditForCust.Text = tbDebitAmountLCY.Text = "";
            rcbChequeType.SelectedValue = "";
            tbChequeNo.Text = "";
            lblOldCustBal.Text = "";
            lblNewCustBal.Text = "";
            rdpCreditValueDate.SelectedDate=  rdpExposureDate.SelectedDate = rdpValueDate.SelectedDate = DateTime.Now;
            lblCreditCustomerName.Text = "";
            lblCreditCustomerID.Text = "";
            rcbSmartBankBranch.SelectedValue = "";
            rcbCreditAccount.SelectedValue = "";
            rcbWaiveCharges.SelectedValue = "";
            tbNarrative.Text = "";
            //tbDebitAmountFCY.Text = "";
            tbDealRate.Text = "";
        }

        void loadDebitAccount(string customerName)
        {
            rcbDebitAccount.Items.Clear();
            DataSet ds = BankProject.DataProvider.Database.B_BDRFROMACCOUNT_GetByCustomer(customerName, rcbDebitCurrency.SelectedValue);
            if (ds != null && ds.Tables.Count > 0 && ds.Tables[0].Rows.Count > 0)
            {
                DataRow dr = ds.Tables[0].NewRow();
                dr["DisplayHasCurrency"] = "";
                dr["Id"] = "";
                dr["CustomerID"] = "";
                dr["Name"] = "";

                ds.Tables[0].Rows.InsertAt(dr, 0);

                rcbDebitAccount.DataTextField = "DisplayHasCurrency";
                rcbDebitAccount.DataValueField = "Id";
                rcbDebitAccount.DataSource = ds;
                rcbDebitAccount.DataBind();
            }
        }

        protected void rcbDebitCurrency_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
        {
            loadDebitAccount("");
        }

        protected void rcbDebitAccount_ItemDataBound(object sender, RadComboBoxItemEventArgs e)
        {
            DataRowView row = e.Item.DataItem as DataRowView;
            e.Item.Attributes["Name"] = row["Name"].ToString();
            e.Item.Attributes["CustomerID"] = row["CustomerID"].ToString();
        }

        void LoadCreidtAccount()
        {
            rcbCreditAccount.Items.Clear();
            if (rcbDebitAccount.SelectedValue != "" && rcbCreditCurrency.SelectedValue != "")
            {
                DataSet ds = BankProject.DataProvider.Database.B_BCRFROMACCOUNT_OtherCustomer(rcbDebitAccount.SelectedItem.Attributes["Name"].ToString(), rcbCreditCurrency.SelectedValue);
                if (ds != null && ds.Tables.Count > 0 && ds.Tables[0].Rows.Count > 0)
                {
                    DataRow dr = ds.Tables[0].NewRow();
                    dr["Display"] = "";
                    dr["Id"] = "";
                    dr["CustomerID"] = "";
                    dr["Name"] = "";
                    ds.Tables[0].Rows.InsertAt(dr, 0);

                    rcbCreditAccount.DataTextField = "Display";
                    rcbCreditAccount.DataValueField = "Id";
                    rcbCreditAccount.DataSource = ds;
                    rcbCreditAccount.DataBind();
                }
            }
        }

        protected void rcbDebitAccount_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
        {
            LoadCreidtAccount();
        }

        protected void rcbCreditCurrency_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
        {
            LoadCreidtAccount();
        }

        protected void rcbCreditAccount_ItemDataBound(object sender, RadComboBoxItemEventArgs e)
        {
            DataRowView row = e.Item.DataItem as DataRowView;
            e.Item.Attributes["Name"] = row["Name"].ToString();
            e.Item.Attributes["CustomerID"] = row["CustomerID"].ToString();
        }
    }
}