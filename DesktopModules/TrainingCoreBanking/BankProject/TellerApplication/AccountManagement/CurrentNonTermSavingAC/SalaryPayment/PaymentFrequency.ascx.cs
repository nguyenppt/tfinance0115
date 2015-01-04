using BankProject.DataProvider;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Telerik.Web.UI;

namespace BankProject.TellerApplication.AccountManagement.CurrentNonTermSavingAC.SalaryPayment
{
    public partial class PaymentFrequency : DotNetNuke.Entities.Modules.PortalModuleBase
    {
         
        protected void Page_Load(object sender, EventArgs e)
        {
            if (IsPostBack) return;

            LoadToolBar();

            rcbAccountPayment.Items.Clear();
            rcbAccountPayment.Items.Add(new RadComboBoxItem(""));
            rcbAccountPayment.AppendDataBoundItems = true;
            rcbAccountPayment.DataValueField = "CustomerID";
            rcbAccountPayment.DataTextField = "Display";
            rcbAccountPayment.DataSource = DataProvider.SQLData.B_BCUSTOMERS_GetCompany();
            rcbAccountPayment.DataBind();
            if (Request.QueryString["CustomerID"] != null)
            {
                rcbAccountPayment.SelectedValue = Request.QueryString["CustomerID"];
                SqlDataSourceControls.SelectParameters.Clear();
                SqlDataSourceControls.SelectParameters.Add("Code", Request.QueryString["CustomerID"] + " - " + Request.QueryString["CustomerName"]);
                this.SqlDataSourceControls.DataBind();
                System.Data.DataView dview = (System.Data.DataView)SqlDataSourceControls.Select(DataSourceSelectArguments.Empty);
                double? total = 0;
                foreach (System.Data.DataRow row in dview.Table.Rows)
                {
                    total += Convert.ToDouble(row["CreditAmount"]);
                    //string name = row[1].toString();
                    // ...
                }
                this.tbTotalDebitAmt.Value = total;
                this.rdpEndDate.SelectedDate = DateTime.Now.AddDays(-20);
                this.rdpFrequency.SelectedDate = DateTime.Now.AddDays(-5);
                string customerName = Request.QueryString["CustomerName"].Replace(".","");
                this.tbImportFile.Text = customerName + ".xls";
                this.tbOrderingCust.Text = "CHI THEO HOP DONG LAO DONG SO 2345";
                isEnableControls(false);
                RadToolBar1.FindItemByValue("btnPreview").Enabled = false;
                RadToolBar1.FindItemByValue("btnCommit").Enabled = false;
                RadToolBar1.FindItemByValue("btnAuthorize").Enabled = true;
                RadToolBar1.FindItemByValue("btnReverse").Enabled = true;
            }
        }
        
        private void LoadToolBar()
        {
            RadToolBar1.FindItemByValue("btnPreview").Enabled = false;
            RadToolBar1.FindItemByValue("btnAuthorize").Enabled = false;
            RadToolBar1.FindItemByValue("btnReverse").Enabled = false;
            RadToolBar1.FindItemByValue("btnSearch").Enabled = false;
            RadToolBar1.FindItemByValue("btnPrint").Enabled = false;
        }
        protected void RadToolBar1_ButtonClick(object sender, RadToolBarEventArgs e)
        {
            //string normalLoan = tbNewNormalLoan.Text;
            var ToolBarButton = e.Item as RadToolBarButton;
            string commandName = ToolBarButton.CommandName;
            switch (commandName)
            {
                case "commit":
                    DisableButton(true);
                    isEnableControls(false);
                    break;
                case "Preview":
                    string[] param = new string[1];
                    param[0] = "id=" + PortalSettings.ActiveTab.KeyID;
                    Response.Redirect(EditUrl("", "", "list",param));
                    break;
                case "authorize":
                    Response.Redirect(DotNetNuke.Common.Globals.NavigateURL(PortalSettings.ActiveTab.KeyID));
                    break;
                case "reverse":
                    Response.Redirect(DotNetNuke.Common.Globals.NavigateURL(PortalSettings.ActiveTab.KeyID));
                    break;
                case "search":
                    break;
                default:
                    RadToolBar1.FindItemByValue("btnCommit").Enabled = true;
                    break;
            }

            //string[] param = new string[4];
            //param[0] = "NewNormalLoan=" + normalLoan;
            //Response.Redirect(EditUrl("", "", "fullview", param));
        }

        private void isEnableControls(bool p)
        {
            this.rdpFrequency.Enabled = p;
            this.tbOrderingCust.Enabled = p;
            this.tbTotalDebitAmt.Enabled = p;
            this.ImportFileUpload.Enabled = p;
            this.ListView1.Enabled = p;
            this.SubmitButton.Enabled = p;
            this.rdpEndDate.Enabled = p;
            this.rcbAccountPayment.Enabled = p;
        }

        private void DisableButton(bool p)
        {
            RadToolBar1.FindItemByValue("btnPreview").Enabled = p;
            RadToolBar1.FindItemByValue("btnCommit").Enabled = !p;
            RadToolBar1.FindItemByValue("btnAuthorize").Enabled = !p;
            RadToolBar1.FindItemByValue("btnReverse").Enabled = !p;
        }

        protected void SubmitButton_Click(object sender, EventArgs e)
        {
            this.ListView1.Items.Clear();
            
            if (ImportFileUpload.UploadedFiles.Count > 0 && !rcbAccountPayment.Text.Equals(""))
            {
                string nameCB = rcbAccountPayment.Text.Split('-')[1];
                UploadedFile file = ImportFileUpload.UploadedFiles[0];
                string name = file.FileName.Split('.')[0];
                if (name.Replace(".", "").ToUpper().Trim().Equals(nameCB.Replace(".", "").ToUpper().Trim()))
                {
                    labelNoResults.Visible = false;

                    //string idCompany = rcbAccountPayment.SelectedValue;
                    SqlDataSourceControls.SelectParameters.Clear();
                    SqlDataSourceControls.SelectParameters.Add("Code", rcbAccountPayment.Text);
                    this.SqlDataSourceControls.DataBind();
                    System.Data.DataView dview = (System.Data.DataView)SqlDataSourceControls.Select(DataSourceSelectArguments.Empty);
                    double? total = 0;
                    foreach (System.Data.DataRow row in dview.Table.Rows)
                    {
                        total += Convert.ToDouble(row["CreditAmount"]);
                    }
                    this.tbTotalDebitAmt.Value = total;
                    //this.tbImportFile.Text = file.FileName;
                }
                else
                {
                    labelNoResults.Text = "Wrong Selected Company Payment file";
                    rcbAccountPayment.SelectedIndex = 0;
                    this.ListView1.Items.Clear();
                    labelNoResults.Visible = true;
                }
            }
            else
            {
                labelNoResults.Text = "Please choose a file to import and a credit account.";
                labelNoResults.Visible = true;
            }
        }
    }
}