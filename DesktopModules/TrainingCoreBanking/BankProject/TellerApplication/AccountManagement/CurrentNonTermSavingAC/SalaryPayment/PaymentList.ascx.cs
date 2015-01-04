using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Telerik.Web.UI;

namespace BankProject.TellerApplication.AccountManagement.CurrentNonTermSavingAC.SalaryPayment
{
    public partial class PaymentList : DotNetNuke.Entities.Modules.PortalModuleBase
    {
        public string TabId
        {
            get
            {
                if (Request.QueryString["id"] != null)
                {
                    return Request.QueryString["id"];
                }
                return "138";
            }
            set
            {
                TabId = value;
            }
        }
        protected void Page_Load(object sender, EventArgs e)
        {
            //if (Request.QueryString["id"] != null)
            //{
            //    TabId = Request.QueryString["id"];
            //}
        }
        protected void radGridReview_OnNeedDataSource(object sender, GridNeedDataSourceEventArgs e)
        {
            this.LoadData();
        }

        private void LoadData()
        {
            radGridReview.DataSource = DataProvider.SQLData.B_BCUSTOMERS_GetCompany();
            //radGridReview.DataBind();
        }
    }
}