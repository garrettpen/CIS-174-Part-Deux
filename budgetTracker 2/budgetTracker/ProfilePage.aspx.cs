using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace budgetTracker
{
    public partial class ProfilePage : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["userName"] == null) //kick user out if session doesn't exist
            {
                Response.Redirect("Login.aspx");
            }
            currentName.Text = Session["userName"].ToString();
            currentName.ReadOnly = true;
        }

        protected bool isUserNameTaken()
        {
            bool check = false;
            //Creating connection object
            SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["UserDataConnectionString"].ConnectionString);
            //Opening connection string
            conn.Open();
            //Creating SQL command and storing it in a variable
            String userExists = "select count(*) from userData where userName=@userName";
            //Creating command object
            SqlCommand com = new SqlCommand(userExists, conn);
            com.Parameters.AddWithValue("@username", newName.Text);
            //Converting result to an int to see if user already exists
            int temp = Convert.ToInt32(com.ExecuteScalar().ToString());
            if (temp == 1)
            {
                check = true;
            }
            //Close Connection
            conn.Close();
            return check;
        }

        protected void updProfile_Click(object sender, EventArgs e)
        {
            //Creating connection object
            SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["UserDataConnectionString"].ConnectionString);
            bool flag = true; //true tell falsy
            //Opening connection string
            conn.Open();

            //updating username if passes checks
            if (!newName.Text.Equals("") && !newName.Text.Equals(Session["userName"]))
            {   
                if (!isUserNameTaken())
                {
                    //Creating SQL command and storing it in a variable
                    String updateData = "UPDATE userData SET userName = @userName WHERE userName = @usernameSess";
                    //Creating command object
                    SqlCommand com = new SqlCommand(updateData, conn);
                    //Adding data from fields to the database
                    com.Parameters.AddWithValue("userName", newName.Text);
                    com.Parameters.AddWithValue("usernameSess", Session["userName"]);
                    com.ExecuteNonQuery();
                    Session["userName"] = newName.Text;
                    currentName.Text = newName.Text;
                }
                else
                {
                    userNameTaken.Text = "Username is already taken. Please try another.";
                    flag = false;
                }
            }

            //updating password if passes checks
            if (!newPassword.Text.Equals(""))
            {
                //Creating SQL command and storing it in a variable
                String updateData = "UPDATE userData SET password = @password WHERE userName = @usernameSess";
                //Creating command object
                SqlCommand com = new SqlCommand(updateData, conn);
                //Adding data from fields to the database
                com.Parameters.AddWithValue("password", newPassword.Text);
                com.Parameters.AddWithValue("usernameSess", Session["userName"]);
                com.ExecuteNonQuery();
            }
            conn.Close();

            //is everything good?
            if (!(newName.Text.Equals("") && newPassword.Text.Equals("")) && flag)
            {
                updateStatusPanel.CssClass = "disBlock panel panel-success";
                updateStatusHead.CssClass = "disBlock panel-heading";
                updateStatusHead.Text = "Your username and/or password has been updated successfully!";
                newName.Text = "";
                confirmName.Text = "";
                newPassword.Text = "";
                confirmPassword.Text = "";
            }
            else if (!flag) //display error message
            {
                updateStatusPanel.CssClass = "disBlock panel panel-danger";
                updateStatusHead.CssClass = "disBlock panel-heading";
                updateStatusHead.Text = "An error occured. Please check below for errors.";
            }
        }

        protected void logOutBtn_Click(object sender, EventArgs e) //log user out
        {
            Session.Remove("userName");
            Response.Redirect("Login.aspx");
        }
    }
}