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
    public partial class ChequeCancleStop : DotNetNuke.Entities.Modules.PortalModuleBase
    {
        public static int autoID = 2;
        protected void Page_Load(object sender, EventArgs e)
        {
                if (IsPostBack) return;
                tbID.Text = "03.000237970." + autoID.ToString("000");
                lblStopCheqPaymentNo.Text = "Phan Van Han";
                rcbSerialNo.Focus();
                rdpActivityDate.SelectedDate = DateTime.Now;
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
        protected void LoadToolBar(bool isauthorize)
        {
            RadToolBar.FindItemByValue("btCommitData").Enabled = !isauthorize;
            RadToolBar.FindItemByValue("btPreview").Enabled = !isauthorize;
            RadToolBar.FindItemByValue("btAuthorize").Enabled = isauthorize;
            RadToolBar.FindItemByValue("btReverse").Enabled = isauthorize;
            RadToolBar.FindItemByValue("btSearch").Enabled = false;
            RadToolBar.FindItemByValue("btPrint").Enabled = false;
        }
        protected void LoadDataPreview()
        {
            if (Request.QueryString["PRCode"] != null)
            {
                string PRCode = Request.QueryString["PRCode"].ToString();
                switch (PRCode)
                { 
                    case "0":
                        LoadDetailPreview("03.000237970.2", "112233", "AB", "01/01/2014");
                        break;
                    case "1":
                        LoadDetailPreview("03.000237971.2", "112234", "AB", "01/02/2014");
                        break;

                    case "2":
                        LoadDetailPreview("03.000237972.2", "112235", "AB", "01/03/2014");
                        break;
                    case "3":
                        LoadDetailPreview("03.000237973.2", "112236", "AB", "01/04/2014");
                        break;
                    case "4":
                        LoadDetailPreview("03.000237974.2", "112237", "AB", "01/05/2014");
                        break;

                    case "5":
                        LoadDetailPreview("03.000237975.2", "112238", "AB", "01/06/2014");
                        break;
                    case "6":
                        LoadDetailPreview("03.000237976.2", "112239", "AB", "01/07/2014");
                        break;
                    case "7":
                        LoadDetailPreview("03.000237977.2", "112240", "AB", "01/05/2014");
                        break;
                    case "8":
                        LoadDetailPreview("03.000237978.2", "112241", "AB", "01/09/2014");
                        break;
                    case "9":
                        LoadDetailPreview("03.000237979.2", "112242", "AB", "01/10/2014");
                        break;
                }
            }
        }
        protected void LoadDetailPreview(string StopNo, string Serial, string ChequeType,  string ActiveDate)
        { 
            tbID.Text=StopNo;
            rcbChequeType.SelectedValue = ChequeType;
            rcbSerialNo.SelectedValue=Serial;
            rdpActivityDate.SelectedDate = Convert.ToDateTime(ActiveDate);
        }
        protected void RadToolBar_OnButtonClick(object sender, RadToolBarEventArgs e)
        {
            var ToolBarButton = e.Item as RadToolBarButton;
            var CommandName = ToolBarButton.CommandName;
            switch (CommandName)
            { 
                case "commit":
                    DefaultSetting();
                    break;
                case "Preview":
                    Response.Redirect(EditUrl("ChequeCancleStop_PL"));
                    break;
                case "reverse":
                case "authorize":
                    LoadToolBar(false);
                    DefaultSetting();
                    BankProject.Controls.Commont.SetTatusFormControls(this.Controls, true);
                    break;
            }
        }
        protected void DefaultSetting()
        {
            autoID++;
            rcbSerialNo.Focus();
            tbID.Text = "03.000237970." + autoID.ToString("000");
            rcbChequeType.SelectedValue= rcbSerialNo.SelectedValue = "";
            rdpActivityDate.SelectedDate = DateTime.Now;
        }
    }
}