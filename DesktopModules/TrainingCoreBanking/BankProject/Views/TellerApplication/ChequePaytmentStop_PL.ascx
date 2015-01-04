<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="ChequePaytmentStop_PL.ascx.cs" Inherits="BankProject.Views.TellerApplication.ChequePaytmentStop_PL" %>
<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<%@ Register Assembly="DotNetNuke.Web" Namespace="DotNetNuke.Web.UI.WebControls" TagPrefix="dnn" %>
<%@ Register TagPrefix="dnn" TagName="Label" Src="~/controls/LabelControl.ascx" %>
<div style="padding:10px;">
    <telerik:RadGrid ID="RadGridDataPreview" runat="server"  AutoGenerateColumns="false"  AllowPaging="true" OnNeedDataSource="DataPreview_OnNeedDataSource" >
       <MasterTableView>
           <Columns>
               <telerik:GridBoundColumn HeaderText="Payment Stop Reference"  DataField="PaymentStopRef" HeaderStyle-Width="300" />
               <telerik:GridBoundColumn HeaderText="Customer Name" DataField="CustomerName" HeaderStyle-Width="300" />
               <telerik:GridBoundColumn HeaderText="Reason" DataField="Reason" HeaderStyle-Width="300"/>
               <telerik:GridBoundColumn HeaderText="Active Date" DataField="ActiveDate" />
               <telerik:GridTemplateColumn>
                   <ItemStyle width="25" />
                   <ItemTemplate>
                       <a href='<%# getUrlPreview(Eval("PRCode").ToString()) %>'><img src="Icons/bank/text_preview.png" width="20" /></a>
                   </ItemTemplate>
               </telerik:GridTemplateColumn>
           </Columns>
       </MasterTableView>
         </telerik:RadGrid>

</div>