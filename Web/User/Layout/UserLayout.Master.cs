using Data.BLL;
using Data.DTO;
using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Web.Models;

namespace Web.User.Layout
{
    public partial class UserLayout : System.Web.UI.MasterPage
    {
        protected List<CategoryInfo> categories;
        protected string hyplnkSearch;
        protected string hyplnkWatchedList;
        protected string hyplnkLiteVersion;
        protected string hyplnkHome;
        protected string hyplnkFavote;
        public string suggeted;

        protected void Page_Load(object sender, EventArgs e)
        {
            try
            {
                object obj = Session["userSession"];
                if (obj == null)
                {
                    hyplnkAccount.HRef = GetRouteUrl("Account_Login", null);
                    hyplnkAccount.InnerText = "Đăng nhập / Đăng ký";

                    // Hide the Change Password link
                    liChangePassword.Visible = false;
                }
                else
                {
                    hyplnkAccount.HRef = GetRouteUrl("Account_Logout", null);
                    hyplnkAccount.InnerText = "Đăng xuất";

                    // Show the Change Password link
                    liChangePassword.Visible = true;

                    hyplnkChangePassword.HRef = GetRouteUrl("Account_ChangePassword", null);
                    hyplnkChangePassword.InnerText = "Đổi mật khẩu";
                }

                suggeted = GetRouteUrl("Suggeted");
                hyplnkSearch = GetRouteUrl("User_Search", null);
                hyplnkWatchedList = GetRouteUrl("User_WatchedList", null);
                hyplnkLiteVersion = GetRouteUrl("User_Home_Lite", null);
                hyplnkHome = GetRouteUrl("User_Home", null);
                hyplnkFavote = GetRouteUrl("User_Favote", null);
                GetCategories();
            }
            catch (Exception ex)
            {
                Session["error"] = new ErrorModel { ErrorTitle = "Ngoại lệ", ErrorDetail = ex.Message };
                Response.RedirectToRoute("Notification_Error", null);
            }
        }

    private void GetCategories()
        {
            using (CategoryBLL categoryBLL = new CategoryBLL())
            {
                categories = categoryBLL.GetCategories()
                .Select(c => new CategoryInfo
                {
                    ID = c.ID,
                    name = c.name,
                    description = c.description,
                    url = GetRouteUrl("User_FilmsByCategory", new { slug = c.name.TextToUrl(), id = c.ID })
                }).ToList();
            }
        }
    }
}