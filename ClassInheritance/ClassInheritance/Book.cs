using System;

namespace ClassInheritance
{
    public sealed class Book : Publication
    {
        public Book(string title, string author, string publisher) : 
            this(title, String.Empty, author, publisher) 
        { }

        public Book(string title, string isbn, string author, string publisher) : 
            base(title, publisher, PublicationType.Book)
        {
            if (!String.IsNullOrEmpty(isbn))
            {
                if (!(isbn.Length == 10 | isbn.Length == 13))
                    throw new ArgumentException("The ISBN must be a 10- or 13-character numeric String.");
                ulong nISBN = 0;
                if (!UInt64.TryParse(isbn, out nISBN))
                    throw new ArgumentException("The ISBN consist of numeric characters only.");
            }
            ISBN = isbn;

            Author = author;
        }

        public string ISBN { get; }

        public string Author { get; }

        public decimal Price { get; private set; }

        public string Currency { get; private set; }

        public decimal SetPrice(Decimal price, string currency)
        {
            if (price < 0)
                throw new ArgumentOutOfRangeException("The price cannot be negative.");
            decimal oldValue = Price;
            Price = price;

            if (currency.Length != 3)
                throw new ArithmeticException("The ISO currency symbol is a 3-character string.");
            Currency = currency;

            return oldValue;
        }

        public override bool Equals(object obj)
        {
            Book book = obj as Book;
            if (book == null)
                return false;
            else
                return ISBN == book.ISBN;
        }

        public override int GetHashCode() => ISBN.GetHashCode();

        public override string ToString()
        {
            return $"{(String.IsNullOrEmpty(Author) ? "" : Author + ", ")}{Title}";
        }
    }
}
