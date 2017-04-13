using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.ComponentModel;


namespace budgetTracker
{
    [DataObject(true)]
    public class ExpenseDB
    {
        [DataObjectMethod(DataObjectMethodType.Select)]
        public static List<Expense> GetExpenses(string userName)
        {
            List<Expense> expenseList = new List<Expense>();
            string expSel = "Select expenseId, expCategory, expName, expAmount from expense where userName = '" + userName + "'";
            string salSel = "Select salaryAmt from salary where userName = '" + userName + "'";
            using (SqlConnection con = new SqlConnection(GetConnectionString()))
            {
                con.Open();
                decimal salaryAmt = 1; //safety
                //select to get salary amount
                using (SqlCommand cmd = new SqlCommand(salSel, con))
                {
                    SqlDataReader dr = cmd.ExecuteReader();
                    if (dr.Read()) //make sure there is a salary to read 
                        salaryAmt = Decimal.Parse(dr["salaryAmt"].ToString());
                    dr.Close();
                }

                //select to get the table data
                using (SqlCommand cmd = new SqlCommand(expSel, con))
                {
                    SqlDataReader dr = cmd.ExecuteReader();
                    Expense expense;
                    while (dr.Read())
                    {
                        expense = new Expense();
                        expense.ExpenseId = dr["expenseId"].ToString();
                        expense.ExpCategory = dr["expCategory"].ToString();
                        expense.ExpName = dr["expName"].ToString();
                        expense.ExpAmount = dr["expAmount"].ToString();
                        expense.ExpPercent = Math.Round(((Decimal.Parse(expense.ExpAmount) / salaryAmt) * 100), 2) + "%";
                        expenseList.Add(expense);
                    }
                    dr.Close();
                }
                con.Close();
            }
            return expenseList;
        }

        [DataObjectMethod(DataObjectMethodType.Update)]
        public static int UpdateExpense(string ExpCategory, string ExpName, string ExpAmount, string original_ExpenseId, string original_ExpCategory, string original_ExpName, string original_ExpAmount, string original_ExpPercent)
        {
            int updateCount = 0;
            string updateStr = "Update expense " +
                               "Set expCategory = @ExpCategory, " +
                               "expName = @ExpName, " +
                               "expAmount = @ExpAmount " +
                               "Where expenseId = @original_ExpenseId";
            using (SqlConnection con = new SqlConnection(GetConnectionString()))
            {
                using (SqlCommand cmd = new SqlCommand(updateStr, con))
                {
                    cmd.Parameters.AddWithValue("ExpCategory", ExpCategory);
                    cmd.Parameters.AddWithValue("ExpName", ExpName);
                    cmd.Parameters.AddWithValue("ExpAmount", ExpAmount);
                    cmd.Parameters.AddWithValue("original_ExpenseId", original_ExpenseId);
                    con.Open();
                    updateCount = cmd.ExecuteNonQuery();
                    con.Close();
                }
            }
            return updateCount;
        }

        private static string GetConnectionString()
        {
            return ConfigurationManager.ConnectionStrings["UserDataConnectionString"].ConnectionString;
        }
    }
}