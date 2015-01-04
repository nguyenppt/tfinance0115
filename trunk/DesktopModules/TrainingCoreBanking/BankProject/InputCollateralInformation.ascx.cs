using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using Telerik.Web.UI;

namespace BankProject
{
    public partial class InputCollateralInformation : DotNetNuke.Entities.Modules.PortalModuleBase
    {
        public static int AutoID = 1;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (IsPostBack) return;
            FirstLoad();
            rcbColateralType.Focus();
            tbCollInfo.Text = "900756.1." + AutoID.ToString();
            RdpValueDate.SelectedDate = DateTime.Now;
            tbExeValue.Value = tbNominalValue.Value * 0.7;
            if (Request.QueryString["IsAuthorize"] != null)
            {
                LoadToolBar(true);
                BankProject.Controls.Commont.SetTatusFormControls(this.Controls, false);
                LoadPreview();
            }
            else
            {
                LoadToolBar(false);
            }
        }
        private void LoadToolBar(bool isauthorize)
        {
            RadToolBar1.FindItemByValue("btCommitData").Enabled = !isauthorize;
            RadToolBar1.FindItemByValue("btPreview").Enabled = !isauthorize;
            RadToolBar1.FindItemByValue("btAuthorize").Enabled = isauthorize;
            RadToolBar1.FindItemByValue("btReverse").Enabled = isauthorize;
            RadToolBar1.FindItemByValue("btSearch").Enabled = false;
            RadToolBar1.FindItemByValue("btPrint").Enabled = false;
        }
        protected void FirstLoad()
        {
            LoadCountries();
        }
        protected void LoadCountries()
        {
            rcbCountry.DataSource = DataProvider.TriTT.B_BCOUNTRY_GetAll();
            rcbCountry.DataTextField = "TenTA";
            rcbCountry.DataValueField = "MaQuocGia";
            rcbCountry.DataBind();
        }
        protected void RadToolBar1_ButtonClick(object sender, RadToolBarEventArgs e)
        {
            var toolbarbutton = e.Item as RadToolBarButton;
            var commandname = toolbarbutton.CommandName;
            if (commandname == "commit")
            {
                AutoID++;
                rcbColateralType.Focus();
                tbCollInfo.Text = "900756.1." + AutoID.ToString();
                this.rcbColateralType.SelectedValue = "";
                this.rcbCollateralCode.SelectedValue = "";
                rcbContingentAcct.SelectedValue = "";
                tbDescription.Text = "";
                tbAddress.Text = "";
                rcbCompany.SelectedValue = "";
                tbApplicationID.Text = "";
                tbNotes.Text = "";
                rcbCompanyStorage.SelectedValue = "";
                rcbCountry.SelectedValue ="VN";
                tbNominalValue.Text = "";
                tbMaxi.Text = "";
                tbExeValue.Text = "";
                RdpValueDate.SelectedDate = DateTime.Now;
                RdpExpiryDate.SelectedDate = null;
                tbCreditCardNo.Text = "";
                tbTotalColAmt.Text = "";
                tbReviewDateFreq.Text = "";
                rcbCardholder.SelectedValue = "";
                rcbCardholder.SelectedValue = "";
            }
            if (commandname == "Preview")
            {
                Response.Redirect(EditUrl("InputCollateralInformation_PL"));
            }
            if (commandname == "authorize" || commandname == "reverse")
            {
                BankProject.Controls.Commont.SetTatusFormControls(this.Controls, true);
                BankProject.Controls.Commont.SetEmptyFormControls(this.Controls);
                LoadToolBar(false);
                AfterProc();
            }
        }
        public void AfterProc()
        {
            rcbColateralType.Focus();
            tbCollInfo.Text = "900756.1." + AutoID.ToString();
            rcbCountry.SelectedValue = "VN";
            RdpValueDate.SelectedDate = DateTime.Now;
            tbExeValue.Value = tbNominalValue.Value * 0.7;
        }
        void LoadPreview()
        {
            if (Request.QueryString["LCCode"] != null)
            {
                string LCCode = Request.QueryString["LCCode"].ToString();
                switch (LCCode)
                {
                    case "0":
                        tbCollInfo.Text = "900756.1.1";
                        lblCollInfo.Text = "Vu Thi My Hanh";
                        rcbColateralType.SelectedValue = "351";
                        rcbCollateralCode.SelectedValue = "7";
                        rcbContingentAcct.SelectedValue = "VND1941100011221";
                        tbDescription.Text = "xe con moi";
                        tbAddress.Text = "so 1 Truong Dinh, Q3, Tp HCM";
                        rcbCollateralStatus.SelectedValue = "00";
                        rcbCompanyStorage.SelectedValue = "VN-001-1221";
                        rcbCurrency.SelectedValue = "VND";
                        rcbCountry.SelectedValue = "VN";
                        tbExeValue.Text = "100000000";
                        tbNominalValue.Text = Convert.ToString(tbExeValue.Value / 0.7);
                        RdpValueDate.SelectedDate = Convert.ToDateTime("8/8/2015");
                        RdpExpiryDate.SelectedDate = Convert.ToDateTime("8/8/2015");
                        break;
                    case "1":
                        tbCollInfo.Text = "900757.1.1";
                        lblCollInfo.Text = "Vu Thi My";
                        rcbColateralType.SelectedValue = "352";
                        rcbCollateralCode.SelectedValue = "8";
                        rcbContingentAcct.SelectedValue = "VND1941100011221";
                        tbDescription.Text = "Nha O Mat Tien";
                        tbAddress.Text = "so 2 Truong Dinh, Q3, Tp HCM";
                        rcbCollateralStatus.SelectedValue = "00";
                        rcbCompanyStorage.SelectedValue = "VN-001-1221";
                        rcbCurrency.SelectedValue = "VND";
                        rcbCountry.SelectedValue = "VN";
                        tbExeValue.Text = "200000000";
                        tbNominalValue.Text = Convert.ToString(tbExeValue.Value / 0.7);
                        RdpValueDate.SelectedDate = Convert.ToDateTime("1/1/2014");
                        RdpExpiryDate.SelectedDate = Convert.ToDateTime("1/1/2015");
                        break;
                    case "2":
                        tbCollInfo.Text = "900759.1.1";
                        lblCollInfo.Text = "Tran Hoai Nhan";
                        rcbColateralType.SelectedValue = "353";
                        rcbCollateralCode.SelectedValue = "8";
                        rcbContingentAcct.SelectedValue = "VND1941100011221";
                        tbDescription.Text = "Nha O Mat Tien";
                        tbAddress.Text = "so 3 Truong Dinh, Q3, Tp HCM";
                        rcbCollateralStatus.SelectedValue = "01";
                        rcbCompanyStorage.SelectedValue = "VN-001-1221";
                        rcbCurrency.SelectedValue = "VND";
                        rcbCountry.SelectedValue = "001";
                        tbExeValue.Text = "300000000";
                        tbNominalValue.Text = Convert.ToString(tbExeValue.Value / 0.7);
                        RdpValueDate.SelectedDate = Convert.ToDateTime("2/2/2014");
                        RdpExpiryDate.SelectedDate = Convert.ToDateTime("2/2/2015");
                        break;
                    case "3":
                        tbCollInfo.Text = "900760.1.1";
                        lblCollInfo.Text = "Tran Nhan Tan";
                        rcbColateralType.SelectedValue = "354";
                        rcbCollateralCode.SelectedValue = "7";
                        rcbContingentAcct.SelectedValue = "VND1941100011221";
                        tbDescription.Text = "Xe con moi, chat luong";
                        tbAddress.Text = "so 5 Truong Dinh, Q3, Tp HCM";
                        rcbCollateralStatus.SelectedValue = "01";
                        rcbCompanyStorage.SelectedValue = "VN-001-1221";
                        rcbCurrency.SelectedValue = "VND";
                        rcbCountry.SelectedValue = "001";
                        tbExeValue.Text = "400000000";
                        tbNominalValue.Text = Convert.ToString(tbExeValue.Value / 0.7);
                        RdpValueDate.SelectedDate = Convert.ToDateTime("3/3/2014");
                        RdpExpiryDate.SelectedDate = Convert.ToDateTime("3/3/2015");
                        break;
                    case "4":
                        tbCollInfo.Text = "900761.1.1";
                        lblCollInfo.Text = "Vu Hien Hoa";
                        rcbColateralType.SelectedValue = "355";
                        rcbCollateralCode.SelectedValue = "7";
                        rcbContingentAcct.SelectedValue = "VND1941100011221";
                        tbDescription.Text = "xe hoi con moi";
                        tbAddress.Text = "so 11 Truong Dinh, Q3, Tp HCM";
                        rcbCollateralStatus.SelectedValue = "02";
                        rcbCompanyStorage.SelectedValue = "VN-001-1221";
                        rcbCurrency.SelectedValue = "VND";
                        rcbCountry.SelectedValue = "001";
                        tbExeValue.Text = "500000000";
                        tbNominalValue.Text = Convert.ToString(tbExeValue.Value / 0.7);
                        RdpValueDate.SelectedDate = Convert.ToDateTime("4/4/2014");
                        RdpExpiryDate.SelectedDate = Convert.ToDateTime("4/4/2015");
                        break;
                    case "5":
                        tbCollInfo.Text = "900762.1.1";
                        lblCollInfo.Text = "Hoang Hoa Tham";
                        rcbColateralType.SelectedValue = "356";
                        rcbCollateralCode.SelectedValue = "8";
                        rcbContingentAcct.SelectedValue = "VND1941100011221";
                        tbDescription.Text = "Nha O Mat Tien";
                        tbAddress.Text = "so 12 Truong Dinh, Q3, Tp HCM";
                        rcbCollateralStatus.SelectedValue = "02";
                        rcbCompanyStorage.SelectedValue = "VN-001-1221";
                        rcbCurrency.SelectedValue = "VND";
                        rcbCountry.SelectedValue = "001";
                        tbExeValue.Text = "600000000";
                        tbNominalValue.Text = Convert.ToString(tbExeValue.Value / 0.7);
                        RdpValueDate.SelectedDate = Convert.ToDateTime("5/5/2014");
                        RdpExpiryDate.SelectedDate = Convert.ToDateTime("5/5/2015");
                        break;
                    case "6":
                        tbCollInfo.Text = "900763.1.1";
                        lblCollInfo.Text = "Nguyen Nhat Linh";
                        rcbColateralType.SelectedValue = "357";
                        rcbCollateralCode.SelectedValue = "8";
                        rcbContingentAcct.SelectedValue = "VND1941100011221";
                        tbDescription.Text = "Nha O Mat Tien";
                        tbAddress.Text = "so 13 Truong Dinh, Q3, Tp HCM";
                        rcbCollateralStatus.SelectedValue = "00";
                        rcbCompanyStorage.SelectedValue = "VN-001-1221";
                        rcbCurrency.SelectedValue = "VND";
                        rcbCountry.SelectedValue = "001";
                        tbExeValue.Text = "700000000";
                        tbNominalValue.Text = Convert.ToString(tbExeValue.Value / 0.7);
                        RdpValueDate.SelectedDate = Convert.ToDateTime("6/6/2014");
                        RdpExpiryDate.SelectedDate = Convert.ToDateTime("6/6/2015");
                        break;
                    case "7":
                        tbCollInfo.Text = "900764.1.1";
                        lblCollInfo.Text = "Vo Hoang My Hanh";
                        rcbColateralType.SelectedValue = "358";
                        rcbCollateralCode.SelectedValue = "8";
                        rcbContingentAcct.SelectedValue = "VND1941100011221";
                        tbDescription.Text = "Nha O Mat Tien";
                        tbAddress.Text = "so 16 Truong Dinh, Q3, Tp HCM";
                        rcbCollateralStatus.SelectedValue = "00";
                        rcbCompanyStorage.SelectedValue = "VN-001-1221";
                        rcbCurrency.SelectedValue = "VND";
                        rcbCountry.SelectedValue = "001";
                        tbExeValue.Text = "700000000";
                        tbNominalValue.Text = Convert.ToString(tbExeValue.Value / 0.7);
                        RdpValueDate.SelectedDate = Convert.ToDateTime("7/7/2014");
                        RdpExpiryDate.SelectedDate = Convert.ToDateTime("7/7/2015");
                        break;
                    case "8":
                        tbCollInfo.Text = "900765.1.1";
                        lblCollInfo.Text = " Le Minh Y";
                        rcbColateralType.SelectedValue = "359";
                        rcbCollateralCode.SelectedValue = "8";
                        rcbContingentAcct.SelectedValue = "VND1941100011221";
                        tbDescription.Text = "Nha O Mat Tien";
                        tbAddress.Text = "so 21 Truong Dinh, Q3, Tp HCM";
                        rcbCollateralStatus.SelectedValue = "01";
                        rcbCompanyStorage.SelectedValue = "VN-001-1221";
                        rcbCurrency.SelectedValue = "VND";
                        rcbCountry.SelectedValue = "001";
                        tbExeValue.Text = "900000000";
                        tbNominalValue.Text = Convert.ToString(tbExeValue.Value / 0.7);
                        RdpValueDate.SelectedDate = Convert.ToDateTime("8/8/2014");
                        RdpExpiryDate.SelectedDate = Convert.ToDateTime("8/8/2015");
                        break;
                    case "9":
                        tbCollInfo.Text = "900766.1.1";
                        lblCollInfo.Text = "Le Minh Anh";
                        rcbColateralType.SelectedValue = "359";
                        rcbCollateralCode.SelectedValue = "7";
                        rcbContingentAcct.SelectedValue = "VND1941100011221";
                        tbDescription.Text = "xe hoi con moi";
                        tbAddress.Text = "so 1 Truong Dinh, Q3, Tp HCM";
                        rcbCollateralStatus.SelectedValue = "01";
                        rcbCompanyStorage.SelectedValue = "VN-001-1221";
                        rcbCurrency.SelectedValue = "VND";
                        rcbCountry.SelectedValue = "001";
                        tbExeValue.Text = "200000000";
                        tbNominalValue.Text = Convert.ToString(tbExeValue.Value / 0.7);
                        RdpValueDate.SelectedDate = Convert.ToDateTime("9/9/2014");
                        RdpExpiryDate.SelectedDate = Convert.ToDateTime("9/9/2015");
                        break;

                }
            }
            
        }
    }
}