using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Stud.Factory
{
    public class StudConnectionString
    {
        private static string cName = "Server=MERAJUDDIN-992;Database=Student;User Id=sa; Password=rfic@992;MultipleActiveResultSets=true";
        public static string CName
        {
            get => cName;
        }
    }
}
