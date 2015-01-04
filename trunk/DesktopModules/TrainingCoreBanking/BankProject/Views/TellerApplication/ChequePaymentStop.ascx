<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="ChequePaymentStop.ascx.cs" Inherits="BankProject.Views.TellerApplication.ChequePaymentStop" %>
<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<%@ Register TagPrefix="dnn" Namespace="DotNetNuke.Web.UI.WebControls" Assembly="DotNetNuke.Web" %>
<%@ Register TagPrefix="dnn" TagName="Label" Src="~/controls/LabelControl.ascx" %>
<telerik:RadWindowManager id="RadWindowManager1"  runat="server" EnableShadow="true" />

<script type="text/javascript">
    jQuery(function ($) {
        $('#tabs-demo').dnnTabs();
    });

  
</script>

<div>   
     <telerik:RadToolBar runat="server" ID="RadToolBar1" EnableRoundedCorners="true" EnableShadows="true" Width="100%" 
        OnButtonClick="OnRadToolBarClick">
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
            <i>
                <asp:Label ID="lblCheqPaymentNo" runat="server" /></i></td>
    </tr>
</table>
<div class="dnnForm" id="tabs-demo">
    <ul class="dnnAdminTabNav">
        <li><a href="#Main">Stop Cheque</a></li>
        <li><a href="#blank">Audit</a></li>
        <li><a href="#blank">Full Vi</a></li>
    </ul>
    <div id="Main" class="dnnClear">
        <table width="100%" cellpadding="0" cellspacing="0">
            <tr>
                <td class="MyLable">Customer:</td>
                <td class="MyContent">
                    <telerik:RadComboBox ID="rcbCustomerID" runat="server" ValidationGroup="Group1" AllowCustomText="false" MarkFirstMatch="true" AppendDataBoundItems="true"
                     width="305"   >
                        <ExpandAnimation Type="None" />
                        <CollapseAnimation Type="None" />
                       <Items>
                           <telerik:RadComboBoxItem Value="" Text="" />
                       </Items>
                        </telerik:RadComboBox>
                </td>
            </tr>
            <tr>
                <td class="MyLable">Currency:
                </td>
                <td class="MyContent">
                    <telerik:RadComboBox ID="rcbCurrency" runat="server" ValidationGroup="Group1" AllowCustomText="false" MarkFirstMatch="true"
                         AppendDataBoundItems="true" Width="150">
                        <CollapseAnimation Type="None" />
                        <ExpandAnimation Type="None" />
                        <Items>
                            <telerik:RadComboBoxItem Value="" Text="" />
                            <telerik:RadComboBoxItem Value="USD" Text="USD" />
                            <telerik:RadComboBoxItem Value="EUR" Text="EUR" />
                            <telerik:RadComboBoxItem Value="GBP" Text="GBP" />
                            <telerik:RadComboBoxItem Value="JPY" Text="JPY" />
                            <telerik:RadComboBoxItem Value="VND" Text="VND" />
                        </Items>
                    </telerik:RadComboBox>
                </td>
            </tr>
        </table>

        <table width="100%" cellpadding="0" cellspacing="0">
            <tr>
                <td class="MyLable">Reason for Stopping:</td>
                <td class="MyContent" width="250">
                    <telerik:RadComboBox ID="rcbReasonForStopping" TabIndex="1"
                        MarkFirstMatch="True"
                        AllowCustomText="false"
                        Width="250" runat="server" ValidationGroup="Group1">
                        <Items>
                            <telerik:RadComboBoxItem Value="" Text="" />
                            <telerik:RadComboBoxItem Value="1" Text="1 - CHEQUES LOST      - 2" />
                            <telerik:RadComboBoxItem Value="2" Text="2 - CHEQUES DESTROYED - 2" />
                            <telerik:RadComboBoxItem Value="3" Text="3 - CHEQUES STOLEN    - 2" />
                        </Items>
                    </telerik:RadComboBox>
                </td>
                <td><a class="add">
                    <img src="Icons/Sigma/Add_16X16_Standard.png"></a></td>
            </tr>
        </table>

        <table width="100%" cellpadding="0" cellspacing="0">
            <tr>
                <td class="MyLable">From Serial:</td>
                <td class="MyContent">
                    <telerik:RadNumericTextBox ID="tbFromSerial" runat="server" ValidationGroup="Group1" NumberFormat-DecimalDigits="0"
                        NumberFormat-GroupSeparator="" TabIndex="2" Width="150" ClientEvents-OnValueChanged="SoSanh_Serial" />
                </td>
                <td class="MyLable">To Serial:</td>
                <td class="MyContent">
                    <telerik:RadNumericTextBox ID="tbToSerial" runat="server" ValidationGroup="Group1" NumberFormat-DecimalDigits="0" NumberFormat-GroupSeparator=""
                     TabIndex="3" width="150" ClientEvents-OnValueChanged="SoSanh_Serial" />
                </td>
            </tr>
        </table>

        <table width="100%" cellpadding="0" cellspacing="0">
            <tr>
                <td class="MyLable">No.of Leaves:</td>
                <td class="MyContent">
                    <asp:Label runat="server" ID="lblNoOfLeaves" />
                </td>
            </tr>

            <tr>
                <td class="MyLable">Cheques Type:</td>
                <td class="MyContent">
                    <telerik:RadComboBox ID="rcbChequeType" 
                        MarkFirstMatch="True" TabIndex="4"
                        AllowCustomText="false" Width="250"
                        runat="server" ValidationGroup="Group1">
                        <Items>
                            <telerik:RadComboBoxItem Value="" Text="" />
                            <telerik:RadComboBoxItem Value="AB" Text="AB - CURRENT ACCOUNTS AB SERIES" />
                        </Items>
                    </telerik:RadComboBox>
                </td>
            </tr>
        </table>

        <table width="100%" cellpadding="0" cellspacing="0">
            <tr>
                <td class="MyLable">Amount From:</td>
                <td class="MyContent" >
                    <telerik:RadNumericTextBox ID ="tbAmountFrom" runat="server" ValidationGroup="Group1"  width="150"/>
                </td>

                <td class="MyLable">Amount:</td>
                <td class="MyContent">
                    <telerik:RadNumericTextBox ID="tbAmount" runat="server" ValidationGroup="Group1"  width="150" />
                </td>
            </tr>
        </table>

        <table width="100%" cellpadding="0" cellspacing="0">
            <tr>
                <td class="MyLable">Waive Charges:</td>
                <td class="MyContent">
                    <telerik:RadComboBox ID="rcbWaiveCharges"
                        MarkFirstMatch="True"
                        AllowCustomText="false"                        
                        runat="server"  width="150">
                        <Items>
                            <telerik:RadComboBoxItem Value="" Text="" />
                            <telerik:RadComboBoxItem Value="YES" Text="YES" />
                            <telerik:RadComboBoxItem Value="NO" Text="NO" />
                        </Items>
                    </telerik:RadComboBox>
                </td>
            </tr>
            <table width="100%" cellpadding="0" cellspacing="0">
            <tr>
                <td class="MyLable">Activity Date:</td>
                <td>
                    <telerik:RadDatePicker ID="rdpActivityDate" runat="server" width="150"/>
                </td>
            </tr>
                </table>
        </table>
    </div>
</div>
<script type="text/javascript">

    
   
    function SoSanh_Serial() {
        var FromSerialElement = $find("<%= tbFromSerial.ClientID %>");
        var FromSerialValue = FromSerialElement.get_value();
        var ToSerialElement = $find("<%= tbToSerial.ClientID %>");
        var ToSerialValue = ToSerialElement.get_value();
        if (ToSerialValue && FromSerialValue) {
            if (FromSerialValue <= ToSerialValue) {
                var leaves = $('#<%=lblNoOfLeaves.ClientID%>');
                leaves.html((ToSerialValue - FromSerialValue + 1).toLocaleString("en-IN"));
            } else { showMessage(); }
        } else return false;
    }
    function showMessage() {
        radconfirm("To Serial Value must be greater than From Serial Value, check these values again !", confirmcallbackfunction2);
    }
    function confirmcallbackfunction2(args) {
        clickcalledAfterRadconfirm = true;
        lastclickItem.click();
        lastClickItem = null;
    }

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

$("#<%=tbID.ClientID %>").keyup(function (event) {

    if (event.keyCode == 13) {
        window.location.href = "Default.aspx?tabid=134&LoadCus=1";
    }
});

</script>