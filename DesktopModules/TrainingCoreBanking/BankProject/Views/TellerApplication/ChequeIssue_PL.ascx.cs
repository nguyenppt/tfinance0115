using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using BankProject.DataProvider;
using Telerik.Web.UI;

namespace BankProject.Views.TellerApplication
{
    public partial class ChequeIssue_PL : DotNetNuke.Entities.Modules.PortalModuleBase
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }
        protected void RadGridPreview_OnNeedDataSource(object sender, GridNeedDataSourceEventArgs e)
        {
            DataTable dt = new DataTable();
            dt.Columns.Add("ChequeNo");
            dt.Columns.Add("ChequeStt");
            dt.Columns.Add("IssueDate");
            dt.Columns.Add("QIss");
            dt.Columns.Add("PRCode");

            DataRow dr8 = dt.NewRow();
            dr8["ChequeNo"]="CC.060002595926.0000001";
            dr8["ChequeStt"]="90 - ISSUED";
            dr8["IssueDate"]="09/06/2014";
            dr8["QIss"]="10";
            dr8["PRCode"]="0";
            dt.Rows.Add(dr8);
            DataRow dr9 = dt.NewRow();
            dr9["ChequeNo"]="CC.060002595927.0000001";
            dr9["ChequeStt"]="90 - ISSUED";
            dr9["IssueDate"]="10/06/2014";
            dr9["QIss"]="10";
            dr9["PRCode"]="1";
            dt.Rows.Add(dr9);

            DataRow dr = dt.NewRow();
            dr["ChequeNo"]="CC.060002595918.0000001";
            dr["ChequeStt"]="90 - ISSUED";
            dr["IssueDate"]="01/06/2014";
            dr["QIss"]="10";
            dr["PRCode"]="2";
            dt.Rows.Add(dr);

            DataRow dr1 = dt.NewRow();
            dr1["ChequeNo"]="CC.060002595919.0000001";
            dr1["ChequeStt"]="90 - ISSUED";
            dr1["IssueDate"]="02/06/2014";
            dr1["QIss"]="10";
            dr1["PRCode"]="3";
            dt.Rows.Add(dr1);
            
            DataRow dr2 = dt.NewRow();
            dr2["ChequeNo"]="CC.060002595920.0000001";
            dr2["ChequeStt"]="90 - ISSUED";
            dr2["IssueDate"]="03/06/2014";
            dr2["QIss"]="10";
            dr2["PRCode"]="4";
            dt.Rows.Add(dr2);

            DataRow dr3 = dt.NewRow();
            dr3["ChequeNo"]="CC.060002595921.0000001";
            dr3["ChequeStt"]="90 - ISSUED";
            dr3["IssueDate"]="04/06/2014";
            dr3["QIss"]="10";
            dr3["PRCode"]="5";
            dt.Rows.Add(dr3);


            DataRow dr4 = dt.NewRow();
            dr4["ChequeNo"]="CC.060002595922.0000001";
            dr4["ChequeStt"]="90 - ISSUED";
            dr4["IssueDate"]="05/06/2014";
            dr4["QIss"]="10";
            dr4["PRCode"]="6";
            dt.Rows.Add(dr4);

            DataRow dr5 = dt.NewRow();
            dr5["ChequeNo"]="CC.060002595923.0000001";
            dr5["ChequeStt"]="90 - ISSUED";
            dr5["IssueDate"]="06/06/2014";
            dr5["QIss"]="10";
            dr5["PRCode"]="7";
            dt.Rows.Add(dr5);
            DataRow dr6 = dt.NewRow();
            dr6["ChequeNo"]="CC.060002595924.0000001";
            dr6["ChequeStt"]="90 - ISSUED";
            dr6["IssueDate"]="07/06/2014";
            dr6["QIss"]="10";
            dr6["PRCode"]="8";
            dt.Rows.Add(dr6);

            DataRow dr7 = dt.NewRow();
            dr7["ChequeNo"]="CC.060002595925.0000001";
            dr7["ChequeStt"]="90 - ISSUED";
            dr7["IssueDate"]="08/06/2014";
            dr7["QIss"]="10";
            dr7["PRCode"]="9";
            dt.Rows.Add(dr7);

            
            RadGridPreview.DataSource=dt;

        }
        protected string getUrlPreview(string id)
        {
            return "Default.aspx?tabid=" + this.TabId.ToString() + "&PRCode=" + id + "&IsAuthorize=1";
        }
    }
}