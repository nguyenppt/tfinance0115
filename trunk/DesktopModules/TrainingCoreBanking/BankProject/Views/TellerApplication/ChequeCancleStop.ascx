<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="ChequeCancleStop.ascx.cs" Inherits="BankProject.Views.TellerApplication.ChequeCancleStop" %>
<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<%@ Register TagPrefix="dnn" Namespace="DotNetNuke.Web.UI.WebControls" Assembly="DotNetNuke.Web" %>
<%@ Register TagPrefix="dnn" TagName="Label" Src="~/controls/LabelControl.ascx" %>

<script type="text/javascript">
    jQuery(function ($) {
        $('#tabs-demo').dnnTabs();
    });
</script>

<div>
    <telerik:RadToolBar ID="RadToolBar" runat="server" EnableRoundedCorners="true" EnableShadows="true" width="100%"  OnButtonClick="RadToolBar_OnButtonClick">
        <Items>
            <telerik:RadToolBarButton ImageUrl="~/Icons/bank/commit.png" ValidationGroup="Commit"
            ToolTip="Commit Data" Value="btCommitData" CommandName="commit">
        </telerik:RadToolBarButton>
             <telerik:RadToolBarButton ImageUrl="~/Icons/bank/preview.png"
            ToolTip="Preview" Value="btPreview" CommandName="Preview">
        </telerik:RadToolBarButton>
        <telerik:RadToolBarButton ImageUrl="~/Icons/bank/authorize.png"
            ToolTip="Authorize" Value="btAuthorize" CommandName="authorize">
        </telerik:RadToolBarButton>
        <telerik:RadToolBarButton ImageUrl="~/Icons/bank/reverse.png"
            ToolTip="Reverse" Value="btReverse" CommandName="reverse">
        </telerik:RadToolBarButton>
        <telerik:RadToolBarButton ImageUrl="~/Icons/bank/search.png"
            ToolTip="Search" Value="btSearch" CommandName="search">
        </telerik:RadToolBarButton>
         <telerik:RadToolBarButton ImageUrl="~/Icons/bank/print.png"
            ToolTip="Print Deal Slip" Value="btPrint" CommandName="print">
        </telerik:RadToolBarButton>
        </Items>
    </telerik:RadToolBar>
</div>
<table width="100%" cellpadding="0" cellspacing="0">
    <tr>
        <td style="width: 200px; padding: 5px 0 5px 20px;">
            <asp:TextBox ID="tbID" runat="server" Width="200" />
            <i> <asp:Label ID="lblStopCheqPaymentNo" runat="server" /></i></td>
    </tr>
</table>
<div class="dnnForm" id="tabs-demo">
    <ul class="dnnAdminTabNav">
        <li><a href="#blank1">Cancle Payment Stop</a></li>
    </ul>
    <div id="blank1" class="dnnClear">
        <table width="100%" cellpadding="0" cellspacing="0">
            <tr>
                <td class="MyLable">Serial No:</td>
                <td class="MyContent" width="160">
                    <telerik:RadComboBox ID="rcbSerialNo" runat="server" ValidationGroup="Group1" width="160"
                        MarkFirstMatch="true" AllowCustomText="false" AppendDataBoundItems="true">
                        <ExpandAnimation Type="None" />
                        <CollapseAnimation Type="None" />
                        <Items>
                            <telerik:RadComboBoxItem value="" Text="" />
                            <telerik:RadComboBoxItem Value="112233" Text="112233" />
                            <telerik:RadComboBoxItem Value="112234" Text="112234" />
                            <telerik:RadComboBoxItem Value="112235" Text="112235" />
                            <telerik:RadComboBoxItem Value="112236" Text="112236" />
                            <telerik:RadComboBoxItem Value="112237" Text="112237" />
                            <telerik:RadComboBoxItem Value="112238" Text="112238" />
                            <telerik:RadComboBoxItem Value="112239" Text="112239" />
                            <telerik:RadComboBoxItem Value="112240" Text="112240" />
                            <telerik:RadComboBoxItem Value="112241" Text="112241" />
                            <telerik:RadComboBoxItem Value="112242" Text="112242" />
                        </Items>
                    </telerik:RadComboBox>
                </td>
                <td>
                    <a class="add"><img src="Icons/Sigma/Add_16X16_Standard.png" /></a>
                </td>
            </tr>
        </table>
         <table width="100%" cellpadding="0" cellspacing="0">
            <tr>
                <td class="MyLable">Cheque Type:</td>
                <td class="MyContent">
                    <telerik:RadComboBox ID="rcbChequeType" runat="server" width="200" ValidationGroup="Group1" MarkFirstMatch="true" AllowCustomText="false" AppendDataBoundItems="true">
                        <ExpandAnimation Type="None" />
                        <CollapseAnimation Type="None" />
                        <Items>
                            <telerik:RadComboBoxItem value="" Text="" />
                            <telerik:RadComboBoxItem Value="AB" Text="AB - Current Accounts AB Series" />
                        </Items>
                    </telerik:RadComboBox>
                </td>
               
            </tr>
             <tr>
                  <td class="MyLable">Activity Date:</td>
                 <td class="MyContent">
                     <telerik:RadDatePicker ID="rdpActivityDate" runat="server" ValidationGroup="Group1" />
                 </td>
             </tr>
        </table>

    </div>

</div>

<script type="text/javascript">
    $(document).ready(
    function () {
        $('a.add').live('click',
            function () {
                $(this)
                    .html('<img src="Icons/Sigma/Delete_16X16_Standard.png" />')
                    .removeClass('add')
                    .addClass('remove');
                $(this)
                    .closest('tr')
                    .clone()
                    .appendTo($(this).closest('table'));
                $(this)
                    .html('<img src="Icons/Sigma/Add_16X16_Standard.png" />')
                    .removeClass('remove')
                    .addClass('add');
            });
        $('a.remove').live('click',
            function () {
                $(this)
                    .closest('tr')
                    .remove();
            });
        $('input:text').each(
            function () {
                var thisName = $(this).attr('name'),
                    thisRrow = $(this)
                                .closest('tr')
                                .index();
                $(this).attr('name', 'row' + thisRow + thisName);
                $(this).attr('id', 'row' + thisRow + thisName);
            });

    });

</script>