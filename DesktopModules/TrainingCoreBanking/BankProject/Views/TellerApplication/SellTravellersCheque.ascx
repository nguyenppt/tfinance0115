<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="SellTravellersCheque.ascx.cs" Inherits="BankProject.Views.TellerApplication.SellTravellersCheque" %>
<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<%@ Register Assembly="BankProject" Namespace="BankProject.Controls" TagPrefix="customControl" %>
<%@ Register Src="~/Controls/VVComboBox.ascx" TagPrefix="uc1" TagName="VVComboBox" %>

<telerik:RadWindowManager ID="RadWindowManager1" runat="server" EnableShadow="true"> </telerik:RadWindowManager>

<asp:ValidationSummary ID="ValidationSummary1" runat="server" ShowMessageBox="True" ShowSummary="False" ValidationGroup="Commit"  />
<script type="text/javascript">
    jQuery(function ($) {
        $('#tabs-demo').dnnTabs();
    });

</script>
<div>
    <telerik:RadToolBar runat="server" ID="RadToolBar1" EnableRoundedCorners="true" EnableShadows="true" Width="100%" 
         OnClientButtonClicking="OnClientButtonClicking" OnButtonClick="RadToolBar1_ButtonClick">
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
            <asp:TextBox ID="txtId" runat="server" Width="200" />
        </td>
    </tr>
</table>
<div class="dnnForm" id="tabs-demo">
    <ul class="dnnAdminTabNav">
        <li><a href="#ChristopherColumbus">Sell Travellers Cheques</a></li>
        <li><a href="#blank">Audit</a></li>
        <li><a href="#blank">Full View</a></li>
    </ul>
    <div id="ChristopherColumbus" class="dnnClear">
        <table width="100%" cellpadding="0" cellspacing="0">
            <tr>
                <td class="MyLable">Customer Name <span class="Required">(*)</span></td>
                <td class="MyContent"><telerik:RadTextBox ID="tbCustomerName" runat="server" Width="350"></telerik:RadTextBox></td>
                <td>
                    <asp:RequiredFieldValidator
                        runat="server" Display="None"
                        ID="RequiredFieldtbCustomerName"
                        ControlToValidate="tbCustomerName"
                        ValidationGroup="Commit"
                        InitialValue=""
                        ErrorMessage="Customer Name is Required" ForeColor="Red">
                    </asp:RequiredFieldValidator>
                </td>
            </tr>
        </table>
        <table width="100%" cellpadding="0" cellspacing="0">
            <tr>
                <td class="MyLable">Address <span class="Required">(*)</span></td>
                <td class="MyContent"><telerik:RadTextBox ID="tbAddress" runat="server" Width="350"></telerik:RadTextBox></td>
                <td>
                    <asp:RequiredFieldValidator
                        runat="server" Display="None"
                        ID="RequiredFieldtbAddress"
                        ControlToValidate="tbAddress"
                        ValidationGroup="Commit"
                        InitialValue=""
                        ErrorMessage="Address is Required" ForeColor="Red">
                    </asp:RequiredFieldValidator>
                </td>
            </tr>
        </table>

        <table width="100%" cellpadding="0" cellspacing="0">
            <tr>
                <td class="MyLable">Passport No. <span class="Required">(*)</span></td>
                <td class="MyContent"><telerik:RadTextBox ID="tbPassportNo" runat="server" Width="160"></telerik:RadTextBox></td>
                <td>
                    <asp:RequiredFieldValidator
                        runat="server" Display="None"
                        ID="RequiredFieldtbPassportNo"
                        ControlToValidate="tbPassportNo"
                        ValidationGroup="Commit"
                        InitialValue=""
                        ErrorMessage="Passport No. is Required" ForeColor="Red">
                    </asp:RequiredFieldValidator>
                </td>
            </tr>
        </table>

        <table width="100%" cellpadding="0" cellspacing="0">
            <tr>
                <td class="MyLable">Date of isssue</td>
                <td class="MyContent"><telerik:RadDatePicker ID="tbDateOfIsssue" runat="server" Width="160"></telerik:RadDatePicker></td>
                <td class="MyLable">Place of Iss</td>
                <td class="MyContent"><telerik:RadTextBox ID="tbPlaceOfIss" runat="server" Width="160"></telerik:RadTextBox></td>
            </tr>
        </table>

                <table width="100%" cellpadding="0" cellspacing="0">
            <tr>
                <td class="MyLable">Phone No.</td>
                <td class="MyContent">
                    <%--<telerik:RadMaskedTextBox ID="txtPhoneNo" runat="server" Mask="(###)###-####" 
            EmptyMessage="-- Enter Phone Number --" HideOnBlur="true" ZeroPadNumericRanges="true" 
                        DisplayMask="(###)###-####"> </telerik:RadMaskedTextBox> --%>
                    <telerik:RadTextBox ID="txtPhoneNo" runat="server"></telerik:RadTextBox>
                </td>
            </tr>
        </table>
        <hr />
         <table width="100%" cellpadding="0" cellspacing="0">
            <tr>
                <td class="MyLable">Teller ID <span class="Required">(*)</span>
                    <asp:RequiredFieldValidator
                        runat="server" Display="None"
                        ID="RequiredFieldtxtTellerId"
                        ControlToValidate="txtTellerId"
                        ValidationGroup="Commit"
                        InitialValue=""
                        ErrorMessage="Teller ID is Required" ForeColor="Red">
                    </asp:RequiredFieldValidator></td>
                <td class="MyContent">
                    <telerik:RadTextBox ID="txtTellerId"
                        runat="server">
                    </telerik:RadTextBox>
                </td>
            </tr>
        </table>
        <hr />
        <asp:UpdatePanel ID="UpdatePanel1" runat="server">
            <ContentTemplate>
        <table width="100%" cellpadding="0" cellspacing="0">
             <tr>
                <td class="MyLable">TC Currency
                <span class="Required">(*)</span>
                    </td>
                <td class="MyContent">
                    <telerik:RadComboBox ID="cmbTCCurrency"
                        MarkFirstMatch="True"
                        AllowCustomText="false"
                        OnSelectedIndexChanged="cmbTCCurrency_SelectedIndexChanged"
                        AutoPostBack="true"
                        runat="server" >
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
                <td><asp:RequiredFieldValidator
                        runat="server" Display="None"
                        ID="RequiredFieldcmbTCCurrency"
                        ControlToValidate="cmbTCCurrency"
                        ValidationGroup="Commit"
                        InitialValue=""
                        ErrorMessage="TC Currency is Required" ForeColor="Red">
                    </asp:RequiredFieldValidator></td>
            </tr>
        </table>
           <table width="100%" cellpadding="0" cellspacing="0">
        <tr>
                <td class="MyLable">Debit Account</td>
                <td class="MyContent" style="width:350px;" >
                    <telerik:RadComboBox ID="rcbDebitAccount"
                        MarkFirstMatch="True"
                        AllowCustomText="false"
                        runat="server" Width="350" >
                    </telerik:RadComboBox>
                </td>
             <td><a class="add">
                    <img src="Icons/Sigma/Add_16X16_Standard.png"></a></td>
            </tr>
        </table>
            </ContentTemplate>
            </asp:UpdatePanel>
         <table width="100%" cellpadding="0" cellspacing="0">
            
            <tr>
                <td class="MyLable">TC Amount</td>
                <td class="MyContent">
                    <telerik:RadNumericTextBox ID="tbTCAmount" runat="server" NumberFormat-DecimalSeparator="," NumberFormat-DecimalDigits="2" ClientEvents-OnValueChanged="OnAmountValueChanged"/>
                </td>
            </tr>
        </table>
        <table width="100%" cellpadding="0" cellspacing="0">
            <tr>
               <td class="MyLable">Dr Currency
                    </td>
                <td class="MyContent">
                    <telerik:RadComboBox ID="rcbDrCurrency"
                        MarkFirstMatch="True"
                        AllowCustomText="false"
                        runat="server" >
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
                <td class="MyLable">Cr Account</td>
                <td class="MyContent" style="width:160px;">
                    <telerik:RadComboBox ID="rcbCrAccount"
                        MarkFirstMatch="True"
                        AllowCustomText="false"
                        OnClientSelectedIndexChanged="OnClientSelectedIndexChanged"
                        Width="160"
                        runat="server" >
                        <Items>
                             <telerik:RadComboBoxItem Value="" Text="" />
                            <telerik:RadComboBoxItem Value="USD" Text="USD-10001-0024-2690" />
                            <telerik:RadComboBoxItem Value="EUR" Text="EUR-10001-0024-2695" />
                            <telerik:RadComboBoxItem Value="GBP" Text="GBP-10001-0024-2700" />
                            <telerik:RadComboBoxItem Value="JPY" Text="JPY-10001-0024-2705" />
                            <telerik:RadComboBoxItem Value="VND" Text="VND-10001-0024-2710" />
                        </Items>
                    </telerik:RadComboBox>
                </td>
            <td> <asp:Label ID="lbCrAccount" runat="server"></asp:Label></td>
            </tr>
        </table>
        <table width="100%" cellpadding="0" cellspacing="0">
            <tr>
                <td class="MyLable">Amount Debited</td>
                <td class="MyContent">
                    <asp:Label ID="lbAmountDebited"
                        runat="server"  />
                </td>
            </tr>
        </table>

           <table width="100%" cellpadding="0" cellspacing="0">
            
            <tr>
                <td class="MyLable">Exchange Rate</td>
                <td class="MyContent">
                    <telerik:RadNumericTextBox ID="tbExchangeRate" runat="server"  NumberFormat-DecimalDigits="0" NumberFormat-DecimalSeparator="," />
                </td>
            </tr>
        </table>
        <table width="100%" cellpadding="0" cellspacing="0">
            <tr>
                <td class="MyLable">Narrative</td>
                <td class="MyContent" style="width:350px; ">
                    <telerik:RadTextBox ID="txtNarrative" Width="350"
                        runat="server"  />
                </td>
                <td><a class="add">
                    <img src="Icons/Sigma/Add_16X16_Standard.png"></a></td>
            </tr>
        </table>
    </div>
    <div id="dvAudit" runat="server">
         <table width="100%" cellpadding="0" cellspacing="0">
            <tr>
                <td class="MyLable">Override</td>
                <td class="MyContent">CREDIT TILL CLOSING BALANCE</td>
            </tr>
                 <tr>
                <td class="MyLable">Override</td>
                <td class="MyContent">Unauthorised overdraft of USD 5028 on account 050001688331</td>
            </tr>
                <tr>
                <td class="MyLable">Record Status</td>
                <td class="MyContent">INAU INPUT Unauthorised</td>
            </tr>
                <tr>
                <td class="MyLable">Current Number</td>
                <td class="MyContent">1</td>
            </tr>
                <tr>
                <td class="MyLable">Inputter</td>
                <td class="MyContent">23_ID0296_I_INAU</td>
            </tr>
              <tr>
                <td class="MyLable">Date Time</td>
                <td class="MyContent">05 JUL 14 16:34</td>
            </tr>

            <tr>
                <td class="MyLable">Authoriser</td>
                <td class="MyContent"></td>
            </tr>
            <tr>
                <td class="MyLable">Company Code</td>
                <td class="MyContent">VN-001-2691</td>
            </tr>
             <tr>
                <td class="MyLable">Department Code</td>
                <td class="MyContent">1</td>
            </tr>
             <tr>
                <td class="MyLable">Auditor Code</td>
                <td class="MyContent"></td>
            </tr>
             <tr>
                <td class="MyLable">Audit Date Time</td>
                <td class="MyContent"></td>
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
                    .addClass('remove')
                    ;
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
    function ValidatorUpdateIsValid() {
        //var i;
        //for (i = 0; i < Page_Validators.length; i++) {
        //    if (!Page_Validators[i].isvalid) {
        //        Page_IsValid = false;
        //        return;
        //    }
        //}
        var teller = $('#<%= txtTellerId.ClientID%>').val();
        var CustomerName = $('#<%= tbCustomerName.ClientID%>').val();
        var Address = $('#<%= tbAddress.ClientID%>').val();
        var PassportNo = $('#<%= tbPassportNo.ClientID%>').val();
        var TCCurrency = $('#<%= cmbTCCurrency.ClientID%>').val();

        Page_IsValid = teller != "" && CustomerName != "" && Address != "" && PassportNo != "" && TCCurrency != "";
    }

    function OnClientButtonClicking(sender, args) {
        ValidatorUpdateIsValid();
        if (Page_IsValid) {
            var button = args.get_item();

            if (button.get_commandName() == "commit" && !clickCalledAfterRadconfirm) {
                args.set_cancel(true);
                lastClickedItem = args.get_item();
                radconfirm("Credit Till Closing Balance", confirmCallbackFunction2);
            }
            if (button.get_commandName() == "authorize" && !clickCalledAfterRadconfirm) {
                radconfirm("Authorised Completed", confirmCallbackFunction2);
            }
        }
    }

    var lastClickedItem = null;
    var clickCalledAfterRadprompt = false;
    var clickCalledAfterRadconfirm = false;

    function confirmCallbackFunction1(args) {
        radconfirm("Unauthorised overdraft of USD on account 050001688331", confirmCallbackFunction2); //" + amtFCYDeposited + "
    }
   
    function confirmCallbackFunction2(args) {
        clickCalledAfterRadconfirm = true;
        lastClickedItem.click();
        lastClickedItem = null;
    }

    function OnClientSelectedIndexChanged() {
        var labelElement = $('#<%= lbCrAccount.ClientID%>');
        labelElement.html("Accounts Pble");

    }

    function OnAmountValueChanged() {
        var TCAmountElement = $find("<%= tbTCAmount.ClientID%>");
        var TCAmount = TCAmountElement.get_value();

        if (TCAmount) {
            var AmountDebitedElement = $('#<%=lbAmountDebited.ClientID%>');
            AmountDebitedElement.html(parseFloat(TCAmount).toFixed(2));
        }
    }
  </script>