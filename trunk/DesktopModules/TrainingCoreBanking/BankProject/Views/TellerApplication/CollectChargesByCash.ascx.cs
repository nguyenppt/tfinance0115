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
    public partial class CollectChargesByCash : PortalModuleBase
    {
        const double percentVat = 0.1;//10%
        private static int Id = 7890;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (IsPostBack) return;
            this.txtId.Text = "TT/09161/0" + Id.ToString();

            txtTellerId.Text = this.UserInfo.Username;
            LoadToolBar();

            DataSet dsc = DataProvider.DataTam.B_BCUSTOMERS_GetAll();
            rcbCustomerID.DataSource = dsc;
            rcbCustomerID.DataTextField = "CustomerName";
            rcbCustomerID.DataValueField = "CustomerID";
            rcbCustomerID.DataBind();

            rcbCategoryPL.Items.Add(new RadComboBoxItem("", ""));
            rcbCategoryPL.AppendDataBoundItems = true;
            rcbCategoryPL.DataSource = DataProvider.Database.B_BBPLACCOUNT_GetAll();
            rcbCategoryPL.DataTextField = "Display";
            rcbCategoryPL.DataValueField = "Id";
            rcbCategoryPL.DataBind();

            tbNarrative.SetTextDefault("");
            tbNarrative.Width = "800";
        }

        private void LoadToolBar()
        {
            RadToolBar1.FindItemByValue("btPreview").Enabled = false;
            RadToolBar1.FindItemByValue("btAuthorize").Enabled = false;
            RadToolBar1.FindItemByValue("btSearch").Enabled = false;
            RadToolBar1.FindItemByValue("btReverse").Enabled = false;
            RadToolBar1.FindItemByValue("btPrint").Enabled = false;
        }

        protected void RadToolBar1_ButtonClick(object sender, RadToolBarEventArgs e)
        {

            var toolBarButton = e.Item as RadToolBarButton;
            string commandName = toolBarButton.CommandName;
            if (commandName == "commit")
            {
                Id++;
                BankProject.Controls.Commont.SetEmptyFormControls(this.Controls);
                this.txtId.Text = "TT/09161/0" + Id.ToString();
                txtTellerId.Text = this.UserInfo.Username;
                //this.txtId.Text = "TT/09161/0" + Id.ToString();
                //this.cmbCustomerAccount.SelectedIndex = 0;
                //this.txtAmtFCY.Text = string.Empty;
                //this.txtAmtLCY.Text = string.Empty;
                //this.txtNarrative.Text = string.Empty;

                //this.cmbCurrencyPaid.SelectedIndex = 0;
                //this.txtDealRate.Text = string.Empty;
                //this.cmbWaiveCharges.SelectedIndex = 0;
            }
        }

        protected void rcbCustomerID_ItemDataBound(object sender, RadComboBoxItemEventArgs e)
        {
            DataRowView row = e.Item.DataItem as DataRowView;
            e.Item.Attributes["CustomerName"] = row["CustomerName2"].ToString();
            e.Item.Attributes["Address"] = row["Address"].ToString();
            e.Item.Attributes["IdentityNo"] = row["IdentityNo"].ToString();
            e.Item.Attributes["IssueDate"] = row["IssueDate"].ToString();
            e.Item.Attributes["IssuePlace"] = row["IssuePlace"].ToString();
        }

        protected void rcbCurrency_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
        {
            switch (rcbCurrency.SelectedValue)
            {
                case "VND":
                    tbChargeAmountFCY.Value = null;
                    tbVatAmountFCY.Value = null;
                    tbTotalAmountFCY.Value = null;

                    tbChargeAmountFCY.Enabled = false;
                    tbVatAmountFCY.Enabled = false;
                    tbTotalAmountFCY.Enabled = false;

                    tbChargeAmountLCY.Enabled = true;
                    tbVatAmountLCY.Enabled = true;
                    tbTotalAmountLCY.Enabled = true;
                    tbChargeAmountLCY_TextChanged(sender, null);
                    break;

                default:
                    tbChargeAmountLCY.Value = null;
                    tbVatAmountLCY.Value = null;
                    tbTotalAmountLCY.Value = null;

                    tbChargeAmountLCY.Enabled = false;
                    tbVatAmountLCY.Enabled = false;
                    tbTotalAmountLCY.Enabled = false;

                    tbChargeAmountFCY.Enabled = true;
                    tbVatAmountFCY.Enabled = true;
                    tbTotalAmountFCY.Enabled = true;
                    tbChargeAmountFCY_TextChanged(sender, null);
                    break;
            }

            string CustomerName = rcbCustomerID.Text != "" ? rcbCustomerID.Text.Split('-')[1].Trim() : "";
            rcbCashAccount.Items.Clear();
            rcbCashAccount.Items.Add(new RadComboBoxItem("",""));
            rcbCashAccount.Items.Add(new RadComboBoxItem("USD-10001-0024-2690","USD"));
            rcbCashAccount.Items.Add(new RadComboBoxItem("EUR-10001-0024-2695","EUR"));
            rcbCashAccount.Items.Add(new RadComboBoxItem("GBP-10001-0024-2700","GBP"));
            rcbCashAccount.Items.Add(new RadComboBoxItem("JPY-10001-0024-2705","JPY"));
            rcbCashAccount.Items.Add(new RadComboBoxItem("VND-10001-0024-2710","VND"));
            rcbCashAccount.DataSource = BankProject.DataProvider.Database.B_BDRFROMACCOUNT_GetByCustomer(CustomerName, rcbCurrency.SelectedValue);
            rcbCashAccount.DataTextField = "Display";
            rcbCashAccount.DataValueField = "Id";
            rcbCashAccount.DataBind();
        }

        protected void tbChargeAmountLCY_TextChanged(object sender, EventArgs e)
        {
            tbVatAmountLCY.Value = tbChargeAmountLCY.Value * percentVat;
            tbTotalAmountLCY.Value = tbChargeAmountLCY.Value + tbVatAmountLCY.Value;
        }

        protected void tbChargeAmountFCY_TextChanged(object sender, EventArgs e)
        {
            double DealRateValue = 1;
            if (tbDealRate.Value > 0)
            {
                DealRateValue = tbDealRate.Value.Value;
            }
            tbVatAmountFCY.Value = tbChargeAmountFCY.Value * percentVat;
            tbTotalAmountFCY.Value = tbVatAmountFCY.Value + tbChargeAmountFCY.Value;

            tbChargeAmountLCY.Value = tbChargeAmountFCY.Value * DealRateValue;
            tbVatAmountLCY.Value = tbChargeAmountLCY.Value * percentVat;
            tbTotalAmountLCY.Value = tbVatAmountLCY.Value + tbChargeAmountLCY.Value;
        }

        protected void tbDealRate_TextChanged(object sender, EventArgs e)
        {
            if (tbChargeAmountFCY.Value > 0)
                tbChargeAmountFCY_TextChanged(sender, null);
            else
                tbChargeAmountLCY_TextChanged(sender, null);
        }

        protected void tbVatAmountLCY_TextChanged(object sender, EventArgs e)
        {
            tbTotalAmountLCY.Value = tbVatAmountLCY.Value + tbChargeAmountLCY.Value;
        }
        
        protected void tbVatAmountFCY_TextChanged(object sender, EventArgs e)
        {
            tbTotalAmountFCY.Value = tbVatAmountFCY.Value + tbChargeAmountFCY.Value;
        }

        
    }
}