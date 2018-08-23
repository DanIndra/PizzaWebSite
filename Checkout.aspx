<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="Checkout.aspx.cs" Inherits="Checkout" %>

<%@ Register Src="~/ViewCart.ascx" TagPrefix="uc1" TagName="ViewCart" %>


<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <style type="text/css">
        .auto-style6 {
            margin-left: 0px;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">

    <asp:Wizard ID="Wizard1" runat="server" Width="392%" BackColor="#EFF3FB"
        BorderColor="#003366" BorderWidth="1px" Font-Names="Verdana" Font-Size="1.0em" ActiveStepIndex="0" CssClass="auto-style6" Height="147px">
        <StepStyle Font-Size="Medium" ForeColor="#333333"></StepStyle>
        <SideBarButtonStyle BackColor="#006699" Font-Names="Verdana" ForeColor="White"></SideBarButtonStyle>
        <NavigationButtonStyle BackColor="White" BorderColor="#006699" BorderStyle="Solid" BorderWidth="1px" Font-Names="Verdana"></NavigationButtonStyle>         
        <HeaderStyle BackColor="#284E98" BorderColor="#EFF3FB" BorderStyle="Solid" BorderWidth="2px" Font-Bold="True"></HeaderStyle>

        <WizardSteps>
            <asp:WizardStep runat="server" StepType="Start" title="Delivery Address">
                <table style="width: 100%; height: 100%;" border="0" >
                    <tr>
                        <td style="width: 200px" > Name </td>
                        <td style="width: 400px" >
                            <asp:TextBox ID="txtName" runat="server" Width="300px"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td style="width: 200px" > Address </td>
                        <td style="width: 400px" >
                            <asp:TextBox ID="txtAddress" runat="server" Width="300px"
                            Columns="30" Rows="5" TextMode="MultiLine"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td style="width: 200px" > E-Mail </td>
                        <td style="width: 400px" >
                            <asp:TextBox ID="TextEmail" runat="server" Width="300px"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td style="width: 200px" ></td>
                        <td style="width: 400px" ></td>
                    </tr>
                </table>
            </asp:WizardStep>


            <asp:WizardStep runat="server" title="Payment">
                <asp:RadioButtonList ID="RadioButtonList1" runat="server" AutoPostBack="True" OnSelectedIndexChanged="RadioButtonList1_SelectedIndexChanged">
                    <asp:ListItem Selected="True" Value="COD">Cash On Delivery</asp:ListItem>
                    <asp:ListItem Value="CC">Credit Card</asp:ListItem>
                </asp:RadioButtonList>

                <asp:Panel ID="CreditCardPayment" runat="server" Visible="False" Width="100%">Card Type<asp:DropDownList ID="Cardtype" runat="server">
                    <asp:ListItem>MasterCard</asp:ListItem>
                    <asp:ListItem>Visa</asp:ListItem>
                    </asp:DropDownList>
                    <br />Card Number:
                    <asp:TextBox ID="TxtCardNumber" runat="server"></asp:TextBox>
                    <br />Expires
                    <asp:TextBox ID="txtExpiremonth" runat="server"></asp:TextBox>
                    /
                    <asp:TextBox ID="txtExpireYear" runat="server"></asp:TextBox>
                </asp:Panel>
            </asp:WizardStep>
            <asp:WizardStep runat="server" StepType="Finish" Title="Shopping Cart">
                <uc1:ViewCart runat="server" ID="ViewCart" />
                <asp:ObjectDataSource ID="ObjectDataSource1" runat="server" SelectMethod="Read" TypeName="StoredCart"></asp:ObjectDataSource>
                <asp:DetailsView ID="DetailsView1" runat="server" Height="50px" Width="125px" AutoGenerateRows="False" DataSourceID="ObjectDataSource1">
                    <Fields>
                        <asp:BoundField DataField="TotalValue" HeaderText="TotalValue" ReadOnly="True" SortExpression="TotalValue" />
                        <asp:BoundField DataField="DeliveryCharge" HeaderText="DeliveryCharge" SortExpression="DeliveryCharge" />
                    </Fields>
                </asp:DetailsView>
            
            </asp:WizardStep>
            <asp:WizardStep runat="server" StepType="Complete" Title="Order Complete">
                Thank you for your order<br />
                <asp:Label ID="lblSuccess" runat="server" BorderStyle="Double"
                    Font-Size="Small" ForeColor="#006699" Visible="false">
                    Your order has been successfully placed. Please allow 5 days for delivery.
                </asp:Label>
                <asp:Label ID="lblError" runat="server" BorderStyle="Double"
                    Font-Size="Small" ForeColor="#006699" Visible="false">
                    Sorry but we are unable to complete your order at this time. Please try again later.
                </asp:Label>
            </asp:WizardStep>
        </WizardSteps>
    </asp:Wizard>

    <asp:Wizard ID="Wizard2" runat="server" OnFinishButtonClick="Wizard2_FinishButtonClick">
        <WizardSteps>
            <asp:WizardStep runat="server" title="Step 1">
            </asp:WizardStep>
            <asp:WizardStep runat="server" title="Step 2">
            </asp:WizardStep>
        </WizardSteps>
    </asp:Wizard>

</asp:Content>

