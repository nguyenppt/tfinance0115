<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="ChequeReturned2.ascx.cs" Inherits="BankProject.Views.TellerApplication.ChequeReturned2" %>
<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>

<script type="text/javascript">
    jQuery(function ($) {
        $('#tabs-demo').dnnTabs();
    });
</script>
<div>
    <telerik:RadToolBar runat="server" ID="RadToolBar1" EnableShadows="true" EnableRoundedCorners="true" Width="100%" OnButtonClick="RadToolBar1_OnButtonClick">
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
            <td style="width:200px; padding:5px 0 5px 20px">
                <telerik:RadTextBox ID="tbID" runat="server" Width="200px" ValidationGroup="Group1">
                 <ClientEvents OnBlur="tbID_OnBlur"  />
                </telerik:RadTextBox>
            </td>
        </tr>
    </table>
</div>
<div class="dnnForm" id="tabs-demo">
    <div>
        <ul class="dnnAdminTabNav">
            <li><a href="# blank1">Register</a></li>
        </ul>
    </div>
    <div id="blan1" class="dnnClear">
        <table width="100%" cellpadding="0" cellspacing="0">
            <tr>
                <td class="MyLable">Total Issued:</td>
                <td class="MyContent">
                    <asp:Label ID="lblTotalIssued" runat="server" />
                </td>
                 <td class="MyLable"></td>
                <td class="MyContent"></td>
            </tr>
            <tr>
                <td class="MyLable">Total Used:</td>
                <td class="MyContent">
                    <asp:Label ID="lblTotalUsed" runat="server" />
                </td>
                 <td class="MyLable"></td>
                <td class="MyContent"></td>
            </tr>
            <tr>
                 <td class="MyLable">Total Held:</td>
                <td class="MyContent">
                    <asp:Label ID="lblTotalHeld" runat="server" />
                </td>
            </tr>
            <tr>
                 <td class="MyLable">Cheque.Nos:</td>
                <td class="MyContent">
                    <asp:Label ID="lblChequesNo" runat="server" />
                </td>
            </tr>
            <tr>
                 <td class="MyLable">Presented Cheques:</td>
                <td class="MyContent">
                    <asp:Label ID="Label3" runat="server" />
                </td>
            </tr>
             <tr>
                 <td class="MyLable">Stopped Cheques:</td>
                <td class="MyContent">
                    <asp:Label ID="lblStoppedCheque" runat="server" />
                </td>
            </tr>
             <tr>
                 <td class="MyLable">Returned Cheques:</td>
                <td class="MyContent" width="200">
                    <telerik:RadTextBox ID="tbReturnedCheque" runat="server" ValidationGroup="Group1" width="200"> </telerik:RadTextBox>
                </td>
                 <td ><a class="add"><img src="Icons/Sigma/Add_16X16_Standard.png"></a></td>           

             </tr>
        </table>
        <table cellpadding="0" cellspacing="0" width="100%">
            <tr>
                <td class="MyLable">Narrative:</td>
                <td class="MyContent">
                    <asp:Label ID="lblNarrative" runat="server" />
                </td>
            </tr>
        </table>
    </div>

</div>

<script type="text/javascript">
    var TotalIssuedElement = $('#<%=lblTotalIssued.ClientID%>');
    var TotalUsedElement = $('#<%=lblTotalUsed.ClientID%>');
    var TotalHeldElement = $('#<%=lblTotalHeld.ClientID%>');
    var StoppedChequesElement = $('#<%=lblStoppedCheque.ClientID%>');
    var ChequeNosElement = $('#<%=lblChequesNo.ClientID%>');

    $("#<%=tbID.ClientID %>").keyup(function (event) {

        if (event.keyCode == 13)  {
            tbID_OnBlur();
        }

      

    });

    function tbID_OnBlur() {
        var tbIDElement = $find("<%=tbID.ClientID%>");
        var tbIDValue = tbIDElement.get_value();

        if (tbIDValue) {
            TotalIssuedElement.html("10");
            TotalUsedElement.html("7");
            TotalHeldElement.html("3");
            ChequeNosElement.html("121230 - 121239");
            StoppedChequesElement.html("0");
        } else {
            TotalIssuedElement.html("");
            TotalUsedElement.html("");
            TotalHeldElement.html("");
            ChequeNosElement.html("");
            StoppedChequesElement.html("");
        }
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