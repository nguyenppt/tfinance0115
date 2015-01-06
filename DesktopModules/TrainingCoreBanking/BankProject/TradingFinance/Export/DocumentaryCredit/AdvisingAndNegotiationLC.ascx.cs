using System;
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
{
    public partial class AdvisingAndNegotiationLC : DotNetNuke.Entities.Modules.PortalModuleBase
    {
        private const string breakLine = "\r\n";
        private VietVictoryCoreBankingEntities dbEntities = new VietVictoryCoreBankingEntities();
        protected struct Tabs
        {
            public const int Register = 242;
            public const int Confirm = 236;
            public const int Cancel = 237;
            public const int Close = 265;
        }
        //
        private void setDefaultControls()
        {
            rcbWaiveCharges.SelectedValue = bd.YesNo.NO;
            rcbWaiveCharges_OnSelectedIndexChanged(null, null);
            tbVatNo.Enabled = false;
            rcbChargeCode.Enabled = false;
            rcbChargeCode2.Enabled = false;
            rcbChargeCode3.Enabled = false;
            //
            divConfirmLC.Style.Remove("Display");
            divConfirmLC.Style.Add("Display", (TabId == Tabs.Confirm ? "" : "none"));
            rcbGenerateDelivery.Enabled = (TabId == Tabs.Confirm);
            txtDateConfirm.Enabled = (TabId == Tabs.Confirm);
            rcbConfirmInstr.Enabled = (TabId == Tabs.Confirm);
            //
            divCancelLC.Style.Remove("Display");
            divCancelLC.Style.Add("Display", (TabId == Tabs.Cancel ? "" : "none"));
            txtCancelDate.Enabled = (TabId == Tabs.Cancel);
            txtContingentExpiryDate.Enabled = (TabId == Tabs.Cancel);
            txtCancelRemark.Enabled = (TabId == Tabs.Cancel);
        }
        protected void Page_Load(object sender, EventArgs e)
        {            
            if (IsPostBack) return;
            //
            var dsCurrency = bd.SQLData.B_BCURRENCY_GetAll();
            bc.Commont.initRadComboBox(ref rcbCurrency, "Code", "Code", dsCurrency);
            bc.Commont.initRadComboBox(ref rcbChargeCcy, "Code", "Code", dsCurrency);
            bc.Commont.initRadComboBox(ref rcbChargeCcy2, "Code", "Code", dsCurrency);
            bc.Commont.initRadComboBox(ref rcbChargeCcy3, "Code", "Code", dsCurrency);

            bc.Commont.initRadComboBox(ref rcbCommodity, "Name", "ID", bd.SQLData.B_BCOMMODITY_GetByTransactionType("OTC"));
            //
            if (!string.IsNullOrEmpty(Request.QueryString["Code"]))
            {
                tbLCCode.Text = Request.QueryString["Code"];
                var ExLC = FindCode(tbLCCode.Text);
                if (ExLC == null)
                {
                    lblLCCodeMessage.Text = "Can not find this Code !";
                    RadToolBar1.FindItemByValue("btCommit").Enabled = false;
                    bc.Commont.SetTatusFormControls(this.Controls, false);
                    return;
                }
                loadLC(ExLC);
                //                
                RadToolBar1.FindItemByValue("btCommit").Enabled = false;
                RadToolBar1.FindItemByValue("btPreview").Enabled = true;
                RadToolBar1.FindItemByValue("btAuthorize").Enabled = false;
                RadToolBar1.FindItemByValue("btReverse").Enabled = false;
                RadToolBar1.FindItemByValue("btSearch").Enabled = true;
                RadToolBar1.FindItemByValue("btPrint").Enabled = true;
                //
                if (TabId == Tabs.Register)
                {
                    switch (ExLC.Status)
                    {
                        case bd.TransactionStatus.UNA:
                        case bd.TransactionStatus.REV:
                            if (!string.IsNullOrEmpty(Request.QueryString["lst"]) && ExLC.Status.Equals(bd.TransactionStatus.UNA))
                            {
                                RadToolBar1.FindItemByValue("btPreview").Enabled = false;
                                RadToolBar1.FindItemByValue("btAuthorize").Enabled = true;
                                RadToolBar1.FindItemByValue("btReverse").Enabled = true;
                                RadToolBar1.FindItemByValue("btSearch").Enabled = false;
                                bc.Commont.SetTatusFormControls(this.Controls, false);
                            }
                            else
                            {
                                RadToolBar1.FindItemByValue("btCommit").Enabled = true;
                                RadToolBar1.FindItemByValue("btPreview").Enabled = true;
                                RadToolBar1.FindItemByValue("btAuthorize").Enabled = false;
                                RadToolBar1.FindItemByValue("btReverse").Enabled = false;
                                RadToolBar1.FindItemByValue("btSearch").Enabled = true;
                                RadToolBar1.FindItemByValue("btPrint").Enabled = false;
                            }
                            break;
                        case bd.TransactionStatus.AUT:
                            lblLCCodeMessage.Text = "This LC is authorized !";
                            break;
                        default:
                            lblLCCodeMessage.Text = "This LC is wrong status(" + ExLC.Status + ") !";
                            break;
                    }
                }
                /*if (TabId == Tabs.Confirm)
                {
                    switch (ExLC.Status)
                    {
                        case bd.TransactionStatus.UNA:
                        case bd.TransactionStatus.REV:
                            if (!string.IsNullOrEmpty(Request.QueryString["lst"]) && ExLC.Status.Equals(bd.TransactionStatus.UNA))
                            {
                                RadToolBar1.FindItemByValue("btPreview").Enabled = false;
                                RadToolBar1.FindItemByValue("btAuthorize").Enabled = true;
                                RadToolBar1.FindItemByValue("btReverse").Enabled = true;
                                RadToolBar1.FindItemByValue("btSearch").Enabled = false;
                                bc.Commont.SetTatusFormControls(this.Controls, false);
                            }
                            else
                            {
                                RadToolBar1.FindItemByValue("btCommit").Enabled = true;
                                RadToolBar1.FindItemByValue("btPreview").Enabled = true;
                                RadToolBar1.FindItemByValue("btAuthorize").Enabled = false;
                                RadToolBar1.FindItemByValue("btReverse").Enabled = false;
                                RadToolBar1.FindItemByValue("btSearch").Enabled = true;
                                RadToolBar1.FindItemByValue("btPrint").Enabled = false;
                            }
                            break;
                        case bd.TransactionStatus.AUT:
                            lblLCCodeMessage.Text = "This LC is authorized !";
                            break;
                        default:
                            lblLCCodeMessage.Text = "This LC is wrong status(" + ExLC.Status + ") !";
                            break;
                    }
                }*/
                if (TabId == Tabs.Cancel)
                {
                    bc.Commont.SetTatusFormControls(this.Controls, false);
                    if (!ExLC.Status.Equals(bd.TransactionStatus.AUT))
                        lblLCCodeMessage.Text = "This LC is not authorized !";
                    else if (!string.IsNullOrEmpty(ExLC.AmendStatus) && ExLC.AmendStatus.Equals(bd.TransactionStatus.UNA))
                        lblLCCodeMessage.Text = "This LC Amend is not authorized !";
                    else if (!string.IsNullOrEmpty(ExLC.ClosedStatus) && !ExLC.ClosedStatus.Equals(bd.TransactionStatus.REV))
                        lblLCCodeMessage.Text = "This LC Close is closed !";
                    else
                    {
                        switch (ExLC.CancelStatus)
                        {
                            case null:
                            case bd.TransactionStatus.UNA:
                            case bd.TransactionStatus.REV:
                                if (!string.IsNullOrEmpty(Request.QueryString["lst"]) && ExLC.CancelStatus.Equals(bd.TransactionStatus.UNA))
                                {
                                    RadToolBar1.FindItemByValue("btPreview").Enabled = false;
                                    RadToolBar1.FindItemByValue("btAuthorize").Enabled = true;
                                    RadToolBar1.FindItemByValue("btReverse").Enabled = true;
                                    RadToolBar1.FindItemByValue("btSearch").Enabled = false;
                                }
                                else
                                {
                                    RadToolBar1.FindItemByValue("btCommit").Enabled = true;
                                    RadToolBar1.FindItemByValue("btPreview").Enabled = true;
                                    RadToolBar1.FindItemByValue("btAuthorize").Enabled = false;
                                    RadToolBar1.FindItemByValue("btReverse").Enabled = false;
                                    RadToolBar1.FindItemByValue("btSearch").Enabled = true;
                                    RadToolBar1.FindItemByValue("btPrint").Enabled = false;
                                }
                                break;
                            case bd.TransactionStatus.AUT:
                                lblLCCodeMessage.Text = "This LC Cancel is authorized !";
                                break;
                            default:
                                lblLCCodeMessage.Text = "This LC Cancel is wrong status(" + ExLC.CancelStatus + ") !";
                                break;
                        }
                    }
                }
                if (TabId == Tabs.Close)
                {
                    bc.Commont.SetTatusFormControls(this.Controls, false);
                    if (!ExLC.Status.Equals(bd.TransactionStatus.AUT))
                        lblLCCodeMessage.Text = "This LC is not authorized !";
                    else if (!string.IsNullOrEmpty(ExLC.AmendStatus) && ExLC.AmendStatus.Equals(bd.TransactionStatus.UNA))
                        lblLCCodeMessage.Text = "This LC Amend is not authorized !";
                    else if (!string.IsNullOrEmpty(ExLC.CancelStatus) && !ExLC.CancelStatus.Equals(bd.TransactionStatus.REV))
                        lblLCCodeMessage.Text = "This LC Close is closed !";
                    else
                    {
                        switch (ExLC.ClosedStatus)
                        {
                            case bd.TransactionStatus.UNA:
                            case bd.TransactionStatus.REV:
                                if (!string.IsNullOrEmpty(Request.QueryString["lst"]) && ExLC.ClosedStatus.Equals(bd.TransactionStatus.UNA))
                                {
                                    RadToolBar1.FindItemByValue("btPreview").Enabled = false;
                                    RadToolBar1.FindItemByValue("btAuthorize").Enabled = true;
                                    RadToolBar1.FindItemByValue("btReverse").Enabled = true;
                                    RadToolBar1.FindItemByValue("btSearch").Enabled = false;
                                }
                                else
                                {
                                    RadToolBar1.FindItemByValue("btCommit").Enabled = true;
                                    RadToolBar1.FindItemByValue("btPreview").Enabled = true;
                                    RadToolBar1.FindItemByValue("btAuthorize").Enabled = false;
                                    RadToolBar1.FindItemByValue("btReverse").Enabled = false;
                                    RadToolBar1.FindItemByValue("btSearch").Enabled = true;
                                    RadToolBar1.FindItemByValue("btPrint").Enabled = false;
                                }
                                break;
                            case bd.TransactionStatus.AUT:
                                lblLCCodeMessage.Text = "This LC Closed is authorized !";
                                break;
                            default:
                                lblLCCodeMessage.Text = "This LC Closed is wrong status(" + ExLC.ClosedStatus + ") !";
                                break;
                        }
                    }
                }
            }
            else
            {
                if (TabId == Tabs.Register)
                {
                    var vatno = bd.Database.B_BMACODE_GetNewSoTT("VATNO");
                    tbVatNo.Text = vatno.Tables[0].Rows[0]["SoTT"].ToString();
                    //
                    var ds = bd.DataTam.B_ISSURLC_GetNewID();
                    tbLCCode.Text = ds.Tables[0].Rows[0]["Code"].ToString();
                    //
                    rcbAdvisingBankType_OnSelectedIndexChanged(null, null);
                    rcbIssuingBankType_OnSelectedIndexChanged(null, null);
                    rcbAvailableWithType_OnSelectedIndexChanged(null, null);
                    rcbReimbBankType_OnSelectedIndexChanged(null, null);
                }
                else
                {
                    RadToolBar1.FindItemByValue("btCommit").Enabled = false;
                    RadToolBar1.FindItemByValue("btPreview").Enabled = true;
                    RadToolBar1.FindItemByValue("btAuthorize").Enabled = false;
                    RadToolBar1.FindItemByValue("btReverse").Enabled = false;
                    RadToolBar1.FindItemByValue("btSearch").Enabled = true;
                    RadToolBar1.FindItemByValue("btPrint").Enabled = false;
                }
            }
            //
            setDefaultControls();                     
        }

        private BEXPORT_LC FindCode(string Code)
        {
            return dbEntities.BEXPORT_LC.Where(p => p.ExportLCCode.Trim().ToLower().Equals(Code.Trim().ToLower())).FirstOrDefault();
        }
        protected void RadToolBar1_ButtonClick(object sender, RadToolBarEventArgs e)
        {
            var toolBarButton = e.Item as RadToolBarButton;
            var ExLC = FindCode(tbLCCode.Text);
            var commandName = toolBarButton.CommandName.ToLower();
            if (TabId == Tabs.Register)
            {                
                switch (commandName)
                {
                    case bc.Commands.Commit:                        
                        if (ExLC == null)
                        {
                            ExLC = new BEXPORT_LC();
                            ExLC.ExportLCCode = tbLCCode.Text.Trim();
                            ExLC.Status = bd.TransactionStatus.UNA;
                            ExLC.CreateDate = DateTime.Now;
                            ExLC.CreateBy = this.UserInfo.Username;
                            saveLC(ref ExLC);
                            dbEntities.BEXPORT_LC.Add(ExLC);
                        }
                        else
                        {
                            ExLC.Status = bd.TransactionStatus.UNA;
                            ExLC.UpdateDate = DateTime.Now;
                            ExLC.UpdatedBy = this.UserInfo.Username;
                            saveLC(ref ExLC);
                            //Xoa di insert lai
                            var ExLCCharge = dbEntities.BEXPORT_LC_CHARGES.Where(p => p.ExportLCCode.Trim().ToLower().Equals(tbLCCode.Text.Trim().ToLower())).FirstOrDefault();
                            while (ExLCCharge != null)
                            {
                                dbEntities.BEXPORT_LC_CHARGES.Remove(ExLCCharge);
                                ExLCCharge = dbEntities.BEXPORT_LC_CHARGES.Where(p => p.ExportLCCode.Trim().ToLower().Equals(tbLCCode.Text.Trim().ToLower())).FirstOrDefault();
                            }
                        }
                        if (ExLC.WaiveCharges.Equals(bd.YesNo.NO))
                        {
                            BEXPORT_LC_CHARGES ExLCCharge;
                            if (tbChargeAmt.Value.HasValue)
                            {
                                ExLCCharge = new BEXPORT_LC_CHARGES();
                                saveCharge(rcbChargeCode, rcbChargeCcy, rcbChargeAcct, tbChargeAmt, rcbPartyCharged, rcbAmortCharge, rcbChargeStatus, lblTaxCode, lblTaxAmt, ref ExLCCharge);
                                dbEntities.BEXPORT_LC_CHARGES.Add(ExLCCharge);
                            }
                            if (tbChargeAmt2.Value.HasValue)
                            {
                                ExLCCharge = new BEXPORT_LC_CHARGES();
                                saveCharge(rcbChargeCode2, rcbChargeCcy2, rcbChargeAcct2, tbChargeAmt2, rcbPartyCharged2, rcbAmortCharge2, rcbChargeStatus2, lblTaxCode2, lblTaxAmt2, ref ExLCCharge);
                                dbEntities.BEXPORT_LC_CHARGES.Add(ExLCCharge);
                            }
                            if (tbChargeAmt3.Value.HasValue)
                            {
                                ExLCCharge = new BEXPORT_LC_CHARGES();
                                saveCharge(rcbChargeCode3, rcbChargeCcy3, rcbChargeAcct3, tbChargeAmt3, rcbPartyCharged3, rcbAmortCharge3, rcbChargeStatus3, lblTaxCode3, lblTaxAmt3, ref ExLCCharge);
                                dbEntities.BEXPORT_LC_CHARGES.Add(ExLCCharge);
                            }
                        }
                        //
                        dbEntities.SaveChanges();
                        //
                        Response.Redirect("Default.aspx?tabid=" + this.TabId);
                        break;
                    case bc.Commands.Authorize:
                    case bc.Commands.Reverse:
                        if (ExLC != null)
                        {
                            if (commandName.Equals(bc.Commands.Authorize))
                            {
                                ExLC.Status = bd.TransactionStatus.AUT;
                                ExLC.AuthorizedBy = this.UserInfo.Username;
                                ExLC.AuthorizedDate = DateTime.Now;
                                //
                                dbEntities.SaveChanges();
                                Response.Redirect("Default.aspx?tabid=" + this.TabId);
                                return;
                            }
                            //
                            ExLC.Status = bd.TransactionStatus.REV;
                            dbEntities.SaveChanges();
                            Response.Redirect("Default.aspx?tabid=" + this.TabId + "&code=" + tbLCCode.Text);
                        }
                        break;
                }

                return;
            }
            if (TabId == Tabs.Cancel)
            {
                switch (commandName)
                {
                    case bc.Commands.Commit:
                        if (ExLC != null)
                        {
                            ExLC.CancelStatus = bd.TransactionStatus.UNA;
                            ExLC.CancelDate = DateTime.Now;
                            ExLC.CancelDay = txtCancelDate.SelectedDate;
                            ExLC.CancelContingentExpiryDate = txtContingentExpiryDate.SelectedDate;
                            ExLC.CancelRemark = txtCancelRemark.Text;
                            //
                            dbEntities.SaveChanges();
                        }                        
                        //
                        Response.Redirect("Default.aspx?tabid=" + this.TabId);
                        break;
                    case bc.Commands.Authorize:
                    case bc.Commands.Reverse:
                        if (ExLC != null)
                        {
                            if (commandName.Equals(bc.Commands.Authorize))
                            {
                                ExLC.CancelStatus = bd.TransactionStatus.AUT;
                                //
                                dbEntities.SaveChanges();
                                Response.Redirect("Default.aspx?tabid=" + this.TabId);
                                return;
                            }
                            //
                            ExLC.CancelStatus = bd.TransactionStatus.REV;
                            dbEntities.SaveChanges();
                            Response.Redirect("Default.aspx?tabid=" + this.TabId + "&code=" + tbLCCode.Text);
                        }
                        break;
                }

                return;
            }
        }
        private void saveLC(ref BEXPORT_LC ExLC)
        {
            ExLC.ImportLCCode = txtImportLCNo.Text.Trim();
            //
            ExLC.IssuingBankType = rcbIssuingBankType.SelectedValue.Trim();
            ExLC.IssuingBankNo = txtIssuingBankNo.Text.Trim();
            ExLC.IssuingBankName = txtIssuingBankName.Text.Trim();
            ExLC.IssuingBankAddr1 = txtIssuingBankAddr1.Text.Trim();
            ExLC.IssuingBankAddr2 = txtIssuingBankAddr2.Text.Trim();
            ExLC.IssuingBankAddr3 = txtIssuingBankAddr3.Text.Trim();
            //
            ExLC.AdvisingBankType = rcbAdvisingBankType.SelectedValue.Trim();
            ExLC.AdvisingBankNo = txtAdvisingBankNo.Text.Trim();
            ExLC.AdvisingBankName = txtAdvisingBankName.Text.Trim();
            ExLC.AdvisingBankAddr1 = txtAdvisingBankAddr1.Text.Trim();
            ExLC.AdvisingBankAddr2 = txtAdvisingBankAddr2.Text.Trim();
            ExLC.AdvisingBankAddr3 = txtAdvisingBankAddr3.Text.Trim();
            //
            ExLC.FormOfDocumentaryCredit = rcbFormOfDocumentaryCredit.SelectedValue.Trim();
            ExLC.DateOfIssue = txtDateOfIssue.SelectedDate;
            ExLC.DateOfExpiry = txtDateOfExpiry.SelectedDate;
            ExLC.PlaceOfExpiry = txtPlaceOfExpiry.Text.Trim();
            ExLC.ApplicableRule = rcbAvailableRule.SelectedValue.Trim();
            //
            ExLC.ApplicantName = txtApplicantName.Text.Trim();
            ExLC.ApplicantAddr1 = tbApplicantAddr1.Text.Trim();
            ExLC.ApplicantAddr2 = tbApplicantAddr2.Text.Trim();
            ExLC.ApplicantAddr3 = tbApplicantAddr3.Text.Trim();
            //
            ExLC.BeneficiaryNo = txtBeneficiaryNo.Text.Trim();
            ExLC.BeneficiaryName = txtBeneficiaryName.Text.Trim();
            ExLC.BeneficiaryAddr1 = txtBeneficiaryAddr1.Text.Trim();
            ExLC.BeneficiaryAddr2 = txtBeneficiaryAddr2.Text.Trim();
            ExLC.BeneficiaryAddr3 = txtBeneficiaryAddr3.Text.Trim();
            //
            ExLC.Currency = rcbCurrency.SelectedValue.Trim();
            ExLC.Amount = txtAmount.Value;
            ExLC.PercentageCreditAmountTolerance1 = txtPercentCreditAmountTolerance1.Value;
            ExLC.PercentageCreditAmountTolerance2 = txtPercentCreditAmountTolerance2.Value;
            ExLC.MaximunCreditAmount = rcbMaximumCreditAmount.SelectedValue.Trim();
            //
            ExLC.AvailableWithType = rcbAvailableWithType.SelectedValue.Trim();
            ExLC.AvailableWithNo = txtAvailableWithNo.Text.Trim();
            ExLC.AvailableWithName = tbAvailableWithName.Text.Trim();
            ExLC.AvailableWithAddr1 = tbAvailableWithAddr1.Text.Trim();
            ExLC.AvailableWithAddr2 = tbAvailableWithAddr2.Text.Trim();
            ExLC.AvailableWithAddr3 = tbAvailableWithAddr3.Text.Trim();
            ExLC.AvailableWithBy = rcbAvailableWithBy.SelectedValue;
            //
            ExLC.DraftsAt = txtDraftsAt1.Text.Trim() + breakLine + txtDraftsAt2.Text.Trim();
            ExLC.Tenor = rcbTenor.SelectedValue;
            ExLC.MixedPaymentDetails = txtMixedPaymentDetails1.Text.Trim() + breakLine + txtMixedPaymentDetails2.Text.Trim() + breakLine + txtMixedPaymentDetails3.Text.Trim() + breakLine + txtMixedPaymentDetails4.Text.Trim();
            ExLC.DeferedPaymentDetails = txtDeferredPaymentDetails1.Text.Trim() + breakLine + txtDeferredPaymentDetails2.Text.Trim() + breakLine + txtDeferredPaymentDetails3.Text.Trim() + breakLine + txtDeferredPaymentDetails4.Text.Trim();
            ExLC.PartialShipment = rcbPartialShipment.SelectedValue;
            ExLC.TranShipment = rcbTranshipment.SelectedValue;
            ExLC.PlaceOfTakingInCharge = txtPlaceOfTakingInCharge.Text.Trim();
            ExLC.PortOfLoading = txtPortOfLoading.Text.Trim();
            ExLC.PortOfDischarge = txtPortOfDischarge.Text.Trim();
            ExLC.PlaceOfFinalDestination = txtPlaceOfFinalDestination.Text.Trim();
            ExLC.LatesDateOfShipment = txtLatesDateOfShipment.SelectedDate;
            ExLC.ShipmentPeriod = txtShipmentPeriod1.Text.Trim() + breakLine + txtShipmentPeriod2.Text.Trim() + breakLine + txtShipmentPeriod3.Text.Trim() + breakLine + txtShipmentPeriod4.Text.Trim() + breakLine + txtShipmentPeriod5.Text.Trim() + breakLine + txtShipmentPeriod6.Text.Trim();
            //
            ExLC.DescriptionOfGoodsServices = txtDescriptionOfGoodsServices.Text.Trim();
            ExLC.Commodity = rcbCommodity.SelectedValue;
            ExLC.DocsRequired = txtDocsRequired.Text.Trim();
            ExLC.AdditionalConditions = txtAdditionalConditions.Text.Trim();
            ExLC.Charges = txtCharges.Text.Trim();
            ExLC.PeriodForPresentation = txtPeriodForPresentation.Text.Trim();
            ExLC.ConfirmationInstructions = rcbConfimationInstructions.SelectedValue;
            //
            ExLC.ReimbBankType = rcbReimbBankType.SelectedValue.Trim();
            ExLC.ReimbBankNo = txtReimbBankNo.Text.Trim();
            ExLC.ReimbBankName = tbReimbBankName.Text.Trim();
            ExLC.ReimbBankAddr1 = tbReimbBankAddr1.Text.Trim();
            ExLC.ReimbBankAddr2 = tbReimbBankAddr1.Text.Trim();
            ExLC.ReimbBankAddr3 = tbReimbBankAddr1.Text.Trim();
            //
            ExLC.InstrToPaygAccptgNegotgBank = txtInstrToPaygAccptgNegotgBank.Text.Trim();
            //
            ExLC.AdviseThroughNo = txtAdviseThroughBankNo.Text.Trim();
            ExLC.AdviseThroughName = txtAdviseThroughBankName.Text.Trim();
            ExLC.AdviseThroughAddr1 = txtAdviseThroughBankAddr1.Text.Trim();
            ExLC.AdviseThroughAddr2 = txtAdviseThroughBankAddr2.Text.Trim();
            ExLC.AdviseThroughAddr3 = txtAdviseThroughBankAddr3.Text.Trim();
            //
            ExLC.SenderToReceiverInformation = txtSenderToReceiverInformation.Text.Trim();
            //
            ExLC.WaiveCharges = rcbWaiveCharges.SelectedValue;
            ExLC.ChargeRemarks = tbChargeRemarks.Text.Trim();
            ExLC.VATNo = tbVatNo.Text.Trim();
        }
        private void saveCharge(RadComboBox cbChargeCode, RadComboBox cbChargeCcy, RadComboBox cbChargeAcc, RadNumericTextBox txtChargeAmt, RadComboBox cbChargeParty, RadComboBox cbChargeAmort,
            RadComboBox cbChargeStatus, Label lblTaxCode, Label lblTaxAmt, ref BEXPORT_LC_CHARGES ExLCCharge)
        {
            ExLCCharge.ChargeCode = cbChargeCode.SelectedValue;
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

        private void loadLC(BEXPORT_LC ExLC)
        {
            switch (TabId)
            {
                case Tabs.Confirm:
                    rcbGenerateDelivery.SelectedValue = ExLC.ConfirmGenerateDelivery;
                    txtDateConfirm.SelectedDate = ExLC.ConfirmDay;
                    //rcbConfirmInstr
                    break;
                case Tabs.Cancel:
                    txtCancelDate.SelectedDate = ExLC.CancelDay;
                    txtContingentExpiryDate.SelectedDate = ExLC.CancelContingentExpiryDate;
                    txtCancelRemark.Text = ExLC.CancelRemark;
                    break;
                case Tabs.Close:
                    break;
            }
            //
            txtImportLCNo.Text = ExLC.ImportLCCode;
            txtImportLCNo_TextChanged(null, null);
            //
            rcbIssuingBankType.SelectedValue = ExLC.IssuingBankType;
            rcbIssuingBankType_OnSelectedIndexChanged(null, null);
            txtIssuingBankNo.Text = ExLC.IssuingBankNo;
            txtIssuingBankName.Text = ExLC.IssuingBankName;
            txtIssuingBankAddr1.Text = ExLC.IssuingBankAddr1;
            txtIssuingBankAddr2.Text = ExLC.IssuingBankAddr2;
            txtIssuingBankAddr3.Text = ExLC.IssuingBankAddr3;
            //
            rcbAdvisingBankType.SelectedValue = ExLC.AdvisingBankType;
            rcbAdvisingBankType_OnSelectedIndexChanged(null, null);
            txtAdvisingBankNo.Text = ExLC.AdvisingBankNo;
            txtAdvisingBankName.Text = ExLC.AdvisingBankName;
            txtAdvisingBankAddr1.Text = ExLC.AdvisingBankAddr1;
            txtAdvisingBankAddr2.Text = ExLC.AdvisingBankAddr2;
            txtAdvisingBankAddr3.Text = ExLC.AdvisingBankAddr3;
            //
            rcbFormOfDocumentaryCredit.SelectedValue = ExLC.FormOfDocumentaryCredit;
            txtDateOfIssue.SelectedDate = ExLC.DateOfIssue;
            txtDateOfExpiry.SelectedDate = ExLC.DateOfExpiry;
            txtPlaceOfExpiry.Text = ExLC.PlaceOfExpiry;
            rcbAvailableRule.SelectedValue = ExLC.ApplicableRule;
            //
            txtApplicantName.Text = ExLC.ApplicantName;
            tbApplicantAddr1.Text = ExLC.ApplicantAddr1;
            tbApplicantAddr2.Text = ExLC.ApplicantAddr2;
            tbApplicantAddr3.Text = ExLC.ApplicantAddr3;
            //
            txtBeneficiaryNo.Text = ExLC.BeneficiaryNo;
            txtBeneficiaryName.Text = ExLC.BeneficiaryName;
            txtBeneficiaryAddr1.Text = ExLC.BeneficiaryAddr1;
            txtBeneficiaryAddr2.Text = ExLC.BeneficiaryAddr2;
            txtBeneficiaryAddr3.Text = ExLC.BeneficiaryAddr3;
            //
            rcbCurrency.SelectedValue = ExLC.Currency;
            txtAmount.Value = ExLC.Amount;
            txtPercentCreditAmountTolerance1.Value = ExLC.PercentageCreditAmountTolerance1;
            txtPercentCreditAmountTolerance2.Value = ExLC.PercentageCreditAmountTolerance2;
            rcbMaximumCreditAmount.SelectedValue = ExLC.MaximunCreditAmount;
            //
            rcbAvailableWithType.SelectedValue = ExLC.AvailableWithType;
            rcbAvailableWithType_OnSelectedIndexChanged(null, null);
            txtAvailableWithNo.Text = ExLC.AvailableWithNo;
            tbAvailableWithName.Text = ExLC.AvailableWithName;
            tbAvailableWithAddr1.Text = ExLC.AvailableWithAddr1;
            tbAvailableWithAddr2.Text = ExLC.AvailableWithAddr2;
            tbAvailableWithAddr3.Text = ExLC.AvailableWithAddr3;
            rcbAvailableWithBy.SelectedValue = ExLC.AvailableWithBy;
            //
            if (!string.IsNullOrEmpty(ExLC.DraftsAt))
            {
                string[] DraftsAt = ExLC.DraftsAt.Split(new string[] { breakLine }, StringSplitOptions.None);
                txtDraftsAt1.Text = DraftsAt[0];
                if (DraftsAt.Length > 1) txtDraftsAt2.Text = DraftsAt[1];
            }
            rcbTenor.SelectedValue = ExLC.Tenor;
            if (!string.IsNullOrEmpty(ExLC.MixedPaymentDetails))
            {
                string[] MixedPaymentDetails = ExLC.MixedPaymentDetails.Split(new string[] { breakLine }, StringSplitOptions.None);
                txtMixedPaymentDetails1.Text = MixedPaymentDetails[0];
                if (MixedPaymentDetails.Length > 1)
                {
                    txtMixedPaymentDetails2.Text = MixedPaymentDetails[1];
                    if (MixedPaymentDetails.Length > 2)
                    {
                        txtMixedPaymentDetails3.Text = MixedPaymentDetails[2];
                        if (MixedPaymentDetails.Length > 3)
                            txtMixedPaymentDetails4.Text = MixedPaymentDetails[3];
                    }
                }
            }
            if (!string.IsNullOrEmpty(ExLC.DeferedPaymentDetails))
            {
                string[] DeferedPaymentDetails = ExLC.DeferedPaymentDetails.Split(new string[] { breakLine }, StringSplitOptions.None);
                txtMixedPaymentDetails1.Text = DeferedPaymentDetails[0];
                if (DeferedPaymentDetails.Length > 1)
                {
                    txtDeferredPaymentDetails2.Text = DeferedPaymentDetails[1];
                    if (DeferedPaymentDetails.Length > 2)
                    {
                        txtDeferredPaymentDetails3.Text = DeferedPaymentDetails[2];
                        if (DeferedPaymentDetails.Length > 3)
                            txtDeferredPaymentDetails4.Text = DeferedPaymentDetails[3];
                    }
                }
            }
            rcbPartialShipment.SelectedValue = ExLC.PartialShipment;
            rcbTranshipment.SelectedValue = ExLC.TranShipment;
            txtPlaceOfTakingInCharge.Text = ExLC.PlaceOfTakingInCharge;
            txtPortOfLoading.Text = ExLC.PortOfLoading;
            txtPortOfDischarge.Text = ExLC.PortOfDischarge;
            txtPlaceOfFinalDestination.Text = ExLC.PlaceOfFinalDestination;
            txtLatesDateOfShipment.SelectedDate = ExLC.LatesDateOfShipment;
            if (!string.IsNullOrEmpty(ExLC.ShipmentPeriod))
            {
                string[] ShipmentPeriod = ExLC.ShipmentPeriod.Split(new string[] { breakLine }, StringSplitOptions.None);
                txtShipmentPeriod1.Text = ShipmentPeriod[0];
                if (ShipmentPeriod.Length > 1)
                {
                    txtShipmentPeriod2.Text = ShipmentPeriod[1];
                    if (ShipmentPeriod.Length > 2)
                    {
                        txtShipmentPeriod3.Text = ShipmentPeriod[2];
                        if (ShipmentPeriod.Length > 3)
                        {
                            txtShipmentPeriod4.Text = ShipmentPeriod[3];
                            if (ShipmentPeriod.Length > 4)
                            {
                                txtShipmentPeriod5.Text = ShipmentPeriod[4];
                                if (ShipmentPeriod.Length > 4)
                                    txtShipmentPeriod6.Text = ShipmentPeriod[4];
                            }
                        }
                    }
                }
            }
            //
            txtDescriptionOfGoodsServices.Text = ExLC.DescriptionOfGoodsServices;
            rcbCommodity.SelectedValue = ExLC.Commodity;
            txtDocsRequired.Text = ExLC.DocsRequired;
            txtAdditionalConditions.Text = ExLC.AdditionalConditions;
            txtCharges.Text = ExLC.Charges;
            txtPeriodForPresentation.Text = ExLC.PeriodForPresentation;
            rcbConfimationInstructions.SelectedValue = ExLC.ConfirmationInstructions;
            //
            rcbReimbBankType.SelectedValue = ExLC.ReimbBankType;
            rcbReimbBankType_OnSelectedIndexChanged(null, null);
            txtReimbBankNo.Text = ExLC.ReimbBankNo;
            tbReimbBankName.Text = ExLC.ReimbBankName;
            tbReimbBankAddr1.Text = ExLC.ReimbBankAddr1;
            tbReimbBankAddr1.Text = ExLC.ReimbBankAddr2;
            tbReimbBankAddr1.Text = ExLC.ReimbBankAddr3;
            //
            txtInstrToPaygAccptgNegotgBank.Text = ExLC.InstrToPaygAccptgNegotgBank;
            //
            txtAdviseThroughBankNo.Text = ExLC.AdviseThroughNo;
            txtAdviseThroughBankName.Text = ExLC.AdviseThroughName;
            txtAdviseThroughBankAddr1.Text = ExLC.AdviseThroughAddr1;
            txtAdviseThroughBankAddr2.Text = ExLC.AdviseThroughAddr2;
            txtAdviseThroughBankAddr3.Text = ExLC.AdviseThroughAddr3;
            //
            txtSenderToReceiverInformation.Text = ExLC.SenderToReceiverInformation;
            //
            rcbWaiveCharges.SelectedValue = ExLC.WaiveCharges;
            tbChargeRemarks.Text = ExLC.ChargeRemarks;
            tbVatNo.Text = ExLC.VATNo;
        }

        protected void rcbAdvisingBankType_OnSelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
        {
            bc.Commont.BankTypeChange(rcbAdvisingBankType.SelectedValue, ref lblAdvisingBankMessage, ref txtAdvisingBankNo, ref txtAdvisingBankName, ref txtAdvisingBankAddr1, ref txtAdvisingBankAddr2, ref txtAdvisingBankAddr3);
        }
        protected void rcbIssuingBankType_OnSelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
        {
            bc.Commont.BankTypeChange(rcbIssuingBankType.SelectedValue, ref lblIssuingBankMessage, ref txtIssuingBankNo, ref txtIssuingBankName, ref txtIssuingBankAddr1, ref txtIssuingBankAddr2, ref txtIssuingBankAddr3);
        }
        protected void rcbAvailableWithType_OnSelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
        {
            bc.Commont.BankTypeChange(rcbAvailableWithType.SelectedValue, ref lblAvailableWithMessage, ref txtAvailableWithNo, ref tbAvailableWithName, ref tbAvailableWithAddr1, ref tbAvailableWithAddr2, ref tbAvailableWithAddr3);
        }
        protected void rcbReimbBankType_OnSelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
        {
            bc.Commont.BankTypeChange(rcbReimbBankType.SelectedValue, ref lblReimbBankMessage, ref txtReimbBankNo, ref tbReimbBankName, ref tbReimbBankAddr1, ref tbReimbBankAddr2, ref tbReimbBankAddr3);
        }

        //ABBKVNVX : AN BINH COMMERCIAL JOINT STOCK BANK
        protected void txtAdvisingBankNo_TextChanged(object sender, EventArgs e)
        {
            bc.Commont.loadBankSwiftCodeInfo(txtAdvisingBankNo.Text, ref lblAdvisingBankMessage, ref txtAdvisingBankName, ref txtAdvisingBankAddr1, ref txtAdvisingBankAddr2, ref txtAdvisingBankAddr3);
        }
        protected void txtIssuingBankNo_TextChanged(object sender, EventArgs e)
        {
            bc.Commont.loadBankSwiftCodeInfo(txtIssuingBankNo.Text, ref lblIssuingBankMessage, ref txtIssuingBankName, ref txtIssuingBankAddr1, ref txtIssuingBankAddr2, ref txtIssuingBankAddr3);
        }
        protected void txtBeneficiaryNo_TextChanged(object sender, EventArgs e)
        {
            bc.Commont.loadBankSwiftCodeInfo(txtBeneficiaryNo.Text, ref lblBeneficiaryMessage, ref txtBeneficiaryName, ref txtBeneficiaryAddr1, ref txtBeneficiaryAddr2, ref txtBeneficiaryAddr3);
        }
        protected void txtAvailableWithNo_TextChanged(object sender, EventArgs e)
        {
            bc.Commont.loadBankSwiftCodeInfo(txtAvailableWithNo.Text, ref lblAvailableWithMessage, ref tbAvailableWithName, ref tbAvailableWithAddr1, ref tbAvailableWithAddr2, ref tbAvailableWithAddr3);
        }
        protected void txtReimbBankNo_TextChanged(object sender, EventArgs e)
        {
            bc.Commont.loadBankSwiftCodeInfo(txtReimbBankNo.Text, ref lblReimbBankMessage, ref tbReimbBankName, ref tbReimbBankAddr1, ref tbReimbBankAddr2, ref tbReimbBankAddr3);
        }
        protected void txtAdviseThroughBankNo_TextChanged(object sender, EventArgs e)
        {
            bc.Commont.loadBankSwiftCodeInfo(txtAdviseThroughBankNo.Text, ref lblAdviseThroughBankMessage, ref txtAdviseThroughBankName, ref txtAdviseThroughBankAddr1, ref txtAdviseThroughBankAddr2, ref txtAdviseThroughBankAddr3);
        }

        protected void rcbWaiveCharges_OnSelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
        {
            string WaiveCharges = rcbWaiveCharges.SelectedValue;
            divACCPTCHG.Visible = WaiveCharges.Equals(bd.YesNo.NO);
            divCABLECHG.Visible = WaiveCharges.Equals(bd.YesNo.NO);
            divPAYMENTCHG.Visible = WaiveCharges.Equals(bd.YesNo.NO);
        }

        protected void LoadChargeAcct(ref RadComboBox cboChargeAcct, string ChargeCcy)
        {
            bc.Commont.initRadComboBox(ref cboChargeAcct, "Display", "Id", bd.SQLData.B_BDRFROMACCOUNT_GetByCurrency(txtCustomerName.Text, ChargeCcy));
        }
        protected void rcbChargeCcy_OnSelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
        {
            LoadChargeAcct(ref rcbChargeAcct, rcbChargeCcy.SelectedValue);
        }
        protected void rcbChargeCcy2_OnSelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
        {
            LoadChargeAcct(ref rcbChargeAcct2, rcbChargeCcy2.SelectedValue);
        }
        protected void rcbChargeCcy3_OnSelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
        {
            LoadChargeAcct(ref rcbChargeAcct3, rcbChargeCcy3.SelectedValue);
        }

        protected void btnReportThuThongBao_Click(object sender, EventArgs e)
        {
            showReport("ThuThongBao");
        }
        protected void btnReportPhieuXuatNgoaiBang_Click(object sender, EventArgs e)
        {
            showReport("PhieuXuatNgoaiBang");
        }
        protected void btnReportPhieuThu_Click(object sender, EventArgs e)
        {
            showReport("PhieuThu");
        }
        private void showReport(string reportType)
        {
            string reportTemplate = "~/DesktopModules/TrainingCoreBanking/BankProject/Report/Template/Export/";
            string reportSaveName = "";
            DataSet reportData = new DataSet();
            DataTable tbl1 = new DataTable();
            Aspose.Words.SaveFormat saveFormat = Aspose.Words.SaveFormat.Doc;
            Aspose.Words.SaveType saveType = Aspose.Words.SaveType.OpenInApplication;
            try
            {
                var obj = dbEntities.BAdvisingAndNegotiationLCs.Where(x => x.NormalLCCode == tbLCCode.Text).FirstOrDefault();
                var objCharge = new List<BAdvisingAndNegotiationLCCharge>();
                if (obj == null)
                {
                    obj = new BAdvisingAndNegotiationLC();
                }
                else
                {
                    objCharge = dbEntities.BAdvisingAndNegotiationLCCharges.Where(x => x.DocCollectCode == tbLCCode.Text).ToList();
                }
                switch (reportType)
                {
                    case "ThuThongBao":
                        reportTemplate = Context.Server.MapPath(reportTemplate + "BM_TTQT_LCXK_01A.doc");

                        reportSaveName = "ThuThongBao" + "_" + DateTime.Now.ToString("yyyyMMddHHmmss") + ".doc";
                        var query = dbEntities.BAdvisingAndNegotiationLCs.Where(x => x.NormalLCCode == tbLCCode.Text).FirstOrDefault();
                        var TBThuTinDung = new List<ThuThongBao>();
                        if (query != null)
                        {
                            var DataThuThongBao = new ThuThongBao()
                            {
                                BeneficiaryNo = query.BeneficiaryNo,
                                BeneficiaryName = query.BeneficiaryName,
                                BeneficiaryAddress = query.BeneficiaryAddr1,
                                NormalLCCode = query.NormalLCCode,
                                ReceivingBank = query.ReceivingBank,
                                ApplicantNo = query.ApplicantNo,
                                Currency = query.Currency,
                                ApplicantName = query.ApplicantName,
                                ApplicantAddress = query.ApplicantAddr1
                            };
                            if (query.Amount != null)
                            {
                                DataThuThongBao.Amount = double.Parse(query.Amount.ToString());
                            }
                            if (query.DateOfIssue != null)
                            {
                                DataThuThongBao.DateIssue = obj.DateOfIssue.Value.Date.Day + "/" + obj.DateOfIssue.Value.Date.Month + "/" + obj.DateOfIssue.Value.Date.Year;
                            }
                            if (query.DateExpiry != null)
                            {
                                DataThuThongBao.DateExpiry = obj.DateExpiry.Value.Date.Day + "/" + obj.DateExpiry.Value.Date.Month + "/" + obj.DateExpiry.Value.Date.Year;
                            }
                            DataThuThongBao.Date = DateTime.Now.Day + "/" + DateTime.Now.Month + "/" + DateTime.Now.Year;
                            TBThuTinDung.Add(DataThuThongBao);
                        }
                        tbl1 = Utils.CreateDataTable<ThuThongBao>(TBThuTinDung);
                        reportData.Tables.Add(tbl1);
                        break;
                    case "PhieuThu":
                        reportTemplate = Context.Server.MapPath(reportTemplate + "RegisterDocumentaryCollectionVAT.doc");
                        reportSaveName = "PhieuThu" + "_" + DateTime.Now.ToString("yyyyMMddHHmmss") + ".doc";
                        var queryPhieuThu = (from CHA in dbEntities.BAdvisingAndNegotiationLCCharges
                                             join AD in dbEntities.BAdvisingAndNegotiationLCs on CHA.DocCollectCode equals AD.NormalLCCode
                                             join CU in dbEntities.BCUSTOMERS on AD.BeneficiaryNo equals CU.CustomerID
                                             join BC in dbEntities.BCHARGECODEs on CHA.Chargecode equals BC.Code
                                             where AD.NormalLCCode == tbLCCode.Text
                                             select new { CHA, AD, CU, BC });
                        var tbPhieuThu = new List<PhieuThu>();
                        var DataPhieuThu = new PhieuThu();
                        foreach (var item in queryPhieuThu)
                        {
                            DataPhieuThu.VATNo = item.CHA.VATNo;
                            DataPhieuThu.CustomerName = item.AD.BeneficiaryName;
                            DataPhieuThu.DocCollectCode = item.CHA.DocCollectCode;
                            DataPhieuThu.CustomerAddress = item.AD.BeneficiaryAddr1;
                            DataPhieuThu.UserNameLogin = UserInfo.DisplayName;
                            DataPhieuThu.IdentityNo = item.CU.IdentityNo;
                            DataPhieuThu.ChargeAcct = item.CHA.ChargeAcct;
                            DataPhieuThu.Remarks = item.CHA.ChargeRemarks;
                            DataPhieuThu.MCurrency = item.AD.Currency;
                            DataPhieuThu.CustomerID = item.AD.BeneficiaryNo;

                            if (item.CHA.Chargecode == "ELC.ADVISE")
                            {
                                if (item.BC.Code == "ELC.ADVISE")
                                {
                                    DataPhieuThu.Cot9_1Name = item.BC.Name_VN;
                                    DataPhieuThu.PL1 = item.BC.PLAccount;
                                }
                                if (item.CHA.ChargeAmt != null)
                                {
                                    DataPhieuThu.Amount1 = double.Parse(item.CHA.ChargeAmt.ToString());
                                }
                                DataPhieuThu.Currency1 = item.CHA.ChargeCcy;

                            }
                            //tab2
                            if (item.CHA.Chargecode == "ELC.CONFIRM")
                            {
                                if (item.BC.Code == "ELC.CONFIRM")
                                {
                                    DataPhieuThu.Cot9_2Name = item.BC.Name_VN;
                                    DataPhieuThu.PL2 = item.BC.PLAccount;
                                }
                                if (item.CHA.ChargeAmt != null)
                                {
                                    DataPhieuThu.Amount2 = double.Parse(item.CHA.ChargeAmt.ToString());
                                }
                                DataPhieuThu.Currency2 = item.CHA.ChargeCcy;
                            }

                            //tab3
                            if (item.CHA.Chargecode == "ELC.OTHER")
                            {
                                if (item.BC.Code == "ELC.OTHER")
                                {
                                    DataPhieuThu.Cot9_3Name = item.BC.Name_VN;
                                    DataPhieuThu.PL3 = item.BC.PLAccount;
                                }
                                if (item.CHA.ChargeAmt != null)
                                {
                                    DataPhieuThu.Amount3 = double.Parse(item.CHA.ChargeAmt.ToString());
                                }
                                DataPhieuThu.Currency3 = item.CHA.ChargeCcy;
                            }

                        }
                        tbPhieuThu.Add(DataPhieuThu);
                        tbl1 = Utils.CreateDataTable<PhieuThu>(tbPhieuThu);
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
            { }
        }

        protected void txtImportLCNo_TextChanged(object sender, EventArgs e)
        {
            lblImportLCNoMessage.Text = "";
            txtCustomerName.Text = "";
            var lc = dbEntities.BIMPORT_NORMAILLC.Where(p => p.NormalLCCode.ToLower().Trim().Equals(txtImportLCNo.Text.ToLower().Trim())).FirstOrDefault();
            if (lc == null)
            {
                lblImportLCNoMessage.Text = "Can not found this LC !";
                return;
            }
            txtCustomerName.Text = lc.ApplicantName;
            lblImportLCNoMessage.Text = lc.ApplicantName;
        }
    }
}