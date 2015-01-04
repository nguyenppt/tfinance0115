<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="ChequeReturned_PL.ascx.cs" Inherits="BankProject.Views.TellerApplication.ChequeReturned_PL" %>
<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<%@ Register Assembly="DotNetNuke.Web" Namespace="DotNetNuke.Web.UI.WebControls" TagPrefix="dnn" %>
<%@ Register TagPrefix="dnn" TagName="Label" Src="~/controls/LabelControl.ascx" %>

<div style="padding:10px">
    <telerik:RadGrid ID="RadGrid" runat="server" AllowPaging="true" AutoGenerateColumns="false"  OnNeedDataSource="RadGrid_OnNeedDataSource">
        <MasterTableView>
            <Columns>
                <telerik:GridBoundColumn HeaderText="Customer ID" DataField="CustomerID" HeaderStyle-Width="17%" />
                 <telerik:GridBoundColumn HeaderText="Total Cheques Issued" DataField="TotalIssued" HeaderStyle-Width="300" 
                    HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center"/>
                 <telerik:GridBoundColumn HeaderText="Cheques Numbers" DataField="ChequesNo" HeaderStyle-Width="25%" />
                 <telerik:GridBoundColumn HeaderText="Returned Cheques" DataField="ReturnedCheque" HeaderStyle-Width="25%" 
                    HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center" />
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
