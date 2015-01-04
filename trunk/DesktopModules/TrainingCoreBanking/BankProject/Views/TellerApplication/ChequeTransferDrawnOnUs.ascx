<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="ChequeTransferDrawnOnUs.ascx.cs" Inherits="BankProject.Views.TellerApplication.ChequeTransferDrawnOnUs" %>
<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<%@ Register TagPrefix="dnn" Namespace="DotNetNuke.Web.UI.WebControls" Assembly="DotNetNuke.Web" %>
<%@ Register TagPrefix="dnn" TagName="Label" Src="~/controls/LabelControl.ascx" %>
<telerik:RadWindowManager id="RadWindowManager1" runat="server"  EnableShadow="true" />
<asp:ValidationSummary ID="ValidationSummary" ValidationGroup="Commit" runat="server" ShowMessageBox="true" ShowSummary="false" />

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
<div>
<table width="100%" cellpadding="0" cellspacing="0">
    <tr>
        <td style="width: 200px; padding: 5px 0 5px 20px;">
            <asp:TextBox ID="tbID" runat="server" Width="200"/> </td>
        <td> <i> <asp:Label ID="lblCheqTransWithdrawn" runat="server" /></i></td>
    </tr>
</table>
</div>
<div id="tabs-demo" class="dnnForm"> 
    <ul class="dnnAdminTabNav">
        <li><a href="#Main">Cheque Transfer Withdrawal</a></li>
        <li><a href="#blank">Audit</a></li>
        <li><a href="#blank">Full View</a></li>
    </ul>
    <div id="Main" class="dnnClear">
        <fieldset>
            <legend style="text-transform:uppercase; font-weight:bold;">Debit Information </legend>
            
            <table width="100%" cellpadding="0" cellspacing="0">
                <tr>
                    <td class="MyLable">Debit Customer:</td>
                    <td class="MyContent" width="90px"><asp:Label ID="lblCustomerID" runat="server" /></td>
                    <td>
                    <asp:Label ID="lblCustomerName" runat="server" /></td>
                </tr>
               </table>
                <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                <ContentTemplate>
            <table width="100%" cellpadding="0" cellspacing="0">
                <tr>
                    <td class="MyLable">Debit Currency:</td>
                    
                  <td class="MyContent">
                    <telerik:RadComboBox ID="rcbDebitCurrency" 
                        AppendDataBoundItems="true" 
                        Width="150"
                        AutoPostBack="true"
                        OnSelectedIndexChanged="rcbDebitCurrency_SelectedIndexChanged"
                         OnClientSelectedIndexChanged="OnIndexChanged_rcbDebitAccount_DebitCurrency"
                        MarkFirstMatch="True" AllowCustomText="false" runat="server" ValidationGroup="Group1">
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
                </tr>
            </table>
            <table width="100%" cellpadding="0" cellspacing="0">
            <tr>
                <td class="MyLable">Debit Account:<span class="Required"> (*)</span>
                    <asp:RequiredFieldValidator Runat="server" Display="None" ID="RequiredFieldValidator1"
                     ControlToValidate="rcbDebitAccount" ValidationGroup="Commit" InitialValue="" ErrorMessage="Debit Account is required"
                    ForeColor="Red"></asp:RequiredFieldValidator> 
                </td>
                <td class="MyContent" width="400px">
                    <telerik:RadComboBox ID="rcbDebitAccount" 
                        MarkFirstMatch="True"
                        OnItemDataBound="rcbDebitAccount_ItemDataBound"
                        OnSelectedIndexChanged="rcbDebitAccount_SelectedIndexChanged"
                        OnClientSelectedIndexChanged="OnIndexChanged_rcbDebitAccount_DebitCurrency"
                        AutoPostBack="true"
                        AllowCustomText="false" width="400" 
                        runat="server" ValidationGroup="Group1">
                       
                    </telerik:RadComboBox>
                </td>
                <td><a class="add"><img src="Icons/Sigma/Add_16X16_Standard.png"></a></td>
            </tr>
        </table>
                </ContentTemplate>
                </asp:UpdatePanel>
            <table width="100%" cellpadding="0" cellspacing="0">
            <tr>
                <td class="MyLable">Debit Amount:</td>
                <td class="MyContent" >
                    <telerik:RadNumericTextBox ID="tbDebitAmountLCY" runat="server" Width="150"  NumberFormat-DecimalDigits="2"
                        ValidationGroup="Group1" ClientEvents-OnValueChanged="tbDebitAmountLCY_ClientEventsOnValueChanged"></telerik:RadNumericTextBox>
                </td>
            </tr>
            <tr>
                <td class="MyLable">Cheque Type:<span class="Required">(*)</span> 
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" Display="None" 
                     ControlToValidate="rcbChequeType" ValidationGroup="Commit" InitialValue="" ErrorMessage="Cheque Type is required"
                    ForeColor="Red" />
                </td>
                <td class="MyContent">
                    <telerik:RadComboBox ID="rcbChequeType"
                        MarkFirstMatch="True" AppendDataBoundItems="true"
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
                <td class="MyLable">Cheque No:</td>
                <td class="MyContent" width="250">
                    <telerik:RadNumericTextBox ID="tbChequeNo" Width="250" runat="server" ValidationGroup="Group1" NumberFormat-DecimalDigits="0" NumberFormat-GroupSeparator=""/>
                </td>
                <td><a class="add"> <img src="Icons/Sigma/Add_16X16_Standard.png"></a></td>
            </tr>
        </table>
             <table width="100%" cellpadding="0" cellspacing="0">
             <tr>
                <td class="MyLable">Old Customer Balance:</td>
                <td class="MyContent"><asp:Label ID="lblOldCustBal" runat="server" /></td>
            </tr>
            <tr>
                <td class="MyLable">New Customer Balance:</td>
                <td class="MyContent"><asp:Label ID="lblNewCustBal" runat="server" /></td>
            </tr>
            <tr>
                <td class="MyLable">Value Date:</td>
                <td class="MyContent" >
                    <telerik:RadDatePicker ID="rdpValueDate" runat="server" Width="150" />
                </td>
            </tr>
        </table>
        </fieldset>
        <fieldset>
            <legend style="font-weight:bold; text-transform:uppercase">Credit Information</legend>
            <asp:UpdatePanel ID="UpdatePanel2" runat="server">
                <ContentTemplate>

        <table width="100%" cellpadding="0" cellspacing="0">
            <tr>
                <td class="MyLable">Credit Customer:</td>
                <td ><asp:Label ID="lblCreditCustomerID" runat="server" /></td>
                <td width="350">
                    <asp:Label ID="lblCreditCustomerName" runat="server" ></asp:Label></td>
            </tr>
            <tr>
                <td class="MyLable">Credit Currency:</td>
                <td class="MyContent">
                    <telerik:RadComboBox ID="rcbCreditCurrency" AppendDataBoundItems="true"
                        MarkFirstMatch="True" width="150"
                        AllowCustomText="false" 
                        AutoPostBack="true"
                        OnSelectedIndexChanged="rcbCreditCurrency_SelectedIndexChanged"
                        OnClientSelectedIndexChanged="OnMatchCurrencyValue"
                        runat="server" ValidationGroup="Group1">
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
            </tr>
            <tr hidden="hidden" >
                <td class="MyLable">Smartbank Branch:</td>
                <td class="MyContent">
                    <telerik:RadComboBox ID="rcbSmartBankBranch"
                        MarkFirstMatch="True" 
                        AllowCustomText="false" Width="320"
                        runat="server" ValidationGroup="Group1">
                        <Items>
                            <telerik:RadComboBoxItem Value="" Text="" />
                            <telerik:RadComboBoxItem Value="0" Text="Chi Nhanh Tan Binh" />
                        </Items>
                    </telerik:RadComboBox>
                </td>
            </tr>

            <tr>
                <td class="MyLable">Credit Account:<span class="Required">(*)</span> </td>
                <td class="MyContent" >
                    <telerik:RadComboBox ID="rcbCreditAccount"
                        MarkFirstMatch="True" AppendDataBoundItems="true" Width="320"
                        OnItemDataBound="rcbCreditAccount_ItemDataBound"
                        AllowCustomText="false" OnClientSelectedIndexChanged="OnMatchCurrencyValue"
                        runat="server" ValidationGroup="Group1">
                        <Items>
                            <telerik:RadComboBoxItem Value="" Text="" />
                            <telerik:RadComboBoxItem Value="EUR" Text="EUR-11451-0001-1611 - In-house remittance payable" />
                             <telerik:RadComboBoxItem Value="GBP" Text="GBP-11451-0001-1612 - In-house remittance payable" />
                             <telerik:RadComboBoxItem Value="JPY" Text="JPY-11451-0001-1613 - In-house remittance payable" />
                             <telerik:RadComboBoxItem Value="USD" Text="USD-11451-0001-1614 - In-house remittance payable" />
                             <telerik:RadComboBoxItem Value="VND" Text="VND-11451-0001-1615 - In-house remittance payable" />
                        </Items>
                    </telerik:RadComboBox>
                </td>
                <td>
                    <asp:Label ID="lblCreditAccountNote" runat="server" />
                </td>
            </tr>
            <tr>
                <td class="MyLable">Deal Rate:</td>
                <td class="MyContent">
                    <telerik:RadNumericTextBox ID="tbDealRate" runat="server" ValidationGroup="Group1"   
                              ClientEvents-OnValueChanged="tbDebitAmountLCY_ClientEventsOnValueChanged"
                        NumberFormat-DecimalDigits="6"></telerik:RadNumericTextBox>
                </td>
            </tr>
            <tr>
                <td class="MyLable">Exposure Date:</td>
                <td class="MyContent">
                    <telerik:RadDatePicker ID="rdpExposureDate" runat="server" />
                </td>
            </tr>
            <tr>
                <td class="MyLable">Amt Credit for Cust:</td>
                <td class="MyContent">
                    <asp:Label ID="lblAmtCreditForCust"
                        runat="server" ValidationGroup="Group1"  />
                </td>
            </tr>

            <tr>
                <td class="MyLable">Value Date:</td>
                <td class="MyContent">
                    <telerik:RadDatePicker ID="rdpCreditValueDate" runat="server" />
                </td>
            </tr>
        </table>
                    
                </ContentTemplate>
            </asp:UpdatePanel>
        <table width="100%" cellpadding="0" cellspacing="0">
            <tr>
                <td class="MyLable">Waive Charges:</td>
                <td class="MyContent">
                    <telerik:RadComboBox ID="rcbWaiveCharges"
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
                <td class="MyLable">Narrative:</td>
                <td class="MyContent" width="300">
                    <telerik:RadTextBox ID="tbNarrative" Width="300"
                        runat="server" ValidationGroup="Group1" />
                </td>
                <td><a class="add"><img src="Icons/Sigma/Add_16X16_Standard.png"></a></td>
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
                       <telerik:RadDatePicker ID="rdpIssDate" runat="server" ClientEvents-OnDateSelected="FillNarrative" validationGroup="Group1" />
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


<script type="text/javascript">
    function OnIndexChanged_rcbDebitAccount_DebitCurrency() {
        var debitAccountElement = $find("<%= rcbDebitAccount.ClientID %>");
        var debitAccountValue = debitAccountElement.get_value();

        var oldCusBalElement = $('#<%=lblOldCustBal.ClientID%>');
        var lblCreditCustomerNameElement = $('#<%=lblCreditCustomerName.ClientID%>');

        var debitCurrencyElement = $find("<%=rcbDebitCurrency.ClientID%>");
        var debitCurrencyValue = debitCurrencyElement.get_value();
        if (debitCurrencyValue.length != 0) {
            if (debitAccountValue.length == 0 || !debitAccountValue.trim()) {
                var NewCustBalElement = $('#<%= lblNewCustBal.ClientID%>');
                var AmtforCustElement = $('#<%= lblAmtCreditForCust.ClientID%>');
                NewCustBalElement.html("");
                AmtforCustElement.html("");
            }
            else {
                var lblCustomerIDElement = $('#<%=lblCustomerID.ClientID%>');
                var lblCustomerNameElement = $('#<%=lblCustomerName.ClientID%>');

                lblCustomerIDElement.html(debitAccountElement.get_selectedItem().get_attributes().getAttribute("CustomerID"));
                lblCustomerNameElement.html(debitAccountElement.get_selectedItem().get_attributes().getAttribute("Name"));
                // lay gia tri va` hien len man hinh gia tri cua old Cus Balance, nho khai bao bien va chu y 
                // pham vi su dung cua cac bien cuc bo
                oldCusBalElement.html("");
                var oldcusBalValue = getOldCustBallance();
                oldCusBalElement.html(oldcusBalValue.toLocaleString("en-US"));

            }
        } else return false;

    }
    
    
    /////// ham tinh toan cho gia tri deal rate : ////////////
    function getDealRate() {
        var dealrateElement = $find("<%=tbDealRate.ClientID%>");
        var dealrateValue = dealrateElement.get_value();
        var debitCurElement = $find("<%=rcbDebitCurrency.ClientID%>");
        var debitCur = debitCurElement.get_value();
        var creditCurElement = $find("<%=rcbCreditCurrency.ClientID%>");
        var creditCur = creditCurElement.get_value();
        var debitAmountElement = $find("<%=tbDebitAmountLCY.ClientID%>");
        var debitAmount = debitAmountElement.get_value();
        var creditAmountElement = $('#<%=lblAmtCreditForCust.ClientID%>');

        if (!dealrateValue || creditCur == debitCur) {
            dealrateValue = 1;

        }
        return dealrateValue;
    }

    //////// tinh chuyen doi tien te //////////// 
    function tbDebitAmountLCY_ClientEventsOnValueChanged() {
        //// khai bao cac element va gia tri cho cac field can su dung
        var debitAmtLCYElement = $find("<%= tbDebitAmountLCY.ClientID%>");
        var debitAmtLCY = debitAmtLCYElement.get_value();
        var creditCurrencyElement = $find("<%= rcbCreditCurrency.ClientID%>");
        var creditCurrencyValue = creditCurrencyElement.get_value();
        //var dealrateElement = $find("<%= tbDealRate.ClientID%>");///

        var oldCusBalElement = $('#<%=lblOldCustBal.ClientID%>');
        var oldCusBalValue = getOldCustBallance();
        var creditAmtForCustElement = $('#<%=lblAmtCreditForCust.ClientID%>');
        var newCusBalElement = $('#<%=lblNewCustBal.ClientID%>');
        newCusBalElement.html("");

        var dealrateValue = "";
        // tinh gia tri cho Amt Credit For Customer //////
        if (oldCusBalValue < debitAmtLCY) { showMessage(); }
        else {

            dealrateValue = getDealRate();
            switch (creditCurrencyValue) {
                //case "":
                //    creditAmtForCustElement.html("");
                //    break;
                case "VND":
                    var tempCreditAmt = dealrateValue * debitAmtLCY;
                    if (tempCreditAmt) { creditAmtForCustElement.html(tempCreditAmt.toLocaleString("en-US", { useGrouping: true, minimumFractionDigits: 2, maximumFractionDigits: 2 })); }
                    if (debitAmtLCY) { newCusBalElement.html((oldCusBalValue - debitAmtLCY).toLocaleString("en-US", { useGrouping: true, minimumFractionDigits: 2, maximumFractionDigits: 2 })); }
                    break;

                default:
                    var tempCreditAmt = dealrateValue * debitAmtLCY;
                    if (tempCreditAmt) { creditAmtForCustElement.html(tempCreditAmt.toLocaleString("en-US", { useGrouping: true, minimumFractionDigits: 2, maximumFractionDigits: 2 })); }
                    if (debitAmtLCY) { newCusBalElement.html((oldCusBalValue - debitAmtLCY).toLocaleString("en-US", { useGrouping: true, minimumFractionDigits: 2, maximumFractionDigits: 2 })); }
                    break;

            }
            /// tinh lai gia tri cho new cus Ballance
        }
    }


    ////////////// so sanh tai khoan va loai tien te ////////////
    function OnMatchCurrencyValue(e) {
        var CreditAccountElement = $find("<%= rcbCreditAccount.ClientID %>");
        var CreditAccount = CreditAccountElement.get_value();
        var CreditCurrencyElement = $find("<%= rcbCreditCurrency.ClientID %>");
        var CreditCurreny = CreditCurrencyElement.get_value();
        var debitCurrencyElement = $find("<%=rcbDebitCurrency.ClientID%>");
        var debitCurrency = debitCurrencyElement.get_value();
        var debitAmtLCYElement = $find("<%= tbDebitAmountLCY.ClientID%>");
        var debitAmtLCY = debitAmtLCYElement.get_value();
        var creditAmtForCustElement = $('#<%=lblAmtCreditForCust.ClientID%>');
        ///show ten Credit customer 
        var CreditCustomerIDElement = $('#<%=lblCreditCustomerID.ClientID%>');
        var CreditCustomerNameElement = $('#<%=lblCreditCustomerName.ClientID%>');
        CreditCustomerIDElement.html(""); //// gan gia tri = null de khi moi lan event xay ra, moi gan gia tri moi vao dc
        CreditCustomerNameElement.html("");
        if (CreditAccount.length !=0 && CreditCurreny.length !=0 ) {
            var lblCustomerIDElement = $('#<%=lblCreditCustomerID.ClientID%>');
            var lblCustomerNameElement = $('#<%=lblCreditCustomerName.ClientID%>');
            lblCustomerIDElement.html(CreditAccountElement.get_selectedItem().get_attributes().getAttribute("CustomerID"));
            lblCustomerNameElement.html(CreditAccountElement.get_selectedItem().get_attributes().getAttribute("Name"));
        }

        //if (CreditAccount && CreditCurreny && (CreditCurreny != CreditAccount)) {
        //    alert("Credit Account and Credit Currency are not matched");
        //    CreditAccountElement.trackChanges();
        //    CreditAccountElement.get_items().getItem(0).select();
        //    CreditAccountElement.updateClientState();
        //    CreditAccountElement.commitChanges();

        //    CreditCurrencyElement.trackChanges();
        //    CreditCurrencyElement.get_items().getItem(0).select();
        //    CreditCurrencyElement.updateClientState();
        //    CreditCurrencyElement.commitChanges();
        //    return false;
        //}
        //////// neu cung loai tien te thi khong can them ty gia, gia tri cuoi = gia tri dau luon !!!
        if (debitCurrency && CreditCurreny && (CreditCurreny == debitCurrency))
        { creditAmtForCustElement.html(debitAmtLCY.toLocaleString("en-US", { useGrouping: true, minimumFractionDigits: 2, maximumFractionDigits: 2 })); }

        ShowLabelAutoRecord();
        // OnChangeDealRate();
        return true;
    }

    function ShowLabelAutoRecord() {
        var CreditAccountElement = $find("<%= rcbCreditAccount.ClientID %>");
        var CreditAccountValue = CreditAccountElement.get_value();

        var AutoRecordElement = $('#<%=lblCreditAccountNote.ClientID%>')
        if (CreditAccountValue) {
            AutoRecordElement.html("RECORD.AUTOMATICALLY.OPENED");
        }
        else {
            AutoRecordElement.html("");
        }
    }



    function getOldCustBallance() {
        var debitCurElement = $find("<%=rcbDebitCurrency.ClientID%>");
        var debitCurValue = debitCurElement.get_value();
        var oldCusBal = 0;
        if (debitCurValue == "VND") oldCusBal = 1000000000; else oldCusBal = 50000;
        return oldCusBal;
    }

    function showMessage() {
        var oldCusBal = getOldCustBallance();
        var debitCurElement = $find("<%=rcbDebitCurrency.ClientID%>");
        var debitCurValue = debitCurElement.get_value();
        radconfirm("Can’t overdraft. Maximum debit amount is " + oldCusBal.toLocaleString("en-US", { useGrouping: true, minimumFractionDigits: 2, maximumFractionDigits: 2 }) + " " + debitCurValue.toLocaleString("en-US", { useGrouping: true, minimumFractionDigits: 2, maximumFractionDigits: 2 }), confirmCallbackFunction2);
    }
    function confirmCallbackFunction1(args) {
        radconfirm("Unauthorised overdraft of USD on account 050001688331", confirmCallbackFunction2); //" + amtFCYDeposited + "
    }

    function confirmCallbackFunction2(args) {
        clickCalledAfterRadconfirm = true;
        lastclickedItem.click();
        lastclickedItem = null;
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

    function FillNarrative() {
        var tbBeneName = $find("<%=tbBeneName.ClientID%>");
         var tbAddress = $find("<%=tbAddress.ClientID%>");
         var tbLegalID = $find("<%=tbLegalID.ClientID%>");
         var rdpIssDate = $find("<%=rdpIssDate.ClientID%>");
         var tbPlaceOfIss = $find("<%=tbPlaceOfIss.ClientID%>");

        var rcbDebitAccount = $find("<%=rcbDebitAccount.ClientID%>");
         var rcbChequeType = $find("<%=rcbChequeType.ClientID%>");
         var tbChequeNo = $find("<%=tbChequeNo.ClientID%>");

        var strNarr = "RUT SEC TM " + rcbChequeType.get_value() + ": " + tbChequeNo.get_value() + " TK " + rcbDebitAccount.get_text() + " NN: ";

         if (tbBeneName.get_value()) {
             strNarr += " - " + tbBeneName.get_value();
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
