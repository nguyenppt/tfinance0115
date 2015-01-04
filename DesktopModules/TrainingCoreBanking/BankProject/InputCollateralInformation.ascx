<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="InputCollateralInformation.ascx.cs" Inherits="BankProject.InputCollateralInformation" %>
<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<%@ Register TagPrefix="dnn" Namespace="DotNetNuke.Web.UI.WebControls" Assembly="DotNetNuke.Web" %>
<%@ Register TagPrefix="dnn" TagName="Label" Src="~/controls/LabelControl.ascx" %>
<%@ Register Assembly="BankProject" Namespace="BankProject.Controls" TagPrefix="customControl" %>

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
    </Items>
</telerik:RadToolBar>

<div>
    <table width="100%" cellpadding="0" cellspacing="0">
        <tr>
            <td style="width:200px; padding:5px 0 5px 20px">
                <telerik:RadTextBox ID="tbCollInfo" runat="server" ValidationGroup="Group1" />
                <i><asp:Label ID="lblCollInfo" runat="server" Text="" /></i>
            </td>
        </tr>
    </table>
</div>

<div class="dnnForm" id="tabs-demo">
    <ul class="dnnAdminTabNav">
        <li><a href="#blank1">Collateral Info</a></li>
    </ul>
    <div id="blank1" class="dnnClear">
         <asp:ValidationSummary ID="ValidationSummary1" runat="server" ShowMessageBox="True"
        ShowSummary="False" ValidationGroup="Commit" />
        <fieldset>
            <legend style="text-transform:uppercase ;font-weight:bold;">Collateral Detais</legend>
            <table width="100%" cellpadding="0" cellspacing="0">
                <tr>
                    <td class="MyLable">Collateral Type:</td>
                    <td class="MyContent" width="350">
                        <telerik:RadComboBox ID="rcbColateralType" runat="server" MarkFirstMatch="true" AllowCustomText="false"
                            width="350">
                            <CollapseAnimation Type="None" />
                            <ExpandAnimation Type="None" />
                            <Items>
                            <telerik:RadComboBoxItem Value="" Text="" />
                            <telerik:RadComboBoxItem Value="351" Text="351 - Nha O cua ben vai co GT Hop phap" /> 
                            <telerik:RadComboBoxItem Value="352" Text="352 - Nha O cua ben vai co GT chua Hop phap" />
                                <telerik:RadComboBoxItem Value="353" Text="331 - Nha O cua ben vai HTT tuong lai" />
                                <telerik:RadComboBoxItem Value="354" Text="354 - Nha O cua ben vai thue mua TC" />
                                <telerik:RadComboBoxItem Value="355" Text="355 - BDS tren dat khac co GT hop phap" />
                                <telerik:RadComboBoxItem Value="356" Text="356 - BDS tren dat khac co GT chua hop phap" />
                                <telerik:RadComboBoxItem Value="357" Text="357 - BDS khac hinh thanh trong tuong lai" />
                                <telerik:RadComboBoxItem Value="358" Text="358 - BDS khac thue mua tai chinh" />
                                <telerik:RadComboBoxItem Value="401" Text="401 - Reserve for future use" />
                            
                            </Items>
                        </telerik:RadComboBox>
                    </td>
                    <td class="MyLable"></td>
                    <td class="MyContent"></td>
                </tr>
                <tr>
                    <td class="MyLable">Collateral Code:</td>
                    <td class="MyContent">
                        <telerik:RadComboBox ID="rcbCollateralCode" runat="server" MarkFirstMatch="true" AllowCustomText="false"
                            width="150">
                            <CollapseAnimation Type="None" />
                            <ExpandAnimation Type="None" />
                            <Items>
                                <telerik:RadComboBoxItem Value="" Text="" />
                                <telerik:RadComboBoxItem Value="8" Text="8 - Nha O" />   
                            <telerik:RadComboBoxItem Value="7" Text="7 - Xe Hoi" /> 
                            </Items>
                        </telerik:RadComboBox>
                    </td>                    
                </tr>
                <tr>
                    <td class="MyLable">Contingent Acct:<span class="Required">(*)</span>
                        <asp:RequiredFieldValidator Runat="server" Display="None" ID="RequiredFieldValidator1"
                     ControlToValidate="rcbContingentAcct" ValidationGroup="Commit" InitialValue="" ErrorMessage="CategoryID is required"
                    ForeColor="Red"></asp:RequiredFieldValidator> 
                    </td>
                    <td class="MyContent width=350">
                        <telerik:RadComboBox ID="rcbContingentAcct" runat="server" MarkFirstMatch="true" AllowCustomText="false"
                            width="350">
                            <CollapseAnimation Type="None" />
                            <ExpandAnimation Type="None" />
                            <Items>
                                <telerik:RadComboBoxItem Value="" Text="" />
                                <telerik:RadComboBoxItem Value="VND1941100011221" Text="VND1941100011221 - BDS the chap, cam co de vay von NH" />   
                             
                            </Items>
                        </telerik:RadComboBox>
                    </td>
                    
                </tr>
                <tr>
                    <td class="MyLable">Description:</td>
                    <td class="MyContent" width="350">
                        <telerik:RadTextBox ID="tbDescription" runat="server" ValidationGroup="Group1" Width="350" />
                    </td>
                    <td><a class="add"><img src="Icons/Sigma/Add_16X16_Standard.png" /></a></td>
                   
                </tr>
                </table>
            <table width="100%" cellpadding="0" cellspacing="0">
                <tr>
                    <td class="MyLable">Address:<span class="Required">(*)</span>                        
                        <asp:RequiredFieldValidator runat="server" Display="None" ID="RequiredFieldValidator2" ControlToValidate="tbAddress"
                            ValidationGroup="Commit" InitialValue="" ErrorMessage="Address is Required !" ForeColor="red" />
                    </td>
                    <td class="MyContent" width="350">
                        <telerik:RadTextBox ID="tbAddress" runat="server" ValidationGroup="Group1" Width="350" />
                    </td>
                    <td ><a class="add"> <img src="Icons/Sigma/Add_16X16_Standard.png" /></a></td>
                        </tr>
                    </table>
                    <table width="100%" cellpadding="0" cellspacing="0">
            
                <tr>
                    <td class="MyLable">Collateral Status:<span class="Required">(*)</span>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" Display="None" ControlToValidate="rcbCollateralStatus"
                            ValidationGroup="Commit" InitialValue="" ErrorMessage="Collateral Status is Required !" />
                    </td>
                    <td class="MyContent">
                        <telerik:RadComboBox ID="rcbCollateralStatus" runat="server" MarkFirstMatch="true" AllowCustomText="false"
                            width="150">
                            <CollapseAnimation Type="None" />
                            <ExpandAnimation Type="None" />
                            <Items>
                                <telerik:RadComboBoxItem Value="" Text="" />
                                <telerik:RadComboBoxItem Value="00" Text="00 - NORMAL" />
                                <telerik:RadComboBoxItem Value="01" Text="01 - RELEASED" />  
                                 <telerik:RadComboBoxItem Value="02" Text="02 - CUSTODY" />
                             
                            </Items>
                        </telerik:RadComboBox>
                    </td>                   
                </tr>
                <tr>
                    <td class="MyLable">Company:</td>
                    <td class="MyContent">
                        <telerik:RadComboBox ID="rcbCompany" runat="server" MarkFirstMatch="true" AllowCustomText="false"
                            width="400">
                            <CollapseAnimation Type="None" />
                            <ExpandAnimation Type="None" />
                            <Items>
                                <telerik:RadComboBoxItem Value="" Text="" />                           
                                <telerik:RadComboBoxItem Value="10002650471" Text="10002650471 - TKTV-VND-Phan Van Han" />
                            <telerik:RadComboBoxItem Value="10002650472" Text="10002650472 - TKTV-VND-Dinh Tien Hoang" />
                            <telerik:RadComboBoxItem Value="10002650473" Text="10002650473 - TKTV-VND-Pham Ngoc Thach" />
                            <telerik:RadComboBoxItem Value="10002650474" Text="10002650474 - TKTV-VND-Vo Thi Sau"  />
                            <telerik:RadComboBoxItem Value="10002650475" Text="10002650475 - TKTV-VND-Truong Cong Dinh"  />
                            <telerik:RadComboBoxItem Value="20002665321" Text="20002665321 - TKTV-USD-CTY TNHH SONG HONG"  />
                            <telerik:RadComboBoxItem Value="20002665322" Text="20002665322 – TKTV-USD-CTY TNHH PHAT TRIEN PHAN MEM ABC" />
                            <telerik:RadComboBoxItem Value="20002665323" Text="20002665323 – TKTV-USD-CTY Travelocity Corp" />
                            <telerik:RadComboBoxItem Value="20002665324" Text="20002665324 – TKTV-VND-CTY Wall Street Corp" />
                            <telerik:RadComboBoxItem Value="20002665325" Text="20002665325 – TKTV-VND-CTY Viet Victory Corp" />
                            </Items>
                        </telerik:RadComboBox>
                    </td>                   
                </tr>
                <tr>
                    <td class="MyLable">Application ID:</td>
                    <td class="MyContent" width="350">
                        <telerik:RadTextBox ID="tbApplicationID" runat="server" Width="350" ValidationGroup="Group1" />
                    </td>
                   
                </tr>
                <tr>
                    <td class="MyLable">Notes:</td>
                    <td class="MyContent">
                         <telerik:RadTextBox ID="tbNotes" runat="server" Width="350" ValidationGroup="Group1" />
                    </td>
                    <td ><a class="add"><img src="Icons/Sigma/Add_16X16_Standard.png"</td>                    
                </tr>
                        </table>
            <table width="100%" cellpadding="0" cellspacing="0">
                <tr>
                    <td class="MyLable">Company Storage:<span class="Required">(*)</span>
                         <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" Display="None" ControlToValidate="rcbCompanyStorage"
                            ValidationGroup="Commit" InitialValue="" ErrorMessage="Company Storage is Required !" />
                    </td>
                    <td class="MyContent" width="250">
                         <telerik:RadComboBox ID="rcbCompanyStorage" runat="server" MarkFirstMatch="true" AllowCustomText="false"
                            width="350">
                            <CollapseAnimation Type="None" />
                            <ExpandAnimation Type="None" />
                            <Items>
                                <telerik:RadComboBoxItem Value="" Text="" />                           
                             <telerik:RadComboBoxItem Value="VN-001-1221" Text="VN-001-1221 - CHI NHANH TAN BINH" /> 
                                <telerik:RadComboBoxItem Value="VN-001-1222" Text="VN-001-1221 - CHI NHANH BINH THANH" /> 
                            </Items>
                        </telerik:RadComboBox>
                    </td>
                    <td class="MyLable"></td>
                    <td class="MyContent"></td>
                </tr>
            </table>
        </fieldset>
        <fieldset>
            <legend style="text-transform:uppercase ;font-weight:bold;">Value Detais</legend>
            <table width="100%" cellpadding="0" cellspacing="0">
                <tr>
                    <td class="MyLable" >Currency:</td>
                    <td class="MyContent">
                        <telerik:RadComboBox ID="rcbCurrency" runat="server" MarkFirstMatch="true" AllowCustomText="false"
                           width="150">
                            <CollapseAnimation Type="None" />
                            <ExpandAnimation Type="None" />
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
                     <td class="MyLable" width=""></td>
                    <td class="MyContent" width=""></td>
                   
                </tr>
                <tr>
                    <td class="MyLable">Country:</td>
                    <td class="MyContent">
                        <telerik:RadComboBox ID="rcbCountry" runat="server" MarkFirstMatch="true" AllowCustomText="false"
                            width="150">
                            <CollapseAnimation Type="None" />
                            <ExpandAnimation Type="None" />
                            <Items>                  
                               <telerik:RadComboBoxItem Value="" Text="" /> 
                            </Items>
                        </telerik:RadComboBox>
                    </td>
                    <tr>
                    <td class="MyLable">Nominal Value:</td>
                    <td class="MyContent">
                        <telerik:RadNumericTextBox ID="tbNominalValue" runat="server" ValidationGroup="Group1" Width="150"
                            NumberFormat-DecimalDigits="0">
                             <ClientEvents OnBlur="clientEvent_NominalValue" />
                        </telerik:RadNumericTextBox>
                       
                    </td>
                </tr>
                <tr>
                    <td class="MyLable">Maximum Value:</td>
                    <td class="MyContent">
                        <telerik:RadNumericTextBox ID="tbMaxi" NumberFormat-DecimalDigits="0" runat="server" ValidationGroup="Group1" Width="150"></telerik:RadNumericTextBox>
                        
                    </td>
                </tr>
                <tr>
                    <td class="MyLable">Provision Value:</td>
                    <td class="MyContent"></td>
                    <td class="MyLable"></td>
                    <td class="MyContent"></td>
                </tr>
                <tr>
                    <td class="MyLable">Execution Value:</td>
                    <td class="MyContent">
                        <telerik:RadNumericTextBox ID="tbExeValue" runat="server" ValidationGroup="Group1" Width="150"
                            NumberFormat-DecimalDigits="0" >
                           
                        </telerik:RadNumericTextBox>
                         
                    </td>                   
                </tr>
                <tr>
                    <td class="MyLable">Allocated Amt:</td>
                    <td class="MyContent"></td>
                    <td class="MyLable"></td>
                    <td class="MyContent"></td>
                </tr>
                <tr>
                    <td class="MyLable">Value Date:</td>
                    <td class="MyContent" >
                        <telerik:RadDatePicker ID="RdpValueDate" width="150" runat="server"></telerik:RadDatePicker>
                    </td>
                    <td class="MyLable">Expiry Date:</td>
                    <td class="MyContent">
                        <telerik:RadDatePicker ID="RdpExpiryDate" width="150"  runat="server"></telerik:RadDatePicker>
                    </td>
                </tr>
                <tr>
                    <td class="MyLable">Review Date Freq:</td>
                    <td class="MyContent">
                        <telerik:RadTextBox ID="tbReviewDateFreq" runat="server" ValidationGroup="Group1" Width="150" />
                    </td>                   
                </tr>
                </tr>
            </table>
        </fieldset>
        <fieldset>
            <legend style="text-transform:uppercase ;font-weight:bold;">Credit Card Information</legend>
            <table width="100%" cellpadding="0" cellspacing="0">
                <tr>
                    <td class="MyLable">Credit Card No:</td>
                    <td class="MyContent" width="150">
                        <telerik:RadNumericTextBox ID="tbCreditCardNo" runat="server" ValidationGroup="Group1" Width="150"
                           NumberFormat-GroupSeparator="" NumberFormat-DecimalDigits="0"></telerik:RadNumericTextBox>
                                            </td>
                    <td ><a class="add"><img src="Icons/Sigma/Add_16X16_Standard.png" /></a></td>
                     </tr>
                   </table>
                     <table width="100%" cellpadding="0" cellspacing="0"> 
                <tr>
                    <td class="MyLable">Card Type:</td>
                    <td class="MyContent">
                        <telerik:RadComboBox ID="rcbCardType" runat="server" MarkFirstMatch="true" AllowCustomText="false"
                            width="150">
                            <CollapseAnimation Type="None" />
                            <ExpandAnimation Type="None" />
                            <Items>
                                <telerik:RadComboBoxItem Value="" Text="" /> 
                            </Items>
                        </telerik:RadComboBox>
                    </td>
                </tr>
                <tr>
                    <td class="MyLable">Cardholder:</td>
                    <td class="MyContent">
                        <telerik:RadComboBox ID="rcbCardholder" runat="server" MarkFirstMatch="true" AllowCustomText="false"
                            width="150">
                            <CollapseAnimation Type="None" />
                            <ExpandAnimation Type="None" />
                            <Items>
                                <telerik:RadComboBoxItem Value="" Text="" />  
                            </Items>
                        </telerik:RadComboBox>
                    </td>
                    <td class="MyLable"></td>
                    <td class="MyContent"></td>
                </tr>
                <tr>
                    <td class="MyLable">Total Col Amt:</td>
                    <td class="MyContent">
                        <telerik:RadNumericTextBox ID="tbTotalColAmt" runat="server" ValidationGroup="Group1" 
                            NumberFormat-DecimalDigits="0" Width="150"></telerik:RadNumericTextBox>
                       
                    </td>
                </tr>       
            </table>
        </fieldset>
    </div>
</div>


<script type="text/javascript">
    function clientEvent_NominalValue(sender, args)
    {
        var NominalValue = $find("<%= tbNominalValue.ClientID%>");
        var ExecutionValue = $find("<%= tbExeValue.ClientID%>");
        ExecutionValue.set_value(NominalValue.get_value()*0.7) ;

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