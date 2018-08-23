using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Diagnostics;
using System.Data.SqlClient;
using System.Configuration;

public partial class Menu : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        DataSet ds = new DataSet();

        string sqlGames = "SELECT MenuItemID, MenuItemType, ItemName, PizzaTopping, " +
            "Description, GraphicFile FROM MenuItem";

        string sqlConsoles = "SELECT fkMenuItemID, ItemSize, ItemPrice " +
            "FROM SizeAndPrice INNER JOIN MenuItem ON MenuItem.MenuItemID = SizeAndPrice.fkMenuItemID " +
            "ORDER BY ItemPrice DESC";

        string ConnectSQLshop = ConfigurationManager.ConnectionStrings["PizzaDBConnectionString1"].ConnectionString;

        using (SqlConnection con = new SqlConnection(ConnectSQLshop))
        {
            SqlDataAdapter da = new SqlDataAdapter(sqlGames, con);
            try
            {
                da.Fill(ds, "MenuItem");
                da.SelectCommand.CommandText = sqlConsoles;
                da.Fill(ds, "SizeAndPrice");
            }
            catch (Exception ex)
            {
                Label5.Text = "ERROR: " + ex.Message;
                return;
            }
        }

        DataColumn pkcol = ds.Tables["MenuItem"].Columns["MenuItemID"];
        DataColumn fkcol = ds.Tables["SizeAndPrice"].Columns["fkMenuItemID"];
        DataRelation dr = new DataRelation("PizzaLink", pkcol, fkcol);
        ds.Relations.Add(dr);

        DataList1.DataSource = ds;
        DataList1.DataMember = "MenuItem";
        DataList1.DataBind();
    }

    protected void DataList1_ItemDataBound(object sender, DataListItemEventArgs e)
    {
        if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
        {
            Repeater rpt = (Repeater)e.Item.FindControl("Repeater1");
            HiddenField ItemID = new HiddenField();
            HiddenField ItemName = new HiddenField();

            ItemID.ID = "ItemID";
            ItemName.ID = "ItemName";

            ItemID.Value = DataBinder.Eval(e.Item.DataItem, "MenuItemID").ToString();
            ItemName.Value = (string)DataBinder.Eval(e.Item.DataItem, "MenuItemtype");

            rpt.Controls.Add(ItemID);
            rpt.Controls.Add(ItemName);
        }
    }

    protected void Repeater1_ItemCommand(object source, RepeaterCommandEventArgs e)
    {
        Repeater rpt = (Repeater)source;
        HiddenField IDControl = (HiddenField)rpt.FindControl("ItemID");
        HiddenField NameControl = (HiddenField)rpt.FindControl("ItemName");

        int MenuItemID = Convert.ToInt32(IDControl.Value);
        string MenuItemType = NameControl.Value;
        string ItemSize = e.CommandName.ToString();
        decimal ItemPrice = Convert.ToDecimal(e.CommandArgument);
        StoredCart.InsertItem(MenuItemID, Title, ItemSize, 1, ItemPrice);
        Label5.Text = string.Format("{0} ({1}) added to the shopping cart", Title, ItemSize);
    }
}