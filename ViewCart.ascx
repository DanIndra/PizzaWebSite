<%@ Control Language="C#" AutoEventWireup="true" CodeFile="ViewCart.ascx.cs" Inherits="CartUI" %>
<asp:ObjectDataSource ID="ObjectDataSource1" runat="server" DeleteMethod="DeleteItem" InsertMethod="InsertItem" SelectMethod="ReadItems" TypeName="StoredCart" UpdateMethod="UpdateItem">
    <DeleteParameters>
        <asp:Parameter Name="MenuItemID" Type="Int32" />
        <asp:Parameter Name="ItemSize" Type="String" />
    </DeleteParameters>
    <InsertParameters>
        <asp:Parameter Name="MenuItemID" Type="Int32" />
        <asp:Parameter Name="MenuItemType" Type="String" />
        <asp:Parameter Name="ItemSize" Type="String" />
        <asp:Parameter Name="Quantity" Type="Int32" />
        <asp:Parameter Name="ItemPrice" Type="Decimal" />
    </InsertParameters>
    <UpdateParameters>
        <asp:Parameter Name="MenuItemID" Type="Int32" />
        <asp:Parameter Name="ItemSize" Type="String" />
        <asp:Parameter Name="Quantity" Type="Int32" />
    </UpdateParameters>
</asp:ObjectDataSource>
<asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" DataKeyNames="MenuItemID,ItemSize" DataSourceID="ObjectDataSource1">
    <Columns>
        <asp:CommandField InsertVisible="False" ShowDeleteButton="True" ShowEditButton="True" />
        <asp:BoundField DataField="MenuItemID" HeaderText="MenuItemID" SortExpression="MenuItemID" Visible="False" />
        <asp:BoundField DataField="MenuItemType" HeaderText="MenuItemType" ReadOnly="True" SortExpression="MenuItemType" />
        <asp:BoundField DataField="ItemSize" HeaderText="ItemSize" ReadOnly="True" SortExpression="ItemSize" />
        <asp:BoundField DataField="Quantity" HeaderText="Quantity" SortExpression="Quantity" />
        <asp:BoundField DataField="ItemPrice" DataFormatString="{0:c}" HeaderText="ItemPrice" ReadOnly="True" SortExpression="ItemPrice" />
        <asp:BoundField DataField="SubTotal" DataFormatString="{0:c}" HeaderText="SubTotal" ReadOnly="True" SortExpression="SubTotal" />
    </Columns>
    <EmptyDataTemplate>
        You have not ordered any items yet,<br /> Please vist the orders pages to add items to the cart.
    </EmptyDataTemplate>
</asp:GridView>

