using Stud.BAL;
using Stud.Factory;
using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using json = System.Text.Json;
using System.Text.Json.Serialization;
using System.Configuration;
using Newtonsoft.Json;

namespace Stud.DAL
{
    public class EFIStudentReg : IStudentReg
    {
        string connectionString = StudConnectionString.CName;
        public string SaveStudentReg(Students students, IEnumerable<StudentSubjects> studentSubjects, int qType)
        {
            students.CreatedDate = DateTime.Now;
            if (students.RegNo == null || students.RegNo == "")
                students.RegNo = GetNextStudentRegNo();

            List<Students> studentsList = new List<Students>();
            studentsList.Add(students);

            string msg = string.Empty;
            msg = SaveData(studentsList, studentSubjects, qType);
            return msg;
        }

        public string SaveData(List<Students> student, IEnumerable<StudentSubjects> studentSubjects, int qType)
        {
            string msg = string.Empty;
            DataTable TblStudents = new DataTable();
            DataTable TblStudentSubjects = new DataTable();

            IEnumerable<Students> studentList = student;
            TblStudents = (DataTable)JsonConvert.DeserializeObject(JsonConvert.SerializeObject(studentList), typeof(DataTable));
            TblStudentSubjects = (DataTable)JsonConvert.DeserializeObject(JsonConvert.SerializeObject(studentSubjects), typeof(DataTable));

            DataTable dataTable = new DataTable();

            using (SqlConnection con = new SqlConnection(connectionString))
            {
                using (SqlCommand cmd = new SqlCommand("SaveStudentReg"))
                {
                    cmd.Connection = con;
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@TblStudents", SqlDbType.NVarChar);
                    cmd.Parameters["@TblStudents"].Value = TblStudents;
                    cmd.Parameters.AddWithValue("@TblStudentSubjects", SqlDbType.NVarChar);
                    cmd.Parameters["@TblStudentSubjects"].Value = TblStudentSubjects;
                    cmd.Parameters.AddWithValue("@qType", SqlDbType.Int);
                    cmd.Parameters["@qType"].Value = qType;
                    con.Open();
                    //cmd.ExecuteNonQuery();
                    SqlDataAdapter sda = new SqlDataAdapter(cmd);
                    con.Close();
                    sda.Fill(dataTable);
                    con.Close();
                }
            }
            if (dataTable != null && dataTable.Rows.Count > 0)
                msg = Convert.ToString(dataTable.Rows[0]["msg"]);

            return msg;
        }
        public string GetClassList(int lang)
        {
            string msg = string.Empty;
            DataTable dataTable = new DataTable();
            using (SqlConnection con = new SqlConnection(connectionString))
            {
                using (SqlCommand cmd = new SqlCommand("GetClass"))
                {
                    cmd.Connection = con;
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@lang", SqlDbType.Int);
                    cmd.Parameters["@lang"].Value = lang;
                    con.Open();
                    SqlDataAdapter sda = new SqlDataAdapter(cmd);
                    sda.Fill(dataTable);
                    con.Close();

                    msg = JsonConvert.SerializeObject(dataTable);
                    //msg = json.JsonSerializer.Serialize(dataTable);
                }
            }
            return msg.ToString();
        }

        public string GetSessionList(int ClassId, int lang)
        {
            string msg = string.Empty;
            DataTable dataTable = new DataTable();
            using (SqlConnection con = new SqlConnection(connectionString))
            {
                using (SqlCommand cmd = new SqlCommand("GetSession"))
                {
                    cmd.Connection = con;
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@lang", SqlDbType.Int);
                    cmd.Parameters["@lang"].Value = lang;
                    cmd.Parameters.AddWithValue("@ClassId", SqlDbType.Int);
                    cmd.Parameters["@ClassId"].Value = ClassId;
                    con.Open();
                    //cmd.ExecuteNonQuery();
                    SqlDataAdapter sda = new SqlDataAdapter(cmd);
                    sda.Fill(dataTable);
                    con.Close();
                    //msg = json.JsonSerializer.Serialize(dataTable);
                    msg = JsonConvert.SerializeObject(dataTable);
                }
            }
            return msg.ToString();
        }

        public string GetSubjectList(int ClassId, int SessionId, int lang, string searchValue, int qType)
        {
            string msg = string.Empty;
            DataTable dataTable = new DataTable();
            using (SqlConnection con = new SqlConnection(connectionString))
            {
                using (SqlCommand cmd = new SqlCommand("GetSubjects"))
                {
                    cmd.Connection = con;
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@lang", SqlDbType.Int);
                    cmd.Parameters["@lang"].Value = lang;
                    cmd.Parameters.AddWithValue("@ClassId", SqlDbType.Int);
                    cmd.Parameters["@ClassId"].Value = ClassId;
                    cmd.Parameters.AddWithValue("@SessionId", SqlDbType.Int);
                    cmd.Parameters["@SessionId"].Value = SessionId;
                    cmd.Parameters.AddWithValue("@searchValue", SqlDbType.VarChar);
                    cmd.Parameters["@searchValue"].Value = searchValue == null ? "0" : searchValue;
                    cmd.Parameters.AddWithValue("@qType", SqlDbType.Int);
                    cmd.Parameters["@qType"].Value = qType;
                    con.Open();
                    //cmd.ExecuteNonQuery();
                    SqlDataAdapter sda = new SqlDataAdapter(cmd);
                    sda.Fill(dataTable);
                    con.Close();
                    //msg = json.JsonSerializer.Serialize(dataTable);
                    msg = JsonConvert.SerializeObject(dataTable);
                }
            }
            return msg.ToString();
        }

        public string GetNextStudentRegNo()
        {
            string NewStudentRegNo = string.Empty;
            DataTable dataTable = new DataTable();
            using (SqlConnection con = new SqlConnection(connectionString))
            {
                using (SqlCommand cmd = new SqlCommand("GetNextStudentRegNo"))
                {
                    cmd.Connection = con;
                    cmd.CommandType = CommandType.StoredProcedure;
                    con.Open();
                    SqlDataAdapter sda = new SqlDataAdapter(cmd);
                    sda.Fill(dataTable);
                    con.Close();
                    if (dataTable != null && dataTable.Rows.Count > 0)
                        NewStudentRegNo = Convert.ToString(dataTable.Rows[0]["NewStudentRegNo"]);
                }
            }
            return NewStudentRegNo;
        }

        public List<AutoData> GetAutoCompleteData(int qType, string SearchText)
        {
            string msg = string.Empty;
            DataTable dataTable = new DataTable();
            List<AutoData> ObjList = new List<AutoData>();

            using (SqlConnection con = new SqlConnection(connectionString))
            {
                using (SqlCommand cmd = new SqlCommand("GetAutoCompleteData"))
                {
                    cmd.Connection = con;
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@qType", SqlDbType.Int);
                    cmd.Parameters["@qType"].Value = qType;
                    cmd.Parameters.AddWithValue("@SearchText", SqlDbType.VarChar);
                    cmd.Parameters["@SearchText"].Value = SearchText;
                    con.Open();
                    SqlDataAdapter sda = new SqlDataAdapter(cmd);
                    sda.Fill(dataTable);
                    con.Close();

                    foreach (DataRow row in dataTable.Rows)
                    {
                        AutoData autoData = new AutoData();
                        autoData.Id = Convert.ToInt32(row["Id"]);
                        autoData.Name = Convert.ToString(row["Name"]);
                        ObjList.Add(autoData);
                    }
                }
            }
            return ObjList;
        }

        public string FillStudentData(int qType, string SearchText)
        {
            string msg = string.Empty;
            DataTable dataTable = new DataTable();
            using (SqlConnection con = new SqlConnection(connectionString))
            {
                using (SqlCommand cmd = new SqlCommand("FillStudentData"))
                {
                    cmd.Connection = con;
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@qType", SqlDbType.Int);
                    cmd.Parameters["@qType"].Value = qType;
                    cmd.Parameters.AddWithValue("@SearchText", SqlDbType.VarChar);
                    cmd.Parameters["@SearchText"].Value = SearchText;
                    con.Open();
                    SqlDataAdapter sda = new SqlDataAdapter(cmd);
                    sda.Fill(dataTable);
                    con.Close();
                    msg = JsonConvert.SerializeObject(dataTable);
                }
            }
            return msg.ToString();
        }

    }
}
