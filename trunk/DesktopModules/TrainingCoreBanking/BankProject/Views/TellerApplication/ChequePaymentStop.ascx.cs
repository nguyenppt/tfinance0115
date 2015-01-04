using System;
using DotNetNuke.Entities.Modules;
using Telerik.Web.UI;
using System.Data;
using BankProject.DataProvider;



namespace BankProject.Views.TellerApplication
{
    public partial class ChequePaymentStop : PortalModuleBase
    {
        public static int AutoID = 2;
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
            
            if (!IsPostBack)
            {
                this.LoadToolBar(false);
                this.tbID.Text = "04.000246907."+ AutoID.ToString("0000");
                lblCheqPaymentNo.Text = "Phan Van Han";
                this.rdpActivityDate.SelectedDate = DateTime.Now;
                rcbCustomerID.DataSource = DataProvider.DataTam.B_BCUSTOMERS_GetAll();
                rcbCustomerID.DataTextField = "CustomerName";
                rcbCustomerID.DataValueField = "CustomerID";
                rcbCustomerID.DataBind();

                if (Request.QueryString["LoadCus"] != null)
                {
                    Random a = new Random();
                    rcbCustomerID.SelectedIndex = a.Next(0, DataProvider.DataTam.B_BCUSTOMERS_GetAll().Tables[0].Rows.Count - 1);
                    rcbCurrency.SelectedValue = "USD";
                }
                
            }

            if (Request.QueryString["IsAuthorize"] != null)
            {
                LoadToolBar(true);
                BankProject.Controls.Commont.SetTatusFormControls(this.Controls, false);
                LoadDataPreview();
            }
            else
            {
                LoadToolBar(false);
            }


        }

        protected void OnRadToolBarClick(object sender, RadToolBarEventArgs e)
        {
            var toolbarButton = e.Item as RadToolBarButton;
            var commandName = toolbarButton.CommandName;
            switch (commandName)
            { 
                case "commit":
                    DefaultSetting();
                    break;
                case "Preview":
                    Response.Redirect(EditUrl("ChequePaytmentStop_PL"));
                    break;
                case "authorize": 
                case "reverse":
                    LoadToolBar(false);
                    DefaultSetting();
                    BankProject.Controls.Commont.SetTatusFormControls(this.Controls, true);
                    break;
            }
        }
        private void DefaultSetting()
        {
            AutoID++;
            this.tbID.Text = "04.000246907." + AutoID.ToString("0000");
            this.rdpActivityDate.SelectedDate = DateTime.Now;
            this.rcbCustomerID.SelectedValue = "";
            this.rcbCurrency.SelectedValue = "";
            this.rcbReasonForStopping.SelectedValue = "";
            this.tbFromSerial.Text = tbToSerial.Text = tbAmountFrom.Text = tbAmount.Text = "";
            this.lblNoOfLeaves.Text = "1";
            rcbChequeType.SelectedValue =rcbWaiveCharges.SelectedValue= "";
        }
        private void LoadDataPreview()
        {
            if (Request.QueryString["PRCode"] != null)
            {
                string PRCode = Request.QueryString["PRCode"].ToString();
                switch (PRCode)
                { 
                    case "0":
                        LoadDetailData("04.000246907.02","1100001","01/01/2014");
                        break;
                    case "1":
                        LoadDetailData("04.000246909.02","1100002","01/02/2014");
                        break;
                    case "2":
                        LoadDetailData("04.000246910.02","1100003","01/03/2014");
                        break;
                        case "3":
                        LoadDetailData("04.000246911.02","1100004","01/04/2014");
                        break;
                        case "4":
                        LoadDetailData("04.000246912.02","1100005","01/05/2014");
                        break;
                        case "5":
                        LoadDetailData("04.000246913.02","2102925","01/06/2014");
                        break;
                        case "6":
                        LoadDetailData("04.000246914.02","2102926","01/07/2014");
                        break;
                    case "7":
                        LoadDetailData("04.000246915.02","2102927","01/09/2014");
                        break;
                    case "8":
                        LoadDetailData("04.000246916.02","2102928","01/10/2014");
                        break;
                    case "9":
                        LoadDetailData("04.000246917.02", "2102929", "01/11/2014");
                        break;

                }
            }
        }
        private void LoadDetailData(string tbIDReference, string CustomerID, string ActiveDate)
        {
            Random auToSerial = new Random();
            Random auFromSerial = new Random();
            tbID.Text=tbIDReference;
            rcbCustomerID.SelectedValue=CustomerID;
            rcbCurrency.SelectedValue="VND";
            rcbReasonForStopping.SelectedValue="3";
            int  FromSerial=auFromSerial.Next(2, 30);
            tbFromSerial.Text = FromSerial.ToString();
            int  ToSerial=auToSerial.Next(40,70);
            tbToSerial.Text=ToSerial.ToString();

            int tempNoLeaves = 0;
                tempNoLeaves = ToSerial - FromSerial;
            lblNoOfLeaves.Text = (tempNoLeaves).ToString();
            rcbChequeType.SelectedValue="AB";
            tbAmountFrom.Text = tbAmount.Text = (10000000 * (ToSerial - FromSerial)).ToString();
            
            rcbWaiveCharges.SelectedValue="YES";
            rdpActivityDate.SelectedDate=Convert.ToDateTime(ActiveDate);
        }
    }
}