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
    public partial class ChequeWithrawalDrawOnUs_PL : DotNetNuke.Entities.Modules.PortalModuleBase
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }
        protected void RadGridPreview_OnNeedDataSource(object sender, GridNeedDataSourceEventArgs e)
        {
            DataTable dt = new DataTable();
            dt.Columns.Add("CustomerID");
            dt.Columns.Add("CustomerName");
            dt.Columns.Add("AmtLCY");
            dt.Columns.Add("Narrative");
            dt.Columns.Add("PRCode");

            DataRow dr = dt.NewRow();
            dr["CustomerID"] = "1100001";
            dr["CustomerName"] = "Phan Van Han";
            dr["AmtLCY"] = "10,000,000";
            dr["Narrative"] = "CHI TRA SEC";
            dr["PRCode"] = "0";
            dt.Rows.Add(dr);

            DataRow dr1 = dt.NewRow();
            dr1["CustomerID"] = "1100002";
            dr1["CustomerName"] = "Dinh Tien Hoang";
            dr1["AmtLCY"] = "11,000,000";
            dr1["Narrative"] = "CHI TRA TIEN THUE NHA";
            dr1["PRCode"] = "1";
            dt.Rows.Add(dr1);
            DataRow dr2 = dt.NewRow();
            dr2["CustomerID"] = "1100003";
            dr2["CustomerName"] = "Pham Ngoc Thach";
            dr2["AmtLCY"] = "12,000,000";
            dr2["Narrative"] = "MUA SAM NOI THAT";
            dr2["PRCode"] = "2";
            dt.Rows.Add(dr2);

            DataRow dr3 = dt.NewRow();
            dr3["CustomerID"] = "1100004";
            dr3["CustomerName"] = "Vo Thi Sau";
            dr3["AmtLCY"] = "13,000,000";
            dr3["Narrative"] = "MUA NHA";
            dr3["PRCode"] = "3";
            dt.Rows.Add(dr3);

            DataRow dr4 = dt.NewRow();
            dr4["CustomerID"] = "1100005";
            dr4["CustomerName"] = "Truong Cong Dinh";
            dr4["AmtLCY"] = "14,000,000";
            dr4["Narrative"] = "MUA XE";
            dr4["PRCode"] = "4";
            dt.Rows.Add(dr4);
            DataRow dr5 = dt.NewRow();
            dr5["CustomerID"] = "2102925";
            dr5["CustomerName"] = "CTY TNHH SONG HONG";
            dr5["AmtLCY"] = "15,000,000";
            dr5["Narrative"] = "DONG TIEN THUE HANG HOA";
            dr5["PRCode"] = "5";
            dt.Rows.Add(dr5);

            DataRow dr6 = dt.NewRow();
            dr6["CustomerID"] = "2102926";
            dr6["CustomerName"] = "CTY TNHH PHAT TRIEN ABC";
            dr6["AmtLCY"] = "16,000,000";
            dr6["Narrative"] = "DONG TIEN THUE VAN PHONG ";
            dr6["PRCode"] = "6";
            dt.Rows.Add(dr6);

            DataRow dr7 = dt.NewRow();
            dr7["CustomerID"] = "2102927";
            dr7["CustomerName"] = "VIETVICTORY CORP";
            dr7["AmtLCY"] = "17,000,000";
            dr7["Narrative"] = "MUA VE MAY BAY";
            dr7["PRCode"] = "7";
            dt.Rows.Add(dr7);
            DataRow dr8 = dt.NewRow();
            dr8["CustomerID"] = "2102928";
            dr8["CustomerName"] = "WALLSTREET CORP";
            dr8["AmtLCY"] = "20,000,000";
            dr8["Narrative"] = "CHI TRA SEC";
            dr8["PRCode"] = "8";
            dt.Rows.Add(dr8);

            DataRow dr9 = dt.NewRow();
            dr9["CustomerID"] = "2102929";
            dr9["CustomerName"] = "PLC CORP";
            dr9["AmtLCY"] = "19,000,000";
            dr9["Narrative"] = "CHI TRA SEC";
            dr9["PRCode"] = "9";
            dt.Rows.Add(dr9);

            RadGridPreview.DataSource = dt;

        }
        public string getUrlPreview(string id)
        {
            return "Default.aspx?tabid=" + this.TabId.ToString() + "&PRCode=" + id + "&IsAuthorize=1";
        }
    }
}