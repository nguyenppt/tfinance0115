﻿<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="DocumentWithNoDiscrepancy.ascx.cs" Inherits="BankProject.TradingFinance.Import.DocumentaryCredit.DocumentWithNoDiscrepancy" %>
<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<%@ Register Src="~/DesktopModules/TrainingCoreBanking/BankProject/Controls/MultiTextBox.ascx" TagPrefix="uc1" TagName="MultiTextBox" %>
<telerik:RadWindowManager ID="RadWindowManager1" runat="server" EnableShadow="true"></telerik:RadWindowManager>
<asp:ValidationSummary ID="ValidationSummary1" runat="server" ShowMessageBox="True" ShowSummary="False" ValidationGroup="Commit" />
<telerik:RadCodeBlock ID="RadCodeBlock2" runat="server">
    <script type="text/javascript" src="DesktopModules/TrainingCoreBanking/BankProject/Scripts/Common.js"></script>
    <script type="text/javascript">        
        jQuery(function ($) {
            $('#tabs-demo').dnnTabs();
        });

        function RadToolBar1_OnClientButtonClicking(sender, args) {
            var button = args.get_item();
            //
            if (button.get_commandName() == '<%=BankProject.Controls.Commands.Commit%>') {
                <% if (TabId == TabDocsWithDiscrepancies || DocsType == TabDocsWithDiscrepancies) %>
                <%{ %>
                if (!MTIsValidInput('tabMT734', null)) {
                    args.set_cancel(true);
                    return;
                }
                <% }%>
            }
            if (button.get_commandName() == '<%=BankProject.Controls.Commands.Preview%>') {
                window.location = '<%=EditUrl("preview_nodiscrepancy")%>&lst=4appr';
            }
            if (button.get_commandName() == '<%=BankProject.Controls.Commands.Search%>') {
                window.location = '<%=EditUrl("preview_nodiscrepancy")%>';
            }
            if (button.get_commandName() == '<%=BankProject.Controls.Commands.Print%>') {
                <%if (TabId == TabDocsWithDiscrepancies)
                  {%>
                radconfirm("Do you want to download MT734 file?", confirmCallbackFunction_MT734, 340, 150, null, 'Download');
                <%}%>
                <%if (TabId == TabDocsAmend)
                  {%>
                var Amount = Number($find("<%=numAmount.ClientID%>").get_value());
                var OldAmount = Number($('#<%=txtOldAmount.ClientID%>').val());
                if (Amount < OldAmount)
                    radconfirm("Do you want to download PHIEU XUAT NGOAI BANG file ?", confirmCallbackFunction_XUATNGOAIBANG, 340, 150, null, 'Download');
                else if (Amount > OldAmount)
                    radconfirm("Do you want to download PHIEU NHAP NGOAI BANG file ?", confirmCallbackFunction_NHAPNGOAIBANG, 340, 150, null, 'Download');
                <%}%>
            }
        }
        
        function confirmCallbackFunction_MT734(result) {
            if (result) {
                $("#<%=btDownloadMT734.ClientID %>").click();
            }
            if ($find("<%=comboWaiveCharges.ClientID%>").get_value() == "YES")
                radconfirm("Do you want to download VAT file?", confirmCallbackFunction_VAT, 340, 150, null, 'Download');
        }
        function confirmCallbackFunction_VAT(result) {
            if (result) {
                $("#<%=btDownloadVAT.ClientID %>").click();
            }
        }
        function confirmCallbackFunction_XUATNGOAIBANG(result) {
            if (result) {
                $("#<%=btDownloadXuatNB.ClientID %>").click();
            }
        }
        function confirmCallbackFunction_NHAPNGOAIBANG(result) {
            if (result) {
                $("#<%=btDownloadNhapNB.ClientID %>").click();
            }
        }
    </script>
</telerik:RadCodeBlock>
<telerik:RadToolBar runat="server" ID="RadToolBar1" OnClientButtonClicking="RadToolBar1_OnClientButtonClicking"
    EnableRoundedCorners="true" EnableShadows="true" width="100%" OnButtonClick="RadToolBar1_ButtonClick" >
        <Items>
            <telerik:RadToolBarButton ImageUrl="~/Icons/bank/commit.png" ValidationGroup="Commit"
            ToolTip="Commit Data" Value="btCommitData" CommandName="commit" enabled="false">
            </telerik:RadToolBarButton>
            <telerik:RadToolBarButton ImageUrl="~/Icons/bank/preview.png"
                ToolTip="Preview" Value="btPreview" CommandName="preview" postback="false" enabled="true">
            </telerik:RadToolBarButton>
            <telerik:RadToolBarButton ImageUrl="~/Icons/bank/authorize.png"
                ToolTip="Authorize" Value="btAuthorize" CommandName="authorize" enabled="false">
            </telerik:RadToolBarButton>
            <telerik:RadToolBarButton ImageUrl="~/Icons/bank/reverse.png"
                ToolTip="Reverse" Value="btReverse" CommandName="reverse" enabled="false">
            </telerik:RadToolBarButton>
            <telerik:RadToolBarButton ImageUrl="~/Icons/bank/search.png"
                ToolTip="Search" Value="btSearch" CommandName="search" postback="false" enabled="true">
            </telerik:RadToolBarButton>
             <telerik:RadToolBarButton ImageUrl="~/Icons/bank/print.png"
                ToolTip="Print Deal Slip" Value="btPrint" CommandName="print" postback="false" enabled="false">
            </telerik:RadToolBarButton>
        </Items>
</telerik:RadToolBar>
<table width="100%" cellpadding="0" cellspacing="0">
    <tr>
        <td style="width:200px; padding:5px 0 5px 20px;"><asp:TextBox ID="txtCode" runat="server" Width="200" />&nbsp;<asp:Label ID="lblError" runat="server" ForeColor="red" /></td>
    </tr>
</table>
<div class="dnnForm" id="tabs-demo">
    <telerik:RadCodeBlock ID="RadCodeBlock3" runat="server">
        <ul class="dnnAdminTabNav">
            <li><a href="#Main">Main</a></li>
            <% if (TabId == TabDocsWithDiscrepancies || DocsType == TabDocsWithDiscrepancies) %>
                <%{ %>
                <li><a href="#tabMT734">MT734</a></li>
                <li style="display:none;"><a href="#tabCharge">Charge</a></li>
            <% }
               else if (TabId == TabDocsReject) %>
                    <%{%>
                        <li style="display:none;"><a href="#tabCharge">Charge</a></li>
            <% } %>
        </ul>
    </telerik:RadCodeBlock>    
    <div id="Main" class="dnnClear">        
        <table width="100%" cellpadding="0" cellspacing="0">
            <%if (TabId == TabDocsAccept){ %>
            <tr>
                <td class="MyLable">Accept Date</td>
                <td class="MyContent">
                    <telerik:RadDatePicker ID="txtAcceptDate" runat="server" />
                </td>
            </tr>
            <tr>
                <td class="MyLable">Accept Remarks</td>
                <td class="MyContent">
                    <telerik:Radtextbox runat="server" ID="txtAcceptRemarks" Width="355" />
                </td>
            </tr>
            <%} %>
            <tr>
                <td class="MyLable" style="width: 180px">1. Draw Type</td>
                <td class="MyContent">
                    <telerik:RadComboBox  Width="355"
                        ID="comboDrawType" 
                        Runat="server"
                        MarkFirstMatch="True"
                        AllowCustomText="false" >
                    </telerik:RadComboBox>
                </td>
            </tr>
        </table>        
        <div runat="server" ID="divPresentorNo">
        <table width="100%" cellpadding="0" cellspacing="0">
            <tr>
                <td class="MyLable" style="width: 180px">27. Presentor No.</td>
                <td class="MyContent" style="width:355px;"><telerik:Radtextbox runat="server" ID="txtPresentorNo" Width="355" AutoPostBack="True" OnTextChanged="txtPresentorNo_OnTextChanged" />                    
                </td>
                <td><asp:Label ID="lblPresentorNoMsg" runat="server" Text="" ForeColor="Red"></asp:Label></td>
            </tr>            
            <tr>
                <td class="MyLable">28.1 Presentor Name</td>
                <td class="MyContent" colspan="2">
                    <telerik:Radtextbox runat="server" ID="txtPresentorName" Width="355" />
                </td>
            </tr>

            <tr>
                <td class="MyLable">29. Presentor Ref. No.</td>
                <td class="MyContent" colspan="2">
                    <telerik:Radtextbox runat="server" ID="txtPresentorRefNo" Width="355" ClientEvents-OnValueChanged ="txtPresentorRefNo_OnValueChanged" />
                </td>
            </tr>
        </table>
        </div>

        <table width="100%" cellpadding="0" cellspacing="0">
            <tr>
                <td class="MyLable" style="width: 180px">2. Currency</td>
                <td class="MyContent">
                    <asp:Label ID="lblCurrency" runat="server" />
                </td>
            </tr>
            
            <tr>
                <td class="MyLable">3. Document Amount<span class="Required"> (*)</span></td>
                <td class="MyContent">
                    <telerik:Radnumerictextbox runat="server" ID="numAmount" ClientEvents-OnValueChanged ="numAmount_OnValueChanged" />
                    <asp:RequiredFieldValidator
                        runat="server" Display="None"
                        ID="RequiredFieldValidator1"
                        ControlToValidate="numAmount"
                        ValidationGroup="Commit"
                        InitialValue=""
                        ErrorMessage="Document Amount is required" ForeColor="Red">
                    </asp:RequiredFieldValidator><asp:HiddenField ID="txtOldAmount" runat="server" />
                </td>
            </tr>
            
            <tr>
                <td class="MyLable">11. Booking Date</td>
                <td class="MyContent">
                    <telerik:RadDatePicker ID="dteBookingDate" runat="server" />
                </td>
            </tr>

            <tr>
                <td class="MyLable">69.4 Docs Received Date<span class="Required"> (*)</span></td>
                <td class="MyContent">
                    <telerik:RadDatePicker ID="dteDocsReceivedDate" runat="server" ClientEvents-OnDateSelected ="dteDocsReceivedDate_OnValueChanged" />
                    <asp:RequiredFieldValidator
                        runat="server" Display="None"
                        ID="RequiredFieldValidator2"
                        ControlToValidate="dteDocsReceivedDate"
                        ValidationGroup="Commit"
                        InitialValue=""
                        ErrorMessage="Docs Received Date is required" ForeColor="Red">
                    </asp:RequiredFieldValidator>
                </td>
            </tr>
        </table>
        
        <div runat="server" ID="divDocCode">
        <div runat="server" ID="divDocsCode1">
        <table width="100%" cellpadding="0" cellspacing="0">
                <tr>
                    <td class="MyLable" style="width: 180px">38.1 Docs Code</td>
                    <td class="MyContent" style="width: 150px">
                        <telerik:RadComboBox Width="355"
                            AppendDataBoundItems="True"
                            ID="comboDocsCode1" runat="server"
                            MarkFirstMatch="True"
                            AllowCustomText="false">
                        </telerik:RadComboBox>
                    </td>
                    <td>
                        <asp:ImageButton ID="btAddDocsCode" runat="server" 
                            OnClick="btAddDocsCode_Click" ImageUrl="~/Icons/Sigma/Add_16X16_Standard.png" />
                    </td>
                </tr>

                <tr>
                    <td class="MyLable">39.1 No. of Originals</td>
                    <td class="MyContent">
                        <telerik:RadNumericTextBox ID="numNoOfOriginals1" runat="server" MaxValue="999" MaxLength="3">
                            <NumberFormat GroupSeparator="" DecimalDigits="0" />
                        </telerik:RadNumericTextBox>
                    </td>
                </tr>

                <tr>
                    <td class="MyLable">40.1 No. of Copies</td>
                    <td class="MyContent">
                        <telerik:RadNumericTextBox ID="numNoOfCopies1" runat="server" MaxValue="999" MaxLength="3">
                            <NumberFormat GroupSeparator="" DecimalDigits="0" />
                        </telerik:RadNumericTextBox>
                    </td>
                </tr>
            </table>
        </div>        
        <div runat="server" ID="divDocsCode2" visible="false">
            <table width="100%" cellpadding="0" cellspacing="0">
                <tr>
                    <td class="MyLable" style="width: 180px">41.1 Docs Code</td>
                    <td style="width: 150px" class="MyContent">
                        <telerik:RadComboBox Width="355"
                            AppendDataBoundItems="True"
                            ID="comboDocsCode2" runat="server"
                            MarkFirstMatch="True"
                            AllowCustomText="false">
                        </telerik:RadComboBox>
                    </td>
                    <td>
                       <asp:ImageButton ID="ImageButton1" runat="server" OnClick="btDeleteDocsCode2_Click" ImageUrl="~/Icons/Sigma/Delete_16X16_Standard.png" /> 
                    </td>
                </tr>

                <tr>
                    <td class="MyLable">42.1 No. of Originals</td>
                    <td class="MyContent">
                        <telerik:RadNumericTextBox ID="numNoOfOriginals2" runat="server" MaxValue="999" MaxLength="3">
                            <NumberFormat GroupSeparator="" DecimalDigits="0" />
                        </telerik:RadNumericTextBox>
                    </td>
                </tr>

                <tr>
                    <td class="MyLable">43.1 No. of Copies</td>
                    <td class="MyContent">
                        <telerik:RadNumericTextBox ID="numNoOfCopies2" runat="server" MaxValue="999" MaxLength="3">
                            <NumberFormat GroupSeparator="" DecimalDigits="0" />
                        </telerik:RadNumericTextBox>
                    </td>
                </tr>
            </table>
        </div>        
        <div runat="server" ID="divDocsCode3" visible="false">
            <table width="100%" cellpadding="0" cellspacing="0">
                <tr>
                    <td class="MyLable" style="width: 180px">44.1 Docs Code</td>
                    <td style="width: 150px" class="MyContent">
                        <telerik:RadComboBox Width="355"
                            AppendDataBoundItems="True"
                            ID="comboDocsCode3" runat="server"
                            MarkFirstMatch="True"
                            AllowCustomText="false">
                        </telerik:RadComboBox>
                    </td>
                    <td>
                        <asp:ImageButton ID="ImageButton2" runat="server" OnClick="btDeleteDocsCode3_Click" ImageUrl="~/Icons/Sigma/Delete_16X16_Standard.png" />
                    </td>
                </tr>

                <tr>
                    <td class="MyLable">45.1 No. of Originals</td>
                    <td class="MyContent">
                        <telerik:RadNumericTextBox ID="numNoOfOriginals3" runat="server" MaxValue="999" MaxLength="3">
                            <NumberFormat GroupSeparator="" DecimalDigits="0" />
                        </telerik:RadNumericTextBox>
                    </td>
                </tr>

                <tr>
                    <td class="MyLable">46.1 No. of Copies</td>
                    <td class="MyContent">
                        <telerik:RadNumericTextBox ID="numNoOfCopies3" runat="server" MaxValue="999" MaxLength="3">
                            <NumberFormat GroupSeparator="" DecimalDigits="0" />
                        </telerik:RadNumericTextBox>
                    </td>
                </tr>
            </table>
        </div>
        
        <table width="100%" cellpadding="0" cellspacing="0">
            <tr>
                <td class="MyLable" style="width: 180px">69.3.1 Full docs amount</td>
                <td class="MyContent">
                    <telerik:RadNumericTextBox runat="server" ID="txtFullDocsAmount" Width="355" />
                </td>
            </tr>
            <tr style="display:none;">
                <td class="MyLable" style="width: 180px">69.3.1 Other Docs</td>
                <td class="MyContent">
                    <telerik:RadNumericTextBox runat="server" ID="txtOtherDocs1" Width="355" />
                </td>
            </tr>
            <tr style="display:none;">
                <td class="MyLable">69.3.2 Other Docs</td>
                <td class="MyContent">
                    <telerik:Radtextbox runat="server" ID="txtOtherDocs2" Width="355" />
                </td>
            </tr>
            
            <tr style="display:none;">
                <td class="MyLable">69.3.3 Other Docs</td>
                <td class="MyContent">
                    <telerik:Radtextbox runat="server" ID="txtOtherDocs3" Width="355" />
                </td>
            </tr>
        </table>
        </div>

        <fieldset runat="server" ID="fieldsetDiscrepancies" visible="false">
            <legend>
                <div style="font-weight: bold; text-transform: uppercase;">Discrepancies and Disposal of Docs</div>
            </legend>            
            <table width="100%" cellpadding="0" cellspacing="0">
                <tr>
                    <td class="MyLable" style="width:170px; vertical-align:top;">33 Discrepancies</td>
                    <td class="MyContent">
                        <telerik:RadTextBox ID="txtDiscrepancies" runat="server" TextMode="MultiLine" Height="100" Width="355" ClientEvents-OnValueChanged="txtDiscrepancies_OnValueChanged"></telerik:RadTextBox>
                    </td>
                </tr>
            </table>
            <table width="100%" cellpadding="0" cellspacing="0">
                <tr>
                    <td class="MyLable" style="width:170px;">69.5.1 Disposal of Docs</td>
                    <td class="MyContent">
                        <telerik:Radtextbox runat="server" ID="txtDisposalOfDocs" Width="355" />
                    </td>
                </tr>
            </table>
        </fieldset>        
        <div runat="server" ID="divLast">
        <fieldset>
            <legend>
                <div style="font-weight: bold; text-transform: uppercase;">Trace Date</div>
            </legend>
            
            <table width="100%" cellpadding="0" cellspacing="0">
                <tr>
                    <td class="MyLable" style="width: 170px">29. Trace Date</td>
                    <td class="MyContent">
                        <telerik:RadDatePicker ID="dteTraceDate" runat="server" />
                    </td>
                </tr>
            </table>
        </fieldset>
        
        <fieldset>
            <legend>
                <div style="font-weight: bold; text-transform: uppercase;">Supplemental Docs</div>
            </legend>
            
            <table width="100%" cellpadding="0" cellspacing="0">
                <tr>
                    <td class="MyLable" style="width: 170px">69.1.1 Docs Received Date</td>
                    <td class="MyContent">
                        <telerik:RadDatePicker ID="dteDocsReceivedDate_Supplemental" runat="server" />
                    </td>
                </tr>
                
                <tr>
                    <td class="MyLable">69.2.1 Presentor Ref. No</td>
                    <td class="MyContent">
                        <telerik:Radtextbox runat="server" ID="txtPresentorRefNo_Supplemental" Width="355" />
                    </td>
                </tr>
                
                <tr>
                    <td class="MyLable">42.1 Docs</td>
                    <td class="MyContent">
                        <telerik:Radtextbox runat="server" ID="txtDocs_Supplemental1" Width="355"  />
                    </td>
                </tr>
            </table>
        </fieldset>
        </div>
    </div>   
   
    <div id="tabMT734" class="dnnClear">
        <div runat="server" ID="divMT734">
            <table width="100%" cellpadding="0" cellspacing="0">
                <tr>
                    <td class="MyLable" style="width: 200px">Presentor No</td>
                    <td class="MyContent" style="width:355px;"><telerik:Radtextbox runat="server" ID="txtPresentorNo_734" Width="355" AutoPostBack="True" OnTextChanged="txtPresentorNo_734_OnTextChanged" />                    
                    </td>
                    <td><asp:Label ID="lblPresentorNo_734Msg" runat="server" Text="" ForeColor="Red"></asp:Label></td>
                </tr> 
            </table>
            <table width="100%" cellpadding="0" cellspacing="0">
            <tr>
                <td class="MyLable" style="width: 200px">Presentor Name</td>
                <td class="MyContent">
                    <telerik:RadTextBox ID="txtPresentorName_734" runat="server" Width="355" />
                </td>
            </tr>
             <tr>
                <td class="MyLable">Presentor Addr.</td>
                <td class="MyContent">
                    <telerik:RadTextBox ID="txtPresentorAddr_734_1" runat="server" Width="355" />
                </td>
            </tr>
            
             <tr>
                <td class="MyLable">Presentor City.</td>
                <td class="MyContent">
                    <telerik:RadTextBox ID="txtPresentorAddr_734_2" runat="server" Width="355" />
                </td>
            </tr>
            
            <tr>
                <td class="MyLable">Presentor Country.</td>
                <td class="MyContent">
                    <telerik:RadTextBox ID="txtPresentorAddr_734_3" runat="server" Width="355" />
                </td>
            </tr>
            
            <tr>
                <td class="MyLable">20. Sender's TRN</td>
                <td class="MyContent">
                    <asp:Label ID="lblSenderTRN" runat="server" />
                </td>
            </tr>
            
            <tr>
                <td class="MyLable">21. Presenting Bank's Ref</td>
                <td class="MyContent">
                    <telerik:RadTextBox ID="txtPresentingBankRef" runat="server" Width="355" MaxLength="16"/>
                </td>
            </tr>
            
            <tr>
                <td class="MyLable">32.A Date and Amt of Utilization</td>
                <td class="MyContent" >
                    <telerik:Raddatepicker runat="server" ID="dteDateUtilization"/>
                    <telerik:Radnumerictextbox runat="server" ID="numAmountUtilization" />
                    <asp:Label ID="lblUtilizationCurrency" runat="server" />
                </td>
               
            </tr>
            
            <tr>
                <td class="MyLable">73. Charges Claimed</td>
                <td class="MyContent">
                    <asp:Label ID="lblChargesClaimed" runat="server" Text="Computed by system" />
                </td>
            </tr>
            
            <tr>
                <td class="MyLable">33.A Total Amount Claimed</td>
                <td class="MyContent">
                    <asp:Label ID="lblTotalAmountClaimed" runat="server" Text="Computed by system" />
                </td>
            </tr>
            
            <tr>
                <td class="MyLable">57.A Account With Bank</td>
                <td class="MyContent">
                    <telerik:RadTextBox ID="txtAccountWithBank" runat="server" Width="355" MaxLength="35"/>
                </td>
            </tr>
            
            <tr>
                <td class="MyLable">72. Sender to Receiver Infomation</td>
                <td class="MyContent">
                    <telerik:RadTextBox ID="tbSendertoReceiverInfomation" runat="server" Width="355" MaxLength="35"/>
                </td>
            </tr>
            <tr>
                <td class="MyLable" style="vertical-align:top;">77.J Discrepancies</td>
                <td class="MyContent"><telerik:RadTextBox runat="server" ID="txtDiscrepancies_734" Height="100" Width="355" TextMode="MultiLine" />
                </td>
            </tr>
            <tr>
                <td class="MyLable">77.B Disposal of Docs</td>
                <td class="MyContent">
                    <telerik:RadTextBox ID="txtDisposalOfDocs_734" runat="server" Width="355" Text="WE ARE HOLDING DOCS AS PER ARTICLE 16c(iii) B OF UCP 600" enabled="false" />
                </td>
            </tr>
        </table>
        </div>
    </div>
       
    <div id="tabCharge" class="dnnClear" style="display:none;">
        <div runat="server" ID="divCharge">
            <asp:HiddenField ID="hiddenCustomerName" runat="server" />
            <table width="100%" cellpadding="0" cellspacing="0">
                <tr>
                    <td class="MyLable">Waive Charges</td>
                    <td class="MyContent">
                        <telerik:RadComboBox AutoPostBack="True"
                            OnSelectedIndexChanged="comboWaiveCharges_OnSelectedIndexChanged"
                            ID="comboWaiveCharges" runat="server"
                            MarkFirstMatch="True"
                            AllowCustomText="false">
                            <Items>
                                <telerik:RadComboBoxItem Value="NO" Text="YES" />
                                <telerik:RadComboBoxItem Value="YES" Text="NO" />
                            </Items>
                        </telerik:RadComboBox>
                    </td>
                </tr>
                <tr>
                    <td class="MyLable">Charge Remarks</td>
                    <td class="MyContent">
                        <asp:TextBox ID="tbChargeRemarks" runat="server" />
                    </td>
                </tr>
                <tr>
                    <td class="MyLable">VAT No</td>
                    <td class="MyContent">
                        <asp:TextBox ID="tbVatNo" runat="server" Enabled="false" />
                    </td>
                </tr>
            </table>        
            <telerik:RadTabStrip runat="server" ID="RadTabStrip3" SelectedIndex="0" MultiPageID="RadMultiPage1" Orientation="HorizontalTop">
                <Tabs>
                    <telerik:RadTab Text="Cable Charge">
                    </telerik:RadTab>
                    <telerik:RadTab Text="Open Charge ">
                    </telerik:RadTab>
                    <telerik:RadTab Text="Open Charge for Import LC (Amort)">
                    </telerik:RadTab>
                </Tabs>
            </telerik:RadTabStrip>
            <telerik:RadMultiPage runat="server" ID="RadMultiPage1" SelectedIndex="0" >
                <telerik:RadPageView runat="server" ID="RadPageView1" >
                    <div runat="server" ID="divCABLECHG">
                        <table width="100%" cellpadding="0" cellspacing="0">
                            <tr>
                                <td class="MyLable">Charge code</td>
                                <td class="MyContent">
                                    <telerik:RadComboBox 
                                        ID="tbChargeCode" runat="server"
                                        MarkFirstMatch="True" 
                                        AllowCustomText="false">
                                        <ExpandAnimation Type="None" />
                                        <CollapseAnimation Type="None" />
                                    </telerik:RadComboBox>
                                    <span id="Span1"></span>
                                </td>
                            </tr>                        
                            <tr>
                                <td class="MyLable">Charge Ccy</td>
                                <td class="MyContent">
                                    <telerik:RadComboBox 
                                        AutoPostBack="True"
                                        OnSelectedIndexChanged="rcbChargeCcy_OnSelectedIndexChanged"
                                        AppendDataBoundItems="True"
                                        ID="rcbChargeCcy" runat="server"
                                        MarkFirstMatch="True"
                                        AllowCustomText="false">
                                        <ExpandAnimation Type="None" />
                                        <CollapseAnimation Type="None" />
                                    </telerik:RadComboBox>
                                </td>
                            </tr>
                            <tr>
                                <td class="MyLable">Charge Acct</td>
                                <td class="MyContent">
                                    <telerik:RadComboBox
                                        AppendDataBoundItems="True"
                                        OnItemDataBound="rcbChargeAcct_ItemDataBound"
                                        ID="rcbChargeAcct" runat="server"
                                        MarkFirstMatch="True" Width="300"
                                        AllowCustomText="false">
                                        <ExpandAnimation Type="None" />
                                        <CollapseAnimation Type="None" />
                                    </telerik:RadComboBox>
                                </td>
                            </tr>
                            <tr style="display: none">
                                <td class="MyLable">Charge Period</td>
                                <td class="MyContent">
                                    <asp:TextBox ID="tbChargePeriod" Text="1" runat="server" Width="100" />
                                </td>
                            </tr>
                            <tr style="display: none">
                                <td class="MyLable">Exch. Rate</td>
                                <td class="MyContent">
                                    <telerik:RadNumericTextBox IncrementSettings-InterceptArrowKeys="true" 
                                        IncrementSettings-InterceptMouseWheel="true" runat="server" ID="tbExcheRate" Width="200px" Value="1" />
                                </td>
                            </tr>
                            <tr>
                                <td class="MyLable">Charge Amt</td>
                                <td class="MyContent">
                                    <telerik:RadNumericTextBox IncrementSettings-InterceptArrowKeys="true" 
                                        IncrementSettings-InterceptMouseWheel="true" runat="server" 
                                        ID="tbChargeAmt" AutoPostBack="true"
                                        OnTextChanged="tbChargeAmt_TextChanged" />
                                </td>
                            </tr>
                            <tr>
                                <td class="MyLable">Party Charged</td>
                                <td class="MyContent">
                                    <telerik:RadComboBox 
                                        AutoPostBack="True"
                                        OnSelectedIndexChanged="rcbPartyCharged_SelectIndexChange"
                                        OnItemDataBound="rcbPartyCharged_ItemDataBound"
                                        ID="rcbPartyCharged" runat="server"
                                        MarkFirstMatch="True" 
                                        AllowCustomText="false">
                                        <ExpandAnimation Type="None" />
                                        <CollapseAnimation Type="None" />
                                    </telerik:RadComboBox>
                                </td>
                            </tr>
                            <tr>
                                <td class="MyLable">Amort Charges</td>
                                <td class="MyContent">
                                    <telerik:RadComboBox
                                        ID="rcbOmortCharge" runat="server"
                                        MarkFirstMatch="True" 
                                        AllowCustomText="false">
                                        <ExpandAnimation Type="None" />
                                        <CollapseAnimation Type="None" />
                                        <Items>
                                            <telerik:RadComboBoxItem Value="NO" Text="NO" />
                                            <telerik:RadComboBoxItem Value="YES" Text="YES" />
                                        </Items>
                                    </telerik:RadComboBox>
                                </td>
                            </tr>                        
                            <tr style="display: none">
                                <td class="MyLable">Charge Status</td>
                                <td class="MyContent">
                                    <telerik:RadComboBox AutoPostBack="true"
                                        OnSelectedIndexChanged="rcbChargeStatus_SelectIndexChange"
                                        ID="rcbChargeStatus" runat="server"
                                        MarkFirstMatch="True" 
                                        AllowCustomText="false">
                                        <ExpandAnimation Type="None" />
                                        <CollapseAnimation Type="None" />
                                        <Items>
                                            <telerik:RadComboBoxItem Value="" Text="" />
                                            <telerik:RadComboBoxItem Value="CHARGE COLECTED" Text="2" />
                                            <telerik:RadComboBoxItem Value="CHARGE UNCOLECTED" Text="3" />
                                        </Items>
                                    </telerik:RadComboBox>
                                </td>
                            </tr>
                            <tr>
                                <td class="MyLable">Tax Code</td>
                                <td class="MyContent">
                                    <asp:Label ID="lblTaxCode" runat="server" />
                                </td>
                            </tr>
                            <tr>
                                <td class="MyLable">Tax Amt</td>
                                <td class="MyContent">
                                    <asp:Label ID="lblTaxAmt" runat="server" />
                                </td>
                            </tr>
                        </table>
                    </div>
                </telerik:RadPageView>
                <telerik:RadPageView runat="server" ID="RadPageView2" >
                    <div runat="server" ID="divPAYMENTCHG">
                        <table width="100%" cellpadding="0" cellspacing="0" id="table2" runat="server">
                            <tr>
                                <td class="MyLable">Charge code</td>
                                <td class="MyContent">
                                    <telerik:RadComboBox
                                        ID="tbChargeCode2" runat="server" 
                                        MarkFirstMatch="True"
                                        AllowCustomText="false">
                                        <ExpandAnimation Type="None" />
                                        <CollapseAnimation Type="None" />
                                    </telerik:RadComboBox>
                                    <span id="spChargeCode2"></span>
                                </td>
                            </tr>                        
                            <tr>
                                <td class="MyLable">Charge Ccy</td>
                                <td class="MyContent">
                                    <telerik:RadComboBox 
                                        AutoPostBack="True"
                                        OnSelectedIndexChanged="rcbChargeCcy2_OnSelectedIndexChanged"
                                        AppendDataBoundItems="True"
                                        ID="rcbChargeCcy2" runat="server"
                                        MarkFirstMatch="True" 
                                        AllowCustomText="false">
                                        <ExpandAnimation Type="None" />
                                        <CollapseAnimation Type="None" />
                                    </telerik:RadComboBox>
                                </td>
                            </tr>
                            <tr>
                                <td class="MyLable">Charge Acct</td>
                                <td class="MyContent" >
                                    <telerik:RadComboBox DropDownCssClass="KDDL"
                                        AppendDataBoundItems="True"
                                        OnItemDataBound="rcbChargeAcct_ItemDataBound"
                                        ID="rcbChargeAcct2" runat="server"
                                        MarkFirstMatch="True" Width="300"
                                        AllowCustomText="false">
                                        <ExpandAnimation Type="None" />
                                        <CollapseAnimation Type="None" />
                                    </telerik:RadComboBox>
                                </td>
                            </tr>
                            <tr style="display: none">
                                <td class="MyLable">Charge Period</td>
                                <td class="MyContent">
                                    <asp:TextBox ID="tbChargePeriod2" Text="1" runat="server" Width="100" />
                                </td>
                            </tr>
                            <tr style="display: none">
                                <td class="MyLable">Exch. Rate</td>
                                <td class="MyContent">
                                    <telerik:RadNumericTextBox IncrementSettings-InterceptArrowKeys="true" IncrementSettings-InterceptMouseWheel="true" runat="server"
                                        ID="tbExcheRate2" Width="200px" />
                                </td>
                            </tr>
                            <tr>
                                <td class="MyLable">Charge Amt</td>
                                <td class="MyContent">
                                    <telerik:RadNumericTextBox IncrementSettings-InterceptArrowKeys="true" 
                                        IncrementSettings-InterceptMouseWheel="true" runat="server"
                                        ID="tbChargeAmt2" AutoPostBack="true"
                                        OnTextChanged="tbChargeAmt2_TextChanged" />
                                </td>
                            </tr>
                            <tr>
                                <td class="MyLable">Party Charged</td>
                                <td class="MyContent">
                                    <telerik:RadComboBox 
                                        AutoPostBack="True"
                                        OnSelectedIndexChanged="rcbPartyCharged2_SelectIndexChange"
                                        OnItemDataBound="rcbPartyCharged_ItemDataBound"
                                        ID="rcbPartyCharged2" runat="server"
                                        MarkFirstMatch="True" 
                                        AllowCustomText="false">
                                        <ExpandAnimation Type="None" />
                                        <CollapseAnimation Type="None" />
                                    </telerik:RadComboBox>
                                </td>
                            </tr>
                            <tr>
                                <td class="MyLable">Amort Charges</td>
                                <td class="MyContent">
                                    <telerik:RadComboBox
                                        ID="rcbOmortCharges2" runat="server"
                                        MarkFirstMatch="True" 
                                        AllowCustomText="false">
                                        <ExpandAnimation Type="None" />
                                        <CollapseAnimation Type="None" />
                                        <Items>
                                            <telerik:RadComboBoxItem Value="NO" Text="NO" />
                                            <telerik:RadComboBoxItem Value="YES" Text="YES" />
                                        </Items>
                                    </telerik:RadComboBox>
                                </td>
                            </tr>                        
                            <tr style="display: none">
                                <td class="MyLable">Charge Status</td>
                                <td class="MyContent">
                                    <telerik:RadComboBox AutoPostBack="true"
                                        OnSelectedIndexChanged="rcbChargeStatus2_SelectIndexChange"
                                        ID="rcbChargeStatus2" runat="server"
                                        MarkFirstMatch="True"
                                        AllowCustomText="false">
                                        <ExpandAnimation Type="None" />
                                        <CollapseAnimation Type="None" />
                                        <Items>
                                            <telerik:RadComboBoxItem Value="" Text="" />
                                            <telerik:RadComboBoxItem Value="CHARGE COLECTED" Text="2" />
                                            <telerik:RadComboBoxItem Value="CHARGE UNCOLECTED" Text="3" />
                                        </Items>
                                    </telerik:RadComboBox>
                                </td>
                            </tr>
                            <tr>
                                <td class="MyLable">Tax Code</td>
                                <td class="MyContent">
                                    <asp:Label ID="lblTaxCode2" runat="server" />
                                </td>
                            </tr>
                            <tr style="display: none">
                                <td class="MyLable">Tax Ccy</td>
                                <td class="MyContent">
                                    <asp:Label ID="lblTaxCcy2" runat="server" />
                                </td>
                            </tr>
                            <tr>
                                <td class="MyLable">Tax Amt</td>
                                <td class="MyContent">
                                    <asp:Label ID="lblTaxAmt2" runat="server" />
                                </td>
                            </tr>
                        </table>
                    </div>
                </telerik:RadPageView>
                <telerik:RadPageView runat="server" ID="RadPageView3" >
                    <div runat="server" ID="divACCPTCHG">
	                    <table width="100%" cellpadding="0" cellspacing="0" id="table4" runat="server">
		                    <tr>
			                    <td class="MyLable">Charge code</td>
			                    <td class="MyContent">
				                    <telerik:RadComboBox
					                    ID="tbChargeCode3" runat="server" 
					                    MarkFirstMatch="True"
					                    AllowCustomText="false">
					                    <ExpandAnimation Type="None" />
					                    <CollapseAnimation Type="None" />
				                    </telerik:RadComboBox>
			                    </td>
		                    </tr>                        
                            <tr>
			                    <td class="MyLable">Charge Ccy</td>
			                    <td class="MyContent">
				                    <telerik:RadComboBox 
                                        AutoPostBack="True"
                                        OnSelectedIndexChanged="rcbChargeCcy3_OnSelectedIndexChanged"
                                        AppendDataBoundItems="True"
					                    ID="rcbChargeCcy3" runat="server"
					                    MarkFirstMatch="True"
					                    AllowCustomText="false">
					                    <ExpandAnimation Type="None" />
					                    <CollapseAnimation Type="None" />
				                    </telerik:RadComboBox>
			                    </td>
		                    </tr>
	                    </table>
	                    <table width="100%" cellpadding="0" cellspacing="0" id="table5" runat="server" >
		                    <tr>
			                    <td class="MyLable">Charge Acct</td>
			                    <td class="MyContent" >
				                    <telerik:RadComboBox DropDownCssClass="KDDL"
                                        AppendDataBoundItems="True"
                                        OnItemDataBound="rcbChargeAcct_ItemDataBound"
                                        ID="rcbChargeAcct3" runat="server"
                                        MarkFirstMatch="True" Width="300"
                                        AllowCustomText="false">
                                        <ExpandAnimation Type="None" />
                                        <CollapseAnimation Type="None" />
                                    </telerik:RadComboBox>
			                    </td>
		                    </tr>
		                    <tr style="display: none">
			                    <td class="MyLable">Charge Period</td>
			                    <td class="MyContent">
				                    <asp:TextBox ID="tbChargePeriod3" Text="1" runat="server" Width="100" />
			                    </td>
		                    </tr>                        
		                    <tr style="display: none">
			                    <td class="MyLable">Exch. Rate</td>
			                    <td class="MyContent">
				                    <telerik:RadNumericTextBox IncrementSettings-InterceptArrowKeys="true" IncrementSettings-InterceptMouseWheel="true" runat="server"
					                    ID="tbExcheRate3" Width="200px" />
			                    </td>
		                    </tr>
		                    <tr>
			                    <td class="MyLable">Charge Amt</td>
			                    <td class="MyContent">
				                    <telerik:RadNumericTextBox 
					                    IncrementSettings-InterceptArrowKeys="true" 
					                    IncrementSettings-InterceptMouseWheel="true" 
					                    runat="server"
					                    ID="tbChargeAmt3" 
					                    AutoPostBack="true"
					                    OnTextChanged="tbChargeAmt3_TextChanged" />
			                    </td>
		                    </tr>
		                    <tr>
			                    <td class="MyLable">Party Charged</td>
			                    <td class="MyContent">
				                    <telerik:RadComboBox
					                    AutoPostBack="True"
					                    OnSelectedIndexChanged="rcbPartyCharged3_SelectIndexChange"
					                    OnItemDataBound="rcbPartyCharged_ItemDataBound"
					                    ID="rcbPartyCharged3" runat="server"
					                    MarkFirstMatch="True"
					                    AllowCustomText="false">
					                    <ExpandAnimation Type="None" />
					                    <CollapseAnimation Type="None" />
				                    </telerik:RadComboBox>
			                    </td>
		                    </tr>
		                    <tr>
			                    <td class="MyLable">Amort Charges</td>
			                    <td class="MyContent">
				                    <telerik:RadComboBox
					                    ID="rcbOmortCharges3" runat="server"
					                    MarkFirstMatch="True"
					                    AllowCustomText="false">
					                    <ExpandAnimation Type="None" />
					                    <CollapseAnimation Type="None" />
					                    <Items>
						                    <telerik:RadComboBoxItem Value="NO" Text="NO" />
						                    <telerik:RadComboBoxItem Value="YES" Text="YES" />
					                    </Items>
				                    </telerik:RadComboBox>
			                    </td>
		                    </tr>                        
		                    <tr style="display: none">
			                    <td class="MyLable">Charge Status</td>
			                    <td class="MyContent">
				                    <telerik:RadComboBox 
					                    ID="rcbChargeStatus3" runat="server"
					                    MarkFirstMatch="True"
					                    AllowCustomText="false">
					                    <ExpandAnimation Type="None" />
					                    <CollapseAnimation Type="None" />
					                    <Items>
						                    <telerik:RadComboBoxItem Value="" Text="" />
						                    <telerik:RadComboBoxItem Value="CHARGE COLECTED" Text="2" />
						                    <telerik:RadComboBoxItem Value="CHARGE UNCOLECTED" Text="3" />
					                    </Items>
				                    </telerik:RadComboBox>
			                    </td>
		                    </tr>
		                    <tr>
			                    <td class="MyLable">Tax Code</td>
			                    <td class="MyContent">
				                    <asp:Label ID="lblTaxCode3" runat="server" />
			                    </td>
		                    </tr>
		                    <tr style="display: none">
			                    <td class="MyLable">Tax Ccy</td>
			                    <td class="MyContent">
				                    <asp:Label ID="lblTaxCcy3" runat="server" />
			                    </td>
		                    </tr>
		                    <tr>
			                    <td class="MyLable">Tax Amt</td>
			                    <td class="MyContent">
				                    <asp:Label ID="lblTaxAmt3" runat="server" />
			                    </td>
		                    </tr>
	                    </table>
                    </div>
                </telerik:RadPageView>           
            </telerik:RadMultiPage>
        </div>
    </div>       
</div>
<telerik:RadAjaxLoadingPanel ID="RadAjaxLoadingPanel1" runat="server" Skin="Default"><img src="icons/bank/ajax-loader-16x16.gif" /></telerik:RadAjaxLoadingPanel>
<telerik:RadAjaxManager ID="RadAjaxManager1" runat="server" DefaultLoadingPanelID="RadAjaxLoadingPanel1">
    <AjaxSettings>        
        <telerik:AjaxSetting AjaxControlID="txtPresentorNo">
            <UpdatedControls>
                <telerik:AjaxUpdatedControl ControlID="lblPresentorNoMsg" />
                <telerik:AjaxUpdatedControl ControlID="txtPresentorName" />
                <telerik:AjaxUpdatedControl ControlID="lblPresentorNo_734Msg" />
                <telerik:AjaxUpdatedControl ControlID="txtPresentorNo_734" />
                <telerik:AjaxUpdatedControl ControlID="txtPresentorName_734" />
                <telerik:AjaxUpdatedControl ControlID="txtPresentorAddr_734_1" />
                <telerik:AjaxUpdatedControl ControlID="txtPresentorAddr_734_2" />
                <telerik:AjaxUpdatedControl ControlID="txtPresentorAddr_734_3" />
            </UpdatedControls>
        </telerik:AjaxSetting>        
        <telerik:AjaxSetting AjaxControlID="rcbChargeCcy">
            <UpdatedControls>
                <telerik:AjaxUpdatedControl ControlID="rcbChargeAcct" />
            </UpdatedControls>
        </telerik:AjaxSetting>        
        <telerik:AjaxSetting AjaxControlID="rcbChargeCcy2">
            <UpdatedControls>
                <telerik:AjaxUpdatedControl ControlID="rcbChargeAcct2" />
            </UpdatedControls>
        </telerik:AjaxSetting>
        
        <telerik:AjaxSetting AjaxControlID="rcbChargeCcy3">
            <UpdatedControls>
                <telerik:AjaxUpdatedControl ControlID="rcbChargeAcct3" />
            </UpdatedControls>
        </telerik:AjaxSetting>
        
        <telerik:AjaxSetting AjaxControlID="txtPresentorNo_734">
            <UpdatedControls>
                <telerik:AjaxUpdatedControl ControlID="lblPresentorNo_734Msg" />
                <telerik:AjaxUpdatedControl ControlID="txtPresentorName_734" />
                <telerik:AjaxUpdatedControl ControlID="txtPresentorAddr_734_1" />
                <telerik:AjaxUpdatedControl ControlID="txtPresentorAddr_734_2" />
                <telerik:AjaxUpdatedControl ControlID="txtPresentorAddr_734_3" />
            </UpdatedControls>
        </telerik:AjaxSetting>

    </AjaxSettings>
</telerik:RadAjaxManager>
<telerik:RadCodeBlock ID="RadCodeBlock1" runat="server">
    <script type="text/javascript">
        $("#<%=txtCode.ClientID %>").keyup(function (event) {
            if (event.keyCode == 13) {
                $("#<%=btSearch.ClientID %>").click();
            }
        });

        $("#<%=txtDiscrepancies.ClientID %>").keyup(function (event) {
            if (event.keyCode == 13) {
                $("#<%=txtDiscrepancies.ClientID %>").val($("#<%=txtDiscrepancies.ClientID %>").val() + '\n');
            }
        });

        $("#<%=txtDiscrepancies_734.ClientID %>").keyup(function (event) {
            if (event.keyCode == 13) {
                $("#<%=txtDiscrepancies_734.ClientID %>").val($("#<%=txtDiscrepancies_734.ClientID %>").val() + '\n');
            }
        });

        function txtPresentorRefNo_OnValueChanged() {
            var txt = $find("<%=txtPresentorRefNo.ClientID%>").get_value();
            $find("<%=txtPresentingBankRef.ClientID %>").set_value(txt);
        };
        
        function numAmount_OnValueChanged() {
            var txt = $find("<%=numAmount.ClientID%>").get_value();
            $find("<%=numAmountUtilization.ClientID %>").set_value(txt);
        };

        function dteDocsReceivedDate_OnValueChanged() {
            var txt = $find("<%=dteDocsReceivedDate.ClientID%>").get_selectedDate();
            $find("<%=dteDateUtilization.ClientID %>").set_selectedDate(txt);
        };

        function txtDiscrepancies_OnValueChanged() {
            var txt = $find("<%=txtDiscrepancies.ClientID%>").get_value();
            $find("<%=txtDiscrepancies_734.ClientID %>").set_value(txt);
        };

        function txtDiscrepancies_OnValueChanged() {
            $find("<%=txtDiscrepancies_734.ClientID %>").set_value($find("<%=txtDiscrepancies.ClientID %>").get_value());
        }
    </script>
</telerik:RadCodeBlock>
<div style="visibility: hidden;"><asp:Button ID="btSearch" runat="server" OnClick="btSearch_Click" Text="Search" /></div>
<div style="visibility: hidden;"><asp:Button ID="btDownloadMT734" runat="server" OnClick="btDownloadMT734_Click" Text="DownloadMT734" /></div>
<div style="visibility: hidden;"><asp:Button ID="btDownloadVAT" runat="server" OnClick="btDownloadVAT_Click" Text="DownloadVAT" /></div>
<div style="visibility: hidden;"><asp:Button ID="btDownloadXuatNB" runat="server" OnClick="btDownloadXuatNB_Click" Text="DownloadXuatNB" /></div>
<div style="visibility: hidden;"><asp:Button ID="btDownloadNhapNB" runat="server" OnClick="btDownloadNhapNB_Click" Text="DownloadNhapNB" /></div>