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
    public partial class NewNormalLoan : DotNetNuke.Entities.Modules.PortalModuleBase
    {
        private string refix_MACODE()
        {
            return "LD";
        }
        protected void Page_Load(object sender, EventArgs e)
        {
            if (IsPostBack) return;
                 LoadToolBar();
                
            DataSet dsCs=DataProvider.DataTam.B_BCUSTOMERS_GetAll();

            rcbCustomerID.Items.Add(new RadComboBoxItem(""));
            rcbCustomerID.DataSource = CustomeTable(dsCs.Tables[0]);
            rcbCustomerID.DataTextField = "CustomerID";
            rcbCustomerID.DataValueField = "CustomerName2";
            rcbCustomerID.DataBind();

            rcbMainCategory.Items.Clear();
            rcbMainCategory.Items.Add(new RadComboBoxItem(""));
            rcbMainCategory.AppendDataBoundItems = true;
            rcbMainCategory.DataValueField = "CatId";
            rcbMainCategory.DataTextField = "Display";
            rcbMainCategory.DataSource = SQLData.B_BRPODCATEGORY_GetAll_IdOver200();
            rcbMainCategory.DataBind();


            //rcbSubCategory.Items.Clear();
            //rcbSubCategory.Items.Add(new RadComboBoxItem(""));
            //rcbSubCategory.DataValueField = "SubCatId";
            //rcbSubCategory.DataTextField = "Display";
            //rcbSubCategory.DataSource = SQLData.B_BRPODCATEGORY_GetSubAll_IdOver200();
            //rcbSubCategory.DataBind();


            rcbPurposeCode.Items.Clear();
            rcbPurposeCode.Items.Add(new RadComboBoxItem(""));
            rcbPurposeCode.AppendDataBoundItems = true;
            rcbPurposeCode.DataValueField = "Id";
            rcbPurposeCode.DataTextField = "Name";
            rcbPurposeCode.DataSource = SQLData.B_BLOANPURPOSE_GetAll();
            rcbPurposeCode.DataBind();


            rcbLoadGroup.Items.Clear();
            rcbLoadGroup.Items.Add(new RadComboBoxItem(""));
            rcbLoadGroup.AppendDataBoundItems = true;
            rcbLoadGroup.DataValueField = "Id";
            rcbLoadGroup.DataTextField = "Name";
            rcbLoadGroup.DataSource = SQLData.B_BLOANGROUP_GetAll();
            rcbLoadGroup.DataBind();
            //rcbCreditToAccount.Items.Clear();
            //rcbCreditToAccount.Items.Add(new RadComboBoxItem(""));
            //rcbCreditToAccount.DataValueField = "Id";
            //rcbCreditToAccount.DataTextField = "Display";
            //rcbCreditToAccount.DataSource = SQLData.B_BDRFROMACCOUNT_GetAll();
            //rcbCreditToAccount.DataBind();

            //rcbPrinRepAccount.Items.Clear();
            //rcbPrinRepAccount.Items.Add(new RadComboBoxItem(""));
            //rcbPrinRepAccount.DataValueField = "Id";
            //rcbPrinRepAccount.DataTextField = "Display";
            //rcbPrinRepAccount.DataSource = SQLData.B_BDRFROMACCOUNT_GetAll();
            //rcbPrinRepAccount.DataBind();

            //rcbIntRepAccount.Items.Clear();
            //rcbIntRepAccount.Items.Add(new RadComboBoxItem(""));
            //rcbIntRepAccount.DataValueField = "Id";
            //rcbIntRepAccount.DataTextField = "Display";
            //rcbIntRepAccount.DataSource = SQLData.B_BDRFROMACCOUNT_GetAll();
            //rcbIntRepAccount.DataBind();

            //rcbChargRepAccount.Items.Clear();
            //rcbChargRepAccount.Items.Add(new RadComboBoxItem(""));
            //rcbChargRepAccount.DataValueField = "Id";
            //rcbChargRepAccount.DataTextField = "Display";
            //rcbChargRepAccount.DataSource = SQLData.B_BDRFROMACCOUNT_GetAll();
            //rcbChargRepAccount.DataBind();

            rcbCurrency.SelectedValue = "VND";
            rdpOpenDate.SelectedDate = DateTime.Now;
            rdpValueDate.SelectedDate = DateTime.Now;
            rcbMainCategory.Focus();


           
            Page.ClientScript.RegisterStartupScript(this.GetType(), "Alert", "clickMainTab();", true);
            if (Request.Params["codeid"] == null)
                tbNewNormalLoan.Text = SQLData.B_BMACODE_GetNewID("CRED_REVOLVING_CONTRACT", refix_MACODE(), "/");
            else
            {
                
                tbNewNormalLoan.Text = Request.Params["codeid"];
                rcbCustomerID.SelectedIndex = int.Parse(Request.QueryString["idx"]);
                SetDataCombox();
                rcbMainCategory.SelectedIndex = 2;
                LoadSubCategory();
                rcbSubCategory.SelectedIndex = 1;
                rcbPurposeCode.SelectedIndex = 5;
                rcbLoadGroup.SelectedIndex = 2;
                tbLoanAmount.Text = Request.QueryString["amount"];
                tbApprovedAmt.Text = tbLoanAmount.Text.Replace(",","");
                rdpOpenDate.SelectedDate = DateTime.Now.AddYears(-2).AddDays(-12);
                rdpValueDate.SelectedDate = DateTime.Now.AddYears(-2).AddDays(-12);
                rdpMaturityDate.SelectedDate = DateTime.Now.AddDays(-1).AddDays(-12);
                rcbCreditToAccount.SelectedIndex = 8;
                rcbCommitmentID.SelectedIndex = 1;
                rcbLimitReference.SelectedIndex = 1;
                rcbRateType.SelectedIndex = 1;
                tbInterestRate.Text = "4";
                rcbAutoSch.SelectedIndex = 1;
                rcbRepaySchType.SelectedIndex = 1;
                rcbDefineSch.SelectedIndex = 1;
                //rcbPrinRepAccount.SelectedIndex = 1;
                //rcbIntRepAccount.SelectedIndex = 1;
                //rcbChargRepAccount.SelectedIndex = 1;
                tbCustomerRemarks.Text = "Khanh hang than thiet";
                cmbAccountOfficer.SelectedIndex = 3;
                rcbSecured.SelectedIndex = 1;
                tbForwardBackWard.Text = "3";
                tbBaseDate.Text = "1";
                rcbCurrency.SelectedIndex = 4;
                //rcbCreditToAccount.DataBind();
                //rcbType.SelectedIndex = 1;
                //rdpDate.SelectedDate = DateTime.Now.AddYears(-2).AddDays(-23);
                //tbFreq.Text = "M";
                
                Page.ClientScript.RegisterStartupScript(this.GetType(), "Alert", "clickFullTab();", true);
            }
            if ( Request.QueryString["key"] != null && !Request.QueryString["key"].Equals(""))
            {
                RadToolBar1.FindItemByValue("btnPreview").Enabled = false;
                RadToolBar1.FindItemByValue("btnAuthorize").Enabled = true;
                RadToolBar1.FindItemByValue("btnReverse").Enabled = true;
                RadToolBar1.FindItemByValue("btnCommit").Enabled = false;
                RadToolBar1.FindItemByValue("btnCommit2").Enabled = false;
                SetEnabledControls(false);
            }
        }

        private void SetDataCombox()
        {
            string name = rcbCustomerID.SelectedValue;
            DataSet ds = Database.B_BDRFROMACCOUNT_GetByCustomer(name, "VND");
            rcbCreditToAccount.DataSource = ds;
            rcbCreditToAccount.DataTextField = "DisplayHasCurrency";
            rcbCreditToAccount.DataValueField = "Id";
            rcbCreditToAccount.DataBind();

            rcbPrinRepAccount.Items.Clear();
            rcbPrinRepAccount.DataValueField = "Id";
            rcbPrinRepAccount.DataTextField = "DisplayHasCurrency";
            rcbPrinRepAccount.DataSource = ds;
            rcbPrinRepAccount.DataBind();

            rcbIntRepAccount.Items.Clear();
            rcbIntRepAccount.DataValueField = "Id";
            rcbIntRepAccount.DataTextField = "DisplayHasCurrency";
            rcbIntRepAccount.DataSource = ds;
            rcbIntRepAccount.DataBind();

            rcbChargRepAccount.Items.Clear();
            rcbChargRepAccount.DataValueField = "Id";
            rcbChargRepAccount.DataTextField = "DisplayHasCurrency";
            rcbChargRepAccount.DataSource = ds;
            rcbChargRepAccount.DataBind();
        }
        public DataTable CustomeTable(DataTable dv)
        {
            DataTable table = new DataTable();
            table.Columns.Add("CustomerID", typeof(string));
            table.Columns.Add("CustomerName2", typeof(string));
            table.Rows.Add("","");
            foreach (DataRow item in dv.Rows)
            {
                table.Rows.Add(item["CustomerID"].ToString() + " - " + item["CustomerName2"],item["CustomerName2"]);
            }
            return table;
        }
        public DataTable GenerateTable()
        {
            DataTable table = new DataTable();
            table.Columns.Add("CustomerID", typeof(string));
            
            table.Rows.Add("");
            table.Rows.Add("06.0065047.1 - Phan Van Han");
            table.Rows.Add("06.0065012.1 - La Van Lam");
            table.Rows.Add("06.0065022.1 - Huynh Tan Phat");
            table.Rows.Add("06.0065044.1 - Pham Ngoc Thach");
            table.Rows.Add("06.0065337.1 - Vu Duc Nhat");
            table.Rows.Add("07.0061122.1 - CTY TNHH Song Long");
            table.Rows.Add("07.0060902.1 - CTY TNHH Vinh Phu");
            table.Rows.Add("07.0004735.1  - Wall Street Corp.");
            table.Rows.Add("07.0002947.1 - Travel City Corp.");
            table.Rows.Add("07.0002098.1 - CyberSoft Corp.");

            return table;
        }
        private void LoadToolBar()
        {
            RadToolBar1.FindItemByValue("btnPreview").Enabled = false;
            RadToolBar1.FindItemByValue("btnAuthorize").Enabled = false;
            RadToolBar1.FindItemByValue("btnReverse").Enabled = false;
            RadToolBar1.FindItemByValue("btnSearch").Enabled = false;
            RadToolBar1.FindItemByValue("btnPrint").Enabled = false;
        }
       
        //protected void rcbCreditToAccount_ItemDataBound(object sender, RadComboBoxItemEventArgs e)
        //{
        //    var row = e.Item.DataItem as DataRowView;
        //    e.Item.Attributes["ID"] = row["CustomerID"].ToString();
        //    e.Item.Attributes["CustomerName2"] = row["CustomerName2"].ToString();
        //}
        protected void RadToolBar1_ButtonClick(object sender, RadToolBarEventArgs e)
        {
            string normalLoan = tbNewNormalLoan.Text;
            var ToolBarButton = e.Item as RadToolBarButton;
            string commandName = ToolBarButton.CommandName;
            switch (commandName)
            {
                case "commit":
                        RadToolBar1.FindItemByValue("btnCommit").Visible = false;
                        RadToolBar1.FindItemByValue("btnCommit2").Visible = true;
                        hfCommitNumber.Value = "1";
                        Page.ClientScript.RegisterStartupScript(this.GetType(), "Alert", "clickFullTab();", true);
                    break;
                case "commit2":
                        RadToolBar1.FindItemByValue("btnPreview").Enabled = true;
                        RadToolBar1.FindItemByValue("btnAuthorize").Enabled = false;
                        RadToolBar1.FindItemByValue("btnReverse").Enabled = false;
                        RadToolBar1.FindItemByValue("btnCommit2").Enabled = false;
                        SetEnabledControls(false);
                        hfCommit2.Value = "1";
                        Page.ClientScript.RegisterStartupScript(this.GetType(), "Alert", "clickMainTab();", true);
                        Page.ClientScript.RegisterStartupScript(this.GetType(), "Alert", "clickFullTab();", true);
                    break;
                case "Preview":
                    hfCommit2.Value = "1";
                    this.Response.Redirect("http://localhost/vietvictorycorebanking/Default.aspx?tabid=202&key=preview");
                    break;
                case "authorize":
                    Response.Redirect("http://localhost/vietvictorycorebanking/Default.aspx?tabid=196");
                    break;
                case "reverse":
                    Response.Redirect("http://localhost/vietvictorycorebanking/Default.aspx?tabid=196");
                    break;
                case "search":
                    break;
                default:
                    RadToolBar1.FindItemByValue("btnCommit").Enabled = true;
                    break;
            }
            if (commandName == "commit")
            {
               
            }
            
            //string[] param = new string[4];
            //param[0] = "NewNormalLoan=" + normalLoan;
            //Response.Redirect(EditUrl("", "", "fullview", param));
        }

        private void SetEnabledControls(bool p)
        {
            rcbMainCategory.Enabled = p;
            rcbSubCategory.Enabled = p;
            rcbPurposeCode.Enabled = p;
            rcbCustomerID.Enabled = p;
            rcbLoadGroup.Enabled = p;
            tbLoanAmount.Enabled = p;
            rdpMaturityDate.Enabled = p;
            rcbCreditToAccount.Enabled = p;
            rcbCommitmentID.Enabled = p;
            rcbLimitReference.Enabled = p;
            rcbRateType.Enabled = p;
            rcbAnnRepMet.Enabled = p;
            tbInterestRate.Enabled = p;
            rcbInterestKey.Enabled = p;
            tbInSpread.Enabled = p;
            rcbRepaySchType.Enabled = p;
            rcbCurrency.Enabled = p;
            rdpOpenDate.Enabled = p;
            rdpValueDate.Enabled = p;
            rdpDrawdown.Enabled = p;
            rcbAutoSch.Enabled = p;
            rcbDefineSch.Enabled = p;
            tbApprovedAmt.Enabled = p;
            rcbPrinRepAccount.Enabled = p;
            rcbIntRepAccount.Enabled = p;
            tbCustomerRemarks.Enabled = p;
            cmbAccountOfficer.Enabled = p;
            rcbChargRepAccount.Enabled = p;
            tbBusDayDef.Enabled = p;
            rcbCollateralID.Enabled = p;
            rtbAmountAlloc.Enabled = p;
            rcbCountryRisk.Enabled = p;
            rtbLegacy.Enabled = p;
            rcbSecured.Enabled = p;
            tbForwardBackWard.Enabled = p;
            tbBaseDate.Enabled = p;
            ListView1.Enabled = p;
        }

        protected void rcbCustomerID_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
        {
           
        }

        protected void rcbCurrency_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
        {
            rcbCreditToAccount.Items.Clear();
            string name = rcbCustomerID.SelectedValue;
            string currency = rcbCurrency.SelectedValue;
            rcbCreditToAccount.Items.Add(new RadComboBoxItem(""));
            DataSet ds = Database.B_BDRFROMACCOUNT_GetByCustomer(name, currency);
            rcbCreditToAccount.DataSource = ds;
            rcbCreditToAccount.DataTextField = "DisplayHasCurrency";
            rcbCreditToAccount.DataValueField = "Id";
            rcbCreditToAccount.DataBind();

            rcbPrinRepAccount.Items.Clear();
            rcbPrinRepAccount.Items.Add(new RadComboBoxItem(""));
            rcbPrinRepAccount.DataValueField = "Id";
            rcbPrinRepAccount.DataTextField = "DisplayHasCurrency";
            rcbPrinRepAccount.DataSource = ds;
            rcbPrinRepAccount.DataBind();

            rcbIntRepAccount.Items.Clear();
            rcbIntRepAccount.Items.Add(new RadComboBoxItem(""));
            rcbIntRepAccount.DataValueField = "Id";
            rcbIntRepAccount.DataTextField = "DisplayHasCurrency";
            rcbIntRepAccount.DataSource = ds;
            rcbIntRepAccount.DataBind();

            rcbChargRepAccount.Items.Clear();
            rcbChargRepAccount.Items.Add(new RadComboBoxItem(""));
            rcbChargRepAccount.DataValueField = "Id";
            rcbChargRepAccount.DataTextField = "DisplayHasCurrency";
            rcbChargRepAccount.DataSource = ds;
            rcbChargRepAccount.DataBind();
        }

        protected void rcbMainCategory_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
        {
            LoadSubCategory();
        }

        private void LoadSubCategory()
        {
            string id = rcbMainCategory.SelectedValue;

            rcbSubCategory.Items.Clear();
            rcbSubCategory.Items.Add(new RadComboBoxItem(""));
            rcbSubCategory.DataValueField = "SubCatId";
            rcbSubCategory.DataTextField = "Display";
            rcbSubCategory.DataSource = SQLData.B_BRPODCATEGORY_GetSubAll_IdOver200(id);
            rcbSubCategory.DataBind();
        }
    }
}
