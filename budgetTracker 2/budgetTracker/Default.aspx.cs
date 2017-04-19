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



            if (Session["expenseTable"] != null)
            {
                HtmlTable tableExpensesSession = (HtmlTable)Session["expenseTable"];
                int count = tableExpensesSession.Rows.Count; //need to set count to variable, because it changes
                for (int i = 0; i < count; i++)
                {
                    //Removes from session and then adds to acutal table
                    //so index will always be 0, because it gets popped off the top
                    tableExpenses.Rows.Add(tableExpensesSession.Rows[0]); 
                }
            }
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
            
        }

        private void addExpense()
        {
            SqlConnection con = new SqlConnection(GetConnectionString());
            insertExpense(con);


            /*HtmlTableRow row = new HtmlTableRow();
            HtmlTableCell cell1 = new HtmlTableCell();
            HtmlTableCell cell2 = new HtmlTableCell();
            HtmlTableCell cell3 = new HtmlTableCell();
            HtmlTableCell cell4 = new HtmlTableCell();


            decimal expenseAmount = Decimal.Parse(expenseAmountInput.Text),
                    curTotalSalary = Decimal.Parse(salaryTotalAmt.Value),
                    percentValue = (expenseAmount / curTotalSalary) * 100;
            string category = ddlExpenseCategory.SelectedValue.ToString();

            row.ID = "exp" + (tableExpenses.Rows.Count + 1);
            cell1.InnerText = ;
            row.Cells.Add(cell1);
            cell2.InnerText = expenseAmount.ToString("c");
            row.Cells.Add(cell2);
            cell3.InnerText = category;
            row.Cells.Add(cell3);
            tableExpenses.Rows.Add(row);
            cell4.InnerText = Math.Round(percentValue,2) + "%";
            row.Cells.Add(cell4);
            Session["expenseTable"] = tableExpenses;*/
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
            //addExpenseNameLabel();
            //addExpenseAmountLabel();
            addExpense();
            updateRemainingBudget();
            expenseAmountInput.Text = String.Empty;
            expenseNameInput.Text = String.Empty;
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
        }

        private static string GetConnectionString()
        {
            return ConfigurationManager.ConnectionStrings["UserDataConnectionString"].ConnectionString;
        }

        protected void Chart1_Load(object sender, EventArgs e)
        {
            // Murillo -- some logic so the pie chart will only update the slice that is the category.
        }

        /*//This function adds a new label for every expense
        private void addExpenseNameLabel()
        {
            Label lbl = new Label();
            lbl.ID = "expense" + i.ToString();
            lbl.Text = expenseNameInput.Text;
            this.Controls.Add(lbl);
            expenseNameInput.Text = String.Empty;
            i++;
        }

        //This function adds a new amount label for every expense
        private void addExpenseAmountLabel()
        {
            Label lbl = new Label();
            lbl.ID = "expenseAmount" + j.ToString();
            lbl.Text = "$" + expenseAmountInput.Text;
            this.Controls.Add(lbl);
            j++;
        }*/
    }
}