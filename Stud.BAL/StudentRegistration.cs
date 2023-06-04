using System.ComponentModel;

namespace Stud.BAL
{
    public class Students
    {
        public int StudId { get; set; }
        [DisplayName("Registration Number")]
        public string? RegNo { get; set; }
        [DisplayName("Full Name")]
        public string? FullName { get; set; }
        public DateTime DOB { get; set; }
        public string? Gender { get; set; }
        [DisplayName("Email Address")]
        public string? EmailAddr { get; set; }
        [DisplayName("DOA(Admission Date)")]
        public DateTime DOA { get; set; }
        [DisplayName("Class")]
        public int ClassId { get; set; }
        [DisplayName("Session/Batch")]
        public int SessionId { get; set; }
        public bool Deleted { get; set; }
        public string? CreatedBy { get; set; }
        public DateTime? CreatedDate { get; set; }
        public string? UpdatedBy { get; set; }
        public DateTime? UpdatedDate { get; set; }
    }

    public class StudentSubjects
    {
        public int StudSubId { get; set; }
        public string? RegNo { get; set; }
        public int SubjectId { get; set; }
        public string? SubjectNo { get; set; }
        public string? CrHours { get; set; }
        public decimal TotalMarks { get; set; }
        public string? Remarks { get; set; }
        public bool Deleted { get; set; }
        public string? CreatedBy { get; set; }
        public DateTime? CreatedDate { get; set; }
    }

    public class Class
    {
        public int ClassId { get; set; }
        public string? EngName { get; set; }
        public string? ArbName { get; set; }
        public bool Deleted { get; set; }
        public string? CreatedBy { get; set; }
        public DateTime CreatedDate { get; set; }
        public string? UpdatedBy { get; set; }
        public DateTime UpdatedDate { get; set; }
    }

    public class Session
    {
        public int SessionId { get; set; }
        public int ClassId { get; set; }
        public string? EngName { get; set; }
        public string? ArbName { get; set; }
        public bool Deleted { get; set; }
        public string? CreatedBy { get; set; }
        public DateTime CreatedDate { get; set; }
        public string? UpdatedBy { get; set; }
        public DateTime UpdatedDate { get; set; }
    }

    public class Subjects
    {
        public int SubjectId { get; set; }
        public int ClassId { get; set; }
        public int SessionId { get; set; }
        public string? SubjectNo { get; set; }
        public string? EngSubjectName { get; set; }
        public string? ArbSubjectName { get; set; }
        public string? CrHours { get; set; }
        public decimal TotalMarks { get; set; }
        public string? Remarks { get; set; }
        public bool Deleted { get; set; }
        public string? CreatedBy { get; set; }
        public DateTime CreatedDate { get; set; }
        public string? UpdatedBy { get; set; }
        public DateTime UpdatedDate { get; set; }
    }

    public class AutoData
    {
        public int Id { get; set; }
        public string? Name { get; set; }

    }
}