<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="DefineCustomerLimit.ascx.cs" Inherits="BankProject.Views.TellerApplication.DefineCustomerLimit" %>
<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<%@ Register TagPrefix="dnn" Namespace="DotNetNuke.Web.UI.WebControls" Assembly="DotNetNuke.Web" %>
<%@ Register TagPrefix="dnn" TagName="Label" Src="~/controls/LabelControl.ascx" %>
<%@ Register Assembly="BankProject" Namespace="BankProject.Controls" TagPrefix="customControl" %>
<telerik:RadWindowManager ID="RadWindowManager1" runat="server" EnableShadow="true" />

<script type="text/javascript">
    jQuery(function ($) {
        $('#tabs-demo').dnnTabs();
    })
</script>

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
         <telerik:RadToolBarButton ImageUrl="~/Icons/bank/edit.png" 
            ToolTip="Edit Data" Value="btEdit" CommandName="edit" />
    </Items>
</telerik:RadToolBar>

<div>
    <table width="100%" cellpadding="0" cellspacing="0">
        <tr>
            <td style="width:200px ;padding:5px 0 5px 20px;">
                <asp:TextBox Width="200" ID="tbLimitID" runat="server" /><span class="Required">(*)</span>
                <asp:RequiredFieldValidator Runat="server" Display="None" ID="RequiredFieldValidator2"
                     ControlToValidate="tbLimitID" ValidationGroup="Commit" InitialValue="" ErrorMessage="Customer Limit ID is required"
                    ForeColor="Red"></asp:RequiredFieldValidator>
                <i>
                    <asp:Label ID="lblCustomerName"  runat="server"></asp:Label> <b><asp:Label ID="lblCheckCustomerName" runat="server" /></b>
                </i>

            </td>
        </tr>
    </table>
</div>
<div class="dnnForm" id="tabs-demo">
    <ul class="dnnAdminTabNav">
        <li><a href="#blank1">Limit Define</a></li>
    </ul>
</div>
<div id="blank1" class="dnnClear">
    <asp:ValidationSummary ID="ValidationSummary1" runat="server" showMessagebox="true" showSummary="false"
        validationGroup="Commit" />
    <fieldset>
        <legend>
            <div style="font-weight:bold; text-transform:uppercase">Limit Details</div>
        </legend>
       
        <table width="100%" cellpadding="0" cellspacing="0">
            <td class="MyLable">Currency:<span class="Required" >(*)</span>
                <asp:RequiredFieldValidator Runat="server" Display="None" ID="RequiredFieldValidator1"
                     ControlToValidate="rcbCurrency" ValidationGroup="Commit" InitialValue="" ErrorMessage="Currency is required"
                    ForeColor="Red"></asp:RequiredFieldValidator>  </td>
            <td class="MyContent" width="333"><telerik:RadComboBox ID="rcbCurrency" runat="server" MarkFirstMatch="true" AllowCustomText="false" appendDataboundItems="true"
                          OnClientSelectedIndexChanged="CurrencyChanged_forNote" >
                            <CollapseAnimation Type="None" />
                            <ExpandAnimation Type="None" />
                            <Items>                     
                                    <telerik:RadComboBoxItem Value="" Text="" />
                            </Items>
                        </telerik:RadComboBox>

            </td>
            <td class="MyLable">Country:</td>
            <td class="MyContent">
                        <telerik:RadComboBox ID="rcbCountry" runat="server"  appendDataboundItems="true"
                             AllowCustomText="false" MarkFirstMatch="true"  height="190" > 
                            <ExpandAnimation Type="none" />
                            <CollapseAnimation Type="None" />
                            <Items>
                               <telerik:RadComboBoxItem Value="" Text="" />
                            </Items>
                            </telerik:RadComboBox>
                     <%--<a class="add"><img src="Icons/Sigma/Add_16X16_Standard.png" /></a>--%>
            </td>
        </table>
          <table width="100%" cellpading="0" cellspacing="0">
            <tr>
                <td class="MyLable">Approved Date:</td>
                <td class="MyContent" >
                    <telerik:RadDatePicker ID="RdpApprovedDate"  runat="server" validationGroup="Group1"></telerik:RadDatePicker>
                </td>
                <td class="MyLable">Offered Until:</td>
                <td class="MyContent">
                    <telerik:RadDatePicker ID="RdpOfferedUnit" runat="server" validationGroup="Group1"></telerik:RadDatePicker>
                </td>
            </tr>
              <tr>
                  <td class="MyLable">Expiry Date:</td>
                  <td class="MyContent">
                      <telerik:RadDatePicker ID="rdpExpiryDate" runat="server" validationGroup="Group1"></telerik:RadDatePicker>
                  </td>
              </tr>
            <tr>
                <td class="MyLable">Proposal Date:</td>
                <td class="MyContent">
                    <telerik:RadDatePicker ID="RdpProposalDate" runat="server" ValidationGroup="Group1"></telerik:RadDatePicker>
                </td>
                <td class="MyLable">Available Date:</td>
                <td class="MyContent">                    
                    <telerik:RadDatePicker ID="RdpAvailableDate" runat="server" ValidationGroup="Group1"></telerik:RadDatePicker>
                </td>
            </tr> 
            </table>
              <table width="100%" cellpading="0" cellspacing="0">
                  </table>
           <table width="100%" cellpading="0" cellspacing="0">
            <tr>
                <td class="MyLable">Internal Limit Amt:</td>
                <td class="MyContent">
                    <telerik:RadNumericTextBox ID="tbIntLimitAmt"  runat="server" ValidationGroup="Group1">
                    </telerik:RadNumericTextBox>
                   
                </td>
                <td class="MyLable">Advised Amount:</td>
                <td class="MyContent">
                    <telerik:RadNumericTextBox ID="tbAdvisedAmt" runat="server"  ValidationGroup="Group1" ></telerik:RadNumericTextBox>
                     
                </td>
            </tr>
            <tr>
                <td class="MyLable">Original Limit:</td>
                <td class="MyContent">
                    <telerik:RadNumericTextBox ID="tbOriginalLimit" runat="server" ValidationGroup="Group1"  />
                </td>
            </tr>
            
               </table>
              <table width="100%" cellpading="0" cellspacing="0">
              <tr>
                <td class="MyLable">Notes:</td>
                <td class="MyContent">
                    <telerik:RadTextBox ID="tbNote" runat="server" ValidationGroup="Group1" Width="400" 
                        text="Mo Han Muc Cho Khach Hang"/><%--<a class="add"><img src="Icons/Sigma/Add_16X16_Standard.png"></a>--%>
                </td>
                <td > </td>
                
            </tr>
        </table>
    </fieldset>

    <fieldset>
        <legend>
            <div style="font-weight:bold; text-transform:uppercase">Orther Details</div>
        </legend>
           <table width="100%" cellpading="0" cellspacing="0">
            <tr>
                <td class="MyLable">Fixed / Variable:</td>
                <td class="MyContent" width="370">
                     <telerik:RadComboBox ID="rcbFandA" runat="server"  width="150"
                         AllowCustomText="false" MarkFirstMatch="true"  > 
                        <ExpandAnimation Type="none" />
                        <CollapseAnimation Type="None" />
                        <Items>
                            <telerik:RadComboBoxItem Value="Fixed" Text="Fixed" /> 
                            <telerik:RadComboBoxItem Value="Variable" Text="Variable" />                          
                        </Items>
                        </telerik:RadComboBox>
                </td>               
            </tr>
            <tr>
                <td class="MyLable">Collateral Type:</td>
                <td class="MyContent" width="350">
                     <telerik:RadComboBox ID="rcbCollateralType" runat="server"  appendDataboundItems ="true" height="150" autopostBack="true"
                         AllowCustomText="false" MarkFirstMatch="true"  width="350" ONSelectedIndexChanged="rcbCollateralType_ONSelectedIndexChanged" > 
                        <ExpandAnimation Type="none" />
                        <CollapseAnimation Type="None" />
                        <Items>
                            <telerik:RadComboBoxItem Value="" Text="" />   
                        </Items>
                        </telerik:RadComboBox>
                </td>  
                <td><%--<a class="add"><img src="Icons/Sigma/Add_16X16_Standard.png" /></a>--%></td>             
            </tr>
            <tr>
                <td class="MyLable">Collateral Code:</td>
                <td class="MyContent" width="350">
                     <telerik:RadComboBox ID="rcbCollateral" runat="server"  appendDataboundItems ="true" height="150"
                         AllowCustomText="false" MarkFirstMatch="true" width="350" > 
                        <ExpandAnimation Type="none" />
                        <CollapseAnimation Type="None" />
                        <Items>
                            <telerik:RadComboBoxItem Value="" Text="" />   
                        </Items>
                        </telerik:RadComboBox>
                </td>  
                <td><%--<a class="add"><img src="Icons/Sigma/Add_16X16_Standard.png" /></a>--%></td>             
            </tr>
               </table>
        <table width="100%" cellpading="0" cellspacing="0">
             <tr>
                <td class="MyLable"width="150">Coll Reqd Amt:</td>
                <td class="MyContent" width="330">
                    <asp:Label ID="lblCollReqdAmt" runat="server" />
                </td>
                <td class="MyLable" >Coll Reqd Pct:</td>
                <td class="MyContent">
                    <asp:Label ID="lblColReqdPct" runat="server" />
                </td>
            </tr>
            <tr>
                <td class="MyLable">Up to Period:</td>
                <td class="MyContent">
                     <asp:Label ID="lblUpToPeriod" runat="server" />
                </td>
                <td class="MyLable"></td>
                <td class="MyContent"></td>
            </tr> <tr>
                <td class="MyLable">Period Amount:</td>
                <td class="MyContent">
                    <asp:Label ID="lblPeriodAmt" runat="server" />
                </td>
                <td class="MyLable">Period Pct:</td>
                <td class="MyContent">
                    <asp:Label ID="lblPeriodPct" runat="server" />
                </td>
            </tr>
            <tr>
                <td class="MyLable">Maximum Secured:</td>
                <td class="MyContent" width="150">
                    <telerik:RadNumericTextBox ID="tbMaxSecured" runat="server" ValidationGroup="Group1" Width="150" ></telerik:RadNumericTextBox>
                  
                </td>
                
            </tr> <tr>
                <td class="MyLable">Maximum Unsecured:</td>
                <td class="MyContent">
                    <telerik:RadNumericTextBox ID="tbMaxUnsecured" runat="server" ValidationGroup="Group1" Width="150"></telerik:RadNumericTextBox>
                   
                </td>               
            </tr>
            <tr>
                <td class="MyLable">Maximum Total:</td>
                <td class="MyContent">
                    <telerik:radnumerictextbox ID="tbMaxTotal" runat="server"  Width="150"></telerik:radnumerictextbox>
                </td>
               
            </tr> 
            <tr>
                <td class="MyLable">Other Secured:</td>
                <td class="MyContent">
                    <asp:Label ID="lblOtherSecured" runat="server" />
                </td>
                <td class="MyLable"></td>
                <td class="MyContent"></td>
            </tr>
            <tr>
                <td class="MyLable">Collateral Right:</td>
                <td class="MyContent">
                    <asp:Label ID="lblCollateralRight" runat="server" />
                </td>
                <td class="MyLable">Amt Secured:</td>
                <td class="MyContent">
                    <asp:Label ID="lblAmtSecured" runat="server" />
                </td>
            </tr> <tr>
                <td class="MyLable">Online Limit:</td>
                <td class="MyContent">
                    <asp:Label ID="lblOnlineLimit" runat="server" />
                </td>
                <td class="MyLable"></td>
                <td class="MyContent"></td>
            </tr>
            <tr>
                <td class="MyLable">Available Amount:</td>
                <td class="MyContent">
                    <asp:Label ID="lblAvailableAmt" runat="server" />
                </td>
                <td class="MyLable">Total Outstand:</td>
                <td class="MyContent">
                    <asp:Label ID="lblTotalOutstand" runat="server" />
                </td>
            </tr>
        
               </table>
    </fieldset>
</div>
<telerik:RadAjaxManager ID="RadAjaxManager1" runat="server" >
    <AjaxSettings>
        <telerik:AjaxSetting AjaxControlID="rcbCollateralType">
            <UpdatedControls>
                 <telerik:AjaxUpdatedControl ControlID="rcbCollateral" />
            </UpdatedControls>
        </telerik:AjaxSetting>
    </AjaxSettings>
</telerik:RadAjaxManager>
<telerik:RadCodeBlock id="RadCodeBlock" runat="server">
<script type="text/javascript">
    $("#<%=tbLimitID.ClientID%>").keyup(function (event) {
        
        if (event.keyCode == 13 || event.keyCode == 9) {
            $("#<%=btSearch.ClientID%>").click();
        }
    });
    function CurrencyChanged_forNote(sender,args)
    {
        var Note = $find("<%=tbNote.ClientID%>");
        var Currency = $find("<%=rcbCurrency.ClientID%>").get_selectedItem().get_value(); 
        var CustomerName = $('#<%=lblCustomerName.ClientID%>').html();
        if (CustomerName && Currency) {
            Note.set_value("Mo Han Muc " + Currency + " cho khach hang " + CustomerName);
        } else Note.set_value("");
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
  </script>
    </telerik:RadCodeBlock>
<div style="visibility:hidden;">
    <asp:Button ID="btSearch" runat="server" OnClick="btSearch_Click1" Text="Search" />
</div>