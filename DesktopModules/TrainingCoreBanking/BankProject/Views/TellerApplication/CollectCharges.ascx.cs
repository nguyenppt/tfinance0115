using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using BankProject.DataProvider;
using DotNetNuke.Entities.Modules;
using Telerik.Web.UI;

namespace BankProject.Views.TellerApplication
{
    public partial class CollectCharges : PortalModuleBase
    {
        const double percentVat = 0.1;//10%
        private string Refix_BMACODE()
        {
            return "TT";
        }
        protected void Page_Load(object sender, EventArgs e)
        {
            if (IsPostBack) return;
            LoadToolBar();

            rcbCurrency.Focus();
            tbDepositCode.Text = TriTT.B_BMACODE_GetNewID_3par("COLL_CONTIN_ENTRY", Refix_BMACODE(), "/");
            rcbCurrency.SelectedValue = "";
            rdpValueDate.SelectedDate = DateTime.Now;

            rcbCategoryPL.Items.Add(new RadComboBoxItem("", ""));
            rcbCategoryPL.AppendDataBoundItems = true;
            rcbCategoryPL.DataSource = DataProvider.Database.B_BBPLACCOUNT_GetAll();
            rcbCategoryPL.DataTextField = "Display";
            rcbCategoryPL.DataValueField = "Id";
            rcbCategoryPL.DataBind();

        }

        private void LoadToolBar()
        {
            RadToolBar1.FindItemByValue("btPreview").Enabled = false;
            RadToolBar1.FindItemByValue("btAuthorize").Enabled = false;
            RadToolBar1.FindItemByValue("btReverse").Enabled = false;
            RadToolBar1.FindItemByValue("btSearch").Enabled = false;
            RadToolBar1.FindItemByValue("btPrint").Enabled = false;
        }

        protected void RadToolBar1_ButtonClick(object sender, RadToolBarEventArgs e)
        {
            var ToolBarButton = e.Item as RadToolBarButton;
            var commandName = ToolBarButton.CommandName;
            if (commandName == "commit")
            {
                tbDepositCode.Text = TriTT.B_BMACODE_GetNewID_3par("COLL_CONTIN_ENTRY", Refix_BMACODE(), "/");
                rcbDebitAccount.SelectedValue = "";
                rcbDebitAccount.Focus();
                tbChargeAmountFCY.Text = "";
                tbChargeAmountLCY.Text = "";
                tbVATAmount.Text = "";
                tbVATAmountLCY.Text = "";
                tbTotalAmount.Text = "";
                tbTotalAmountLCY.Text = "";
                tbVATSerialNo.Text = "";
                tbNarrative.Text = "";
                rcbCategoryPL.SelectedValue = "";
                rcbCurrency.SelectedValue = "";
                txtDealRate.Text = "";
            }
        }

        void LoadCustomerAcc() {
            rcbDebitAccount.Items.Clear();

            DataSet ds = BankProject.DataProvider.Database.B_BDRFROMACCOUNT_GetByCustomer("", rcbCurrency.SelectedValue);
            if (ds != null && ds.Tables.Count > 0 && ds.Tables[0].Rows.Count > 0)
            {
                DataRow dr = ds.Tables[0].NewRow();
                dr["Display"] = "";
                dr["Id"] = "";
                dr["CustomerID"] = "";
                dr["Name"] = "";
                ds.Tables[0].Rows.InsertAt(dr, 0);

                rcbDebitAccount.DataTextField = "Display";
                rcbDebitAccount.DataValueField = "Id";
                rcbDebitAccount.DataSource = ds;
                rcbDebitAccount.DataBind();
            }

            
        }

        protected void rcbDebitAccount_ItemDataBound(object sender, RadComboBoxItemEventArgs e)
        {
            DataRowView row = e.Item.DataItem as DataRowView;
            e.Item.Attributes["CustomerName"] = row["Name"].ToString();  //CustomerName
            e.Item.Attributes["CustomerID"] = row["CustomerID"].ToString();
        }


        protected void rcbCurrency_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
        {
            LoadCustomerAcc();

            switch (rcbCurrency.SelectedValue)
            {
                case "VND":
                    tbChargeAmountFCY.Value = null;
                    tbVATAmount.Value = null;
                    tbTotalAmount.Value = null;

                    tbChargeAmountFCY.Enabled = false;
                    tbVATAmount.Enabled = false;
                    tbTotalAmount.Enabled = false;

                    tbChargeAmountLCY.Enabled = true;
                    tbVATAmountLCY.Enabled = true;
                    tbTotalAmountLCY.Enabled = true;
                    tbChargeAmountLCY_TextChanged(sender, null);
                    break;

                default:
                    tbChargeAmountLCY.Value = null;
                    tbVATAmountLCY.Value = null;
                    tbTotalAmountLCY.Value = null;

                    tbChargeAmountLCY.Enabled = false;
                    tbVATAmountLCY.Enabled = false;
                    tbTotalAmountLCY.Enabled = false;

                    tbChargeAmountFCY.Enabled = true;
                    tbVATAmount.Enabled = true;
                    tbTotalAmount.Enabled = true;
                    tbChargeAmountFCY_TextChanged(sender, null);
                    break;
            }
        }

        protected void tbChargeAmountLCY_TextChanged(object sender, EventArgs e)
        {
            tbVATAmountLCY.Value = tbChargeAmountLCY.Value * percentVat;
            tbTotalAmountLCY.Value = tbVATAmountLCY.Value + tbChargeAmountLCY.Value;
        }

        protected void tbChargeAmountFCY_TextChanged(object sender, EventArgs e)
        {
            double DealRateValue = 1;
            if (txtDealRate.Value > 0)
            {
                DealRateValue = txtDealRate.Value.Value;
            }
            tbVATAmount.Value = tbChargeAmountFCY.Value * percentVat;
            tbTotalAmount.Value = tbVATAmount.Value + tbChargeAmountFCY.Value;

            tbChargeAmountLCY.Value = tbChargeAmountFCY.Value * DealRateValue;
            tbVATAmountLCY.Value = tbChargeAmountLCY.Value * percentVat;
            tbTotalAmountLCY.Value = tbVATAmountLCY.Value + tbChargeAmountLCY.Value;
        }

        protected void txtDealRate_TextChanged(object sender, EventArgs e)
        {
            if (tbChargeAmountFCY.Value > 0)
                tbChargeAmountFCY_TextChanged(sender, null);
            else
                tbChargeAmountLCY_TextChanged(sender, null);
        }

        protected void tbVATAmountLCY_TextChanged(object sender, EventArgs e)
        {
            tbTotalAmountLCY.Value = tbVATAmountLCY.Value + tbChargeAmountLCY.Value;
        }

        protected void tbVATAmount_TextChanged(object sender, EventArgs e)
        {
            tbTotalAmount.Value = tbVATAmount.Value + tbChargeAmountFCY.Value;
        }
    }
}