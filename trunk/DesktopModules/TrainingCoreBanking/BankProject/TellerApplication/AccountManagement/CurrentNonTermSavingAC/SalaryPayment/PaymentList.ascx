<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="PaymentList.ascx.cs" Inherits="BankProject.TellerApplication.AccountManagement.CurrentNonTermSavingAC.SalaryPayment.PaymentList" %>
<%@ Register assembly="Telerik.Web.UI" namespace="Telerik.Web.UI" tagprefix="telerik" %>
<telerik:RadGrid runat="server" AutoGenerateColumns="False" ID="radGridReview" AllowPaging="True" OnNeedDataSource="radGridReview_OnNeedDataSource">
    <MasterTableView>
        <Columns>

            <telerik:GridBoundColumn HeaderText="Customer ID" DataField="CustomerId" />
            <telerik:GridBoundColumn HeaderText="Customer Name" DataField="CustomerName" />
            <telerik:GridTemplateColumn>
                <ItemStyle Width="25" />
                <ItemTemplate>
                    <a href='Default.aspx?tabid=<%=TabId %>&CustomerId=<%# Eval("CustomerId") %>&CustomerName=<%# Eval("CustomerName") %>'>
                        <img src="Icons/bank/text_preview.png" alt="" title="" style="" />
                    </a>
                </ItemTemplate>
            </telerik:GridTemplateColumn>
        </Columns>
    </MasterTableView>
</telerik:RadGrid>
   