using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using Telerik.Web.UI;
using BankProject.DataProvider;

namespace BankProject.Views.TellerApplication
{
    public partial class ChequeIssue : DotNetNuke.Entities.Modules.PortalModuleBase
    {
        public static int AutoID = 1;
        
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!this.IsPostBack)
            {
                tbQuantityOfIssued.Focus();
                tbID.Text = "CC.060002595918." + DataProvider.TriTT.B_CHEQUE_ISSUE_NO("CHEQUE_ISSUE_NO").ToString().PadLeft(6,'0');
                lblChequeCode.Text = "Phan Van Han";
                this.rdpIssueDate.SelectedDate = DateTime.Now;
                rcbChequeStatus.SelectedValue = "90";

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
        private void LoadToolBar(bool isauthorize)
        {
            RadToolBar1.FindItemByValue("btCommitData").Enabled = !isauthorize;
            RadToolBar1.FindItemByValue("btPreview").Enabled = !isauthorize;
            RadToolBar1.FindItemByValue("btAuthorize").Enabled = isauthorize;
            RadToolBar1.FindItemByValue("btReverse").Enabled = isauthorize;
            RadToolBar1.FindItemByValue("btSearch").Enabled = false;
            RadToolBar1.FindItemByValue("btPrint").Enabled = false;
        }
        protected void RadToolBar1_ButtonClick(object sender, RadToolBarEventArgs e)
        {
            var ToolBarButton = e.Item as RadToolBarButton;
            var commandName = ToolBarButton.CommandName;
            if (commandName == "commit")
            {
                Response.Redirect(EditUrl("waivecharges"));
                AutoID++;
                tbQuantityOfIssued.Focus();
                tbID.Text = "CC.060002595918." + DataProvider.TriTT.B_CHEQUE_ISSUE_NO("CHEQUE_ISSUE_NO").ToString().PadLeft(6,'0');

                rcbChequeStatus.SelectedValue = "90";
                this.rdpIssueDate.SelectedDate = DateTime.Now;
                rcbChequeStatus.SelectedValue = "";
                tbQuantityOfIssued.Text = "";
                tbChequeNoStart.Text = "";
                Response.Redirect("Default.aspx?tabid=141");
            }
            if (commandName == "Preview")
            {
                Response.Redirect(EditUrl("ChequeIssue_PL"));
            }
            if (commandName == "authorize" || commandName == "reverse")
            {
                LoadToolBar(false);
                BankProject.Controls.Commont.SetTatusFormControls(this.Controls, true);
                 AfterProc();
            }
        }
        void AfterProc()
        {
            tbQuantityOfIssued.Focus();
           
            tbID.Text = "CC.060002595918." + DataProvider.TriTT.B_CHEQUE_ISSUE_NO("CHEQUE_ISSUE_NO").ToString().PadLeft(6, '0');
            this.rdpIssueDate.SelectedDate = DateTime.Now;
            this.tbChequeNoStart.Text = "";
            tbQuantityOfIssued.Text = "";
            rcbCurrency.SelectedValue = "";
        }
        protected void LoadDataPreview()
        {
            Random AutoNum = new Random();
            if (Request.QueryString["PRCode"] != null)
            {
                string PCCode = Request.QueryString["PRCode"].ToString();
                switch (PCCode)
                { 
                    case "0":
                        tbID.Text = "CC.060002595926.0000001";                        
                        rdpIssueDate.SelectedDate = Convert.ToDateTime("9/6/2014");
                        tbQuantityOfIssued.Text = "10";
                        tbChequeNoStart.Text = Convert.ToString(AutoNum.Next(500000, 599999));
                        rcbCurrency.SelectedValue = "VND";
                        break;

                    case "1":
                        tbID.Text = "CC.060002595927.0000001";
                        rdpIssueDate.SelectedDate = Convert.ToDateTime("8/6/2014");
                        tbQuantityOfIssued.Text = "10";
                        tbChequeNoStart.Text = Convert.ToString(AutoNum.Next(500000, 599999));
                        rcbCurrency.SelectedValue = "VND";
                        break;
                    case "2":
                        tbID.Text = "CC.060002595928.0000001";
                        rdpIssueDate.SelectedDate = Convert.ToDateTime("1/6/2014");
                        tbQuantityOfIssued.Text = "10";
                        tbChequeNoStart.Text = Convert.ToString(AutoNum.Next(500000, 599999));
                        rcbCurrency.SelectedValue = "VND";
                        break;
                    case "3":
                        tbID.Text = "CC.060002595929.0000001";
                        rdpIssueDate.SelectedDate = Convert.ToDateTime("1/6/2014");
                        tbQuantityOfIssued.Text = "10";
                        tbChequeNoStart.Text = Convert.ToString(AutoNum.Next(500000, 599999));
                        rcbCurrency.SelectedValue = "VND";
                        break;
                    case "4":
                        tbID.Text = "CC.060002595930.0000001";
                        rdpIssueDate.SelectedDate = Convert.ToDateTime("2/6/2014");
                        tbQuantityOfIssued.Text = "10";
                        tbChequeNoStart.Text = Convert.ToString(AutoNum.Next(500000, 599999));
                        rcbCurrency.SelectedValue = "VND";
                        break;
                    case "5":
                        tbID.Text = "CC.060002595931.0000001";
                        rdpIssueDate.SelectedDate = Convert.ToDateTime("3/6/2014");
                        tbQuantityOfIssued.Text = "10";
                        tbChequeNoStart.Text = Convert.ToString(AutoNum.Next(500000, 599999));
                        rcbCurrency.SelectedValue = "VND";
                        break;

                    case "6":
                        tbID.Text = "CC.060002595932.0000001";
                        rdpIssueDate.SelectedDate = Convert.ToDateTime("4/6/2014");
                        tbQuantityOfIssued.Text = "10";
                        tbChequeNoStart.Text = Convert.ToString(AutoNum.Next(500000, 599999));
                        rcbCurrency.SelectedValue = "VND";
                        break;
                    case "7":
                        tbID.Text = "CC.060002595933.0000001";
                        rdpIssueDate.SelectedDate = Convert.ToDateTime("5/6/2014");
                        tbQuantityOfIssued.Text = "10";
                        tbChequeNoStart.Text = Convert.ToString(AutoNum.Next(500000, 599999));
                        rcbCurrency.SelectedValue = "VND";
                        break;
                    case "8":
                        tbID.Text = "CC.060002595934.0000001";
                        rdpIssueDate.SelectedDate = Convert.ToDateTime("6/6/2014");
                        tbQuantityOfIssued.Text = "10";
                        tbChequeNoStart.Text = Convert.ToString(AutoNum.Next(500000, 599999));
                        rcbCurrency.SelectedValue = "VND";
                        break;

                    case "9":
                        tbID.Text = "CC.060002595935.0000001";
                        rdpIssueDate.SelectedDate = Convert.ToDateTime("7/6/2014");
                        tbQuantityOfIssued.Text = "10";
                        tbChequeNoStart.Text = Convert.ToString(AutoNum.Next(500000, 599999));
                        rcbCurrency.SelectedValue = "VND";
                        break;
                }
            }
        }
    }
}