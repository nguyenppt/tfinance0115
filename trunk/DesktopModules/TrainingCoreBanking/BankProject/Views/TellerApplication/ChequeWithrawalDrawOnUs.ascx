<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="ChequeWithrawalDrawOnUs.ascx.cs" Inherits="BankProject.Views.TellerApplication.ChequeWithrawalDrawOnUs" %>
<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<%@ Register TagPrefix="dnn" Namespace="DotNetNuke.Web.UI.WebControls" Assembly="DotNetNuke.Web" %>
<%@ Register TagPrefix="dnn" TagName="Label" Src="~/controls/LabelControl.ascx" %>
<telerik:RadWindowManager id="RadWindowManager1" runat="server"  EnableShadow="true" />
<script type="text/javascript">
    jQuery(function ($) {
        $('#tabs-demo').dnnTabs();
    });
</script>

<div>
    <telerik:RadToolBar runat="server" ID="RadToolBar1" EnableRoundedCorners="true" EnableShadows="true" Width="100%"
         OnButtonClick="RadToolBar1_ButtonClick">
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
<div>
    <table width="100%" cellpadding="0" cellspacing="0" >
        <tr>
            <td style="width: 200px; padding: 5px 0 5px 20px;">
                <asp:TextBox ID="tbID" runat="server" ValidationGroup="Group1" />
                <i><asp:Label ID="lblID" runat="server" ></asp:Label></i>
            </td>
        </tr>
    </table>
</div>
<asp:ValidationSummary ID="ValidationSummary1" runat="server"  ShowMessageBox="true" ShowSummary="false" ValidationGroup="Commit" />

<div class="dnnForm" id="tabs-demo">
    <ul class="dnnAdminTabNav">
        <li><a href="# blank1">Cheque Withdrawal</a></li>
    </ul>
    <div id="blank1" class="dnnClear">
        <table width="100%" cellpading="0" cellspacing="0">
            <tr>
                <td class="MyLable">Customer:</td>
                <td class="MyContent" width="90"><asp:Label ID="lblCustomerID" runat="server" /></td>
                <td class="MyContent" ><asp:Label ID="lblCustomerName" runat="server" /></td>
            </tr>
        </table>
        <fieldset>
            <legend></legend>
           <table width="100%" cellpading="0" cellspacing="0">
               <tr>
                   <td class="MyLable">Currency:<span class="Required">(*)</span>
                        <asp:RequiredFieldValidator Runat="server" Display="None" ID="RequiredFieldValidator7"
                     ControlToValidate="rcbCurrency" ValidationGroup="Commit" InitialValue="" 
                    ErrorMessage="Account Customer is required"  ForeColor="Red" />
                   </td>
                   <td class="MyContent">
                        <telerik:RadComboBox ID="rcbCurrency"
                        MarkFirstMatch="True" AppendDataBoundItems="true"
                        AllowCustomText="false" 
                        runat="server" ValidationGroup="Group1" 
                            autopostback="true"
                            OnSelectedIndexChanged ="rcbCurrency_OnSelectedIndexChanged"
                            OnClientSelectedIndexChanged="rcbAccCustomer_OnClientSelectedIndexChanged">
                        <Items>
                            <telerik:RadComboBoxItem Value="" Text="" />
                            
                            <telerik:RadComboBoxItem Value="EUR" Text="EUR" />
                            <telerik:RadComboBoxItem Value="GBP" Text="GBP" />
                            <telerik:RadComboBoxItem Value="JPY" Text="JPY" />
                            <telerik:RadComboBoxItem Value="USD" Text="USD" />
                            <telerik:RadComboBoxItem Value="VND" Text="VND" />
                        </Items>
                    </telerik:RadComboBox>
                   </td>
                   <td class="MyLable"></td>
                   <td class="MyContent"></td>
               </tr>
               <tr>
                   <td class="MyLable">Account Customer:<span class="Required"> (*)</span>
                    <asp:RequiredFieldValidator Runat="server" Display="None" ID="RequiredFieldValidator1"
                     ControlToValidate="rcbAccCustomer" ValidationGroup="Commit" InitialValue="" 
                    ErrorMessage="Account Customer is required"  ForeColor="Red" /></td>
                   <td class="MyContent"  width="350">
                       <telerik:RadComboBox ID="rcbAccCustomer" runat="server" AllowCustomText="false"
                           width="350" MarkFirstMatch="true"
                           AppendDataBoundItems="true" OnClientSelectedIndexChanged="rcbAccCustomer_OnClientSelectedIndexChanged">
                           <CollapseAnimation Type="None" />
                           <ExpandAnimation Type="None" />
                       </telerik:RadComboBox></td>
                   <td>    
                   <a class="add"><img src="Icons/Sigma/Add_16X16_Standard.png" /></a>
                   </td>
                   
               </tr>
               </table>
           <table id="tblAmount" width="100%" cellpading="0" cellspacing="0">
                <tr>
                   <td class="MyLable">Amount Local:</td>
                   <td class="MyContent">
                       <telerik:RadNumericTextBox id="tbAmountLocal" runat="server" validationGroup="Group1"  ClientEvents-OnValueChanged="AmountLocal_OnValueChanged" >
                         
                       </telerik:RadNumericTextBox>
                   </td>
               </tr>
               
                <tr>
                   <td class="MyLable">Old Customer Balance:</td>
                   <td class="MyContent">
                       <asp:label ID="lblOldCustBal" runat="server" ValidationGroup="Group1" />
                   </td>
               </tr>
                <tr>
                   <td class="MyLable">New Customer Balance:</td>
                   <td class="MyContent">
                       <asp:label ID="lblNewCustBal" runat="server" ValidationGroup="Group1" />
                   </td>
               </tr>

                <tr>
                   <td class="MyLable">Cheque Type:<span class="Required">(*)</span>
                       <asp:RequiredFieldValidator Runat="server" Display="None" ID="RequiredFieldValidator2"
                     ControlToValidate="rcbChequeType" ValidationGroup="Commit" InitialValue="" 
                    ErrorMessage="Cheque Type is required"  ForeColor="Red" />
                   </td>
                   <td class="MyContent" width="200">
                       <telerik:RadComboBox ID="rcbChequeType" runat="server"  AllowCustomText="false"
                        MarkFirstMatch="true"  AppendDataBoundItems="true" Width="200">
                        <ExpandAnimation Type="None" />
                        <CollapseAnimation Type="None" />
                        <Items>
                            <telerik:RadComboBoxItem Value="" Text="" />
                             <telerik:RadComboBoxItem Value="CC" Text="CC - Current Accounts CC Series" />
                        </Items>
                    </telerik:RadComboBox>               
                   </td>
                   
               </tr>
                <tr>
                   <td class="MyLable">Cheque No:<span class="Required">(*)</span>
                       <asp:RequiredFieldValidator Runat="server" Display="None" ID="RequiredFieldValidator3"
                     ControlToValidate="tbChequeNo" ValidationGroup="Commit" InitialValue="" 
                    ErrorMessage="Cheque No is required"  ForeColor="Red"  />
                   </td>
                   <td class="MyContent">
                       <telerik:RadTextBox ID="tbChequeNo" runat="server" ValidationGroup="Group1" width="200"/>
                   </td>
                   <td class="MyLable"><a class="add"><img src="Icons/Sigma/Add_16X16_Standard.png" /></a></td>
                   <td class="MyContent"></td>
               </tr>
           </table>
        </fieldset>
        <fieldset>
            <legend></legend>
            <table width="100%" cellpading="0" cellspacing="0">
                <tr>
                   <td class="MyLable">Teller ID:<span class="Required">(*)</span>
                       <asp:RequiredFieldValidator Runat="server" Display="None" ID="RequiredFieldValidator4"
                     ControlToValidate="tbTellerID" ValidationGroup="Commit" InitialValue="" 
                    ErrorMessage="Teller ID is required"  ForeColor="Red" />
                   </td>
                   <td class="MyContent">
                       <telerik:RadTextBox ID="tbTellerID" runat="server" ValidationGroup="Group1" />
                   </td>
                   <td class="MyLable"></td>
                   <td class="MyContent"></td>
               </tr>
                <tr>
                   <td class="MyLable">Currency Paid:<span class="Required">(*)</span>
                       <asp:RequiredFieldValidator Runat="server" Display="None" ID="RequiredFieldValidator5"
                     ControlToValidate="rcbCurrencyPaid" ValidationGroup="Commit" InitialValue="" 
                    ErrorMessage="Currency Paid is required"  ForeColor="Red" />
                   </td>
                   <td class="MyContent">
                       <telerik:RadComboBox ID="rcbCurrencyPaid" runat="server" AllowCustomText="false"
                        MarkFirstMatch="true"  AppendDataBoundItems="true" OnClientSelectedIndexChanged="OnMatchCurrencyValue" >
                        <ExpandAnimation Type="None" />
                        <CollapseAnimation Type="None" />
                        <Items>
                            <telerik:RadComboBoxItem Value="" Text="" />
                            <telerik:RadComboBoxItem Value="EUR" Text="EUR" />
                            <telerik:RadComboBoxItem Value="GBP" Text="GBP" />
                            <telerik:RadComboBoxItem Value="JPY" Text="JPY" />
                            <telerik:RadComboBoxItem Value="USD" Text="USD" />
                            <telerik:RadComboBoxItem Value="VND" Text="VND" />
                        </Items>
                    </telerik:RadComboBox>                                     
                   </td>
                   <td class="MyLable"></td>
                   <td class="MyContent"></td>
               </tr>
                <tr>
                   <td class="MyLable">Account Paid: <span class="Required">(*)</span>
                       <asp:RequiredFieldValidator Runat="server" Display="None" ID="RequiredFieldValidator6"
                     ControlToValidate="rcbAccountPaid" ValidationGroup="Commit" InitialValue="" 
                    ErrorMessage="Currency Paid is required"  ForeColor="Red" />
                   </td>
                   <td class="MyContent">
                       <telerik:RadComboBox ID="rcbAccountPaid" runat="server" AllowCustomText="false"
                        MarkFirstMatch="true"  AppendDataBoundItems="true" width="350" OnClientSelectedIndexChanged="OnMatchCurrencyValue">
                        <ExpandAnimation Type="None" />
                        <CollapseAnimation Type="None" />
                        <Items>
                            <telerik:RadComboBoxItem Value="" Text="" />
                            <telerik:RadComboBoxItem Value="EUR" Text="EUR-10001-0695-1221 - RECORD AUD" />
                            <telerik:RadComboBoxItem Value="GBP" Text="GBP-10001-0695-1222 - RECORD AUD" />
                            <telerik:RadComboBoxItem Value="JPY" Text="JPY-10001-0695-1223 - RECORD AUD" />
                            <telerik:RadComboBoxItem Value="USD" Text="USD-10001-0695-1224 - RECORD AUD" />
                            <telerik:RadComboBoxItem Value="VND" Text="VND-10001-0695-1225 - RECORD AUD" />
                        </Items>
                    </telerik:RadComboBox>                                     
                   </td>
                   <td class="MyContent">
                       <asp:label ID="lblAccountPaidNote" runat="server" />
                   </td>
                   <td class="MyContent"></td>
               </tr>
                <tr>
                   <td class="MyLable">Deal Rate:</td>
                   <td class="MyContent">
                       <telerik:RadTextBox ID="tbDealRate" runat="server" ValidationGroup="Group1" ClientEvents-OnValueChanged="AmountLocal_OnValueChanged">
                          
                       </telerik:RadTextBox>
                   </td>
                   <td class="MyLable"></td>
                   <td class="MyContent"></td>
               </tr>
                <tr>
                   <td class="MyLable">Amt Paid to Cust:</td>
                   <td class="MyContent">
                       <asp:label ID="lblAmtPaidToCust" runat="server" ValidationGroup="Group1" />
                      
                   </td>
                   <td class="MyLable"></td>
                   <td class="MyContent"></td>
               </tr>
                <tr>
                   <td class="MyLable">Waive Charges:</td>
                   <td class="MyContent">
                        <telerik:RadComboBox ID="rcbWaiveCharges" runat="server" AllowCustomText="false"
                        MarkFirstMatch="true"  AppendDataBoundItems="true" >
                        <ExpandAnimation Type="None" />
                        <CollapseAnimation Type="None" />
                        <Items>
                            <telerik:RadComboBoxItem Value="YES" Text="YES" />
                            <telerik:RadComboBoxItem Value="NO" Text="NO" />
                        </Items>
                    </telerik:RadComboBox>    
                   </td>
                   <td class="MyLable"></td>
                   <td class="MyContent"></td>
               </tr>
                <tr>
                   <td class="MyLable">Narrative:</td>
                   <td class="MyContent" width="350">
                       <telerik:RadTextBox ID="tbNarrative" runat="server" ValidationGroup="Group1" 
                           Text="" width="350"/>
                   </td>
                   <td class="MyLable"><a class="add"><img src="Icons/Sigma/Add_16X16_Standard.png" /></a></td>
                   
               </tr>
           </table>
        </fieldset>
        <fieldset>
            <legend style="font-weight:bold; text-transform:uppercase;">Beneficiary Information</legend>
            <table width="100%" cellpading="0" cellspacing="0">
                <tr>
                   <td class="MyLable">Beneficiary Name:</td>
                   <td class="MyContent">
                       <telerik:RadTextBox ID="tbBeneName" runat="server" ClientEvents-OnValueChanged="FillNarrative" ValidationGroup="Group1" Width="350" />
                   </td>
                   <td class="MyLable"></td>
                   <td class="MyContent"></td>
               </tr>
                <tr>
                   <td class="MyLable">Address:</td>
                   <td class="MyContent">
                        <telerik:RadTextBox ID="tbAddress" runat="server" ClientEvents-OnValueChanged="FillNarrative" ValidationGroup="Group1" Width="350" />
                   </td>
                   
               </tr>
                <tr>
                   <td class="MyLable">Legal ID:</td>
                   <td class="MyContent">
                        <telerik:RadTextBox ID="tbLegalID" runat="server" ClientEvents-OnValueChanged="FillNarrative" ValidationGroup="Group1" Width="350" />
                   </td>
                   <td class="MyLable"></td>
                   <td class="MyContent"></td>
               </tr>
                <tr>
                   <td class="MyLable">Issued Date:</td>
                   <td class="MyContent">
                       <telerik:RadDatePicker ID="rdpIssDate" runat="server" ClientEvents-OnDateSelected="FillNarrative" validationGroup="Group1" >
                           <DateInput DateFormat="dd/MM/yyyy" runat="server"> 
            </DateInput> 
                       </telerik:RadDatePicker>
                   </td>
                   <td class="MyLable">Place of Iss:</td>
                   <td class="MyContent">
                       <telerik:RadTextBox ID="tbPlaceOfIss" runat="server" ClientEvents-OnValueChanged="FillNarrative" ValidationGroup="Group1" />
                   </td>
               </tr>
                </table>
        </fieldset>
    </div>
</div>
    <telerik:radcodeblock runat="server">
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

    ////khai bao bien de lay ten khach hang ////

    function rcbAccCustomer_OnClientSelectedIndexChanged() {
        var AcctCustomerElement = $find("<%=rcbAccCustomer.ClientID%>");
        var AcctCustomer = AcctCustomerElement.get_value();
        var CustomerIDElement = $('#<%=lblCustomerID.ClientID%>');
        var CustomerNameElement = $('#<%=lblCustomerName.ClientID%>');
        var CurrencyElement = $find("<%=rcbCurrency.ClientID%>");
        var CurrencyValue = CurrencyElement.get_value();
        var OldCustBalElement = $('#<%=lblOldCustBal.ClientID%>');
        var NewCustBalElement = $('#<%=lblNewCustBal.ClientID%>');
            NewCustBalElement.html("");
        var AmtPaidtoCustElement = $('#<%=lblAmtPaidToCust.ClientID%>');
        var AmtLocalElement = $find("<%=tbAmountLocal.ClientID%>");
        if (CurrencyValue.length != 0) {
            if (AcctCustomer.length == 0 || !AcctCustomer.trim()) {
                CustomerIDElement.html("");
                CustomerNameElement.html("");
                OldCustBalElement.html("");
                NewCustBalElement.html("");
                AmtPaidtoCustElement.html("");
                AmtLocalElement.set_value("");
                
            }
            else {
                switch (AcctCustomer) {
                    case "0":
                        CustomerIDElement.html("1100002");
                        CustomerNameElement.html("DINH TIEN HOANG");
                        break;
                    case "1":
                        CustomerIDElement.html("1100004");
                        CustomerNameElement.html("VO THI SAU");
                        break;
                    case "2":
                        CustomerIDElement.html("2102927");
                        CustomerNameElement.html("PLC Corp");
                        break;
                    case "3":
                        CustomerIDElement.html("2102929");
                        CustomerNameElement.html("VIETVICTORY Corp");
                        break;
                    case "":
                        CustomerIDElement.html("");
                        CustomerNameElement.html("");
                        OldCustBalElement.html("");
                        NewCustBalElement.html("");
                        AmtPaidtoCustElement.html("");
                        AmtLocalElement.set_value("");
                }
                var OldCustBalElement = $('#<%=lblOldCustBal.ClientID%>');
                var OldCustBal = getOldCustBalance();
                OldCustBalElement.html(OldCustBal.toLocaleString("en-US"));
            }
        } else
        {
            CustomerIDElement.html("");
            CustomerNameElement.html("");
            OldCustBalElement.html("");
            NewCustBalElement.html("");
            AmtPaidtoCustElement.html("");
            AmtLocalElement.set_value("");
        }
    }

    function getOldCustBalance() {
        var CurrencyElement = $find("<%=rcbCurrency.ClientID%>");
        var Currency = CurrencyElement.get_value();
        var OldCustBal = 0;
       
        var AccountCustomerElement= $find("<%=rcbAccCustomer.ClientID%>");
        var AcountCustomer = AccountCustomerElement.get_value();
        if (AcountCustomer && Currency) {
            switch (Currency) {
                case "VND":
                    OldCustBal = 1565000000;
                    return OldCustBal;
                    break;
                case "":
                    OldCustBal = "";
                    return OldCustBal;
                    break;
                default:
                    OldCustBal = 50000;
                    return OldCustBal;
                    break;
            }
        } else return OldCustBal="";
        //if (Currency == "VND") { OldCustBal = 1565000000; }
        //else OldCustBal = 50000;
        //return OldCustBal;
    }
    //window.onload = function focus() {
    //    document.getElementById("tbAmountLocal").focus();
    
    ////// tinh lai gia tri moi cho tai khoan New Cust Balance va chuyen doi tien te /////
    function AmountLocal_OnValueChanged(sender, args) {
        var AmountLocalElement = $find("<%= tbAmountLocal.ClientID%>");
        var AmountLocal = AmountLocalElement.get_value();

        var OldCustBalanceElement = $('#<%=lblOldCustBal.ClientID%>');
        var OldCustBalance = getOldCustBalance();
        var NewCustBalanceElement = $('#<%=lblNewCustBal.ClientID%>');
        var CurrencyPaidElement = $find("<%=rcbCurrencyPaid.ClientID%>");
        var CurrencyPaidValue = CurrencyPaidElement.get_value();
        var AmtPaidToCust = $('#<%=lblAmtPaidToCust.ClientID%>');
        var AccountPaidElement = $find("<%=rcbAccountPaid.ClientID%>");
        var AccountPaid = AccountPaidElement.get_value();

        var AcctCustomerElement = $find("<%=rcbAccCustomer.ClientID%>");// lay gia tri AcctCustomer,CurrencyValue de check, phong truong hop client chua chon 
        var AcctCustomer = AcctCustomerElement.get_value();             // ma nhap gia tri cho Amount Local
        var CurrencyElement = $find("<%=rcbCurrency.ClientID%>");
        var CurrencyValue = CurrencyElement.get_value();
        if (AcctCustomer && CurrencyValue) {
            if ((AmountLocal) && (OldCustBalance < AmountLocal)) {
                ShowMessage();
                AmountLocalElement.set_value("");
            }
            else {
                var dealrate = 0;
                dealrate = getDealRate();
                if (!AmountLocal) { AmountLocal = 0; }
                if (CurrencyPaidValue && AccountPaid) {
                    AmtPaidToCust.html((dealrate * AmountLocal).toLocaleString("en-US"));
                }
                //switch (CurrencyPaidValue) {
                //    case "":
                //        AmtPaidToCust.html("");
                //        break;
                //    default:
                //        AmtPaidToCust.html((dealrate * AmountLocal).toLocaleString("en-IN"));
                //}
                NewCustBalanceElement.html((OldCustBalance - AmountLocal).toLocaleString("en-US"));
            }
        }
        else
        {
            radconfirm("Check Currency, Account Customer and Amount Local again.", confirmCallbackFunction2);
        }
    }
    ////////// lay gia tri deal rate ///////////////
    function getDealRate() {
        var dealrateElement = $find("<%=tbDealRate.ClientID%>");
        var dealrateValue = dealrateElement.get_value();
        var CurrencyElement = $find("<%=rcbCurrency.ClientID%>");
        var CurrencyValue = CurrencyElement.get_value();
        var CurrencyPaidElement = $find("<%=rcbCurrencyPaid.ClientID%>");
        var CurrencyPaidValue = CurrencyPaidElement.get_value();

        if (dealrateValue == null || CurrencyValue == CurrencyPaidValue)
        { dealrateValue = 1; }
        return dealrateValue;
    }
    function OnMatchCurrencyValue(e) {
        var CurrencyPaidElement = $find("<%=rcbCurrencyPaid.ClientID%>");
        var CurrencyPaidValue = CurrencyPaidElement.get_value();
        var AccountPaidElement = $find("<%=rcbAccountPaid.ClientID%>");
        var AccountPaid = AccountPaidElement.get_value();
        var AmtPaidtoCustomerElement = $('#<%=lblAmtPaidToCust.ClientID%>');
        var CurrencyElement = $find("<%=rcbCurrency.ClientID%>");
        var CurrencyValue = CurrencyElement.get_value();
        
        if (!CurrencyPaidValue || !AccountPaid) { AmtPaidtoCustomerElement.html(""); }

        if (CurrencyPaidValue && AccountPaid && (CurrencyPaidValue != AccountPaid)) {
            radconfirm("Account Paid And Currency Paid are not matched !", confirmCallbackFunction3);
            //alert("Account Paid And Currency Paid are not matched !");
            CurrencyPaidElement.trackChanges();
            CurrencyPaidElement.get_items().getItem(0).select();
            CurrencyPaidElement.updateClientState();
            CurrencyPaidElement.commitChanges();


            AccountPaidElement.trackChanges();
            AccountPaidElement.get_items().getItem(0).select();
            AccountPaidElement.updateClientState();
            AccountPaidElement.commitChanges();
            return false;
        } 
    

        ////////// tinh gia tri account paid khi deal rate khong duoc nhap va bang 1
        var LocalAmtElement = $find("<%=tbAmountLocal.ClientID%>");
        var dealrateElement = $find("<%=tbDealRate.ClientID%>");
        var dealrate = dealrateElement.get_value();
        if (CurrencyPaidValue && AccountPaid) {
            if (CurrencyPaidValue == CurrencyValue) { dealrate = 1; }
            var LocalAmt = LocalAmtElement.get_value();
            AmtPaidtoCustomerElement.html((LocalAmt * dealrate).toLocaleString("en-US"));
        }
        else AmtPaidtoCustomerElement.html("");

        //if (CurrencyPaidValue && CurrencyValue && (CurrencyValue == CurrencyPaidValue)) { dealrate = 1; } else
        
           
        //    var LocalAmt = LocalAmtElement.get_value();
        //        AmtPaidtoCustomerElement.html((LocalAmt * dealrate).toLocaleString("en-IN"));
        
        showLabelAutoRecord();
        return true;
    }
    function showLabelAutoRecord() {
        var AccountPaidElement = $find("<%=rcbAccountPaid.ClientID%>");
        var AccountPaid = AccountPaidElement.get_value();
        var AutoRecordElement = $('#<%=lblAccountPaidNote.ClientID%>');
        if (AccountPaid) { AutoRecordElement.html("RECORD.AUTOMATICALLY.OPENED"); }
        else { AutoRecordElement.html(""); }
    }

    function ShowMessage() {
        var OldCustBallance = getOldCustBalance();
        var CurrencyElement = $find("<%=rcbCurrency.ClientID%>");
        var Currency = CurrencyElement.get_value();
        radconfirm("Can't overdraft. Maximum Amount Local is " + OldCustBallance.toLocaleString("en-US") + " " + Currency.toLocaleString("en-US"), confirmCallbackFunction2);
    }
    var lastClickedItem = null;
    var clickCalledAfterRadprompt = false;
    var clickCalledAfterRadconfirm = false;


    function confirmCallbackFunction2(args) {
        clickCalledAfterRadconfirm = true;
        if (lastClickedItem != null) {
            lastClickedItem.click();
            lastClickedItem = null;
        }

        //Dat sau khi da hoan thanh confirm xong thi moi set focus duoc o text box local Amount
        var LocalAmtElement = $find("<%=tbAmountLocal.ClientID%>");
        LocalAmtElement.focus();
        LocalAmtElement.set_value("");
    }
    function confirmCallbackFunction3(args) {  //// Confirm nay de phuc vu cho viec thay doi Currency paid va Account Paid, nhung khong xoa gia tri 
        clickCalledAfterRadconfirm = true;      /// Amount Local da nhap o tren
        if (lastClickedItem != null)
        {
            lastClickedItem.click();
            lastClickedItem = null;
        }
    }

    function FillNarrative() {
        var tbBeneName = $find("<%=tbBeneName.ClientID%>");
        var tbAddress = $find("<%=tbAddress.ClientID%>");
        var tbLegalID = $find("<%=tbLegalID.ClientID%>");
        var rdpIssDate = $find("<%=rdpIssDate.ClientID%>");
        var tbPlaceOfIss = $find("<%=tbPlaceOfIss.ClientID%>");

        var rcbAccCustomer = $find("<%=rcbAccCustomer.ClientID%>");
        var rcbChequeType = $find("<%=rcbChequeType.ClientID%>");
        var tbChequeNo = $find("<%=tbChequeNo.ClientID%>");

        var strNarr = "RUT SEC TM " + rcbChequeType.get_value() + ": " + tbChequeNo.get_value() + " TK " + rcbAccCustomer.get_text() + " NN: ";

        if (tbBeneName.get_value()) {
            strNarr += tbBeneName.get_value();
        }

        if (tbLegalID.get_value()) {
            strNarr += " - " + tbLegalID.get_value();
        }

        if (rdpIssDate.get_selectedDate() != null && rdpIssDate.get_selectedDate() != "") {
            strNarr += " - " + rdpIssDate.get_selectedDate().toLocaleString("en-US");
        }

        if (tbPlaceOfIss.get_value()) {
            strNarr += " - " + tbPlaceOfIss.get_value();
        }

        if (tbAddress.get_value()) {
            strNarr += " - " + tbAddress.get_value();
        }
        $find("<%=tbNarrative.ClientID%>").set_value(strNarr);
    }
   
</script>
    </telerik:radcodeblock>

<telerik:RadAjaxManager ID="RadAjaxManager1" runat="server" 
    DefaultLoadingPanelID="AjaxLoadingPanel1" >
    <AjaxSettings>

        <telerik:AjaxSetting AjaxControlID="rcbCurrency">
            <UpdatedControls>
                 <telerik:AjaxUpdatedControl ControlID="rcbAccCustomer" />
            </UpdatedControls>
        </telerik:AjaxSetting> 
    </AjaxSettings>
</telerik:RadAjaxManager>

<telerik:RadInputManager ID="RadInputManager1" runat="server">
        <telerik:DateInputSetting BehaviorID="DateInputBehavior2" DateFormat="dd MMM yyyy">
            <TargetControls>
                <telerik:TargetInput ControlID="rdpIssDate"></telerik:TargetInput>
            </TargetControls>
        </telerik:DateInputSetting>
    </telerik:RadInputManager>
