using Microsoft.AspNetCore.Mvc;
using StudApp.Models;
using System.Diagnostics;

namespace StudApp.Controllers
{
    public class HomeController : Controller
    {
        private readonly ILogger<HomeController> _logger;

        public HomeController(ILogger<HomeController> logger)
        {
            _logger = logger;
        }

        public IActionResult Index(int lang)
        {
            if (lang == 1 || lang == 0)
                ViewBag.Lang = "~/Views/Shared/_Layouten.cshtml";
            else
                ViewBag.Lang = "~/Views/Shared/_Layout.cshtml";

            return View();
        }

        public IActionResult Privacy()
        {
            return View();
        }

        [ResponseCache(Duration = 0, Location = ResponseCacheLocation.None, NoStore = true)]
        public IActionResult Error()
        {
            return View(new ErrorViewModel { RequestId = Activity.Current?.Id ?? HttpContext.TraceIdentifier });
        }
    }
}