<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="Menu.aspx.cs" Inherits="Menu" %>
<%@ Import Namespace ="System.Data" %>
<%@ Import Namespace ="System.Data.SqlClient" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
        <asp:Label ID="Label5" runat="server"></asp:Label>
    <asp:HyperLink ID="HyperLink1" runat="server" NavigateUrl="~/Checkout">Proceed to Checkout</asp:HyperLink>
    <asp:DataList ID="DataList1" runat="server" OnItemDataBound="DataList1_ItemDataBound">
        <ItemTemplate>
            <asp:Image ID="Image2" runat="server" ImageUrl='<%# Eval("GraphicFile", "Images/{0}") %>' />
            <asp:Label ID="Label1" runat="server" Text='<%# Eval("ItemName") %>'></asp:Label>
            <asp:Label ID="Label2" runat="server" Text='<%# Eval("PizzaTopping") %>'></asp:Label>

            <asp:Repeater ID="Repeater1" runat="server" DataSource='<%# ((DataRowView)Container.DataItem) .CreateChildView("PizzaLink") %>' OnItemCommand="Repeater1_ItemCommand">
                <ItemTemplate > <span style =" color: blue">
                   <%# Eval ("ItemSize") %>: <%#Eval ("ItemPrice", "£{0:F2}")%>
                    <asp:LinkButton ID="LinkButton1" runat="server" CommandName='<%# Eval ("ItemSize") %>' CommandArgument='<%#Eval ("ItemPrice", "£{0:F2}")%>' Font-Size="Small">
                        <asp:Image ID="CartIcon" runat="server" ImageUrl="~/Images/cartIcon.gif"
                            AlternateText="Click to add to shopping cart" />
                        </asp:LinkButton>&nbsp; </span>  
                    </ItemTemplate>
               </asp:Repeater>
        </ItemTemplate>


    </asp:DataList>
</asp:Content>

