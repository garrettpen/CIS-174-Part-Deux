using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.HtmlControls;
using System.Data.SqlClient;
using System.Configuration;

namespace budgetTracker
{
    public partial class Default : System.Web.UI.Page
    {

        protected void Page_Load(object sender, EventArgs e)
        {
            decimal currentSalary;
            selectSalary(new SqlConnection(GetConnectionString()), out currentSalary);
            monthlySalaryLabel.Text = currentSalary.ToString("c");
        }

        protected bool selectSalary(SqlConnection con, out decimal currentSalary)
        {
            string salSel = "Select salaryAmt from salary where userName = '" + Session["userName"].ToString() + "'";
            currentSalary = 0;
            bool needsToInsert = true;
            con.Open();
            using (SqlCommand cmd = new SqlCommand(salSel, con))
            {
                SqlDataReader dr = cmd.ExecuteReader();
                if (dr.Read()) //make sure there is a salary to read
                {
                    currentSalary = Decimal.Parse(dr["salaryAmt"].ToString());
                    needsToInsert = false;
                }
                dr.Close();
            }
            con.Close();
            return needsToInsert;
        }

        protected void insertSalary(SqlConnection con, decimal salary)
        {
            String insertData = "insert into salary (userName,salaryAmt) values(@userName,@salaryAmt)";
            con.Open();
            SqlCommand cmd = new SqlCommand(insertData, con);
            cmd.Parameters.AddWithValue("@userName", Session["userName"].ToString());
            cmd.Parameters.AddWithValue("@salaryAmt", salary.ToString());
            cmd.ExecuteNonQuery();
            con.Close();
        }

        protected void updSalary(SqlConnection con, decimal salary)
        {
            String updData = "update salary set salaryAmt = @salaryAmt where userName = @userName";
            con.Open();
            SqlCommand cmd = new SqlCommand(updData, con);
            //Adding data from fields to the database
            cmd.Parameters.AddWithValue("@userName", Session["userName"].ToString());
            cmd.Parameters.AddWithValue("@salaryAmt", salary.ToString());
            cmd.ExecuteNonQuery();
            con.Close();
        }

        protected void insertExpense(SqlConnection con)
        {
            String insertData = "insert into expense (userName,expCategory,expName,expAmount) values(@userName,@expCategory,@expName,@expAmount)";
            con.Open();
            //Creating command object
            SqlCommand cmd = new SqlCommand(insertData, con);
            //Adding data from fields to the database
            cmd.Parameters.AddWithValue("@userName", Session["userName"].ToString());
            cmd.Parameters.AddWithValue("@expCategory", ddlExpenseCategory.SelectedValue.ToString());
            cmd.Parameters.AddWithValue("@expName", expenseNameInput.Text);
            cmd.Parameters.AddWithValue("@expAmount", expenseAmountInput.Text);
            cmd.ExecuteNonQuery();
            con.Close();
        }

        //upon clicking save salary button the number in the text box will be stored in a label
        protected void saveSalaryButton_Click(object sender, EventArgs e)
        {
            SqlConnection con = new SqlConnection(GetConnectionString());
            decimal currentSalary;
            bool needsToInsert = selectSalary(con, out currentSalary);
            decimal salaryToAdd = Decimal.Parse(salaryInput.Text);
            decimal salary = currentSalary + salaryToAdd;
            if (needsToInsert)
                insertSalary(con, salary);
            else
                updSalary(con, salary);
            monthlySalaryLabel.Text = salary.ToString("c");
            Response.Redirect(Request.RawUrl); //-> c# was being difficult letting me set up insert method...
        }

        private void addExpense()
        {
            SqlConnection con = new SqlConnection(GetConnectionString());
            insertExpense(con);
        }

        //This function updates the remianing monthly budget
        private void updateRemainingBudget()
        {
            SqlConnection con = new SqlConnection(GetConnectionString());
            decimal currentSalary;
            decimal expenseAmount = Decimal.Parse(expenseAmountInput.Text);
            bool needsToInsert = selectSalary(con, out currentSalary);
            decimal salary = currentSalary - expenseAmount;

            if (needsToInsert)
                insertSalary(con, salary);
            else
                updSalary(con, salary);
            monthlySalaryLabel.Text = salary.ToString("c");
        }

        protected void addExpenseButton_Click(object sender, EventArgs e)
        {
            addExpense();
            updateRemainingBudget();
            expenseAmountInput.Text = String.Empty;
            expenseNameInput.Text = String.Empty;
            Response.Redirect(Request.RawUrl); //-> c# was being difficult letting me set up insert method...
        }

        protected void expenseGrid_RowUpdated(object sender, GridViewUpdatedEventArgs e)
        {
            if (e.Exception != null)
            {
                lblError.Text = "A database error has occurrd. <br /><br /> Message: " + e.Exception.Message;
                e.ExceptionHandled = true;
                e.KeepInEditMode = true;
            }
            else if (e.AffectedRows == 0)
            {
                lblError.Text = "Another user may have updated that category.<br /> Please try again.";
            }
        }

        protected void expenseGrid_RowDeleted(object sender, GridViewDeletedEventArgs e)
        {
            if (e.Exception != null)
            {
                lblError.Text = "A database error has occurrd. <br /><br /> Message: " + e.Exception.Message;
                e.ExceptionHandled = true;
            }
            else if (e.AffectedRows == 0)
            {
                lblError.Text = "Another user may have updated that category.<br /> Please try again.";
            }
        }

        protected void expenseDataSource_Updated(object sender, ObjectDataSourceStatusEventArgs e)
        {
            e.AffectedRows = Convert.ToInt32(e.ReturnValue);
            SqlConnection con = new SqlConnection(GetConnectionString());
            decimal currentSalary;
            selectSalary(con, out currentSalary);
            monthlySalaryLabel.Text = currentSalary.ToString("c");

        }

        protected void expenseDataSource_Deleted(object sender, ObjectDataSourceStatusEventArgs e)
        {
            e.AffectedRows = Convert.ToInt32(e.ReturnValue);
            SqlConnection con = new SqlConnection(GetConnectionString());
            decimal currentSalary;
            selectSalary(con, out currentSalary);
            monthlySalaryLabel.Text = currentSalary.ToString("c");
        }

        private static string GetConnectionString()
        {
            return ConfigurationManager.ConnectionStrings["UserDataConnectionString"].ConnectionString;
        }
    }
}