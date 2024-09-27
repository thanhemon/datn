using Common.SystemInformation;
using Common.Web;
using Data.BLL;
using System;
using System.Threading.Tasks;
using Web.Models;

namespace Web.Admin
{
    public partial class Index : System.Web.UI.Page
    {
        private FilmBLL filmBLL;
        protected SystemInfo systemInfo;
        protected long pageVisitor;
        protected long movieNumber;
        protected long categoryNumber;
        protected long tagNumber;
        protected bool enableShowDetail;

        protected async void Page_Load(object sender, EventArgs e)
        {
            filmBLL = new FilmBLL();
            pageVisitor = PageVisitor.Views;
            enableShowDetail = false;
            try
            {
                if (CheckLoggedIn())
                {
                    systemInfo = new SystemInfo();
                    await LoadOverview();
                    enableShowDetail = true;
                }
                else
                {
                    Response.RedirectToRoute("Account_Login", null);
                }
            }
            catch (Exception ex)
            {
                Session["error"] = new ErrorModel { ErrorTitle = "Ngoại lệ", ErrorDetail = ex.Message };
                Response.RedirectToRoute("Notification_Error", null);
            }
            filmBLL.Dispose();
        }

        private bool CheckLoggedIn()
        {
            object obj = Session["userSession"];
            if (obj == null)
                return false;

            UserSession userSession = (UserSession)obj;
            return (userSession.role == "Admin" || userSession.role == "Editor");
        }

        private async Task LoadOverview()
        {
            movieNumber = await filmBLL.CountAllAsync();
            categoryNumber = await new CategoryBLL(filmBLL).CountAllAsync();
            tagNumber = await new TagBLL(filmBLL).CountAllAsync();
        }
    }
}