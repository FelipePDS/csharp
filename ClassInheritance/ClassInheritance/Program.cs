using System;
using static System.Console;

namespace ClassInheritance
{
    class Program
    {
        static void Main(string[] args)
        {
            Book book = new Book("The Tempest", "0971655819", "Shakespeare, William", 
                "Public Domain Press");

            ShowPublicationInfo(book);
            book.Publish(new DateTime(2016, 8, 18));
            ShowPublicationInfo(book);

            Book book2 = new Book("The Tempest", "Classic Works Press", "Shakespeare, William");
            
            Write($"{book.Title} and {book2.Title} are the same publication: " +
                $"{((Publication) book).Equals(book2)}");

            ReadKey();
        }

        public static void ShowPublicationInfo(Publication pub)
        {
            string pubDate = pub.PublicationDate;
            WriteLine($"{pub.Title}, " +
                $"{(pubDate == "NYP" ? "Not Yet Publshed" : "published on " + pubDate):d} by {pub.Publisher}");
        }
    }
}
