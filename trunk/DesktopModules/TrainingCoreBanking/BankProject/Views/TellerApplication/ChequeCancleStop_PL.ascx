<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="ChequeCancleStop_PL.ascx.cs" Inherits="BankProject.Views.TellerApplication.ChequeCancleStop_PL" %>
<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>

<div style="padding:10px;">
    <telerik:RadGrid ID="RadGrid" runat="server" AutoGenerateColumns="false" AllowPaging="true" OnNeedDataSource="RadGrid_OnNeedDataSource">
        <MasterTableView>
            <Columns>
                <telerik:GridBoundColumn HeaderText="Stop Cheque Number" DataField="ChequeNo" HeaderStyle-Width="170" />
                <telerik:GridBoundColumn HeaderText="Serial Number" DataField="SerialNumber" HeaderStyle-Width="300" 
                    HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center"/>
                 <telerik:GridBoundColumn HeaderText="Cheque Type" DataField="ChequeType" HeaderStyle-Width="250" />
                 <telerik:GridBoundColumn HeaderText="Active Date" DataField="ActiveDate"  />
                <telerik:GridTemplateColumn>
                    <ItemStyle Width="25px" />
                    <ItemTemplate>
                        <a href='<%# getUrlPreview(Eval("PRCode").ToString()) %>'><img src="Icons/bank/text_preview.png" width="20" /></a>
                    </ItemTemplate>
                </telerik:GridTemplateColumn>
            </Columns>
        </MasterTableView>
    </telerik:RadGrid>

</div>