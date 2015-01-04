using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Telerik.Web.UI;

namespace BankProject.Views.TellerApplication
{
    public partial class LoanAccountList : DotNetNuke.Entities.Modules.PortalModuleBase
    {
        string key = "";
        protected void Page_Load(object sender, EventArgs e)
        {
            //Response.Redirect(EditUrl("NormalLoan"));
            if (Request.QueryString["key"] != null)
            {
                key = Request.QueryString["key"];
            }
            key = "";
        }

        private void LoadData()
        {
            radGridReview.DataSource = GenerateTable();
            //radGridReview.DataBind();
        }

        protected void radGridReview_OnNeedDataSource(object sender, GridNeedDataSourceEventArgs e)
        {
            this.LoadData();
        }
        public DataTable GenerateTable()
        {
            if (Request.QueryString["key"] != null)
            {
                key = Request.QueryString["key"];
            }
            DataTable table = new DataTable();
            table.Columns.Add("Id", typeof(string));
            table.Columns.Add("CustomerId", typeof(string));
            table.Columns.Add("LoanAmount", typeof(string));
            table.Columns.Add("idx", typeof(int));
            table.Columns.Add("key", typeof(string));
            table.Rows.Add("LD/14194/00629", "2102928 ","10,000,000,000.00",9,key);
            table.Rows.Add("LD/12194/00341", "2102927 ", "300,000,000.00",8,key);
            table.Rows.Add("LD/10104/02219", "2102926 ", "2,000,000,000.00",7,key);
            table.Rows.Add("LD/01134/01121", "1100001 ", "10,000,000.00",1,key);
            table.Rows.Add("LD/09794/00122", "1100002 ", "30,000,000,000.00",2,key);
            table.Rows.Add("LD/11194/01127", "1100003 ", "90,000,000,000.00",3,key);
            table.Rows.Add("LD/11187/00043", "1100004 ", "300,000,000.00",4,key);

            return table;
        }
    }
}