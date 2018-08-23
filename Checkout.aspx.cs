using System;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;


public partial class Checkout : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }

    protected void RadioButton1_CheckedChanged(object sender, EventArgs e)
    {

    }

    protected void RadioButtonList1_SelectedIndexChanged(object sender, EventArgs e)
    {
        RadioButtonList rbl = (RadioButtonList)sender;
        Panel ccp = (Panel)Wizard1.FindControl("CreditCardPayment");

        if (rbl.SelectedValue == "CC")
        {
            ccp.Visible = true;
        }
        else
        {
            ccp.Visible = false;
        }
    }

    protected void Wizard2_FinishButtonClick(object sender, WizardNavigationEventArgs e)
    {
      

            SqlConnection conn = null;
            SqlTransaction trans = null;
            SqlCommand cmd = default(SqlCommand);
            ShoppingCart cart = StoredCart.Read();

            if (cart == null || cart.Items.Count == 0)
            {
                e.Cancel = true;
                return;
            }

            try
            {
                int SaleID = 0;

                conn = new SqlConnection(ConfigurationManager.ConnectionStrings
                                        ["CSConnectionString"].ConnectionString);
                conn.Open();

                trans = conn.BeginTransaction();

                cmd = new SqlCommand();
                cmd.Connection = conn;
                cmd.Transaction = trans;

                cmd.CommandText = "spInsertSale";
                cmd.CommandType = CommandType.StoredProcedure;

                cmd.Parameters.Add("@OrderDate", SqlDbType.DateTime);
                cmd.Parameters.Add("@CustName", SqlDbType.VarChar, 50);
                cmd.Parameters.Add("@Address", SqlDbType.VarChar, 250);
                cmd.Parameters.Add("@PostCode", SqlDbType.VarChar, 50);
                cmd.Parameters.Add("@DeliveryCharge", SqlDbType.Money);
                cmd.Parameters.Add("@TotalValue", SqlDbType.Money);
                cmd.Parameters.Add("@OrderID", SqlDbType.Int);

                cmd.Parameters["@OrderDate"].Value = DateTime.Now;
                cmd.Parameters["@CustName"].Value = ((TextBox)Wizard1.FindControl("txtName")).Text;
                cmd.Parameters["@Address"].Value = ((TextBox)Wizard1.FindControl("txtAddress")).Text;
                cmd.Parameters["@PostCode"].Value = ((TextBox)Wizard1.FindControl("txtEmail")).Text;
                cmd.Parameters["@DeliveryCharge"].Value = cart.DeliveryCharge;
                cmd.Parameters["@TotalValue"].Value = cart.Total;
                cmd.Parameters["@OrderID"].Direction = ParameterDirection.Output;

                cmd.ExecuteNonQuery();
                OrderID = Convert.ToInt32(cmd.Parameters["@OrderID"].Value);

                cmd.CommandText = "spInsertOrderItems";
                cmd.Parameters.Clear();
                cmd.Parameters.Add("@fkOrderID", SqlDbType.Int);
                cmd.Parameters.Add("@fkMenuItemID", SqlDbType.Int);
                cmd.Parameters.Add("@ItemSize", SqlDbType.VarChar, 10);
                cmd.Parameters.Add("@ItemName", SqlDbType.VarChar, 50);
                cmd.Parameters.Add("@Quantity", SqlDbType.Int);
                cmd.Parameters.Add("@SubTotal", SqlDbType.Money);
                cmd.Parameters["@fkOrderID"].Value = OrderID;


                foreach (CartItem item in cart.Items)
                {
                    cmd.Parameters["@fkMenuItemID"].Value = item.OrderID;
                    cmd.Parameters["@ItemSize"].Value = item.Console;
                    cmd.Parameters["@ItemSize"].Value = item.Title;
                    cmd.Parameters["@Quantity"].Value = item.Quantity;
                    cmd.Parameters["@SubTotal"].Value = item.SubTotal;

                    cmd.ExecuteNonQuery();
                }

                trans.Commit();
                lblSuccess.Visible = true;
            }
            catch
            {
                if (trans != null)
                {
                    trans.Rollback();
                }
                lblError.Visible = true;
                return;
            }
            finally
            {
                if (conn != null)
                {
                    conn.Close();
                }

            }
            cart.Items.Clear();
        
    }
}