using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Telerik.Web.UI;
using BankProject.DataProvider;
using System.Data;

namespace BankProject.Views.TellerApplication
{
    public partial class ChequeWithrawalDrawOnUs : DotNetNuke.Entities.Modules.PortalModuleBase
    {
        protected string refix_MACODE()
        {
            return "TT";
        }
        protected void Page_Load(object sender, EventArgs e)
        {
            if (IsPostBack) return;
            tbID.Text = DataProvider.TriTT.B_BMACODE_GetNewID_3par("COLL_CONTIN_ENTRY", refix_MACODE(), "/");
            rdpIssDate.SelectedDate = DateTime.Now;
            tbTellerID.Text = UserInfo.Username;
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
        protected void RadToolBar1_ButtonClick(object sender, RadToolBarEventArgs e)
        { 
            var toolBarButton = e.Item as RadToolBarButton;
            var commandName = toolBarButton.CommandName;
            if (commandName == "commit")
            {
                tbID.Text = DataProvider.TriTT.B_BMACODE_GetNewID_3par("COLL_CONTIN_ENTRY", refix_MACODE(), "/");
                rdpIssDate.SelectedDate = DateTime.Now;
                rcbAccCustomer.SelectedValue = "";
                tbAmountLocal.Text = "";
                //tbAmountFCY.Text = "";
                rcbChequeType.SelectedValue = "";
                tbChequeNo.Text = "";
                rcbAccountPaid.SelectedValue = "";
                tbDealRate.Text = "";
                lblAmtPaidToCust.Text = "";
                tbNarrative.Text = "";
                tbBeneName.Text = "";
                tbAddress.Text = "";
                tbLegalID.Text = "";
                rdpIssDate.SelectedDate = DateTime.Now;
                tbPlaceOfIss.Text = "";
                rcbCurrency.SelectedValue = "";
                rcbCurrencyPaid.SelectedValue = "";
                tbTellerID.Text = UserInfo.Username;
            }
            if (commandName == "Preview")
            {
                Response.Redirect(EditUrl("ChequeWithrawalDrawOnUs_PL"));
            }
            if (commandName == "authorize" || commandName == "reverse")
            {
                BankProject.Controls.Commont.SetTatusFormControls(this.Controls, true);
                LoadToolBar(false);
                AfterProc();
            }
        }
        protected void LoadDataPreview()
        {
            if (Request.QueryString["PRCode"] != null)
            {
                string PRCode = Request.QueryString["PRCode"].ToString();
                switch (PRCode)
                { 
                    case "0":
                        LoadDetailPreveiew("TT/14195/08279","1100001","Phan Van Han","VND","0","10000000","30000000",
                           "CHI TRA SEC","CTY TNHH TOAN CAU","100 Pham Ngu Lao, Q1");
                        break;
                    case "1":
                        LoadDetailPreveiew("TT/14195/08291", "1100002", "Dinh Tien Hoang", "VND", "1", "11000000", "30000000",
                           "CHI TRA TIEN THUE NHA", "CTY TNHH TOAN CAU", "100 Pham Ngu Lao, Q1");
                        break;
                    case "2":
                        LoadDetailPreveiew("TT/14195/08292", "1100003", "Pham Ngoc Thach", "VND", "2", "12000000", "30000000",
                           "CHI TRA TIEN THUE NHA", "CTY TNHH TOAN CAU", "100 Pham Ngu Lao, Q1");
                        break;
                    case "3":
                        LoadDetailPreveiew("TT/14195/08293", "1100004", "Vo Thi Sau", "VND", "3", "13000000", "30000000",
                           "CHI TRA TIEN THUE NHA", "CTY TNHH TOAN CAU", "100 Pham Ngu Lao, Q1");
                        break;
                    case "4":
                        LoadDetailPreveiew("TT/14195/08294", "1100005", "Truong Cong Dinh", "VND", "0", "14000000", "30000000",
                           "CHI TRA TIEN THUE NHA", "CTY TNHH TOAN CAU", "100 Pham Ngu Lao, Q1");
                        break;
                    case "5":
                        LoadDetailPreveiew("TT/14195/08295", "2102925", "Cty TNHH SONG HONG", "VND", "1", "15000000", "30000000",
                           "CHI TRA TIEN THUE NHA", "CTY TNHH TOAN CAU", "100 Pham Ngu Lao, Q1");
                        break;
                    case "6":
                        LoadDetailPreveiew("TT/14195/08296", "2102926", "CTY TNHH PHAN MEM ABC", "VND", "2", "16000000", "30000000",
                           "CHI TRA TIEN THUE NHA", "CTY TNHH TOAN CAU", "100 Pham Ngu Lao, Q1");
                        break;
                    case "7":
                        LoadDetailPreveiew("TT/14195/08297", "2102927", "VietVictory CORP", "VND", "3", "17000000", "30000000",
                           "CHI TRA TIEN THUE NHA", "CTY TNHH TOAN CAU", "100 Pham Ngu Lao, Q1");
                        break;
                    case "8":
                        LoadDetailPreveiew("TT/14195/08298", "2102928", "WALLSTREET CORP", "VND", "0", "20000000", "30000000",
                           "CHI TRA TIEN THUE NHA", "CTY TNHH TOAN CAU", "100 Pham Ngu Lao, Q1");
                        break;
                    case "9":
                        LoadDetailPreveiew("TT/14195/08299", "2102929", "PLC CORP", "VND", "1", "19000000", "30000000",
                           "CHI TRA TIEN THUE NHA", "CTY TNHH TOAN CAU", "100 Pham Ngu Lao, Q1");
                        break;
                }
            }
        }

        private void AfterProc()
        {
            tbID.Text = DataProvider.TriTT.B_BMACODE_GetNewID_3par("COLL_CONTIN_ENTRY", refix_MACODE(), "/");
            rdpIssDate.SelectedDate = DateTime.Now;
            rcbCurrency.SelectedValue = "";
            rcbCurrencyPaid.SelectedValue = "";
            tbID.Text = "TT/14195/08300";
            lblCustomerID.Text = "";
            lblCustomerName.Text = "";
            rcbAccountPaid.SelectedValue = rcbCurrencyPaid.SelectedValue = rcbCurrency.SelectedValue = "";
            rcbAccCustomer.SelectedValue = "";
            lblAmtPaidToCust.Text = tbAmountLocal.Text = "";
            lblOldCustBal.Text = "";
            lblNewCustBal.Text = "";
            rcbChequeType.SelectedValue = "";
            tbLegalID.Text = tbChequeNo.Text = "";
            tbTellerID.Text = "host";
            tbNarrative.Text = "";
            tbBeneName.Text = "";
            tbAddress.Text = "";
            tbTellerID.Text = UserInfo.Username;
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
        private void LoadDetailPreveiew( string chequeID, string CustomerID, string CustomerName,string Currency, string AccountCust, string Amount, string OldCustBal, 
            string Narrative, string BeneName, string Address)
        {
            Random AutoCheque = new Random();
            tbID.Text = chequeID;
            lblCustomerID.Text = CustomerID;
            lblCustomerName.Text=CustomerName;
            rcbAccountPaid.SelectedValue= rcbCurrencyPaid.SelectedValue= rcbCurrency.SelectedValue=Currency;
            rcbAccCustomer.SelectedValue = AccountCust;
            lblAmtPaidToCust.Text= tbAmountLocal.Text=Amount;
            lblOldCustBal.Text=OldCustBal;
            lblNewCustBal.Text = Convert.ToString(Convert.ToInt32(OldCustBal) - Convert.ToInt32(Amount));
            rcbChequeType.SelectedValue="CC";
            tbLegalID.Text=tbChequeNo.Text= Convert.ToString(AutoCheque.Next(50000000,90000000));
            tbTellerID.Text="host";
            tbNarrative.Text=Narrative;
            tbBeneName.Text=BeneName;
            tbAddress.Text=Address;           
        }

        protected void rcbCurrency_OnSelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
        {
            rcbAccCustomer.Items.Clear();
            rcbAccCustomer.AppendDataBoundItems = true;
            rcbAccCustomer.Items.Add(new RadComboBoxItem("", ""));
            rcbAccCustomer.DataSource = DataProvider.Database.B_BDRFROMACCOUNT_GetByCustomer("", rcbCurrency.SelectedValue);
            rcbAccCustomer.DataValueField = "ID";
            rcbAccCustomer.DataTextField = "Display";
            rcbAccCustomer.DataBind();
        }
    }
}