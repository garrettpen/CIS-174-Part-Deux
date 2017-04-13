using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Configuration;

namespace budgetTracker
{
    public partial class Login : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void loginButton_Click(object sender, EventArgs e)
        {
            //Creating connection object and opening it
            SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["UserDataConnectionString"].ConnectionString);
            conn.Open();
            //Creating string to hold query
            string checkUser = "select count(*) from userData where userName='"+userNameBox.Text+"'";
            //Creating object to store SQL command
            SqlCommand com = new SqlCommand(checkUser, conn);
            //storing query result in variable
            int temp = Convert.ToInt32(com.ExecuteScalar().ToString());
            conn.Close();
            //evaluating if user name exists 
            if (temp == 1)
            {
                //open connection
                conn.Open();
                //Storing query in variable
                string checkPasswordQuery = "select password from userData where userName='" + userNameBox.Text + "'";
                //Creating object to store SQL command
                SqlCommand passComm = new SqlCommand(checkPasswordQuery, conn);
                //Storing result of SQL command in variable
                string password = passComm.ExecuteScalar().ToString();
                conn.Close();
                //If password is correct go to application page
                if (password == passwordBox.Text)
                {
                    Session["userName"] = userNameBox.Text;
                    Response.Redirect("~/Default.aspx");
                }
                //prompt for correct password
                else
                {
                    Response.Write("Incorrect password. Please try again.");
                }
            }
            //prompt for correct username
            else
            {
                Response.Write("Incorrect user name. Please try again.");
            }
        }

    }
}