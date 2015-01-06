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

namespace BankProject.TradingFinance.Export.DocumentaryCredit
{
    public partial class EnquiryLC : DotNetNuke.Entities.Modules.PortalModuleBase
    {
        VietVictoryCoreBankingEntities dbEntities = new VietVictoryCoreBankingEntities();
        protected string lstType = "";
        protected int refId;
        protected struct Tabs
        {
            public const int Register = 242;
            public const int Confirm = 236;
            public const int Cancel = 237;
            public const int Close = 265;
        }
        protected void Page_Load(object sender, EventArgs e)
        {
            lstType = Request.QueryString["lst"];
            if (!string.IsNullOrEmpty(Request.QueryString["refid"]))
                refId = Convert.ToInt32(Request.QueryString["refid"]);
            else
                refId = Tabs.Register;
            RadToolBar1.FindItemByValue("btSearch").Enabled = (string.IsNullOrEmpty(lstType) || !lstType.ToLower().Equals("4appr"));
            if (IsPostBack) return;
        }

        protected void RadToolBar1_ButtonClick(object sender, RadToolBarEventArgs e)
        {
            var toolBarButton = e.Item as RadToolBarButton;
            string commandName = toolBarButton.CommandName;
            switch (commandName)
            {
                case bc.Commands.Search:
                    loadData();
                    radGridReview.Rebind();
                    break;
            }
        }

        protected void radGridReview_OnNeedDataSource(object sender, GridNeedDataSourceEventArgs e)
        {
            if (!IsPostBack && !string.IsNullOrEmpty(lstType) && lstType.ToLower().Equals("4appr")) loadData();
        }

        private void loadData()
        {
            IQueryable<BEXPORT_LC> enquiry = dbEntities.BEXPORT_LC.AsQueryable();
            if (!string.IsNullOrEmpty(lstType) && lstType.ToLower().Equals("4appr"))
            {
                switch (refId)
                {
                    case Tabs.Confirm:
                        enquiry = enquiry.Where(p => p.ConfirmStatus.Equals(bd.TransactionStatus.UNA));
                        break;
                    case Tabs.Cancel:
                        enquiry = enquiry.Where(p => p.CancelStatus.Equals(bd.TransactionStatus.UNA));
                        break;
                    case Tabs.Close:
                        enquiry = enquiry.Where(p => p.ClosedStatus.Equals(bd.TransactionStatus.UNA));
                        break;
                    default:// Tabs.Register:
                        enquiry = enquiry.Where(p => p.Status.Equals(bd.TransactionStatus.UNA));
                        break;
                }                
            }
                        
            if (!string.IsNullOrEmpty(txtRefNo.Text))
                enquiry = enquiry.Where(p => p.ImportLCCode.Equals(txtRefNo.Text));
            if (!string.IsNullOrEmpty(txtApplicantName.Text))
                enquiry = enquiry.Where(p => p.ApplicantName.Contains(txtApplicantName.Text));
            if (!string.IsNullOrEmpty(txtBeneficiaryID.Text))
                enquiry = enquiry.Where(p => p.BeneficiaryNo.Equals(txtBeneficiaryID.Text));
            if (!string.IsNullOrEmpty(txtBeneficiaryName.Text))
                enquiry = enquiry.Where(p => p.BeneficiaryName.Contains(txtBeneficiaryName.Text));
            if (txtIssueDate.SelectedDate.HasValue)
                enquiry = enquiry.Where(p => p.DateOfIssue.Equals(txtIssueDate.SelectedDate));
            if (!string.IsNullOrEmpty(txtIssuingBank.Text))
                enquiry = enquiry.Where(p => p.IssuingBankNo.Equals(txtIssuingBank.Text));
            switch (refId)
            {
                case Tabs.Confirm:
                    radGridReview.DataSource = enquiry
                        .OrderByDescending(p => p.ConfirmDate)
                        .Select(q => new { q.ExportLCCode, q.ImportLCCode, q.ApplicantName, q.Amount, q.Currency, q.BeneficiaryNo, q.BeneficiaryName, q.DateOfIssue, q.IssuingBankNo, Status = q.ConfirmStatus })
                        .ToList();
                    return;
                case Tabs.Cancel:
                    radGridReview.DataSource = enquiry
                        .OrderByDescending(p => p.CancelDate)
                        .Select(q => new { q.ExportLCCode, q.ImportLCCode, q.ApplicantName, q.Amount, q.Currency, q.BeneficiaryNo, q.BeneficiaryName, q.DateOfIssue, q.IssuingBankNo, Status = q.CancelStatus })
                        .ToList();
                    return;
                case Tabs.Close:
                    radGridReview.DataSource = enquiry
                        .OrderByDescending(p => p.ClosedDate)
                        .Select(q => new { q.ExportLCCode, q.ImportLCCode, q.ApplicantName, q.Amount, q.Currency, q.BeneficiaryNo, q.BeneficiaryName, q.DateOfIssue, q.IssuingBankNo, Status = q.ClosedStatus })
                        .ToList();
                    return;
                default:// Tabs.Register:
                    radGridReview.DataSource = enquiry
                        .OrderByDescending(p => p.CreateDate)
                        .Select(q => new { q.ExportLCCode, q.ImportLCCode, q.ApplicantName, q.Amount, q.Currency, q.BeneficiaryNo, q.BeneficiaryName, q.DateOfIssue, q.IssuingBankNo, Status = q.Status })
                        .ToList();
                    return;
            }
        }
    }
}