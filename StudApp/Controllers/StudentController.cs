using Microsoft.AspNetCore.Mvc;
using Stud.BAL;
using Stud.Factory;
using StudApp.Models;
using System.Diagnostics;

namespace StudApp.Controllers
{
    public class StudentController : Controller
    {
        private readonly ILogger<HomeController> _logger;
        private readonly IStudentReg iStudentReg;

        public StudentController(ILogger<HomeController> logger, IStudentReg iStud)
        {
            _logger = logger;
            iStudentReg = iStud; ;
        }
        public IActionResult Index()
        {

            return View();
        }
        public IActionResult StudentReg(int lang)
        {
            if (lang == 1 || lang == 0)
                ViewBag.Lang = "~/Views/Shared/_Layouten.cshtml";
            else
                ViewBag.Lang = "~/Views/Shared/_Layout.cshtml";

            return View();
        }

        [HttpPost]
        public JsonResult GetAutoRegistrationNo(string Prefix)
        {
            List<AutoData> ObjList = new List<AutoData>();
            ObjList = iStudentReg.GetAutoCompleteData(1, Prefix);
            return Json(ObjList);
        }

        [HttpPost]
        public JsonResult GetAutoEmailAddr(string Prefix)
        {
            List<AutoData> ObjList = new List<AutoData>();
            ObjList = iStudentReg.GetAutoCompleteData(2, Prefix);
            return Json(ObjList);
        }
        [HttpPost]
        public JsonResult GetAutoFullName(string Prefix)
        {
            List<AutoData> ObjList = new List<AutoData>();
            ObjList = iStudentReg.GetAutoCompleteData(3, Prefix);
            return Json(ObjList);
        }

        [HttpPost]
        [ActionName("SaveData")]
        public string SaveData(Students student, IEnumerable<StudentSubjects> studentSubjects, int qType)
        {
            string msg = string.Empty;
            try
            {
                msg = iStudentReg.SaveStudentReg(student, studentSubjects, qType);
            }
            catch (Exception ex)
            {
                msg = ex.Message;
            }
            return msg;
        }

        [HttpGet]
        [ActionName("GetClassList")]
        public string GetClassList()
        {
            int lang = 1;
            string? msg = string.Empty;
            msg = iStudentReg.GetClassList(lang);
            return msg;
        }

        [HttpGet]
        [ActionName("GetSessionList")]
        public string GetSessionList(int ClassId)
        {
            int lang = 1;
            string msg = string.Empty;
            msg = iStudentReg.GetSessionList(ClassId, lang);
            return msg;
        }

        [HttpGet]
        [ActionName("GetNextStudentRegNo")]
        public string GetNextStudentRegNo()
        {
            string msg = string.Empty;
            msg = iStudentReg.GetNextStudentRegNo();
            return msg;
        }

        [HttpGet]
        [ActionName("FillStudentData")]
        public string FillStudentData(string value, int qType)
        {
            string msg = string.Empty;
            try
            {
                msg = iStudentReg.FillStudentData(qType, value);
            }
            catch (Exception ex)
            {
                msg = ex.Message;
            }
            return msg;
        }

        [HttpGet]
        [ActionName("GetSubjectList")]
        public string GetSubjectList(int ClassId, int SessionId, string searchValue, int qType)
        {
            int lang = 1;
            string? msg = string.Empty;
            msg = iStudentReg.GetSubjectList(ClassId, SessionId, lang, searchValue, qType);
            return msg;
        }

        [ResponseCache(Duration = 0, Location = ResponseCacheLocation.None, NoStore = true)]
        public IActionResult Error()
        {
            return View(new ErrorViewModel { RequestId = Activity.Current?.Id ?? HttpContext.TraceIdentifier });
        }
    }
}
