using System;

namespace Classes
{
    class Program
    {
        static void Main(string[] args)
        {
            BankAccount account = new BankAccount("Felipe", 2000);

            Console.WriteLine($"Account {account.Number} was created for {account.Owner} with {account.Balance} initial balance.");

            account.MakeWithDrawal(500, DateTime.Now, "Rent payment");
            Console.WriteLine(account.Balance);
            account.MakeDeposit(100, DateTime.Now, "Friend paid me back");
            Console.WriteLine(account.Balance);

            try
            {
                account.MakeWithDrawal(750, DateTime.Now, "Attempt to overdraw");
            }
            catch (ArgumentOutOfRangeException e)
            {
                Console.WriteLine("Exception caught trying to overdraw");
                Console.WriteLine(e.ToString());
            }

            Console.WriteLine(account.GetAccountHistory());

            var giftCard = new GiftCardAccount("Gift Card", 100, 50);
            giftCard.MakeDeposit(20, DateTime.Now, "get expensive coffee");
            giftCard.MakeDeposit(50, DateTime.Now, "buy groceries");
            giftCard.PerformMonthEndTransactions();
            giftCard.MakeDeposit(27.50m, DateTime.Now, "add some additional");
            Console.WriteLine(giftCard.GetAccountHistory());

            var saving = new InterestEarningAccount("saving account", 10000);
            saving.MakeDeposit(750, DateTime.Now, "save some money");
            saving.MakeDeposit(1250, DateTime.Now, "add more savings");
            saving.MakeWithDrawal(250, DateTime.Now, "Needed to pay monthly bills");
            saving.PerformMonthEndTransactions();
            Console.WriteLine(saving.GetAccountHistory());

            var lineOfCredit = new LineOfCreditAccount("line of credit", 0, 2000);
            lineOfCredit.MakeWithDrawal(1000m, DateTime.Now, "Take out monthly advance");
            lineOfCredit.MakeDeposit(50m, DateTime.Now, "Pay back small amount");
            lineOfCredit.MakeWithDrawal(5000m, DateTime.Now, "Emergency funds for repairs");
            lineOfCredit.MakeDeposit(150m, DateTime.Now, "Partial restoration on repairs");
            lineOfCredit.PerformMonthEndTransactions();
            Console.WriteLine(lineOfCredit.GetAccountHistory());

            Console.ReadKey();
        }
    }
}
