<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="CashWithdrawalsBuying.ascx.cs" Inherits="BankProject.Views.TellerApplication.CashWithdrawalsBuying" %>
<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
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
        <li><a href="#ChristopherColumbus">Cash Withdrawals</a></li>
        <li><a href="#blank">Audit</a></li>
        <li><a href="#blank">Full View</a></li>
    </ul>
    <div id="ChristopherColumbus" class="dnnClear">
        <table width="100%" cellpadding="0" cellspacing="0">
            <tr>
                <td class="MyLable">Customer</td>
                <td class="MyContent" style="width:100px;"><asp:Label ID="lbCustomer"  Width="100" runat="server"></asp:Label></td>
                <td class="MyContent" ><asp:Label ID="lbCustomerName" runat="server"></asp:Label></td>
            </tr>
        </table>

        <hr />
         
        <table width="100%" cellpadding="0" cellspacing="0">
            <tr>
                <td class="MyLable">Currency</td>
                <td class="MyContent"><asp:Label ID="lbCurrency" runat="server"></asp:Label></td>
            </tr>
        </table>
        <table width="100%" cellpadding="0" cellspacing="0">
            <tr>
                <td class="MyLable">Account Customer
                <span class="Required">(*)</span>
                    </td>
                <td class="MyContent">
                    <telerik:RadComboBox ID="cmbCustomerAccount"
                        MarkFirstMatch="True"
                        AllowCustomText="false"
                        OnClientSelectedIndexChanged="cmbCustomerAccount_OnClientSelectedIndexChanged"
                        runat="server"           width="300"             >
                        <Items>
                            <telerik:RadComboBoxItem Value="" Text="" />
                            <telerik:RadComboBoxItem Value="0" Text="03.000045632.1 - BANK OF SHANGHAI" />
                            <telerik:RadComboBoxItem Value="1" Text="03.000068528.1 - CITI BANK NEWYORK" />
                            <telerik:RadComboBoxItem Value="2" Text="03.000078945.1 - HSBC" />
                        </Items>
                    </telerik:RadComboBox>
                    
                </td>
                <td><asp:RequiredFieldValidator
                        runat="server" Display="None"
                        ID="RequiredFieldValidator8"
                        ControlToValidate="cmbCustomerAccount"
                        ValidationGroup="Commit"
                        InitialValue=""
                        ErrorMessage="Customer Account is Required" ForeColor="Red">
                    </asp:RequiredFieldValidator></td>
            </tr>
        </table>
           <table width="100%" cellpadding="0" cellspacing="0">
            <tr>
                <td class="MyLable">Amt LCY</td>
                <td class="MyContent">
                    <telerik:RadNumericTextBox ID="txtAmtLCY" runat="server" NumberFormat-GroupSeparator=","  NumberFormat-DecimalDigits="0"/>
                     <span>Exchange Rate: 20,000</span>
                </td>
            </tr>
            <tr>
                <td class="MyLable">Amt FCY</td>
                <td class="MyContent">
                    <telerik:RadNumericTextBox ID="txtAmtFCY" runat="server" ClientEvents-OnValueChanged ="OnAmtLCYDepositedChanged"/>
                </td>
            </tr>
            <tr>
                <td class="MyLable">Next Trans Com</td>
                <td class="MyContent">
                    <asp:Label ID="lbNextTransCom" runat="server"></asp:Label>
                </td>
            </tr>
        </table>
       
        <table width="100%" cellpadding="0" cellspacing="0">
            <tr>
                <td class="MyLable">Currency Paid
                <span class="Required">(*)</span>
                    </td>
                <td class="MyContent">
                    <telerik:RadComboBox ID="cmbCurrencyPaid"
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
                <td><asp:RequiredFieldValidator
                        runat="server" Display="None"
                        ID="RequiredFieldValidator1"
                        ControlToValidate="cmbCurrencyPaid"
                        ValidationGroup="Commit"
                        InitialValue=""
                        ErrorMessage="Currency Paid is Required" ForeColor="Red">
                    </asp:RequiredFieldValidator></td>
            </tr>
            <tr>
                <td class="MyLable">Deal Rate</td>
                <td class="MyContent">
                    <telerik:RadNumericTextBox ID="txtDealRate" runat="server" NumberFormat-DecimalDigits="5" ClientEvents-OnValueChanged="OnAmtLCYDepositedChanged" />
                </td>
            </tr>
            <tr>
                <td class="MyLable">Amt Paid to Cust</td>
                <td class="MyContent">
                    <telerik:RadNumericTextBox ID="lblAmtPaidToCust" ReadOnly="true" TabIndex="0" runat="server"  NumberFormat-DecimalDigits="2" />
                </td>
            </tr>

            <tr>
                <td class="MyLable">New Cust Bal</td>
                <td class="MyContent">
                    <telerik:RadNumericTextBox ID="lblNewCustBal" ReadOnly="true" TabIndex="0" runat="server" NumberFormat-DecimalDigits="2" />
                </td>
            </tr>
        </table>
        <hr />
        <table width="100%" cellpadding="0" cellspacing="0">
            <tr>
                <td class="MyLable">Teller ID <span class="Required">(*)</span>
                    <asp:RequiredFieldValidator
                        runat="server" Display="None"
                        ID="RequiredFieldValidator6"
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
       <table width="100%" cellpadding="0" cellspacing="0">
            <tr>
                <td class="MyLable">
                Waive Charges
                <td class="MyContent">
                    <telerik:RadComboBox ID="cmbWaiveCharges"
                        MarkFirstMatch="True"
                        AllowCustomText="false"
                        runat="server">
                        <Items>
                            <telerik:RadComboBoxItem Value="" Text="" />
                            <telerik:RadComboBoxItem Value="YES" Text="YES" />
                            <telerik:RadComboBoxItem Value="NO" Text="NO" />
                        </Items>
                    </telerik:RadComboBox>
                </td>
            </tr>
        </table>

        <table width="100%" cellpadding="0" cellspacing="0">
            <tr>
                <td class="MyLable">Narrative</td>
                <td class="MyContent" width="300">
                    <telerik:RadTextBox ID="txtNarrative" Width="300"
                        runat="server"  />
                </td>
                <td><a class="add">
                    <img src="Icons/Sigma/Add_16X16_Standard.png"></a></td>
            </tr>
        </table>
    </div>
    <div id="dvAudit" runat="server">
        <hr />

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

    function cmbCustomerAccount_OnClientSelectedIndexChanged(sender, eventArgs) {
        //sender.set_text("You selected " + item.get_text());
        var customeridElement = $find("<%= cmbCustomerAccount.ClientID%>");
        var customerid = customeridElement.get_value();
        var customer = "";
        if (customerid == "0") { customer = "16123";}
        if (customerid == "1") { customer = "16548"; }
        if (customerid == "2") { customer = "17125"; }
        $('#<%=lbCustomer.ClientID%>').html(customer);
        $('#<%=lbCustomerName.ClientID%>').html(customeridElement.get_text().split(" - ")[1]);
        $('#<%=lbCurrency.ClientID%>').html("USD");
        var TellerId = $('#<%=txtTellerId.ClientID%>');
        TellerId.html("0296");
        
    }

    function ValidatorUpdateIsValid() {
        var CustomerAccount = $('#<%= cmbCustomerAccount.ClientID%>').val();
        var TellerId = $('#<%= txtTellerId.ClientID%>').val();
        var CurrencyPaid = $('#<%= cmbCurrencyPaid.ClientID%>').val();

        Page_IsValid = CustomerAccount != "" && TellerId != "" && CurrencyPaid != "";
    }

    function OnClientButtonClicking(sender, args) {
        var button = args.get_item();
        if (button.get_commandName() == "commit" && !clickCalledAfterRadconfirm) {
            ValidatorUpdateIsValid();
            if (Page_IsValid) {
                args.set_cancel(true);
                lastClickedItem = args.get_item();
                radconfirm("Credit Till Closing Balance", confirmCallbackFunction1);
                Page_IsValid = true;
            }
        }

        if (button.get_commandName() == "authorize" && !clickCalledAfterRadconfirm) {
            radconfirm("Authorised Completed", confirmCallbackFunction2);
        }

        if (button.get_commandName() == "Preview") {
            window.location = "Default.aspx?tabid=150&ctl=chitiet&mid=779";
        }
    }

    var lastClickedItem = null;
    var clickCalledAfterRadprompt = false;
    var clickCalledAfterRadconfirm = false;

    function confirmCallbackFunction1(args) {
        clickCalledAfterRadconfirm = false;
        var amtFCYDepositedElement = $find("<%= txtAmtFCY.ClientID%>");
        var amtFCYDeposited = amtFCYDepositedElement.get_value();
        radconfirm("Unauthorised overdraft of USD " + amtFCYDeposited + " on account 050001688331", confirmCallbackFunction2); //" + amtFCYDeposited + "
    }
   
    function confirmCallbackFunction2(args) {
        clickCalledAfterRadconfirm = true;
        lastClickedItem.click();
        lastClickedItem = null;
    }
    
    function OnAmtLCYDepositedChanged() {
        var amtFCYDepositedElement = $find("<%= txtAmtFCY.ClientID%>");
        var amtFCYDeposited = amtFCYDepositedElement.get_value();
        var amtLCYDepositedElement = $find("<%= txtAmtLCY.ClientID %>");
        var DealRateElement = $find("<%= txtDealRate.ClientID%>");

        var newCustBalElement = $find("<%=lblNewCustBal.ClientID%>");
        var nAmtPaidToCustElement = $find("<%=lblAmtPaidToCust.ClientID%>");

        if (amtFCYDeposited) {
            amtLCYDepositedElement.set_value(amtFCYDeposited * 20000);
            var dealrate = 1;
            if (DealRateElement.get_value() != 0) {
                dealrate = DealRateElement.get_value();
            } 
            newCustBalElement.set_value(-1 * dealrate * amtFCYDeposited);
            nAmtPaidToCustElement.set_value(dealrate * amtFCYDeposited);
        }
    }
  </script>