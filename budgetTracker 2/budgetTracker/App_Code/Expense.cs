namespace budgetTracker
{
    public class Expense
    {
        private string expenseId;
        private string expCategory;
        private string expName;
        private string expAmount;
        private string expPercent;

        public Expense()
        {
        }
        public string ExpenseId
        {
            get
            {
                return expenseId;
            }
            set
            {
                expenseId = value;
            }
        }
        public string ExpCategory
        {
            get
            {
                return expCategory;
            }
            set
            {
                expCategory = value;
            }
        }
        public string ExpName
        {
            get
            {
                return expName;
            }
            set
            {
                expName = value;
            }
        }
        public string ExpAmount
        {
            get
            {
                return expAmount;
            }
            set
            {
                expAmount = value;
            }
        }
        public string ExpPercent
        {
            get
            {
                return expPercent;
            }
            set
            {
                expPercent = value;
            }
        }
    }
}