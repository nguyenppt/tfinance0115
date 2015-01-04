<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="ChequeWithrawalDrawOnUs_PL.ascx.cs" Inherits="BankProject.Views.TellerApplication.ChequeWithrawalDrawOnUs_PL" %>
<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>

<div style="padding:10px;">
    <telerik:RadGrid ID="RadGridPreview" runat="server" AutoGenerateColumns="false"  AllowPaging="true" 
        OnNeedDataSource="RadGridPreview_OnNeedDataSource">
        <MasterTableView>
            <Columns>
                <telerik:GridBoundColumn  HeaderText="Customer ID"  DataField="CustomerID" />
                <telerik:GridBoundColumn HeaderText="Customer Name" DataField="CustomerName" />
                 <telerik:GridBoundColumn HeaderText="Amount LCY" DataField="AmtLCY" />
                <telerik:GridBoundColumn HeaderText="Narrative" DataField="Narrative" />
                <telerik:GridTemplateColumn>
                    <ItemStyle Width="25" />
                    <ItemTemplate>
                        <a href='<%# getUrlPreview(Eval("PRCode").ToString()) %>'><img src="Icons/bank/text_preview.png" width="20" /></a>
                    </ItemTemplate>
                </telerik:GridTemplateColumn>
            </Columns>
        </MasterTableView>
    </telerik:RadGrid>
</div>