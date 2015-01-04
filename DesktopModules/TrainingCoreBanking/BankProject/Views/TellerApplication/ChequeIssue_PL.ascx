<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="ChequeIssue_PL.ascx.cs" Inherits="BankProject.Views.TellerApplication.ChequeIssue_PL" %>
<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>

<div style="padding:10px;">
    <telerik:RadGrid ID="RadGridPreview" runat="server"  AutoGenerateColumns="false" AllowPaging="true"  
        OnNeedDataSource="RadGridPreview_OnNeedDataSource">
        <MasterTableView>
            <Columns>
                <telerik:GridBoundColumn HeaderText="Cheque No" DataField="ChequeNo"  HeaderStyle-Width="120"
                    ItemStyle-HorizontalAlign="left" />
                <telerik:GridBoundColumn HeaderText="Cheque Status" DataField="ChequeStt" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center"
                    HeaderStyle-Width="150" />
                <telerik:GridBoundColumn HeaderText="Issue Date" DataField="IssueDate" ItemStyle-HorizontalAlign="Right" 
                    HeaderStyle-Width="50" HeaderStyle-HorizontalAlign="Right"/>
                <telerik:GridBoundColumn HeaderText="Quantity Of Issued" DataField="QIss"  ItemStyle-HorizontalAlign="Center" HeaderStyle-Width="150"
                    HeaderStyle-HorizontalAlign="Center" />
                <telerik:GridTemplateColumn>
                    <ItemStyle width="25" />
                    <ItemTemplate>
                        <a href='<%# getUrlPreview(Eval("PRCode").ToString()) %>'> <img src="Icons/bank/text_preview.png" width="20"" /></a>
                    </ItemTemplate>
                </telerik:GridTemplateColumn>
            </Columns>
        </MasterTableView>
    </telerik:RadGrid>
</div>
