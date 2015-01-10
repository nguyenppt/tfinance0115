﻿using System;
using System.Data;
using System.Web.UI;
using DotNetNuke.Common;
using Telerik.Web.UI;
using BankProject.DBContext;
using bd = BankProject.DataProvider;
using bc = BankProject.Controls;
using BankProject.DataProvider;
using System.Linq;
using System.Collections.Generic;
using System.Data.Objects;
using BankProject.Helper;
using BankProject.Model;
using System.Globalization;
using System.Web.UI.WebControls;
using System.Data.Entity.Validation;

namespace BankProject.TradingFinance.Export.DocumentaryCredit
{//B_ExportDocCreditProcessing
    public partial class DocumentProcessing : DotNetNuke.Entities.Modules.PortalModuleBase
    {
        private ExportLCDocProcessing dbEntities = new ExportLCDocProcessing();
        protected void Page_Load(object sender, EventArgs e)
        {
            txtChargeCode1.Text = (TabId == ExportLCDocProcessing.Actions.Amend ? ExportLCDocProcessing.Charges.Service : ExportLCDocProcessing.Charges.Commission);
            txtChargeCode2.Text = ExportLCDocProcessing.Charges.Courier;
            txtChargeCode3.Text = ExportLCDocProcessing.Charges.Other;
            if (IsPostBack) return;
            //
            RadToolBar1.FindItemByValue("btCommit").Enabled = false;
            RadToolBar1.FindItemByValue("btPreview").Enabled = false;
            RadToolBar1.FindItemByValue("btAuthorize").Enabled = false;
            RadToolBar1.FindItemByValue("btReverse").Enabled = false;
            RadToolBar1.FindItemByValue("btSearch").Enabled = false;
            RadToolBar1.FindItemByValue("btPrint").Enabled = false;
            //
            setDefaultControls();
            //
            string lst = Request.QueryString["lst"];
            tbLCCode.Text = Request.QueryString["code"];
            if (!string.IsNullOrEmpty(tbLCCode.Text))
            {
                BEXPORT_LC_DOCS_PROCESSING ExLCDoc, ExLCDocAmend;
                int i = tbLCCode.Text.IndexOf(".");
                #region Amend
                if (TabId == ExportLCDocProcessing.Actions.Amend)
                {
                    //Code có dạng DocCode = TFxxx.No hoặc AmendCode = TFxxx.No.No
                    if (i < 0)
                    {
                        lblLCCodeMessage.Text = "Invalid Code !";
                        return;
                    }
                    #region Nếu chờ duyệt
                    if (!string.IsNullOrEmpty(lst) && lst.Equals("4appr"))
                    {
                        //Nếu code là TFxxx.No -> báo lỗi
                        if (tbLCCode.Text.IndexOf(".", i + 1) < 0)
                        {
                            lblLCCodeMessage.Text = "Invalid Code !";
                            return;
                        }
                        //Load thông tin AmendCode
                        ExLCDocAmend = dbEntities.findExportLCDoc(tbLCCode.Text);
                        if (ExLCDocAmend == null)
                        {
                            lblLCCodeMessage.Text = "This Code not exists !";
                            return;
                        }
                        loadLCDoc(ExLCDocAmend);
                        bc.Commont.SetTatusFormControls(this.Controls, false);
                        if (!string.IsNullOrEmpty(ExLCDocAmend.AmendStatus) && !ExLCDocAmend.AmendStatus.Equals(bd.TransactionStatus.UNA))
                        {
                            lblLCCodeMessage.Text = "This Code status invalid !";
                            RadToolBar1.FindItemByValue("btPreview").Enabled = true;
                            RadToolBar1.FindItemByValue("btSearch").Enabled = true;
                            RadToolBar1.FindItemByValue("btPrint").Enabled = true;
                            return;
                        }
                        //Cho phép duyệt
                        RadToolBar1.FindItemByValue("btAuthorize").Enabled = true;
                        RadToolBar1.FindItemByValue("btReverse").Enabled = true;
                        RadToolBar1.FindItemByValue("btPrint").Enabled = true;
                        return;
                    }
                    #endregion
                    //
                    ExLCDoc = dbEntities.findExportLCDoc(tbLCCode.Text);
                    if (ExLCDoc == null)
                    {
                        lblLCCodeMessage.Text = "This Code not exists !";
                        return;
                    }
                    #region Nếu Code là AmendCode = TFxxx.No.No
                    if (tbLCCode.Text.IndexOf(".", i + 1) > 0)
                    {
                        loadLCDoc(ExLCDoc);
                        if (ExLCDoc.AmendStatus.Equals(bd.TransactionStatus.AUT))
                        {
                            lblLCCodeMessage.Text = "This Code is authorized !";
                            RadToolBar1.FindItemByValue("btPreview").Enabled = true;
                            RadToolBar1.FindItemByValue("btSearch").Enabled = true;
                            RadToolBar1.FindItemByValue("btPrint").Enabled = true;
                            bc.Commont.SetTatusFormControls(this.Controls, false);
                            return;
                        }
                        //Cho phép edit ?
                        ExLCDocAmend = dbEntities.findExportLCDocLastestAmend(ExLCDoc.DocCode);
                        if (!ExLCDoc.AmendNo.Equals(ExLCDocAmend.AmendNo))
                        {
                            RadToolBar1.FindItemByValue("btPreview").Enabled = true;
                            RadToolBar1.FindItemByValue("btSearch").Enabled = true;
                            RadToolBar1.FindItemByValue("btPrint").Enabled = true;
                            bc.Commont.SetTatusFormControls(this.Controls, false);
                            return;
                        }
                        //Cho phép edit
                        RadToolBar1.FindItemByValue("btCommit").Enabled = true;
                        RadToolBar1.FindItemByValue("btPreview").Enabled = true;
                        RadToolBar1.FindItemByValue("btSearch").Enabled = true;
                        return;
                    }
                    #endregion
                    //Code là DocCode = TFxxx.No
                    if (!ExLCDoc.Status.Equals(bd.TransactionStatus.AUT))
                    {
                        lblLCCodeMessage.Text = "This Code is not authorized !";
                        return;
                    }
                    if (ExLCDoc.PaymentFull != null && ExLCDoc.PaymentFull.Value)
                    {
                        lblLCCodeMessage.Text = "This Code is PAYMENT FULL !";
                        return;
                    }
                    if (!string.IsNullOrEmpty(ExLCDoc.AmendStatus) && ExLCDoc.Status.Equals(bd.TransactionStatus.UNA))
                    {
                        lblLCCodeMessage.Text = "This Code is waiting for AMEND approve !";
                        return;
                    }
                    if (!string.IsNullOrEmpty(ExLCDoc.RejectStatus))
                    {
                        if (ExLCDoc.RejectStatus.Equals(bd.TransactionStatus.UNA))
                        {
                            lblLCCodeMessage.Text = "This Code is waiting for REJECT approve !";
                            return;
                        }
                        if (ExLCDoc.RejectStatus.Equals(bd.TransactionStatus.AUT))
                        {
                            lblLCCodeMessage.Text = "This Code is REJECTED !";
                            return;
                        }
                    }
                    ExLCDocAmend = dbEntities.findExportLCDocLastestAmend(tbLCCode.Text);
                    if (ExLCDocAmend.AmendNo.Equals(tbLCCode.Text))
                        tbLCCode.Text += ".1";
                    else
                    {
                        string[] s = ExLCDocAmend.AmendNo.Split('.');
                        tbLCCode.Text += "." + (Convert.ToInt32(s[2]) + 1);
                    }
                    loadLCDoc(ExLCDoc);
                    //Cho phép amend
                    RadToolBar1.FindItemByValue("btCommit").Enabled = true;
                    RadToolBar1.FindItemByValue("btPreview").Enabled = true;
                    RadToolBar1.FindItemByValue("btSearch").Enabled = true;
                    return;
                }
                #endregion Amend
                #region register, reject, accept
                #region chờ duyệt
                if (!string.IsNullOrEmpty(lst) && lst.Equals("4appr"))
                {
                    if (i < 0)
                    {
                        lblLCCodeMessage.Text = "Invalid Code !";
                        return;
                    }
                    ExLCDoc = dbEntities.findExportLCDoc(tbLCCode.Text);
                    if (ExLCDoc == null)
                    {
                        lblLCCodeMessage.Text = "This Code not exists !";
                        return;
                    }
                    loadLCDoc(ExLCDoc);
                    bc.Commont.SetTatusFormControls(this.Controls, false);
                    if (TabId == ExportLCDocProcessing.Actions.Accept)
                    {
                        if (!string.IsNullOrEmpty(ExLCDoc.AcceptStatus) && ExLCDoc.AcceptStatus.Equals(bd.TransactionStatus.UNA))
                        {
                            //Cho phép duyệt
                            RadToolBar1.FindItemByValue("btAuthorize").Enabled = true;
                            RadToolBar1.FindItemByValue("btReverse").Enabled = true;
                            RadToolBar1.FindItemByValue("btPrint").Enabled = true;
                            return;
                        }
                        return;
                    }
                    if (TabId == ExportLCDocProcessing.Actions.Reject)
                    {
                        if (!string.IsNullOrEmpty(ExLCDoc.RejectStatus) && ExLCDoc.RejectStatus.Equals(bd.TransactionStatus.UNA))
                        {
                            //Cho phép duyệt
                            RadToolBar1.FindItemByValue("btAuthorize").Enabled = true;
                            RadToolBar1.FindItemByValue("btReverse").Enabled = true;
                            RadToolBar1.FindItemByValue("btPrint").Enabled = true;
                            return;
                        }
                        return;
                    }
                    //register approve
                    if (!string.IsNullOrEmpty(ExLCDoc.Status) && ExLCDoc.Status.Equals(bd.TransactionStatus.UNA))
                    {
                        //Cho phép duyệt
                        RadToolBar1.FindItemByValue("btAuthorize").Enabled = true;
                        RadToolBar1.FindItemByValue("btReverse").Enabled = true;
                        RadToolBar1.FindItemByValue("btPrint").Enabled = true;
                        return;
                    }
                    return;
                }
                #endregion
                //
                if (i < 0)//Export LC code
                {
                    if (TabId == ExportLCDocProcessing.Actions.Reject || TabId == ExportLCDocProcessing.Actions.Accept)
                    {
                        lblLCCodeMessage.Text = "Invalid Code !";
                        return;
                    }
                    ExLCDoc = dbEntities.findExportLCLastestDoc(tbLCCode.Text);
                    if (ExLCDoc != null)
                    {
                        if (ExLCDoc.Status.Equals(bd.TransactionStatus.UNA))
                        {
                            lblLCCodeMessage.Text = "This LCCode has doc waiting for approve !";
                            return;
                        }
                    }
                    var ExLC = dbEntities.findExportLC(tbLCCode.Text);
                    if (ExLC == null)
                    {
                        lblLCCodeMessage.Text = "This LCCode not exists !";
                        return;
                    }
                    loadLC(ExLC);
                    txtVATNo.Text = dbEntities.getVATNo();
                    if (ExLCDoc == null)
                        tbLCCode.Text += ".1";
                    else
                    {
                        string[] s = ExLCDoc.DocCode.Split('.');
                        tbLCCode.Text += "." + (Convert.ToInt32(s[1]) + 1);
                    }
                    //Cho phép thanh toán
                    RadToolBar1.FindItemByValue("btCommit").Enabled = true;
                    RadToolBar1.FindItemByValue("btPreview").Enabled = true;
                    RadToolBar1.FindItemByValue("btSearch").Enabled = true;
                    return;
                }
                //
                ExLCDoc = dbEntities.findExportLCDoc(tbLCCode.Text);
                if (ExLCDoc == null)
                {
                    lblLCCodeMessage.Text = "This Code not exists !";
                    return;
                }
                loadLCDoc(ExLCDoc);
                if (TabId == ExportLCDocProcessing.Actions.Accept || TabId == ExportLCDocProcessing.Actions.Reject)
                {
                    bc.Commont.SetTatusFormControls(this.Controls, false);
                    if (!string.IsNullOrEmpty(ExLCDoc.ActiveRecordFlag) && !ExLCDoc.ActiveRecordFlag.Equals("Yes"))
                    if (!ExLCDoc.Status.Equals(bd.TransactionStatus.AUT))
                        return;
                    if (TabId == ExportLCDocProcessing.Actions.Accept)
                    {
                        if (string.IsNullOrEmpty(ExLCDoc.AcceptStatus) || !ExLCDoc.AcceptStatus.Equals(bd.TransactionStatus.AUT))
                        {
                            //Cho phép accept
                            RadToolBar1.FindItemByValue("btCommit").Enabled = true;
                            RadToolBar1.FindItemByValue("btPreview").Enabled = true;
                            RadToolBar1.FindItemByValue("btSearch").Enabled = true;
                            return;
                        }
                        return;
                    }
                    if (TabId == ExportLCDocProcessing.Actions.Reject)
                    {
                        if (string.IsNullOrEmpty(ExLCDoc.RejectStatus) || !ExLCDoc.RejectStatus.Equals(bd.TransactionStatus.AUT))
                        {
                            //Cho phép reject
                            RadToolBar1.FindItemByValue("btCommit").Enabled = true;
                            RadToolBar1.FindItemByValue("btPreview").Enabled = true;
                            RadToolBar1.FindItemByValue("btSearch").Enabled = true;
                            return;
                        }
                        return;
                    }
                }
                if (!ExLCDoc.Status.Equals(bd.TransactionStatus.AUT))
                {
                    //Cho phép edit
                    RadToolBar1.FindItemByValue("btCommit").Enabled = true;
                    RadToolBar1.FindItemByValue("btPreview").Enabled = true;
                    RadToolBar1.FindItemByValue("btSearch").Enabled = true;
                    return;
                }
                bc.Commont.SetTatusFormControls(this.Controls, false);
                return;
                #endregion register, reject, accept
            }
            RadToolBar1.FindItemByValue("btPreview").Enabled = true;
            RadToolBar1.FindItemByValue("btSearch").Enabled = true;
        }
        private void setDefaultControls()
        {
            txtBeneficiaryName.Enabled = false;
            txtBeneficiaryAddr1.Enabled = false;
            txtBeneficiaryAddr2.Enabled = false;
            txtBeneficiaryAddr3.Enabled = false;
            //
            txtApplicantName.Enabled = false;
            txtApplicantAddr1.Enabled = false;
            txtApplicantAddr2.Enabled = false;
            txtApplicantAddr3.Enabled = false;
            //
            txtIssuingBankNo.Enabled = false;
            txtIssuingBankName.Enabled = false;
            txtIssuingBankAddr1.Enabled = false;
            txtIssuingBankAddr2.Enabled = false;
            txtIssuingBankAddr3.Enabled = false;
            //
            txtDocumentaryCreditNo.Enabled = false;
            txtCommodity.Enabled = false;
            txtOriginalAmount.Enabled = false;
            txtTenor.Enabled = false;
            txtOriginalTenor.Enabled = false;
            //
            txtChargeCode1.Enabled = false;
            txtChargeCode2.Enabled = false;
            txtChargeCode3.Enabled = false;
            //
            txtVATNo.Enabled = false;
            //
            divAmountRegister.Visible = (TabId != ExportLCDocProcessing.Actions.Amend);
            divAmountAmend.Visible = (TabId == ExportLCDocProcessing.Actions.Amend);
            //
            divTenorRegister.Visible = (TabId != ExportLCDocProcessing.Actions.Amend);
            divTenorAmend.Visible = (TabId == ExportLCDocProcessing.Actions.Amend);
            //
            if (TabId == ExportLCDocProcessing.Actions.Amend)
                RadTabStrip3.Tabs[0].Text = "Service Charge";
            //
            var dsCurrency = bd.SQLData.B_BCURRENCY_GetAll();
            bc.Commont.initRadComboBox(ref rcbCurrency, "Code", "Code", dsCurrency);
            bc.Commont.initRadComboBox(ref rcbChargeCcy1, "Code", "Code", dsCurrency);
            bc.Commont.initRadComboBox(ref rcbChargeCcy2, "Code", "Code", dsCurrency);
            bc.Commont.initRadComboBox(ref rcbChargeCcy3, "Code", "Code", dsCurrency);
            //
            var tblList = bd.SQLData.CreateGenerateDatas("DocumetaryCollection_TabMain_DocsCode");
            bc.Commont.initRadComboBox(ref rcbDocsCode1, "Description", "Id", tblList);
            bc.Commont.initRadComboBox(ref rcbDocsCode2, "Description", "Id", tblList);
            bc.Commont.initRadComboBox(ref rcbDocsCode3, "Description", "Id", tblList);
        }
        private void loadLC(BEXPORT_LC ExLC)
        {
            txtBeneficiaryName.Text = ExLC.BeneficiaryName;
            txtBeneficiaryAddr1.Text = ExLC.BeneficiaryAddr1;
            txtBeneficiaryAddr2.Text = ExLC.BeneficiaryAddr2;
            txtBeneficiaryAddr3.Text = ExLC.BeneficiaryAddr3;
            //
            txtApplicantName.Text = ExLC.ApplicantName;
            txtApplicantAddr1.Text = ExLC.ApplicantAddr1;
            txtApplicantAddr2.Text = ExLC.ApplicantAddr2;
            txtApplicantAddr3.Text = ExLC.ApplicantAddr3;
            //
            txtIssuingBankNo.Text = ExLC.IssuingBankNo;
            txtIssuingBankName.Text = ExLC.IssuingBankName;
            txtIssuingBankAddr1.Text = ExLC.IssuingBankAddr1;
            txtIssuingBankAddr2.Text = ExLC.IssuingBankAddr2;
            txtIssuingBankAddr3.Text = ExLC.IssuingBankAddr3;
            //
            txtDocumentaryCreditNo.Text = ExLC.ImportLCCode;
            txtCommodity.Text = ExLC.Commodity;
            rcbCurrency.SelectedValue = ExLC.Currency;
            txtAmount.Value = ExLC.Amount;
            txtTenor.Text = ExLC.Tenor;
        }
        private void loadLCDoc(BEXPORT_LC_DOCS_PROCESSING ExLCDoc)
        {
            if (TabId == ExportLCDocProcessing.Actions.Accept)
            {
            }
            if (TabId == ExportLCDocProcessing.Actions.Reject)
            {
            }
            txtBeneficiaryName.Text = ExLCDoc.BeneficiaryName;
            txtBeneficiaryAddr1.Text = ExLCDoc.BeneficiaryAddr1;
            txtBeneficiaryAddr2.Text = ExLCDoc.BeneficiaryAddr2;
            txtBeneficiaryAddr3.Text = ExLCDoc.BeneficiaryAddr3;
            //
            txtApplicantName.Text = ExLCDoc.ApplicantName;
            txtApplicantAddr1.Text = ExLCDoc.ApplicantAddr1;
            txtApplicantAddr2.Text = ExLCDoc.ApplicantAddr2;
            txtApplicantAddr3.Text = ExLCDoc.ApplicantAddr3;
            //
            txtIssuingBankNo.Text = ExLCDoc.IssuingBankNo;
            txtIssuingBankName.Text = ExLCDoc.IssuingBankName;
            txtIssuingBankAddr1.Text = ExLCDoc.IssuingBankAddr1;
            txtIssuingBankAddr2.Text = ExLCDoc.IssuingBankAddr2;
            txtIssuingBankAddr3.Text = ExLCDoc.IssuingBankAddr3;
            //
            txtNostroAgentBankNo.Text = ExLCDoc.NostroAgentBankNo;
            txtNostroAgentBankName.Text = ExLCDoc.NostroAgentBankName;
            txtNostroAgentBankAddr1.Text = ExLCDoc.NostroAgentBankAddr1;
            txtNostroAgentBankAddr2.Text = ExLCDoc.NostroAgentBankAddr2;
            txtNostroAgentBankAddr3.Text = ExLCDoc.NostroAgentBankAddr3;
            //
            txtReceivingBankName.Text = ExLCDoc.ReceivingBankName;
            txtReceivingBankAddr1.Text = ExLCDoc.ReceivingBankAddr1;
            txtReceivingBankAddr2.Text = ExLCDoc.ReceivingBankAddr2;
            txtReceivingBankAddr3.Text = ExLCDoc.ReceivingBankAddr3;
            //
            txtDocumentaryCreditNo.Text = ExLCDoc.DocumentaryCreditNo;
            txtCommodity.Text = ExLCDoc.Commodity;
            rcbCurrency.SelectedValue = ExLCDoc.Currency;
            if (TabId == ExportLCDocProcessing.Actions.Amend)
            {
                if (!string.IsNullOrEmpty(Request.QueryString["lst"]) && Request.QueryString["lst"].Equals("4appr"))
                {
                    var ExLCDocOld = dbEntities.findExportLCDoc(ExLCDoc.AmendNoOriginal, true);
                    txtOriginalAmount.Value = ExLCDocOld.Amount;
                    txtNewAmount.Value = ExLCDoc.Amount;
                    //
                    txtOriginalTenor.Text = ExLCDocOld.Tenor;                    
                    rcbNewTenor.SelectedValue = ExLCDoc.Tenor;
                }
                else
                {
                    txtOriginalAmount.Value = ExLCDoc.Amount;
                    txtOriginalTenor.Text = ExLCDoc.Tenor;
                }
            }
            else
            {
                txtAmount.Value = ExLCDoc.Amount;
                txtTenor.Text = ExLCDoc.Tenor;
            }
            txtDocumentReceivedDate.SelectedDate = ExLCDoc.DocumentReceivedDate;
            txtProccessingDate.SelectedDate = ExLCDoc.ProccessingDate;            
            txtInvoiceNo.Text = ExLCDoc.InvoiceNo;
            //
            loadLCDocsCode(ExLCDoc.DocsCode1, ExLCDoc.NoOfOriginals1, ExLCDoc.NoOfCopies1, ref rcbDocsCode1, ref txtNoOfOriginals1, ref txtNoOfCopies1);
            loadLCDocsCode(ExLCDoc.DocsCode2, ExLCDoc.NoOfOriginals2, ExLCDoc.NoOfCopies2, ref rcbDocsCode2, ref txtNoOfOriginals2, ref txtNoOfCopies2);
            loadLCDocsCode(ExLCDoc.DocsCode3, ExLCDoc.NoOfOriginals3, ExLCDoc.NoOfCopies3, ref rcbDocsCode3, ref txtNoOfOriginals3, ref txtNoOfCopies3);
            if (!string.IsNullOrEmpty(ExLCDoc.DocsCode3))
            {
                divDocs2.Attributes.CssStyle.Remove("Display");
                divDocs3.Attributes.CssStyle.Remove("Display");
            }
            else if (!string.IsNullOrEmpty(ExLCDoc.DocsCode2))
                divDocs2.Attributes.CssStyle.Remove("Display");
            //
            txtRemark.Text = ExLCDoc.Remark;
            txtSettlementInstruction.Text = ExLCDoc.SettlementInstruction;
            //
            rcbWaiveCharges.SelectedValue = ExLCDoc.WaiveCharges;
            rcbWaiveCharges_OnSelectedIndexChanged(null, null);
            txtChargeRemarks.Text = ExLCDoc.ChargeRemarks;
            txtVATNo.Text = ExLCDoc.VATNo;
            if (ExLCDoc.WaiveCharges.Equals(bd.YesNo.NO)) loadCharges();
        }
        private void loadLCDocsCode(string DocsCode, int? NoOfOriginals, int? NoOfCopies, ref RadComboBox rcbDocsCode, ref RadNumericTextBox txtNoOfOriginals, ref RadNumericTextBox txtNoOfCopies)
        {
            rcbDocsCode.SelectedValue = DocsCode;
            txtNoOfOriginals.Value = NoOfOriginals;
            txtNoOfCopies.Value = NoOfCopies;
        }
        private void loadCharges()
        {
            var lstCharges = dbEntities.BEXPORT_LC_DOCS_PROCESSING_CHARGES.Where(p => p.DocsCode.Equals(tbLCCode.Text));
            if (lstCharges == null || lstCharges.Count() <= 0) return;
            //
            foreach (BEXPORT_LC_DOCS_PROCESSING_CHARGES ch in lstCharges)
            {
                switch (ch.ChargeCode)
                {
                    case ExportLCDocProcessing.Charges.Commission:
                    //case ExportLCDocProcessing.Charges.Service:
                        loadCharge(ch, ref txtChargeCode1, ref rcbChargeCcy1, ref rcbChargeAcct1, ref tbChargeAmt1, ref rcbPartyCharged1, ref rcbAmortCharge1, ref rcbChargeStatus1, ref lblTaxCode1, ref lblTaxAmt1);
                        break;
                    case ExportLCDocProcessing.Charges.Courier:
                        loadCharge(ch, ref txtChargeCode2, ref rcbChargeCcy2, ref rcbChargeAcct2, ref tbChargeAmt2, ref rcbPartyCharged2, ref rcbAmortCharge2, ref rcbChargeStatus2, ref lblTaxCode2, ref lblTaxAmt2);
                        break;
                    case ExportLCDocProcessing.Charges.Other:
                        loadCharge(ch, ref txtChargeCode3, ref rcbChargeCcy3, ref rcbChargeAcct3, ref tbChargeAmt3, ref rcbPartyCharged3, ref rcbAmortCharge3, ref rcbChargeStatus3, ref lblTaxCode3, ref lblTaxAmt3);
                        break;
                }
            }
        }
        private void loadCharge(BEXPORT_LC_DOCS_PROCESSING_CHARGES ExLCCharge, ref RadTextBox txtChargeCode, ref RadComboBox cbChargeCcy, ref RadComboBox cbChargeAcc, ref RadNumericTextBox txtChargeAmt,
            ref RadComboBox cbChargeParty, ref RadComboBox cbChargeAmort, ref RadComboBox cbChargeStatus, ref Label lblTaxCode, ref Label lblTaxAmt)
        {
            txtChargeCode.Text = ExLCCharge.ChargeCode;
            cbChargeCcy.SelectedValue = ExLCCharge.ChargeCcy;
            cbChargeAcc.SelectedValue = ExLCCharge.ChargeAcc;
            txtChargeAmt.Value = ExLCCharge.ChargeAmt;
            cbChargeParty.SelectedValue = ExLCCharge.PartyCharged;
            cbChargeAmort.SelectedValue = ExLCCharge.AmortCharge;
            cbChargeStatus.SelectedValue = ExLCCharge.ChargeStatus;
            lblTaxCode.Text = ExLCCharge.TaxCode;
            if (ExLCCharge.TaxAmt.HasValue)
                lblTaxAmt.Text = ExLCCharge.TaxAmt.ToString();
        }

        protected void RadToolBar1_ButtonClick(object sender, RadToolBarEventArgs e)
        {
            string docCode = tbLCCode.Text.Trim(), lcCode;            
            var ExLCDoc = dbEntities.findExportLCDoc(docCode);
            BEXPORT_LC ExLC;
            var toolBarButton = e.Item as RadToolBarButton;
            var commandName = toolBarButton.CommandName.ToLower();
            #region Register
            if (TabId == ExportLCDocProcessing.Actions.Register || TabId == ExportLCDocProcessing.Actions.Register1)
            {
                lcCode = docCode.Substring(0, docCode.IndexOf("."));
                ExLC = dbEntities.findExportLC(lcCode);
                var ExLCAmount = ExLC.Amount - (ExLC.PaymentAmount.HasValue ? ExLC.PaymentAmount.Value : 0);
                switch (commandName)
                {
                    case bc.Commands.Commit:
                        if (ExLCAmount < txtAmount.Value.Value)
                        {
                            lblLCCodeMessage.Text = "Doc Amount must less than or equal LC Amount";
                            return;
                        }
                        if (ExLCDoc == null)
                        {
                            ExLCDoc = new BEXPORT_LC_DOCS_PROCESSING();
                            ExLCDoc.DocCode = docCode;
                            ExLCDoc.AmendNo = docCode;
                            ExLCDoc.ActiveRecordFlag = "Yes";
                            ExLCDoc.Status = bd.TransactionStatus.UNA;
                            ExLCDoc.CreateDate = DateTime.Now;
                            ExLCDoc.CreateBy = this.UserInfo.Username;
                            saveLCDoc(ref ExLCDoc);
                            dbEntities.BEXPORT_LC_DOCS_PROCESSING.Add(ExLCDoc);
                        }
                        else
                        {
                            ExLCDoc.Status = bd.TransactionStatus.UNA;
                            ExLCDoc.ActiveRecordFlag = "Yes";
                            ExLCDoc.UpdateDate = DateTime.Now;
                            ExLCDoc.UpdatedBy = this.UserInfo.Username;
                            saveLCDoc(ref ExLCDoc);
                            //Xoa di insert lai
                            var ExLCDocCharge = dbEntities.BEXPORT_LC_DOCS_PROCESSING_CHARGES.Where(p => p.DocsCode.Trim().ToLower().Equals(docCode.ToLower()));
                            if (ExLCDocCharge != null)
                            {
                                foreach(BEXPORT_LC_DOCS_PROCESSING_CHARGES ch in ExLCDocCharge)
                                    dbEntities.BEXPORT_LC_DOCS_PROCESSING_CHARGES.Remove(ch);
                            }
                        }
                        if (ExLCDoc.WaiveCharges.Equals(bd.YesNo.NO))
                        {
                            BEXPORT_LC_DOCS_PROCESSING_CHARGES ExLCCharge;
                            if (tbChargeAmt1.Value.HasValue)
                            {
                                ExLCCharge = new BEXPORT_LC_DOCS_PROCESSING_CHARGES();
                                saveCharge(txtChargeCode1, rcbChargeCcy1, rcbChargeAcct1, tbChargeAmt1, rcbPartyCharged1, rcbAmortCharge1, rcbChargeStatus1, lblTaxCode1, lblTaxAmt1, ref ExLCCharge);
                                dbEntities.BEXPORT_LC_DOCS_PROCESSING_CHARGES.Add(ExLCCharge);
                            }
                            if (tbChargeAmt2.Value.HasValue)
                            {
                                ExLCCharge = new BEXPORT_LC_DOCS_PROCESSING_CHARGES();
                                saveCharge(txtChargeCode2, rcbChargeCcy2, rcbChargeAcct2, tbChargeAmt2, rcbPartyCharged2, rcbAmortCharge2, rcbChargeStatus2, lblTaxCode2, lblTaxAmt2, ref ExLCCharge);
                                dbEntities.BEXPORT_LC_DOCS_PROCESSING_CHARGES.Add(ExLCCharge);
                            }
                            if (tbChargeAmt3.Value.HasValue)
                            {
                                ExLCCharge = new BEXPORT_LC_DOCS_PROCESSING_CHARGES();
                                saveCharge(txtChargeCode3, rcbChargeCcy3, rcbChargeAcct3, tbChargeAmt3, rcbPartyCharged3, rcbAmortCharge3, rcbChargeStatus3, lblTaxCode3, lblTaxAmt3, ref ExLCCharge);
                                dbEntities.BEXPORT_LC_DOCS_PROCESSING_CHARGES.Add(ExLCCharge);
                            }
                        }
                        //
                        dbEntities.SaveChanges();
                        //
                        Response.Redirect("Default.aspx?tabid=" + this.TabId);
                        break;
                    case bc.Commands.Authorize:
                    case bc.Commands.Reverse:
                        if (ExLCDoc != null)
                        {
                            if (commandName.Equals(bc.Commands.Authorize))
                            {
                                ExLCDoc.Status = bd.TransactionStatus.AUT;
                                ExLCDoc.AuthorizedBy = this.UserInfo.Username;
                                ExLCDoc.AuthorizedDate = DateTime.Now;
                                //
                                if (ExLC.PaymentAmount.HasValue)
                                    ExLC.PaymentAmount += ExLCDoc.Amount;
                                else
                                    ExLC.PaymentAmount = ExLCDoc.Amount;
                                ExLC.PaymentFull = (ExLC.PaymentAmount == ExLC.Amount);
                                //
                                dbEntities.SaveChanges();
                                Response.Redirect("Default.aspx?tabid=" + this.TabId);
                            }
                            else
                            {
                                ExLCDoc.Status = bd.TransactionStatus.REV;
                                dbEntities.SaveChanges();
                                Response.Redirect("Default.aspx?tabid=" + this.TabId + "&code=" + tbLCCode.Text);
                            }
                        }
                        break;
                }
                return;
            }
            #endregion Register
            #region Amend
            if (TabId == ExportLCDocProcessing.Actions.Amend)
            {
                docCode = docCode.Substring(0, docCode.IndexOf(".", docCode.IndexOf(".") + 1));
                switch (commandName)
                {
                    case bc.Commands.Commit:
                        if (ExLCDoc == null)
                        {
                            var ExLCDocOld = dbEntities.findExportLCDoc(docCode);
                            ExLCDocOld.ActiveRecordFlag = "No";
                            ExLCDoc = new BEXPORT_LC_DOCS_PROCESSING()
                            {
                                AmendNo = tbLCCode.Text.Trim(),
                                AmendNoOriginal = ExLCDocOld.AmendNo,
                                DocCode = docCode,
                                ActiveRecordFlag = "Yes",
                                AmendStatus = bd.TransactionStatus.UNA,
                                AmendDate = DateTime.Now,
                                AmendBy = this.UserInfo.Username,
                                PaymentFull = ExLCDocOld.PaymentFull,
                                Status = ExLCDocOld.Status,
                                CreateBy = ExLCDocOld.CreateBy,
                                CreateDate = ExLCDocOld.CreateDate,
                                UpdatedBy = ExLCDocOld.UpdatedBy,
                                UpdateDate = ExLCDocOld.UpdateDate,
                                AuthorizedBy = ExLCDocOld.AuthorizedBy,
                                AuthorizedDate = ExLCDocOld.AuthorizedDate,
                                RejectStatus = ExLCDocOld.RejectStatus,
                                RejectDate = ExLCDocOld.RejectDate,
                                AcceptStatus = ExLCDocOld.AcceptStatus,
                                AcceptDate = ExLCDocOld.AcceptDate,
                                PaymentAmount = ExLCDocOld.PaymentAmount
                            };
                            saveLCDoc(ref ExLCDoc);
                            dbEntities.BEXPORT_LC_DOCS_PROCESSING.Add(ExLCDoc);
                        }
                        else
                        {
                            var ExLCDocOld = dbEntities.findExportLCDoc(ExLCDoc.AmendNoOriginal);
                            ExLCDocOld.ActiveRecordFlag = "No";
                            //
                            ExLCDoc.AmendStatus = bd.TransactionStatus.UNA;
                            ExLCDoc.ActiveRecordFlag = "Yes";
                            ExLCDoc.UpdateDate = DateTime.Now;
                            ExLCDoc.UpdatedBy = this.UserInfo.Username;
                            saveLCDoc(ref ExLCDoc);
                            //Xoa di insert lai
                            var ExLCDocCharge = dbEntities.BEXPORT_LC_DOCS_PROCESSING_CHARGES.Where(p => p.DocsCode.Trim().ToLower().Equals(ExLCDoc.AmendNo.ToLower()));
                            if (ExLCDocCharge != null)
                            {
                                foreach (BEXPORT_LC_DOCS_PROCESSING_CHARGES ch in ExLCDocCharge)
                                    dbEntities.BEXPORT_LC_DOCS_PROCESSING_CHARGES.Remove(ch);
                            }
                        }
                        if (ExLCDoc.WaiveCharges.Equals(bd.YesNo.NO))
                        {
                            BEXPORT_LC_DOCS_PROCESSING_CHARGES ExLCCharge;
                            if (tbChargeAmt1.Value.HasValue)
                            {
                                ExLCCharge = new BEXPORT_LC_DOCS_PROCESSING_CHARGES();
                                saveCharge(txtChargeCode1, rcbChargeCcy1, rcbChargeAcct1, tbChargeAmt1, rcbPartyCharged1, rcbAmortCharge1, rcbChargeStatus1, lblTaxCode1, lblTaxAmt1, ref ExLCCharge);
                                dbEntities.BEXPORT_LC_DOCS_PROCESSING_CHARGES.Add(ExLCCharge);
                            }
                            if (tbChargeAmt2.Value.HasValue)
                            {
                                ExLCCharge = new BEXPORT_LC_DOCS_PROCESSING_CHARGES();
                                saveCharge(txtChargeCode2, rcbChargeCcy2, rcbChargeAcct2, tbChargeAmt2, rcbPartyCharged2, rcbAmortCharge2, rcbChargeStatus2, lblTaxCode2, lblTaxAmt2, ref ExLCCharge);
                                dbEntities.BEXPORT_LC_DOCS_PROCESSING_CHARGES.Add(ExLCCharge);
                            }
                            if (tbChargeAmt3.Value.HasValue)
                            {
                                ExLCCharge = new BEXPORT_LC_DOCS_PROCESSING_CHARGES();
                                saveCharge(txtChargeCode3, rcbChargeCcy3, rcbChargeAcct3, tbChargeAmt3, rcbPartyCharged3, rcbAmortCharge3, rcbChargeStatus3, lblTaxCode3, lblTaxAmt3, ref ExLCCharge);
                                dbEntities.BEXPORT_LC_DOCS_PROCESSING_CHARGES.Add(ExLCCharge);
                            }
                        }
                        //
                        dbEntities.SaveChanges();
                        //
                        Response.Redirect("Default.aspx?tabid=" + this.TabId);
                        break;
                    case bc.Commands.Authorize:
                    case bc.Commands.Reverse:
                        if (ExLCDoc != null)
                        {
                            if (commandName.Equals(bc.Commands.Authorize))
                            {
                                ExLCDoc.AmendStatus = bd.TransactionStatus.AUT;
                                //
                                dbEntities.SaveChanges();
                                Response.Redirect("Default.aspx?tabid=" + this.TabId);
                            }
                            else
                            {
                                var ExLCDocOld = dbEntities.findExportLCDoc(ExLCDoc.AmendNoOriginal, true);
                                ExLCDocOld.ActiveRecordFlag = "Yes";
                                //
                                ExLCDoc.AmendStatus = bd.TransactionStatus.REV;
                                ExLCDoc.ActiveRecordFlag = "No";
                                //
                                dbEntities.SaveChanges();
                                Response.Redirect("Default.aspx?tabid=" + this.TabId + "&code=" + tbLCCode.Text);
                            }
                        }
                        break;
                }
                return;
            }
            #endregion Amend
            #region Accept, Reject
            if (TabId == ExportLCDocProcessing.Actions.Reject || TabId == ExportLCDocProcessing.Actions.Accept)
            {
                switch (commandName)
                {
                    case bc.Commands.Commit:
                        if (ExLCDoc != null)
                        {
                            if (TabId == ExportLCDocProcessing.Actions.Reject)
                            {
                                ExLCDoc.RejectStatus = bd.TransactionStatus.UNA;
                                ExLCDoc.RejectDate = DateTime.Now;
                            }
                            else
                            {
                                ExLCDoc.AcceptStatus = bd.TransactionStatus.UNA;
                                ExLCDoc.AcceptDate = DateTime.Now;
                            }
                            saveLCDoc(ref ExLCDoc);
                            dbEntities.SaveChanges();
                        }                        
                        //
                        Response.Redirect("Default.aspx?tabid=" + this.TabId);
                        break;
                    case bc.Commands.Authorize:
                    case bc.Commands.Reverse:
                        if (ExLCDoc != null)
                        {
                            if (commandName.Equals(bc.Commands.Authorize))
                            {
                                if (TabId == ExportLCDocProcessing.Actions.Reject)
                                    ExLCDoc.RejectStatus = bd.TransactionStatus.AUT;
                                else
                                    ExLCDoc.AcceptStatus = bd.TransactionStatus.AUT;
                                //
                                dbEntities.SaveChanges();
                                Response.Redirect("Default.aspx?tabid=" + this.TabId);
                            }
                            else
                            {
                                if (TabId == ExportLCDocProcessing.Actions.Reject)
                                    ExLCDoc.RejectStatus = bd.TransactionStatus.REV;
                                else
                                    ExLCDoc.AcceptStatus = bd.TransactionStatus.REV;
                                //
                                dbEntities.SaveChanges();
                                Response.Redirect("Default.aspx?tabid=" + this.TabId + "&code=" + tbLCCode.Text);
                            }
                        }
                        break;
                }
                return;
            }
            #endregion Accept, Reject
        }
        private void saveLCDoc(ref BEXPORT_LC_DOCS_PROCESSING ExLCDoc)
        {
            ExLCDoc.BeneficiaryName = txtBeneficiaryName.Text;
            ExLCDoc.BeneficiaryAddr1 = txtBeneficiaryAddr1.Text;
            ExLCDoc.BeneficiaryAddr2 = txtBeneficiaryAddr2.Text;
            ExLCDoc.BeneficiaryAddr3 = txtBeneficiaryAddr3.Text;
            //
            ExLCDoc.ApplicantName = txtApplicantName.Text;
            ExLCDoc.ApplicantAddr1 = txtApplicantAddr1.Text;
            ExLCDoc.ApplicantAddr2 = txtApplicantAddr2.Text;
            ExLCDoc.ApplicantAddr3 = txtApplicantAddr3.Text;
            //
            ExLCDoc.IssuingBankNo = txtIssuingBankNo.Text;
            ExLCDoc.IssuingBankName = txtIssuingBankName.Text;
            ExLCDoc.IssuingBankAddr1 = txtIssuingBankAddr1.Text;
            ExLCDoc.IssuingBankAddr2 = txtIssuingBankAddr2.Text;
            ExLCDoc.IssuingBankAddr3 = txtIssuingBankAddr3.Text;
            //
            ExLCDoc.NostroAgentBankNo = txtNostroAgentBankNo.Text;
            ExLCDoc.NostroAgentBankName = txtNostroAgentBankName.Text;
            ExLCDoc.NostroAgentBankAddr1 = txtNostroAgentBankAddr1.Text;
            ExLCDoc.NostroAgentBankAddr2 = txtNostroAgentBankAddr2.Text;
            ExLCDoc.NostroAgentBankAddr3 = txtNostroAgentBankAddr3.Text;
            //
            ExLCDoc.ReceivingBankName = txtReceivingBankName.Text;
            ExLCDoc.ReceivingBankAddr1 = txtReceivingBankAddr1.Text;
            ExLCDoc.ReceivingBankAddr2 = txtReceivingBankAddr2.Text;
            ExLCDoc.ReceivingBankAddr3 = txtReceivingBankAddr3.Text;
            //
            ExLCDoc.DocumentaryCreditNo = txtDocumentaryCreditNo.Text;
            ExLCDoc.Commodity = txtCommodity.Text;
            ExLCDoc.Currency = rcbCurrency.SelectedValue;            
            ExLCDoc.DocumentReceivedDate = txtDocumentReceivedDate.SelectedDate;
            ExLCDoc.ProccessingDate = txtProccessingDate.SelectedDate;            
            ExLCDoc.InvoiceNo = txtInvoiceNo.Text;
            if (TabId == ExportLCDocProcessing.Actions.Amend)
            {
                ExLCDoc.Amount = txtNewAmount.Value;
                ExLCDoc.Tenor = rcbNewTenor.SelectedValue;
            }
            else
            {
                ExLCDoc.Amount = txtAmount.Value;
                ExLCDoc.Tenor = txtTenor.Text;
            }
            //
            ExLCDoc.DocsCode1 = rcbDocsCode1.SelectedValue;
            if (txtNoOfOriginals1.Value.HasValue)
                ExLCDoc.NoOfOriginals1 = Convert.ToInt32(txtNoOfOriginals1.Value.Value);
            else
                ExLCDoc.NoOfOriginals1 = null;
            if (txtNoOfCopies1.Value.HasValue)
                ExLCDoc.NoOfCopies1 = Convert.ToInt32(txtNoOfCopies1.Value.Value);
            else
                ExLCDoc.NoOfCopies1 = null;
            //
            ExLCDoc.DocsCode2 = rcbDocsCode2.SelectedValue;
            if (txtNoOfOriginals2.Value.HasValue)
                ExLCDoc.NoOfOriginals2 = Convert.ToInt32(txtNoOfOriginals2.Value.Value);
            else
                ExLCDoc.NoOfOriginals2 = null;
            if (txtNoOfCopies2.Value.HasValue)
                ExLCDoc.NoOfCopies2 = Convert.ToInt32(txtNoOfCopies2.Value.Value);
            else
                ExLCDoc.NoOfCopies2 = null;
            //
            ExLCDoc.DocsCode3 = rcbDocsCode3.SelectedValue;
            if (txtNoOfOriginals3.Value.HasValue)
                ExLCDoc.NoOfOriginals3 = Convert.ToInt32(txtNoOfOriginals3.Value.Value);
            else
                ExLCDoc.NoOfOriginals3 = null;
            if (txtNoOfCopies3.Value.HasValue)
                ExLCDoc.NoOfCopies3 = Convert.ToInt32(txtNoOfCopies3.Value.Value);
            else
                ExLCDoc.NoOfCopies3 = null;
            //
            ExLCDoc.Remark = txtRemark.Text;
            ExLCDoc.SettlementInstruction = txtSettlementInstruction.Text;
            //
            ExLCDoc.WaiveCharges = rcbWaiveCharges.SelectedValue;
            ExLCDoc.ChargeRemarks = txtChargeRemarks.Text;
            ExLCDoc.VATNo = txtVATNo.Text;
        }
        private void saveCharge(RadTextBox txtChargeCode, RadComboBox cbChargeCcy, RadComboBox cbChargeAcc, RadNumericTextBox txtChargeAmt, RadComboBox cbChargeParty, RadComboBox cbChargeAmort,
            RadComboBox cbChargeStatus, Label lblTaxCode, Label lblTaxAmt, ref BEXPORT_LC_DOCS_PROCESSING_CHARGES ExLCCharge)
        {
            ExLCCharge.DocsCode = tbLCCode.Text;
            ExLCCharge.ChargeCode = txtChargeCode.Text;
            ExLCCharge.ChargeCcy = cbChargeCcy.SelectedValue;
            ExLCCharge.ChargeAcc = cbChargeAcc.SelectedValue;
            ExLCCharge.ChargeAmt = txtChargeAmt.Value;
            ExLCCharge.PartyCharged = cbChargeParty.SelectedValue;
            ExLCCharge.AmortCharge = cbChargeAmort.SelectedValue;
            ExLCCharge.ChargeStatus = cbChargeStatus.SelectedValue;
            ExLCCharge.TaxCode = lblTaxCode.Text;
            if (!string.IsNullOrEmpty(lblTaxAmt.Text))
                ExLCCharge.TaxAmt = Convert.ToDouble(lblTaxAmt.Text);
        }

        //ABBKVNVX : AN BINH COMMERCIAL JOINT STOCK BANK
        protected void txtNostroAgentBankNo_TextChanged(object sender, EventArgs e)
        {
            bc.Commont.loadBankSwiftCodeInfo(txtNostroAgentBankNo.Text, ref lblNostroAgentBankMessage, ref txtNostroAgentBankName, ref txtNostroAgentBankAddr1, ref txtNostroAgentBankAddr2, ref txtNostroAgentBankAddr3);
        }

        protected void rcbWaiveCharges_OnSelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
        {
            string WaiveCharges = rcbWaiveCharges.SelectedValue;
            RadTabStrip3.Visible = WaiveCharges.Equals(bd.YesNo.NO);
            RadMultiPage1.Visible = WaiveCharges.Equals(bd.YesNo.NO);
        }

        protected void LoadChargeAcct(ref RadComboBox cboChargeAcct, string ChargeCcy)
        {
            //bc.Commont.initRadComboBox(ref cboChargeAcct, "Display", "Id", bd.SQLData.B_BDRFROMACCOUNT_GetByCurrency(txtCustomerName.Text, ChargeCcy));
        }
        protected void rcbChargeCcy1_OnSelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
        {
            LoadChargeAcct(ref rcbChargeAcct1, rcbChargeCcy1.SelectedValue);
        }
        protected void rcbChargeCcy2_OnSelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
        {
            LoadChargeAcct(ref rcbChargeAcct2, rcbChargeCcy2.SelectedValue);
        }
        protected void rcbChargeCcy3_OnSelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
        {
            LoadChargeAcct(ref rcbChargeAcct3, rcbChargeCcy3.SelectedValue);
        }

        protected void btnVAT_Click(object sender, EventArgs e)
        {
            showReport("VAT");
        }
        private void showReport(string reportType)
        {
            var ExLCDoc = dbEntities.findExportLCDoc(tbLCCode.Text);
            if (ExLCDoc == null)
            {
                lblLCCodeMessage.Text = "Can not find this Code.";
                return;
            }
            //
            string reportTemplate = "~/DesktopModules/TrainingCoreBanking/BankProject/Report/Template/Export/DocumentProcessing/";
            string reportSaveName = "";
            DataSet reportData = new DataSet();
            DataTable tbl1 = new DataTable();
            Aspose.Words.SaveFormat saveFormat = Aspose.Words.SaveFormat.Doc;
            Aspose.Words.SaveType saveType = Aspose.Words.SaveType.OpenInApplication;
            try
            {
                switch (reportType)
                {
                    case "VAT":
                        reportTemplate = Context.Server.MapPath(reportTemplate + "VAT.doc");
                        reportSaveName = "VAT" + "_" + DateTime.Now.ToString("yyyyMMddHHmmss") + ".doc";
                        //
                        var dataVAT = new Model.Reports.VAT()
                        {
                            UserName = ExLCDoc.CreateBy,
                            VATNo = ExLCDoc.VATNo,
                            TransCode = ExLCDoc.DocCode,
                            //
                            CustomerID = "",
                            CustomerName = "",
                            CustomerAddress = "",
                            IdentityNo = "",
                            //
                            DebitAccount = "",
                            ChargeRemarks = ExLCDoc.ChargeRemarks
                        };
                        //
                        var ExLCDocCharges = dbEntities.BEXPORT_LC_DOCS_PROCESSING_CHARGES.Where(p => p.DocsCode.Equals(tbLCCode.Text));
                        if (ExLCDocCharges != null)
                        {
                            double TotalTaxAmount = 0, TotalChargeAmount = 0;
                            foreach (BEXPORT_LC_DOCS_PROCESSING_CHARGES ch in ExLCDocCharges)
                            {
                                if (ch.ChargeAmt.HasValue && ch.ChargeAmt.Value != 0)
                                {
                                    if (string.IsNullOrEmpty(dataVAT.ChargeType1))
                                    {
                                        dataVAT.ChargeType1 = dbEntities.getChargeTypeInfo(ch.ChargeCode, 1);
                                        dataVAT.ChargeAmount1 = ch.ChargeAmt.Value + ch.ChargeCcy + " " + dbEntities.getChargeTypeInfo(ch.ChargeCode, 2);
                                        if (ch.TaxAmt.HasValue) TotalTaxAmount += ch.TaxAmt.Value;
                                        TotalChargeAmount += ch.ChargeAmt.Value;
                                    }
                                    else if (string.IsNullOrEmpty(dataVAT.ChargeType2))
                                    {
                                        dataVAT.ChargeType2 = dbEntities.getChargeTypeInfo(ch.ChargeCode, 1);
                                        dataVAT.ChargeAmount2 = ch.ChargeAmt.Value + ch.ChargeCcy + " " + dbEntities.getChargeTypeInfo(ch.ChargeCode, 2);
                                        if (ch.TaxAmt.HasValue) TotalTaxAmount += ch.TaxAmt.Value;
                                        TotalChargeAmount += ch.ChargeAmt.Value;
                                    }
                                    else if (string.IsNullOrEmpty(dataVAT.ChargeType3))
                                    {
                                        dataVAT.ChargeType3 = dbEntities.getChargeTypeInfo(ch.ChargeCode, 1);
                                        dataVAT.ChargeAmount3 = ch.ChargeAmt.Value + ch.ChargeCcy + " " + dbEntities.getChargeTypeInfo(ch.ChargeCode, 2);
                                        if (ch.TaxAmt.HasValue) TotalTaxAmount += ch.TaxAmt.Value;
                                        TotalChargeAmount += ch.ChargeAmt.Value;
                                    }
                                }
                            }
                            TotalChargeAmount += TotalTaxAmount;
                            if (TotalChargeAmount != 0)
                            {
                                dataVAT.TotalChargeAmount = TotalChargeAmount + ExLCDoc.Currency;
                                dataVAT.TotalChargeAmountWord = Utils.ReadNumber(ExLCDoc.Currency, TotalChargeAmount);
                                if (TotalTaxAmount != 0)
                                {
                                    dataVAT.TotalTaxAmount = TotalTaxAmount + ExLCDoc.Currency + " PL90304";
                                    dataVAT.TotalTaxText = "VAT";
                                }
                            }
                        }
                        //
                        var lstData2 = new List<Model.Reports.VAT>();
                        lstData2.Add(dataVAT);
                        tbl1 = Utils.CreateDataTable<Model.Reports.VAT>(lstData2);
                        reportData.Tables.Add(tbl1);
                        break;
                }
                if (reportData != null)
                {
                    try
                    {
                        reportData.Tables[0].TableName = "Table1";
                        bc.Reports.createFileDownload(reportTemplate, reportData, reportSaveName, saveFormat, saveType, Response);
                    }
                    catch (Exception err)
                    {
                        lblLCCodeMessage.Text = reportData.Tables[0].TableName + "#" + err.Message;
                    }
                }
            }
            catch (Exception ex)
            {
                lblLCCodeMessage.Text = ex.Message;
            }
        }
    }
}