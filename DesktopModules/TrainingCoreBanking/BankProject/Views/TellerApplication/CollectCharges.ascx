<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="CollectCharges.ascx.cs" Inherits="BankProject.Views.TellerApplication.CollectCharges" %>
<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<%@ Register TagPrefix="dnn" Namespace="DotNetNuke.Web.UI.WebControls" Assembly="DotNetNuke.Web" %>
<%@ Register TagPrefix="dnn" TagName="Label" Src="~/controls/LabelControl.ascx" %>
<%@ Register Assembly="BankProject" Namespace="BankProject.Controls" TagPrefix="customControl" %>

<!--tao the tab-->
<script type="text/javascript">
    jQuery(function ($) {
        $('#tabs-demo').dnnTabs();
    });
</script>

<!--bieu tuong buttons-->
<telerik:RadToolBar runat="server" ID="RadToolBar1" EnableRoundedCorners="true" EnableShadows="true" Width="100%" OnButtonClick="RadToolBar1_ButtonClick">
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

<!--tao khung search-->
<div>
     <asp:ValidationSummary ID="ValidationSummary1" runat="server" ShowMessageBox="True"
        ShowSummary="False" ValidationGroup="Commit" />
    <table width="100%" cellpadding="0" cellspacing="0">
        <tr>
            <td style="width: 200px; padding: 5px 0 5px 20px;">
                <asp:TextBox ID="tbDepositCode" runat="server" Width="200" />
                <i>
                    <asp:Label ID="lblDepositCode" runat="server" />

                </i>

            </td>
        </tr>
    </table>
</div>

<!-- tao cac tabs va noi dung cac tabs-->
<div class="dnnForm" id="tabs-demo">
    <ul class="dnnAdminTabNav">
        <li><a href="#CollectCharges">Collect Charges</a></li>
       <!--  <li><a href="#Audit">Audit</a></li>
        <li><a href="#FullView">Full View</a></li>  -->
    </ul>
    <!--<div id="Audit"></div>
    <div id="FullView"></div>  -->
    <div id="CollectCharges">
        <table>
            <tr>
                <td class="MyLable">Customer:</td>
                <td class="MyContent">
                    <asp:Label ID="lblCustomerID" runat="server"></asp:Label>
                </td>
                <td class="MyContent"> 
                    <asp:Label ID="lblCustomerName" runat="server"></asp:Label>
                </td>  
                
            </tr>
        </table>
        <hr />
        </div>
    <asp:UpdatePanel ID="UpdatePanel7" runat="server">
        <ContentTemplate>

      <table>
       <tr>
            <td class="MyLable">Currency:</td>
            <td class="MyContent">              
                  <telerik:RadcomboBox
                        ID="rcbCurrency" runat="server" 
                        MarkFirstMatch="True" Width="150" Height="150px"
                      OnSelectedIndexChanged="rcbCurrency_SelectedIndexChanged"
                      AutoPostBack="true"
                        AllowCustomText="false" validationGroup="Group1">
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
                    </telerik:RadcomboBox>   

            </td>
       </tr>
             </table>

     <table width="100%" cellpadding="0" cellspacing="0">
                <tr>    
                    <td style="width: 153px" class="MyLable">Debit Account:<span class="Required">(*)</span>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" display="None"
                            ControlToValidate="rcbDebitAccount" ValidationGroup="Commit" InitialValue="" ErrorMessage="Debit Account is required !"
                            foreColor="Red" />
                    </td>
                    <td style="width: 320px" class="MyContent">
                       <telerik:RadcomboBox
                        ID="rcbDebitAccount" runat="server" 
                        MarkFirstMatch="True" Width="320" 
                           AppendDataBoundItems="true"
                           AutoPostBack="true" 

                         OnItemDataBound="rcbDebitAccount_ItemDataBound"

                        AllowCustomText="false" validationGroup="Group1" OnClientSelectedIndexChanged="rcbDebitAccount_OnClientSelectedIndexChanged" >
                        <ExpandAnimation Type="None" />
                        <CollapseAnimation Type="None" />
                       <Items>
                           <telerik:RadComboBoxItem value="" Text="" />
                       </Items>
                    </telerik:RadcomboBox> 
                    </td>
                  
                    <td><a class="add"><img src="Icons/Sigma/Add_16X16_Standard.png"></a></td>
                </tr>          
            </table>
    <table>
         <tr>
            <td class="MyLable">Chrg Amount LCY:</td>
            <td class="MyContent">
                  <telerik:RadNumericTextBox ID="tbChargeAmountLCY" runat="server"   AutoPostBack="true" ValidationGroup="Group1" NumberFormat-DecimalDigits="0" OnTextChanged="tbChargeAmountLCY_TextChanged" />
                
            </td>
        </tr>
          <tr>
            <td class="MyLable">Chrg Amount FCY:</td>
            <td class="MyContent">
                  <telerik:RadNumericTextBox ID="tbChargeAmountFCY" runat="server"   AutoPostBack="true" ValidationGroup="Group1" NumberFormat-DecimalDigits="2" OnTextChanged="tbChargeAmountFCY_TextChanged" />
                
            </td>
        </tr>
             <tr>
                 <td class="MyLable">Value Date:</td>
                 <td class="MyContent">
                     <telerik:RadDatePicker ID="rdpValueDate" runat="server" validationGroup="Group1" />
                 </td>
               
             </tr>

         <tr>
                 <td class="MyLable">Category PL:<span class="Required">(*)</span>
                     <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" errorMessage="Category TP is required"
                         Initial="" ForeColor="Red" display="None"  ControlToValidate="rcbCategoryPL" ValidationGroup="Commit" />
                 </td>
                 <td class="MyContent">
                    <telerik:RadComboBox width="300px"  
                          ID="rcbCategoryPL"  
                          validationGroup="Group1" RunAt="server" MarkFirstMatch="true" 
                         AllowCustomText="false"> 
                        
                     <Items>
                         <telerik:RadComboBoxItem value=""  text="" />
                         <telerik:RadComboBoxItem value="PL-62153"  text="PL-62153 - Fees on Counting&Checking Charges" />
                     </Items>
                         </telerik:RadComboBox>  
            
                 </td>
              
                 
             </tr>
          <tr>
                 <td class="MyLable">Deal Rate:</td>
                 <td class="MyContent">
                     <telerik:RadNumericTextBox id="txtDealRate" NumberFormat-DecimalDigits="0" OnTextChanged="txtDealRate_TextChanged" AutoPostBack="true" runat="server" validationGroup="Group1" />
                 </td>
             </tr>
         <tr>
        <tr>
                 <td class="MyLable">Vat Amount LCY:</td>
                 <td class="MyContent">
                     <telerik:RadNumericTextBox id="tbVATAmountLCY" NumberFormat-DecimalDigits="0" ReadOnly="true" OnTextChanged="tbVATAmountLCY_TextChanged" AutoPostBack="true" runat="server" validationGroup="Group1" />
                 </td>
             </tr>
         <tr>
                 <td class="MyLable">Vat Amount FCY:</td>
                 <td class="MyContent">
                     <telerik:RadNumericTextBox id="tbVATAmount" NumberFormat-DecimalDigits="2" ReadOnly="true" OnTextChanged="tbVATAmount_TextChanged" AutoPostBack="true" runat="server" validationGroup="Group1" />
                 </td>
             </tr>
         <tr>
                 <td class="MyLable">Total Amount LCY:</td>
                 <td class="MyContent">
                     <telerik:RadNumericTextBox id="tbTotalAmountLCY" NumberFormat-DecimalDigits="0" ReadOnly="true" runat="server" AutoPostBack="true" validationGroup="Group1" />
                 </td>
             </tr>

         <tr>
                 <td class="MyLable">Total Amount FCY:</td>
                 <td class="MyContent">
                     <telerik:RadNumericTextBox id="tbTotalAmount" NumberFormat-DecimalDigits="2" ReadOnly="true" runat="server" AutoPostBack="true" validationGroup="Group1" />
                 </td>
             </tr>

         <tr>
                 <td class="MyLable">Vat Serial No:</td>
                 <td class="MyContent">
                     <telerik:RadTextBox id="tbVATSerialNo" runat="server" validationGroup="Group1" />
                 </td>
             </tr>
    </table>
          
     <table>
           </ContentTemplate>
    </asp:UpdatePanel>
             <table width="100%" cellpadding="0" cellspacing="0">
                <tr>    
                    <td style="width: 153px" class="MyLable">Narrative:</td>
                    <td style="width: 100px" class="MyContent">
                        <telerik:RadTextBox width="300" ID="tbNarrative" runat="server"/>
                    </td>
                    <td><a class="add"><img src="Icons/Sigma/Add_16X16_Standard.png"></a></td>
                </tr>
            </table>

    
    </div>

<!-- phan con lai- p2-->
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

    function rcbDebitAccount_OnClientSelectedIndexChanged()
    {
        var lblCustomerIDElement = $('#<%=lblCustomerID.ClientID%>');
        var lblCustomerNameElement = $('#<%=lblCustomerName.ClientID%>');
        var debitAccountElement = $find("<%= rcbDebitAccount.ClientID %>");
        var debitAccountValue = debitAccountElement.get_value();

        if (debitAccountValue.length == 0 || !debitAccountValue.trim()) {
            lblCustomerIDElement.html("");
            lblCustomerNameElement.html("");
        }
        else {
            lblCustomerIDElement.html(debitAccountElement.get_selectedItem().get_attributes().getAttribute("CustomerID"));
            lblCustomerNameElement.html(debitAccountElement.get_selectedItem().get_attributes().getAttribute("CustomerName"));
        }
    }

   

   

  </script>