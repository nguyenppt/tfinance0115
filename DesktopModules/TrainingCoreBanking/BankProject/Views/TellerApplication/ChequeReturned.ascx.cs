using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Telerik.Web.UI;
using System.Data;
using BankProject.DataProvider;

namespace BankProject.Views.TellerApplication
{
    public partial class ChequeReturned : DotNetNuke.Entities.Modules.PortalModuleBase
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (IsPostBack) return;
            else
            {
                var dsCus = DataTam.B_BCUSTOMERS_GetAll();
                if (dsCus != null && dsCus.Tables.Count > 0 && dsCus.Tables[0].Rows.Count > 0)
                {
                    DataRow dr = dsCus.Tables[0].NewRow();
                    dr["CustomerID"] = "";
                    dr["CustomerName"] = "";
                    dsCus.Tables[0].Rows.InsertAt(dr, 0);

                    TbCustomerID.Items.Clear();
                    TbCustomerID.DataValueField = "CustomerID";
                    TbCustomerID.DataTextField = "CustomerName";
                    TbCustomerID.DataSource = dsCus;
                    TbCustomerID.DataBind();
                }
               

                //tbReturnedCheque.Focus();
                if (Request.QueryString["CustomerID_LinkCode"] != null)
                {
                    //LoadToolBar(true);
                   
                    //BankProject.Controls.Commont.SetTatusFormControls(this.Controls, false);
                    Response.Redirect(EditUrl("CustomerID_LinkCode", Request.QueryString["CustomerID_LinkCode"], "ChequeReturned2"));
                    //LoadDataPreview();
                }
                else 
                {
                    RadToolBar1.FindItemByValue("btCommitData").Enabled = false;
                    RadToolBar1.FindItemByValue("btPreview").Enabled = false;
                    RadToolBar1.FindItemByValue("btAuthorize").Enabled = false;
                    RadToolBar1.FindItemByValue("btReverse").Enabled = false;
                    RadToolBar1.FindItemByValue("btSearch").Enabled = true;
                    RadToolBar1.FindItemByValue("btPrint").Enabled = false;
                    RadGrid1.DataSource = TriTT.B_BCHEQUERETURN_findItem("!", "", "", "");    
                }
            }
        }
        protected string geturlReview(string CustomerID_LinkCode)
        {
            return "Default.aspx?tabid=" + this.TabId.ToString() + "&CustomerID_LinkCode=" + CustomerID_LinkCode + "&IsAuthorize=1";
        }
        protected void LoadToolBar(bool isauthorize)
        {
            RadToolBar1.FindItemByValue("btCommitData").Enabled = !isauthorize;
            RadToolBar1.FindItemByValue("btPreview").Enabled = !isauthorize;
            RadToolBar1.FindItemByValue("btAuthorize").Enabled = isauthorize;
            RadToolBar1.FindItemByValue("btReverse").Enabled = isauthorize;
            RadToolBar1.FindItemByValue("btSearch").Enabled = false;
            RadToolBar1.FindItemByValue("btPrint").Enabled = false;
        }
        protected void btSearch_Click(object sender, EventArgs e)
        {
            Search();
        }
        protected void RadToolBar1_OnButtonClick(object sender, RadToolBarEventArgs e)
        {
            var toolbarButton = e.Item as RadToolBarButton;
            var CommandName = toolbarButton.CommandName;
            if (CommandName == "search")
            {
                Search();
            }
        }

        protected void RadGrid_OnNeedDataSource(object sender, GridNeedDataSourceEventArgs e)
        {
            RadGrid1.DataSource = TriTT.B_BCHEQUERETURN_findItem("", "", "", "");
        }

        protected void Search()
        {
            if (string.IsNullOrEmpty(tbChequeReference.Text.Trim()) && string.IsNullOrEmpty(TbCustomerID.Text.Trim()) &&
                string.IsNullOrEmpty(tbCustomerName.Text.Trim())
               && string.IsNullOrEmpty(rdpIssueDate.SelectedDate.ToString().Trim()))
                RadGrid1.DataSource = TriTT.B_BCHEQUERETURN_findItem("", "", "", "");
            else
                RadGrid1.DataSource = TriTT.B_BCHEQUERETURN_findItem(tbChequeReference.Text.Trim(), TbCustomerID.SelectedValue, 
                    tbCustomerName.Text.Trim(), rdpIssueDate.SelectedDate.ToString());
            RadGrid1.DataBind(); 
        }


        //protected void RadToolBar1_OnButtonClick(object sender, RadToolBarEventArgs e)
        //{
        //    var ToolBar = e.Item as RadToolBarButton;
        //    var commandName = ToolBar.CommandName;
        //    switch (commandName)
        //    { 
        //        case "commit":
        //            DefaultSetting();
        //            break;
        //        case "Preview":
        //            Response.Redirect(EditUrl("ChequeReturned_PL"));
        //            break;
        //        case "reverse":
        //        case "authorize":
        //            BankProject.Controls.Commont.SetTatusFormControls(this.Controls, true);
        //            DefaultSetting();
        //            LoadToolBar(false);
        //            break;
        //    }
        //}
        //protected void LoadDataPreview()
        //{
        //    if (Request.QueryString["PRCode"] != null)
        //    {
        //        //string PRCode = Request.QueryString["PRCode"].ToString();
        //        //var dr = Request.QueryString["Datarow"];
        //        //LoadDetailData("AB.001343429", 20, 7, 123456, 213465);
        //        string PRCode = Request.QueryString["PRCode"].ToString();
                
        //        switch (PRCode)
        //        {
        //            case "0":
        //                LoadDetailData("CC.060002595926", 10, 4, 123456, 123465, "123456");
        //                break;
        //            case "1":
        //                LoadDetailData("CC.060002595927", 10, 3, 123466, 123475, "123467");
        //                break;
        //            case "2":
        //                LoadDetailData("CC.060002595918", 10, 5, 123476, 123485, "123477");
        //                break;
        //            case "3":
        //                LoadDetailData("CC.060002595919", 10, 2, 123486, 123495, "123490");
        //                break;
        //            case "4":
        //                LoadDetailData("CC.060002595920", 10, 3, 123506, 123515, "123509");
        //                break;
        //            case "5":
        //                LoadDetailData("CC.060002595921", 10, 7, 123516, 123525, "123516");
        //                break;
        //            case "6":
        //                LoadDetailData("CC.060002595922", 10, 1, 123536, 123545, "123539");
        //                break;
        //            case "7":
        //                LoadDetailData("CC.060002595923", 20, 7, 123556, 123575, "123559");
        //                break;
        //            case "8":
        //                LoadDetailData("CC.060002595924", 20, 9, 123576, 123595, "123577");
        //                break;
        //            case "9":
        //                LoadDetailData("CC.060002595925", 20, 7, 122120, 122139, "123590");
        //                break;
        //        }
        //    }
        //}
        //protected void LoadDetailData(string ID,int TotalIssued, int TotalUsed, int FromChequesNo,int TochequeNo, string ReturnedCheque)
        //{
        //    tbID.Text = ID;
        //    lblTotalIssued.Text=TotalIssued.ToString();
        //    lblTotalUsed.Text=TotalUsed.ToString();
        //    int TotalHeld = TotalIssued - TotalUsed;
        //    lblTotalHeld.Text=TotalHeld.ToString();

        //    lblChequesNo.Text = FromChequesNo.ToString() +" - "+ TochequeNo.ToString();
        //    lblStoppedCheque.Text="0";
        //    //Random returnedCheque = new Random();
        //    tbReturnedCheque.Text = ReturnedCheque.ToString();     //returnedCheque.Next(FromChequesNo, TochequeNo).ToString();
        //    ID = "";
        //    FromChequesNo = TotalUsed = TotalIssued = 0; //ReturnedCheque=
        //}
        //protected void DefaultSetting()
        //{
        //    tbID.Text = "";
        //    tbReturnedCheque.Text= lblTotalUsed.Text = lblTotalIssued.Text = lblTotalHeld.Text = lblStoppedCheque.Text = lblChequesNo.Text = "";

        //}
    }
}