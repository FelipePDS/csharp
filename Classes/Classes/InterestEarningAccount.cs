using System;

namespace Classes
{
    public class InterestEarningAccount : BankAccount
    {
        public InterestEarningAccount(string name, decimal initialBalance) : base(name, initialBalance)
        {

        }

        public override void PerformMonthEndTransactions()
        {
            if (Balance > 500m)
            {
                var interest = Balance * .05m;
                MakeDeposit(interest, DateTime.Now, "apply monthly interest");
            }
        }
    }
}
