using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Telerik.Web.UI;
using System.Data;


namespace BankProject.Views.TellerApplication
{
    public partial class ChequeReturned_PL : DotNetNuke.Entities.Modules.PortalModuleBase
    {
        DataTable dt = new DataTable();
        
        protected void RadGrid_OnNeedDataSource(object sender, GridNeedDataSourceEventArgs e)
        { 
            dt.Columns.Add("CustomerID") ;
            dt.Columns.Add("TotalIssued");
            dt.Columns.Add("ChequesNo");
            dt.Columns.Add("ReturnedCheque");
            dt.Columns.Add("PRCode");

            DataRow dr = dt.NewRow();
            dr["CustomerID"] = "CC.060002595926";
            dr["TotalIssued"]="10";
            dr["ChequesNo"]="123456 - 123465";
            dr["ReturnedCheque"]="123456";
            dr["PRCode"]="0";
            dt.Rows.Add(dr);
            DataRow dr1 = dt.NewRow();
            dr1["CustomerID"] = "CC.060002595927";
            dr1["TotalIssued"] = "10";
            dr1["ChequesNo"] = "123466 - 123475";
            dr1["ReturnedCheque"] = "123467";
            dr1["PRCode"] = "1";
            dt.Rows.Add(dr1);

            DataRow dr2 = dt.NewRow();
            dr2["CustomerID"] = "CC.060002595918";
            dr2["TotalIssued"] = "10";
            dr2["ChequesNo"] = "123476 - 123485";
            dr2["ReturnedCheque"] = "123477";
            dr2["PRCode"] = "2";
            dt.Rows.Add(dr2);
            DataRow dr3 = dt.NewRow();
            dr3["CustomerID"] = "CC.060002595919";
            dr3["TotalIssued"] = "10";
            dr3["ChequesNo"] = "123486 - 123495";
            dr3["ReturnedCheque"] = "123490";
            dr3["PRCode"] = "3";
            dt.Rows.Add(dr3);

            DataRow dr4 = dt.NewRow();
            dr4["CustomerID"] = "CC.060002595920";
            dr4["TotalIssued"] = "10";
            dr4["ChequesNo"] = "123506 - 123515";
            dr4["ReturnedCheque"] = "123509";
            dr4["PRCode"] = "4";
            dt.Rows.Add(dr4);
            DataRow dr5 = dt.NewRow();
            dr5["CustomerID"] = "CC.060002595921";
            dr5["TotalIssued"] = "10";
            dr5["ChequesNo"] = "123516 - 123525";
            dr5["ReturnedCheque"] = "123516";
            dr5["PRCode"] = "5";
            dt.Rows.Add(dr5);

            DataRow dr6 = dt.NewRow();
            dr6["CustomerID"] = "CC.060002595922";
            dr6["TotalIssued"] = "10";
            dr6["ChequesNo"] = "123536 - 123545";
            dr6["ReturnedCheque"] = "123539";
            dr6["PRCode"] = "6";
            dt.Rows.Add(dr6);
            DataRow dr7 = dt.NewRow();
            dr7["CustomerID"] = "CC.060002595923";
            dr7["TotalIssued"] = "20";
            dr7["ChequesNo"] = "123556 - 123575";
            dr7["ReturnedCheque"] = "123559";
            dr7["PRCode"] = "7";
            dt.Rows.Add(dr7);

            DataRow dr8 = dt.NewRow();
            dr8["CustomerID"] = "CC.060002595924";
            dr8["TotalIssued"] = "20";
            dr8["ChequesNo"] = "123576 - 123595";
            dr8["ReturnedCheque"] = "123577";
            dr8["PRCode"] = "8";
            dt.Rows.Add(dr8);
            DataRow dr9 = dt.NewRow();
            dr9["CustomerID"] = "CC.060002595925";
            dr9["TotalIssued"] = "20";
            dr9["ChequesNo"] = "122120 - 122139";
            dr9["ReturnedCheque"] = "122139";
            dr9["PRCode"] = "9";
            dt.Rows.Add(dr9);
            RadGrid.DataSource = dt;
        }
        protected void Page_Load(object sender, EventArgs e)
        {
            if (IsPostBack) return;
            else
            {
                if (Request.QueryString["PRCode"] != null)
                { Response.Redirect(EditUrl("PRCode", Request.QueryString["PRCode"], "ChequeReturned2")); }
            }
        }
        public string getUrlPreview(string id)
        {
            return "Default.aspx?tabid=136&&ctl=ChequeReturned2&mid=837" +  "&PRCode=" + id + "&IsAuthorize=1";
        }


    }
}