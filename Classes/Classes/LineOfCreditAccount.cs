using System;

namespace Classes
{
    public class LineOfCreditAccount : BankAccount
    {
        public LineOfCreditAccount(string name, decimal initialBalance) : base(name, initialBalance)
        {
            
        }

        public LineOfCreditAccount(string name, decimal initialBalance, decimal creditLimit) : base(name, initialBalance, -creditLimit)
        {
            
        }

        protected override Transaction CheckWithdrawalLimit(bool isOverdrawn) =>
            isOverdrawn
            ? new Transaction(-20, DateTime.Now, "Apply overdraft fee")
            : default;

        public override void PerformMonthEndTransactions()
        {
            if (Balance < 0)
            {
                var interest = -Balance * .07m;
                MakeWithDrawal(interest, DateTime.Now, "Charge monthly interest");
            }
        }
    }
}
