﻿using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Telerik.Web.UI;

namespace BankProject.Controls
{
    public partial class VVDatePicker : System.Web.UI.UserControl
    {
        DataSet ds;
        string _VVTLabel, _VVTText, _OnBlur, _VVTDataKey, _LBwidth = "150", _IbtId;

        string _width = "200";
        bool _Enabled = true;
        bool _Icon = true;

        public bool Icon
        {
            get { return _Icon; }
            set { _Icon = value; }
        }
        public string IbtId
        {
            get { return _IbtId; }
            set { _IbtId = value; }
        }
        public bool Enabled
        {
            get { return _Enabled; }
            set { _Enabled = value; }
        }
        public string LBWidth
        {
            get { return _LBwidth; }
            set { _LBwidth = value; }
        }
        public string Width
        {
            get { return _width; }
            set { _width = value; }
        }
        public string OnBlur
        {
            get { return _OnBlur; }
            set { _OnBlur = value; }
        }
        public string VVTLabel
        {
            get { return _VVTLabel; }
            set { _VVTLabel = value; }
        }
        public string VVText
        {
            get { return _VVTText; }
            set { _VVTText = value; }
        }
        public string VVTDataKey
        {
            get { return _VVTDataKey; }
            set { _VVTDataKey = value; }
        }
        protected void Page_Load(object sender, EventArgs e)
        {
            if (IsPostBack) return;

        }
        public void Clear()
        {
            DataProvider.KhanhND.B_BDYNAMICCONTROLS_DelByTab(Request.QueryString["tabid"].ToString(), this.ID.ToString(), Session["DataKey"].ToString());
        }
        public void InsertTextBox(string TextValues)
        {
            DataSet dst = DataProvider.KhanhND.B_BDYNAMICCONTROLS_Update("0", Request.QueryString["tabid"].ToString(), this.ID.ToString(), "", TextValues, Session["DataKey"].ToString());
        }
        public void ReLoadControl()
        {
            for (int i = 0; tblMain.Rows.Count > 0; i++)
            {
                TableRow rw = tblMain.Rows[0];
                tblMain.Rows.Remove(rw);
            }
            LoadControls();
        }
        public void SetEnable(bool menable)
        {
            Enabled = menable;
            try
            {
                for (int i = 0; tblMain.Rows.Count > 0; i++)
                {
                    TableRow rw = tblMain.Rows[0];
                    tblMain.Rows.Remove(rw);
                }
            }
            catch { }
            LoadControls();
        }

        public void ReLoadControl(string mDataKey)
        {
            DataProvider.KhanhND.B_BDYNAMICCONTROLS_DelByTab(Request.QueryString["tabid"].ToString(), this.ID.ToString(), "");
            Session["DataKey"] = mDataKey;
            try
            {
                for (int i = 0; tblMain.Rows.Count > 0; i++)
                {
                    TableRow rw = tblMain.Rows[0];
                    tblMain.Rows.Remove(rw);
                }
            }
            catch { }
            LoadControls();
        }
        public void SetTextDefault(string mText)
        {
            DataProvider.KhanhND.B_BDYNAMICCONTROLS_DelByTab(Request.QueryString["tabid"].ToString(), this.ID.ToString(), "");
            VVText = mText;
            for (int i = 0; tblMain.Rows.Count > 0; i++)
            {
                TableRow rw = tblMain.Rows[0];
                tblMain.Rows.Remove(rw);
            }
            LoadControls();
        }
        protected override void OnInit(EventArgs e)
        {
            base.OnInit(e);

            if (!IsPostBack)
            {

                if (Request.QueryString["CodeID"] != null)
                    Session["DataKey"] = Request.QueryString["CodeID"].ToString();
                else
                    Session["DataKey"] = "";

                if (Session["DataKey"] == null)
                {
                    Session["DataKey"] = "";
                    DataProvider.KhanhND.B_BDYNAMICCONTROLS_DelByTab(Request.QueryString["tabid"].ToString(), this.ID.ToString(), "");
                }
                else if (Session["DataKey"].ToString() == "")
                    DataProvider.KhanhND.B_BDYNAMICCONTROLS_DelByTab(Request.QueryString["tabid"].ToString(), this.ID.ToString(), "");
            }
            else
            {

                DataProvider.KhanhND.B_BDYNAMICCONTROLS_UpdateByTab(Request.QueryString["tabid"].ToString(), "", Session["DataKey"].ToString(), "");

            }

            LoadControls();
        }

        private void LoadControls()
        {
            ds = BankProject.DataProvider.KhanhND.B_BDYNAMICCONTROLS_GetControls(Request.QueryString["tabid"].ToString(), this.ID.ToString(), Session["DataKey"].ToString());
            for (int i = 0; i < ds.Tables[0].Rows.Count; i++)
            {
                if (i > 0)
                {
                    Label lb = new Label();
                    lb.ID = "lbl" + ds.Tables[0].Rows[i]["DataControlID"].ToString();
                    lb.Text = VVTLabel;

                    RadDatePicker dp = new RadDatePicker();
                    dp.ID = "txtName" + ds.Tables[0].Rows[0]["DataControlID"].ToString();
                    dp.AutoPostBack = true;
                    dp.Width = Unit.Parse(Width);
                    if (OnBlur != "")
                        dp.Attributes.Add("onblur", OnBlur + "(this,'" + this.ID + "');");

                    ImageButton ibt = new ImageButton();
                    ibt.ID = "ibt" + ds.Tables[0].Rows[i]["DataControlID"].ToString();
                    IbtId = ibt.ID;
                    ibt.ImageUrl = "~/Icons/Sigma/Delete_16X16_Standard.png";
                    ibt.Click += ibt_Click;

                    TableRow tr = new TableRow();
                    tr.ID = ds.Tables[0].Rows[i]["DataControlID"].ToString();

                    TableCell tc = new TableCell();
                    tc.CssClass = "MyLable";
                    tc.Controls.Add(lb);
                    tc.Width = Unit.Parse(LBWidth);

                    TableCell tc2 = new TableCell();
                    tc2.CssClass = "MyContent";
                    tc2.Width = Unit.Parse(Width);
                    tc2.Controls.Add(dp);

                    TableCell tc3 = new TableCell();
                    tc3.Controls.Add(ibt);

                    tr.Cells.Add(tc);
                    tr.Cells.Add(tc2);
                    if (Icon)
                        tr.Cells.Add(tc3);
                    if (tblMain == null)
                        tblMain = new Table();
                    tblMain.Rows.Add(tr);
                }
                else
                {
                    Label lb = new Label();
                    lb.ID = "lbl" + ds.Tables[0].Rows[i]["DataControlID"].ToString();
                    lb.Text = VVTLabel;

                    RadDatePicker dp = new RadDatePicker();
                    dp.ID = "txtName" + ds.Tables[0].Rows[0]["DataControlID"].ToString();
                    dp.AutoPostBack = true;
                    dp.Width = Unit.Parse(Width);
                    if (OnBlur != "")
                        dp.Attributes.Add("onblur", OnBlur + "(this,'" + this.ID + "');");

                    ImageButton ibt = new ImageButton();
                    ibt.ID = "ibt" + ds.Tables[0].Rows[i]["DataControlID"].ToString();
                    IbtId = ibt.ID;
                    ibt.ImageUrl = "~/Icons/Sigma/Add_16X16_Standard.png";
                    ibt.Click += ibtVVT_Click;
                    ibt.Enabled = Enabled;

                    TableRow tr = new TableRow();
                    tr.ID = ds.Tables[0].Rows[i]["DataControlID"].ToString();

                    TableCell tc = new TableCell();
                    tc.CssClass = "MyLable";
                    tc.Controls.Add(lb);
                    tc.Width = Unit.Parse(LBWidth);

                    TableCell tc2 = new TableCell();
                    tc2.CssClass = "MyContent";
                    tc2.Width = Unit.Parse(Width);
                    tc2.Controls.Add(dp);

                    TableCell tc3 = new TableCell();
                    tc3.Controls.Add(ibt);

                    tr.Cells.Add(tc);
                    tr.Cells.Add(tc2);
                    if (Icon)
                        tr.Cells.Add(tc3);
                    if (tblMain == null)
                        tblMain = new Table();
                    tblMain.Rows.Add(tr);
                }
            }


        }

        void tb_TextChanged(object sender, EventArgs e)
        {
            TextBox tb = (TextBox)sender;
            DataSet dst = DataProvider.KhanhND.B_BDYNAMICCONTROLS_Update(tb.ID.ToString().Replace("txtName", ""), Request.QueryString["tabid"].ToString(), this.ID.ToString(), "", tb.Text, Session["DataKey"].ToString());
        }

        void ibt_Click(object sender, ImageClickEventArgs e)
        {
            ImageButton ibtXoa = (ImageButton)sender;
            DeleteRow(ibtXoa.ID);
        }

        public void DeleteRow(string nameIbt)
        {
            string name = nameIbt.Replace("ibt", "");
            TableRow rw = (TableRow)tblMain.FindControl(name);
            tblMain.Rows.Remove(rw);
            DataProvider.KhanhND.B_BDYNAMICCONTROLS_Del(name);
        }

        protected void ibtVVT_Click(object sender, ImageClickEventArgs e)
        {

            AddNewRow();
        }

        public void AddNewRow()
        {
            DataSet dst = DataProvider.KhanhND.B_BDYNAMICCONTROLS_Update("0", Request.QueryString["tabid"].ToString(), this.ID.ToString(), "", "", Session["DataKey"].ToString());


            Label lb = new Label();
            lb.ID = "lbl" + dst.Tables[0].Rows[0]["DataControlID"].ToString();
            lb.Text = VVTLabel;

            RadDatePicker dp = new RadDatePicker();
            dp.ID = "txtName" + dst.Tables[0].Rows[0]["DataControlID"].ToString();
            dp.AutoPostBack = true;
            dp.Width = Unit.Parse(Width);
            if (OnBlur != "")
                dp.Attributes.Add("onblur", OnBlur + "(this,'" + this.ID + "');");

            ImageButton ibt = new ImageButton();
            ibt.ID = "ibt" + dst.Tables[0].Rows[0]["DataControlID"].ToString();
            IbtId = ibt.ID;
            ibt.ImageUrl = "~/Icons/Sigma/Delete_16X16_Standard.png";
            ibt.Click += ibt_Click;

            TableRow tr = new TableRow();
            tr.ID = dst.Tables[0].Rows[0]["DataControlID"].ToString();

            TableCell tc = new TableCell();
            tc.CssClass = "MyLable";
            tc.Controls.Add(lb);
            tc.Width = Unit.Parse(LBWidth);

            TableCell tc2 = new TableCell();
            tc2.CssClass = "MyContent";
            tc2.Width = Unit.Parse(Width);
            tc2.Controls.Add(dp);

            TableCell tc3 = new TableCell();
            tc3.Controls.Add(ibt);

            tr.Cells.Add(tc);
            tr.Cells.Add(tc2);
            if (Icon)
                tr.Cells.Add(tc3);
            if (tblMain == null)
                tblMain = new Table();
            tblMain.Rows.Add(tr);
        }
    }
}