<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="ChequeTransferDrawnOnUs_PL.ascx.cs" Inherits="BankProject.Views.TellerApplication.WebUserControl1" %>
<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<%@ Register Assembly="DotNetNuke.Web" Namespace="DotNetNuke.Web.UI.WebControls" TagPrefix="dnn" %>
<%@ Register TagPrefix="dnn" TagName="Label" Src="~/controls/LabelControl.ascx" %>
<div style="padding:10px">
    <telerik:RadGrid ID="RadGrid1" runat="server"  AutoGenerateColumns="false" AllowPaging="true" OnNeedDataSource="RadGrid1_OnNeedDataSource" >
        <MasterTableView>
            <Columns>
                <telerik:GridBoundColumn HeaderText="Customer ID" DataField="CustomerID" HeaderStyle-Width="150" />
                <telerik:GridBoundColumn HeaderText="Customer Name" DataField="CustomerName" HeaderStyle-Width="190" />
                <telerik:GridBoundColumn HeaderText="Debit Amount LCY" DataField="DebitAmountLCY" HeaderStyle-Width="105" ItemStyle-HorizontalAlign="Right"
                    HeaderStyle-HorizontalAlign="Right" />
                <telerik:GridBoundColumn HeaderText="Value Date" DataField="ValueDate" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center" HeaderStyle-Width="150" />
                <telerik:GridTemplateColumn>
                    <ItemStyle Width="25" />
                    <ItemTemplate>
                        <a href='<%# getUrlPreview(Eval("LCCode").ToString()) %>'><img src="Icons/bank/text_preview.png" width="20" /></a>
                    </ItemTemplate>
                </telerik:GridTemplateColumn>
            </Columns>
        </MasterTableView>
    </telerik:RadGrid>
</div>