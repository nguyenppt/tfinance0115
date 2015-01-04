<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="LoanAccountList.ascx.cs" Inherits="BankProject.Views.TellerApplication.LoanAccountList" %>
<%@ Register assembly="Telerik.Web.UI" namespace="Telerik.Web.UI" tagprefix="telerik" %>
<telerik:RadGrid runat="server" AutoGenerateColumns="False" ID="radGridReview" AllowPaging="True" OnNeedDataSource="radGridReview_OnNeedDataSource">
    <MasterTableView>
        <Columns>

            <telerik:GridBoundColumn HeaderText="Code" DataField="Id" />
            <telerik:GridBoundColumn HeaderText="Customer ID" DataField="CustomerId" />
            <telerik:GridBoundColumn HeaderText="Loan Amount" DataField="LoanAmount" />
            <telerik:GridTemplateColumn>
                <ItemStyle Width="25" />
                <ItemTemplate>
                    <a href='Default.aspx?tabid=202&ctl=NormalLoan&mid=821&codeid=<%# Eval("Id") %>&idx=<%# Eval("idx") %>&amount=<%# Eval("LoanAmount") %>&key=<%# Eval("key") %>''>
                        <img src="Icons/bank/text_preview.png" alt="" title="" style="" />
                    </a>
                </ItemTemplate>
            </telerik:GridTemplateColumn>
        </Columns>
    </MasterTableView>
</telerik:RadGrid>
   