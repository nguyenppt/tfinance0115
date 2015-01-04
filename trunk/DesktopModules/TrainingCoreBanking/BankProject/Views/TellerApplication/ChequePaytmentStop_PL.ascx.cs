using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Telerik.Web.UI;
using DotNetNuke.Entities.Modules;
using System.Data;

namespace BankProject.Views.TellerApplication
{
    public partial class ChequePaytmentStop_PL : DotNetNuke.Entities.Modules.PortalModuleBase
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        public void DataPreview_OnNeedDataSource(object sender, GridNeedDataSourceEventArgs e)
        {
            DataTable dt = new DataTable();
            dt.Columns.Add("PaymentStopRef");
            dt.Columns.Add("CustomerName");
            dt.Columns.Add("Reason");
            dt.Columns.Add("ActiveDate");
            dt.Columns.Add("PRCode");

            DataRow dr = dt.NewRow();
            dr["PaymentStopRef"] = "04.000246907.02";
            dr["CustomerName"] = "PHAN VAN HAN";
            dr["Reason"] = "CHEQUES STOLEN";
            dr["ActiveDate"] = "01/01/2014";
            dr["PRCode"] = "0";
            dt.Rows.Add(dr);

            DataRow dr1 = dt.NewRow();
            dr1["PaymentStopRef"] = "04.000246909.02";
            dr1["CustomerName"] = "DINH TIEN HOANG";
            dr1["Reason"] = "CHEQUES STOLEN";
            dr1["ActiveDate"] = "01/02/2014";
            dr1["PRCode"] = "1";
            dt.Rows.Add(dr1);
            DataRow dr2 = dt.NewRow();
            dr2["PaymentStopRef"] = "04.000246910.02";
            dr2["CustomerName"] = "PHAM NGOC THACH";
            dr2["Reason"] = "CHEQUES STOLEN";
            dr2["ActiveDate"] = "01/03/2014";
            dr2["PRCode"] = "2";
            dt.Rows.Add(dr2);
            DataRow dr3 = dt.NewRow();
            dr3["PaymentStopRef"] = "04.000246911.02";
            dr3["CustomerName"] = "VO THI SAU";
            dr3["Reason"] = "CHEQUES STOLEN";
            dr3["ActiveDate"] = "01/04/2014";
            dr3["PRCode"] = "3";
            dt.Rows.Add(dr3);

            DataRow dr4 = dt.NewRow();
            dr4["PaymentStopRef"] = "04.000246912.02";
            dr4["CustomerName"] = "TRUONG CONG DINH";
            dr4["Reason"] = "CHEQUES STOLEN";
            dr4["ActiveDate"] = "01/05/2014";
            dr4["PRCode"] = "4";
            dt.Rows.Add(dr4);
            DataRow dr5 = dt.NewRow();
            dr5["PaymentStopRef"] = "04.000246913.02";
            dr5["CustomerName"] = "CTY TNHH SONG HONG";
            dr5["Reason"] = "CHEQUES STOLEN";
            dr5["ActiveDate"] = "01/06/2014";
            dr5["PRCode"] = "5";
            dt.Rows.Add(dr5);

            DataRow dr6 = dt.NewRow();
            dr6["PaymentStopRef"] = "04.000246914.02";
            dr6["CustomerName"] = "CTY TNHH BAS";
            dr6["Reason"] = "CHEQUES STOLEN";
            dr6["ActiveDate"] = "01/07/2014";
            dr6["PRCode"] = "6";
            dt.Rows.Add(dr6);
            DataRow dr7 = dt.NewRow();
            dr7["PaymentStopRef"] = "04.000246915.02";
            dr7["CustomerName"] = "TRADE CORP";
            dr7["Reason"] = "CHEQUES STOLEN";
            dr7["ActiveDate"] = "01/09/2014";
            dr7["PRCode"] = "7";
            dt.Rows.Add(dr7);

            DataRow dr8 = dt.NewRow();
            dr8["PaymentStopRef"] = "04.000246916.02";
            dr8["CustomerName"] = "CTY MINH ANH";
            dr8["Reason"] = "CHEQUES STOLEN";
            dr8["ActiveDate"] = "01/10/2014";
            dr8["PRCode"] = "8";
            dt.Rows.Add(dr8);
            DataRow dr9 = dt.NewRow();
            dr9["PaymentStopRef"] = "04.000246917.02";
            dr9["CustomerName"] = "CTY HOANG VU";
            dr9["Reason"] = "CHEQUES STOLEN";
            dr9["ActiveDate"] = "01/11/2014";
            dr9["PRCode"] = "9";
            dt.Rows.Add(dr9);

            RadGridDataPreview.DataSource = dt;
        }
        protected string getUrlPreview(string id)
        {
            return "Default.aspx?tabid=" + this.TabId.ToString() + "&PRCode=" + id + "&IsAuthorize=1";
        }

    }
}