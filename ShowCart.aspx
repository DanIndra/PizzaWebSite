<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="ShowCart.aspx.cs" Inherits="ShowCart" %>

<%@ Register Src="~/ViewCart.ascx" TagPrefix="uc1" TagName="ViewCart" %>


<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <uc1:ViewCart runat="server" ID="ViewCart" />
    <asp:HyperLink ID="HyperLink1" runat="server" NavigateUrl="~/Checkout">Proceed to Checkout</asp:HyperLink>
</asp:Content>

