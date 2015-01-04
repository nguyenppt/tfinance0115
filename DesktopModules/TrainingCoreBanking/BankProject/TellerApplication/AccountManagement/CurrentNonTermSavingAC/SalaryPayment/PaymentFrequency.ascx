<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="PaymentFrequency.ascx.cs" Inherits="BankProject.TellerApplication.AccountManagement.CurrentNonTermSavingAC.SalaryPayment.PaymentFrequency" %>
<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<%@ Register Src="../../../../Controls/VVTextBox.ascx" TagPrefix="uc1" TagName="VVTextBox" %>
<%@ Register src="../../../../Controls/VVComboBox.ascx"  TagPrefix="uc2" TagName="VVComboBox" %>
<%@ register Assembly="DotNetNuke.web" Namespace="DotNetNuke.Web.UI.WebControls" TagPrefix="dnn"%>
<%@ Register src="~/controls/LabelControl.ascx" TagPrefix="dnn" TagName="Label"%>

<script type="text/javascript">
    jQuery(function ($) {
        $('#tabs-demo').dnnTabs();
    })
    function setTextBox(radUpload, eventArgs) {
        var url = radUpload.getFileInputs()[0].value;
        var fileName = url.substr(url.lastIndexOf('\\') + 1, (url.length - 1));
        document.getElementById("<%=tbImportFile.ClientID%>").value = fileName;
    }
</script>
<style type="text/css">
div.Upload .ruFakeInput
    {
        visibility: hidden;
        width:0px;
        padding:0px;
        
    }
 </style>
<telerik:RadToolBar runat="server" ID="RadToolBar1"  EnableRoundedCorners="true" EnableShadows="true" Width="100%" OnButtonClick="RadToolBar1_ButtonClick">
    <Items>
        <telerik:RadToolBarButton ImageUrl="~/Icons/bank/commit.png" ValidationGroup="Commit" 
            ToolTip="Commit Data" Value="btnCommit" CommandName="commit">
        </telerik:RadToolBarButton>
        <telerik:RadToolBarButton ImageUrl="~/Icons/bank/preview.png"
            ToolTip="Preview" Value="btnPreview" CommandName="Preview">
        </telerik:RadToolBarButton>
        <telerik:RadToolBarButton ImageUrl="~/Icons/bank/authorize.png"
            ToolTip="Authorize" Value="btnAuthorize" CommandName="authorize">
        </telerik:RadToolBarButton>
        <telerik:RadToolBarButton ImageUrl="~/Icons/bank/reverse.png"
            ToolTip="Reverse" Value="btnReverse" CommandName="reverse">
        </telerik:RadToolBarButton>
        <telerik:RadToolBarButton ImageUrl="~/Icons/bank/search.png"
            ToolTip="Search" Value="btnSearch" CommandName="search">
        </telerik:RadToolBarButton>
         <telerik:RadToolBarButton ImageUrl="~/Icons/bank/print.png"
            ToolTip="Print Deal Slip" Value="btnPrint" CommandName="print">
        </telerik:RadToolBarButton>
    </Items>
</telerik:RadToolBar>

<div>
    <table width="100%" cellpadding="0" cellspacing="0">
        <tr>
            <td style="width:150px; padding: 5px 0 5px 20px;" >
                <telerik:RadComboBox ID="rcbAccountPayment"
                    MarkFirstMatch="True"
                    AllowCustomText="false"
                    Width="350" runat="server" ValidationGroup="Group1">
                </telerik:RadComboBox>
               
                </td>
        </tr>
    </table>
</div>

<div  class="dnnForm" id="tabs-demo">
    <ul class="dnnAdminTabNav">
        <li><a href="#Main">Salary Frequency</a></li>
        <li><a href="#Audit">Audit Info</a></li>
        <li><a href="#Full">Full View</a></li>
    </ul>
    
    <div id="Main" class="dnnClear">
         <asp:ValidationSummary ID="ValidationSummary1" runat="server" ShowMessageBox="True"
        ShowSummary="False" ValidationGroup="Commit" />
        <table style="width: 100%; padding: 0px">
            <tr>
                <td class="MyLable">Currency</td>
                <td class="MyContent">
                    <asp:Label ID="lblCurrency" runat="server" Text="VND" Enabled="false"></asp:Label>
                </td>
            </tr>
            </table>
            <table style="width: 100%; padding: 0px">
                <tr>
                    <td class="MyLable" style="width:150px">GB IMPORT FILE</td>
                    <td class="MyContent" style="width:200px">
                        <telerik:RadTextBox ID="tbImportFile" Width="250" runat="server" ReadOnly="true"></telerik:RadTextBox>
                    </td>
                    <td class="MyContent" style="width:80px">
                        <telerik:RadUpload ID="ImportFileUpload"  Width="50" OnClientFileSelected="setTextBox" CssClass="Upload" ControlObjectsVisibility="None" runat="server"></telerik:RadUpload>
                    </td>
                    <td class="MyContent" style="width:100px;padding-top:5px;">
                        <asp:Button runat="server" ID="SubmitButton" Text="Upload file" OnClick="SubmitButton_Click" />
                    </td>
                    <td>
                        <asp:Label runat="server" ForeColor="Red" Visible="false" ID="labelNoResults" Text="Please choose a file to import."></asp:Label>
                    </td>
                </tr>



            </table>
         <table style="width: 100%; padding: 0px">
            <tr>
                <td class="MyLable">Total Debit Amt</td>
                <td class="MyContent">
                    <telerik:RadNumericTextBox ID="tbTotalDebitAmt" runat="server" ValidationGroup="Group1">
                    </telerik:RadNumericTextBox>
                </td>
                <%--<td class="MyLable">Approved Amt:</td>
                <td class="MyContent" width="150px">
                    <telerik:RadNumericTextBox ID="tbApprovedAmt" runat="server" ValidationGroup="Group1" Width="150"></telerik:RadNumericTextBox>
                </td>--%>
            </tr>
            <%
                string tabId = Request.QueryString["tabid"];
                if (tabId.Equals("138")) { 
                 %>
            <tr >
                <td class="MyLable">Fequency</td>
                <td class="MyContent">
                     <telerik:RadDatePicker ID="rdpFrequency" runat="server"/>
                </td>
            </tr>
            <%} %>
            <tr>
                <td class="MyLable">End Date</td>
                <td class="MyContent">
                    <telerik:RadDatePicker ID="rdpEndDate" runat="server" DateInput-ClientEvents-OnValueChanging="valueChanging" />
                </td>

            </tr>

            <tr>
                <td class="MyLable">Ordering Cust</td>
                <td class="MyContent">
                    <telerik:RadTextBox ID="tbOrderingCust" runat="server" Width="250"></telerik:RadTextBox>
                </td>

            </tr>

        </table>

        <fieldset>
            <legend style="text-transform: uppercase; font-weight: bold;">Credit Information</legend>
            <center>
            <asp:ListView ID="ListView1"  runat="server" DataKeyNames="Id" DataSourceID="SqlDataSourceControls" InsertItemPosition="LastItem">
                <AlternatingItemTemplate>
                    <tr style="">
                        
                        <td style="padding-left:20px;">
                            <asp:Label ID="PaymentMethodLabel" runat="server" Text='<%# Eval("PaymentMethod") %>' />
                        </td>
                        <td>
                            <%--<asp:Label ID="CreditAmountLabel" runat="server" Text='<%# Eval("CreditAmount") %>' />--%>
                            <telerik:RadNumericTextBox ID="CreditAmountLabel" Runat="server" ReadOnly="true" BorderWidth="0" Value='<%# Bind("CreditAmount") %>'>
                    <EnabledStyle HorizontalAlign="Right"  PaddingRight="50" />
                    </telerik:RadNumericTextBox>
                        </td>
                        <td style="padding-left:100px;">
                            <asp:Label ID="CreditAccountLabel" runat="server" Text='<%# Eval("CreditAccount") %>' />
                        </td>
                        <td >
                            <asp:Label ID="CodeLabel" Visible="false" runat="server" Text='<%# Eval("Code") %>' />
                        </td>
                        <td>
                            <asp:ImageButton ImageUrl="~/Icons/Sigma/Delete_16X16_Standard.png" ID="DeleteButton" runat="server" CommandName="Delete" Text="Delete" />&nbsp;&nbsp;&nbsp
                            <asp:ImageButton ImageUrl="~/Icons/Sigma/Edit_16X16_Standard.png" runat="server" ID="EditButton" CommandName="Edit" Text="Edit" />
                        </td>
                    </tr>
                </AlternatingItemTemplate>
                <EditItemTemplate>
                    <tr style="">
                        
                      <td>
                            <asp:DropDownList ID="PaymentMethodTextBox" SelectedValue='<%# Bind("PaymentMethod") %>' runat="server">
                                <asp:ListItem Text="" Value=""></asp:ListItem>
                                <asp:ListItem Value="AC - Account Transfer" Text="AC - Account Transfer"></asp:ListItem>
                            </asp:DropDownList>
                            <%--<asp:TextBox ID="PaymentMethodTextBox" runat="server" Text='<%# Bind("PaymentMethod") %>' />--%>
                        </td>
                        <td>
                            <telerik:RadNumericTextBox ID="CreditAmountTextBox" Value='<%# Bind("CreditAmount") %>' runat="server"></telerik:RadNumericTextBox>
                            <%--<asp:TextBox ID="CreditAmountTextBox" runat="server" Text='<%# Bind("CreditAmount") %>' />--%>
                        </td>
                        <td>
                            <asp:DropDownList ID="CreditAccountTextBox" runat="server" SelectedValue='<%# Bind("CreditAccount") %>'  DataSourceID="SqlDataSourceCreditAccount" DataTextField="Display" DataValueField="Display">
                            </asp:DropDownList>
                             <asp:SqlDataSource ID="SqlDataSourceCreditAccount" runat="server" ConnectionString="<%$ ConnectionStrings:VietVictoryCoreBanking %>" SelectCommand="select *,  Currency + ' - ' + Id + ' - ' + Name as Display
	from dbo.BDRFROMACCOUNT"></asp:SqlDataSource>
                            <%--<asp:DropDownList ID="CreditAccountTextBox" SelectedValue='<%# Bind("CreditAccount") %>' runat="server"></asp:DropDownList>--%>
                            <%--<asp:TextBox ID="CreditAccountTextBox" runat="server" Text='<%# Bind("CreditAccount") %>' />--%>
                        </td>
                        <td>
                            <asp:TextBox ID="CodeTextBox" Visible="false" runat="server" Text='<%# Bind("Code") %>' />
                        </td>
                        <td>
                            <asp:ImageButton ImageUrl="~/Icons/Sigma/Save_16X16_Standard.png" ID="UpdateButton" runat="server" CommandName="Update" Text="Update" />&nbsp;&nbsp;&nbsp
                            <asp:ImageButton ImageUrl="~/Icons/Sigma/Cancel_16X16_Standard.png" ID="CancelButton" runat="server" CommandName="Cancel" Text="Cancel" />
                        </td>
                    </tr>
                </EditItemTemplate>
                <EmptyDataTemplate>
                    <table runat="server" style="">
                        <tr>
                            <td>No data was returned.</td>
                        </tr>
                    </table>
                </EmptyDataTemplate>
                <InsertItemTemplate>
                    <tr style="">
                       <asp:ValidationSummary ID="ValidationSummary3" runat="server" ShowMessageBox="True"
        ShowSummary="False" ValidationGroup="myVGInsert" />
                        <td>
                            <asp:DropDownList ID="PaymentMethodTextBox" SelectedValue='<%# Bind("PaymentMethod") %>' runat="server">
                                <asp:ListItem Text="" Value=""></asp:ListItem>
                                <asp:ListItem Value="AC - Account Transfer" Text="AC - Account Transfer"></asp:ListItem>
                            </asp:DropDownList>
                            <%--<asp:TextBox ID="PaymentMethodTextBox" runat="server" Text='<%# Bind("PaymentMethod") %>' />--%>
                             <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server"
                                ErrorMessage="Please input data"
                                ControlToValidate="PaymentMethodTextBox" ForeColor="Red" Display="None"
                                ValidationGroup="myVGInsert" />
                        </td>
                        <td>
                            <telerik:RadNumericTextBox ID="CreditAmountTextBox" Value='<%# Bind("CreditAmount") %>' runat="server"></telerik:RadNumericTextBox>
                            <%--<asp:TextBox ID="CreditAmountTextBox" runat="server" Text='<%# Bind("CreditAmount") %>' />--%>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator13" runat="server"
                                ErrorMessage="Please input data"
                                ControlToValidate="CreditAmountTextBox" ForeColor="Red" Display="None"
                                ValidationGroup="myVGInsert" />
                        </td>
                        <td>
                            <asp:DropDownList ID="CreditAccountTextBox" runat="server" SelectedValue='<%# Bind("CreditAccount") %>'  DataSourceID="SqlDataSourceCreditAccount" DataTextField="Display" DataValueField="Display" AppendDataBoundItems="true">
                                <asp:ListItem Value="" Text=""></asp:ListItem>
                            </asp:DropDownList>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server"
                                ErrorMessage="Please input data"
                                ControlToValidate="CreditAccountTextBox" ForeColor="Red" Display="None"
                                ValidationGroup="myVGInsert" />
                             <asp:SqlDataSource ID="SqlDataSourceCreditAccount" runat="server" ConnectionString="<%$ ConnectionStrings:VietVictoryCoreBanking %>" SelectCommand="select *,  Currency + ' - ' + Id + ' - ' + Name as Display
	from dbo.BDRFROMACCOUNT where Currency='VND'"></asp:SqlDataSource>
                            <%--<asp:DropDownList ID="CreditAccountTextBox" SelectedValue='<%# Bind("CreditAccount") %>' runat="server"></asp:DropDownList>--%>
                            <%--<asp:TextBox ID="CreditAccountTextBox" runat="server" Text='<%# Bind("CreditAccount") %>' />--%>
                        </td>
                        <td>
                            <asp:TextBox Visible="false" ID="CodeTextBox" runat="server" Text='<%# Bind("Code") %>' />
                        </td>
                         <td>
                            <asp:ImageButton  ImageUrl="~/Icons/Sigma/Save_16X16_Standard.png" ID="InsertButton" runat="server" CommandName="Insert" Text="Insert" />&nbsp;&nbsp;&nbsp
                            <asp:ImageButton ImageUrl="~/Icons/Sigma/Refresh_16x16_Standard.png" ID="CancelButton" runat="server" CommandName="Cancel" Text="Clear" />
                        </td>
                    </tr>
                </InsertItemTemplate>
                <ItemTemplate>
                    <tr style="">
                        
                        <td style="padding-left:20px;">
                            <asp:Label ID="PaymentMethodLabel" runat="server" Text='<%# Eval("PaymentMethod") %>' />
                        </td>
                        <td>
                            <%--<asp:Label ID="CreditAmountLabel" runat="server" Text='<%# Eval("CreditAmount") %>' />--%>
                            <telerik:RadNumericTextBox ID="CreditAmountLabel" runat="server" ReadOnly="true" BorderWidth="0" Value='<%# Bind("CreditAmount") %>'>
                                <EnabledStyle HorizontalAlign="Right" PaddingRight="50" />
                            </telerik:RadNumericTextBox>
                        </td>
                        <td style="padding-left:100px;">
                            <asp:Label ID="CreditAccountLabel" runat="server" Text='<%# Eval("CreditAccount") %>' />
                        </td>
                        <td>
                            <asp:Label ID="CodeLabel" Visible="false" runat="server" Text='<%# Eval("Code") %>' />
                        </td>
                        <td>
                            <asp:ImageButton ImageUrl="~/Icons/Sigma/Delete_16X16_Standard.png" runat="server" CommandName="Delete" Text="Delete" />&nbsp;&nbsp;&nbsp
                            <asp:ImageButton ImageUrl="~/Icons/Sigma/Edit_16X16_Standard.png" ID="EditButton" runat="server" CommandName="Edit" Text="Edit" />
                        </td>
                    </tr>
                </ItemTemplate>
                <LayoutTemplate>
                    <table runat="server">
                        <tr runat="server">
                            <td runat="server">
                                <table id="itemPlaceholderContainer" runat="server" border="0" style="">
                                    <tr runat="server" style="">
                                        <th runat="server">Payment Method</th>
                                        <th runat="server">Credit Amount</th>
                                        <th runat="server">Credit Account</th>
                                        <th runat="server" visible="false">Code</th>
                                        <th runat="server"></th>
                                    </tr>
                                    <tr id="itemPlaceholder" runat="server">
                                    </tr>
                                </table>
                            </td>
                        </tr>
                        <tr runat="server">
                            <td runat="server" style=""></td>
                        </tr>
                    </table>
                </LayoutTemplate>
                <SelectedItemTemplate>
                    <tr style="">
                       
                        <td>
                            <asp:Label ID="PaymentMethodLabel" runat="server" Text='<%# Eval("PaymentMethod") %>' />
                        </td>
                        <td>
                            <asp:Label ID="CreditAmountLabel" runat="server" Text='<%# Eval("CreditAmount") %>' />
                        </td>
                        <td>
                            <asp:Label ID="CreditAccountLabel" runat="server" Text='<%# Eval("CreditAccount") %>' />
                        </td>
                        <td>
                            <asp:Label ID="CodeLabel" Visible="false" runat="server" Text='<%# Eval("Code") %>' />
                        </td>
                         <td>
                            <asp:ImageButton ImageUrl="~/Icons/Sigma/Delete_16X16_Standard.png" ID="DeleteButton" runat="server" CommandName="Delete" Text="Delete" />&nbsp;&nbsp;&nbsp
                            <asp:ImageButton ImageUrl="~/Icons/Sigma/Edit_16X16_Standard.png" ID="EditButton" runat="server" CommandName="Edit" Text="Edit" />
                        </td>
                    </tr>
                </SelectedItemTemplate>
            </asp:ListView>
            </center>
            <asp:SqlDataSource ID="SqlDataSourceControls" runat="server" ConnectionString="<%$ ConnectionStrings:VietVictoryCoreBanking %>" DeleteCommand="DELETE FROM [BPaymentFrequenceControl] WHERE [Id] = @Id" InsertCommand="INSERT INTO [BPaymentFrequenceControl] ([PaymentMethod], [CreditAmount], [CreditAccount], [Code]) VALUES (@PaymentMethod, @CreditAmount, @CreditAccount, @Code)" SelectCommand="SELECT * FROM [BPaymentFrequenceControl] WHERE [Code]=@Code" UpdateCommand="UPDATE [BPaymentFrequenceControl] SET [PaymentMethod] = @PaymentMethod, [CreditAmount] = @CreditAmount, [CreditAccount] = @CreditAccount, [Code] = @Code WHERE [Id] = @Id">
                <DeleteParameters>
                    <asp:Parameter Name="Id" Type="Int32" />
                </DeleteParameters>
                <InsertParameters>
                    <asp:Parameter Name="PaymentMethod" Type="String" />
                    <asp:Parameter Name="CreditAmount" Type="Double" />
                    <asp:Parameter Name="CreditAccount" Type="String" />
                    <asp:ControlParameter ControlID="rcbAccountPayment" DbType="String" Name="Code" PropertyName="Text" />
                </InsertParameters>
                <SelectParameters>
                    <asp:ControlParameter ControlID="rcbAccountPayment" DbType="String" Name="Code" PropertyName="Text" />
                </SelectParameters>
                <UpdateParameters>
                    <asp:Parameter Name="PaymentMethod" Type="String" />
                    <asp:Parameter Name="CreditAmount" Type="Double" />
                    <asp:Parameter Name="CreditAccount" Type="String" />
                    <asp:Parameter Name="Code" Type="String" />
                    <asp:Parameter Name="Id" Type="Int32" />
                </UpdateParameters>
            </asp:SqlDataSource>
            
            
        </fieldset>

    </div>
   
    <div id="Audit" class="dnnClear">Audit Tab</div>
    <div id="Full" class="dnnClear">Full Tab</div>
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
    
    function GenerateZero(k) {
        n = 1;
        for (var i = 0; i < k.length; i++) {
            n *= 10;
        }
        return n;
    }
    function addCommas(str) {
        var parts = (str + "").split("."),
            main = parts[0],
            len = main.length,
            output = "",
            i = len - 1;

        while (i >= 0) {
            output = main.charAt(i) + output;
            if ((len - i) % 3 === 0 && i > 0) {
                output = "," + output;
            }
            --i;
        }
        // put decimal part back
        //if (parts.length > 1) {
        //    console.log(parts[1]);
        //    output += "." + parts[1];
        //}

        return output + ".00";
    }
    function SetNumber(sender, args) {
        //sender.set_value(sender.get_value().toUpperCase());
        var number;
        var m = sender.get_value().substring(sender.get_value().length - 1);
        if (isNaN(m)) {
            var val = sender.get_value().substring(0, sender.get_value().length - 1).split(".");
            switch (m.toUpperCase()) {

                case "T":
                    var n1 = val[0] * 1000;
                    var n2 = 0;
                    if (val[1] != null)
                        n2 = (val[1] / GenerateZero(val[1])) * 1000;
                    number = n1 + n2;
                    sender.set_value(addCommas(number));
                    break;
                case "M":
                    var n1 = val[0] * 1000000;
                    var n2 = 0;
                    if (val[1] != null)
                        n2 = (val[1] / GenerateZero(val[1])) * 1000000;
                    number = n1 + n2;
                    sender.set_value(addCommas(number));
                    break;
                case "B":
                    var n1 = val[0] * 1000000000;
                    var n2 = 0;
                    if (val[1] != null)
                        n2 = (val[1] / GenerateZero(val[1])) * 1000000000;
                    number = n1 + n2;
                    sender.set_value(addCommas(number));
                    break;
                default:
                    alert("Character is not valid. Please use T, M and B character");
                    return false;
                    break;
            }
        } else {
            if (sender.get_value() != "") {
                number = sender.get_value();
                sender.set_value(addCommas(number));
            }

        }
        //var num = sender.get_value();
    }
    function clickFullTab() {
        $('#tabs-demo').tabs({ selected: 2 });
    }
    function clickMainTab() {
        $('#tabs-demo').tabs({ selected: 0 });
    }
    function valueChanging(sender, args) {
        if (document.getElementById("<%=rdpFrequency.ClientID%>") != null) {
            var dateEnd = args.get_newValue();
            var datePicker = $find("<%=rdpFrequency.ClientID %>");
            var dateFreq = datePicker.get_dateInput().get_selectedDate().format("M/d/yyyy");
            var d1 = Date.parse(dateFreq);
            var d2 = Date.parse(dateEnd);
            if (d2 < d1) {
                alert("The date input is incorrect.\n The End Date must be greater than the Frequency Date");
                $find("<%=rdpEndDate.ClientID %>").clear();
                args.set_value(null);
            }
            else {
                console.log("nhap dung");
            }
        }
    }
</script>


