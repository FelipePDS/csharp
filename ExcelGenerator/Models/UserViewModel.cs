using System.Collections.Generic;

namespace ExcelGenerator.Models
{
    public class UserViewModel : BaseViewModel
    {
        public UserViewModel()
        {
            UserList = new List<User>();
        }

        public IEnumerable<User> UserList { get; set; }

        public string SearchString { get; set; }
    }
}
