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
    public partial class ChequeCancleStop_PL : DotNetNuke.Entities.Modules.PortalModuleBase
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }
        protected void RadGrid_OnNeedDataSource(object sender, GridNeedDataSourceEventArgs e)
        {
            DataTable dt = new DataTable();
            dt.Columns.Add("ChequeNo");
            dt.Columns.Add("SerialNumber");
            dt.Columns.Add("ChequeType");
            dt.Columns.Add("ActiveDate");
            dt.Columns.Add("PRCode");

            DataRow dr = dt.NewRow();
            dr["ChequeNo"]="03.000237970.2";
            dr["SerialNumber"]="112233";
            dr["ChequeType"]="Current Account";
            dr["ActiveDate"]="01/01/2014";
            dr["PRCode"] = "0";
            dt.Rows.Add(dr);

            DataRow dr1 = dt.NewRow();
            dr1["ChequeNo"] = "03.000237971.2";
            dr1["SerialNumber"] = "112234";
            dr1["ChequeType"] = "Current Account";
            dr1["ActiveDate"] = "01/02/2014";
            dr1["PRCode"] = "1";
            dt.Rows.Add(dr1);
            DataRow dr2 = dt.NewRow();
            dr2["ChequeNo"] = "03.000237972.2";
            dr2["SerialNumber"] = "112235";
            dr2["ChequeType"] = "Current Account";
            dr2["ActiveDate"] = "01/03/2014";
            dr2["PRCode"] = "2";
            dt.Rows.Add(dr2);

            DataRow dr3 = dt.NewRow();
            dr3["ChequeNo"] = "03.000237973.2";
            dr3["SerialNumber"] = "112236";
            dr3["ChequeType"] = "Current Account";
            dr3["ActiveDate"] = "01/04/2014";
            dr3["PRCode"] = "3";
            dt.Rows.Add(dr3);
            DataRow dr4 = dt.NewRow();
            dr4["ChequeNo"] = "03.000237974.2";
            dr4["SerialNumber"] = "112237";
            dr4["ChequeType"] = "Current Account";
            dr4["ActiveDate"] = "01/05/2014";
            dr4["PRCode"] = "4";
            dt.Rows.Add(dr4);

            DataRow dr5 = dt.NewRow();
            dr5["ChequeNo"] = "03.000237975.2";
            dr5["SerialNumber"] = "112238";
            dr5["ChequeType"] = "Current Account";
            dr5["ActiveDate"] = "01/06/2014";
            dr5["PRCode"] = "5";
            dt.Rows.Add(dr5);
            DataRow dr6 = dt.NewRow();
            dr6["ChequeNo"] = "03.000237976.2";
            dr6["SerialNumber"] = "112239";
            dr6["ChequeType"] = "Current Account";
            dr6["ActiveDate"] = "01/07/2014";
            dr6["PRCode"] = "6";
            dt.Rows.Add(dr6);

            DataRow dr7 = dt.NewRow();
            dr7["ChequeNo"] = "03.000237977.2";
            dr7["SerialNumber"] = "112240";
            dr7["ChequeType"] = "Current Account";
            dr7["ActiveDate"] = "01/08/2014";
            dr7["PRCode"] = "7";
            dt.Rows.Add(dr7);
            DataRow dr8 = dt.NewRow();
            dr8["ChequeNo"] = "03.000237978.2";
            dr8["SerialNumber"] = "112241";
            dr8["ChequeType"] = "Current Account";
            dr8["ActiveDate"] = "01/09/2014";
            dr8["PRCode"] = "8";
            dt.Rows.Add(dr8);
            DataRow dr9 = dt.NewRow();
            dr9["ChequeNo"] = "03.000237979.2";
            dr9["SerialNumber"] = "112242";
            dr9["ChequeType"] = "Current Account";
            dr9["ActiveDate"] = "01/10/2014";
            dr9["PRCode"] = "9";
            dt.Rows.Add(dr9);

            RadGrid.DataSource = dt;
        }
        protected string getUrlPreview(string id)
        {
            return "Default.aspx?tabid=" + this.TabId.ToString() + "&PRCode=" + id + "&IsAuthorize=1";
        }
    }
}