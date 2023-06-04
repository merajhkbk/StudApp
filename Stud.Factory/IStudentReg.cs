using Stud.BAL;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Stud.Factory
{
    public interface IStudentReg
    {
        string SaveStudentReg(Students students, IEnumerable<StudentSubjects> studentSubjects, int qType);
        string GetClassList(int lang);
        string GetSessionList( int ClassId, int lang);
        string GetSubjectList(int ClassId, int SessionId, int lang, string searchValue, int qType);
        string GetNextStudentRegNo();
        List<AutoData> GetAutoCompleteData(int qType, string SearchText);
        string FillStudentData(int qType, string SearchText);
    }
}
