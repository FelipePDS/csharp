using System;
using System.Collections.Generic;
using System.Text;

namespace Classes
{
    public class BankAccount
    {
        public BankAccount(string name, decimal initialBalance) : this(name, initialBalance, 0) { }

        public BankAccount(string name, decimal initialBalance, decimal minimumBalance)
        {
            this.Owner = name;

            this.Number = accountNumberSeed.ToString();
            accountNumberSeed++;

            this.minimumBalance = minimumBalance;

            if (initialBalance > 0)
            {
                MakeDeposit(initialBalance, DateTime.Now, "initial balance");
            }
        }

        private static int accountNumberSeed = 1234567890;

        private readonly decimal minimumBalance = 0;

        public string Number { get; }
        public string Owner { get; set; }
        public decimal Balance 
        {
            get
            {
                decimal balance = 0;
                foreach (var transaction in allTransactions)
                {
                    balance += transaction.Amount;
                }

                return balance;
            }
        }

        List<Transaction> allTransactions = new List<Transaction>();

        public void MakeDeposit(decimal amount, DateTime date, string note)
        {
            if (amount <= 0)
            {
                throw new ArgumentOutOfRangeException(nameof(amount), "Amount of deposit must be positive");
            }

            var deposit = new Transaction(amount, date, note);
            allTransactions.Add(deposit);
        }

        public void MakeWithDrawal(decimal amount, DateTime date, string note)
        {
            if (amount <= 0)
            {
                throw new ArgumentOutOfRangeException(nameof(amount), "Amount of withdrawal must be positive");
            }

            var overdraftTransaction = CheckWithdrawalLimit(Balance - amount < minimumBalance);

            var withdrawal = new Transaction(-amount, date, note);
            allTransactions.Add(withdrawal);

            if (overdraftTransaction != null)
            {
                allTransactions.Add(overdraftTransaction);
            }
        }

        protected virtual Transaction CheckWithdrawalLimit(bool isOverdrawal)
        {
            if (isOverdrawal)
            {
                throw new ArgumentOutOfRangeException("Not sufficient funds for this withdrawal");
            }
            else
            {
                return default;
            }
        }

        public string GetAccountHistory()
        {
            var report = new StringBuilder();

            decimal balance = 0;
            report.AppendLine("Date\t\tAmount\tBalance\tNote");

            foreach (var transaction in allTransactions)
            {
                balance += transaction.Amount;
                report.AppendLine($"{transaction.Date.ToShortDateString()}\t{transaction.Amount}\t{balance}\t{transaction.Notes}");
            }

            return report.ToString();
        }

        public virtual void PerformMonthEndTransactions()
        {

        }
    }
}
