using System;

namespace ClassInheritance
{
    public enum PublicationType
    {
        Misc,
        Book,
        Magazine,
        Article
    }

    public abstract class Publication
    {
        private bool published = false;
        private DateTime datePublished;
        private int totalPages;

        public Publication(string title, string publisher, PublicationType type)
        {
            if (String.IsNullOrEmpty(title))
                throw new ArgumentException("The title is required.");
            Title = title;

            if (String.IsNullOrEmpty(publisher))
                throw new ArgumentException("The publiher is required.");
            Publisher = publisher;

            Type = type;
        }

        public string Publisher { get; }
        
        public string Title { get; }
        
        public PublicationType Type { get; }

        public string CopyrightName { get; private set; }

        public int CopyrightDate { get; private set; }

        public int Pages
        {
            get { return totalPages; }
            set
            {
                if (value <= 0)
                    throw new ArgumentOutOfRangeException("The number of pages cannot be zero or negative.");
                totalPages = value;
            }
        }

        public void Publish(DateTime datePublished)
        {
            published = true;
            this.datePublished = datePublished;
        }

        public string PublicationDate
        {
            get
            {
                if (!published)
                    return "NYP";
                else
                    return datePublished.ToString("d");
            }
        }

        public void Copyright(string copyrightName, int copyrightDate)
        {
            if (String.IsNullOrEmpty(copyrightName))
                throw new ArgumentException("The name of the copyright holder is required.");
            CopyrightName = copyrightName;

            int currentYear = DateTime.Now.Year;
            if (copyrightDate < currentYear - 10 || copyrightDate > currentYear + 2)
                throw new ArgumentOutOfRangeException($"The copyright year must be between {currentYear - 10} and {currentYear + 1}");
            CopyrightDate = copyrightDate;
        }

        public override string ToString() => Title;
    }
}
