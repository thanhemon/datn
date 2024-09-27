using Common;
using Data.BLL;
using Data.DTO;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using System.Web;
using System.Web.UI;
using Web.Models;

namespace Web.User
{
    public partial class SearchByTag : System.Web.UI.Page
    {
        private FilmBLL filmBLL;
        protected List<FilmInfo> filmInfos;
        protected int tagId;

        protected async void Page_Load(object sender, EventArgs e)
        {
            // Lấy tagId từ RouteData
            if (Page.RouteData.Values["tagId"] != null)
            {
                if (int.TryParse(Page.RouteData.Values["tagId"].ToString(), out tagId))
                {
                    filmBLL = new FilmBLL();
                    try
                    {
                        await SearchFilmsByTag(tagId); // Gọi phương thức và truyền tagId
                    }
                    catch (Exception ex)
                    {
                        Session["error"] = new ErrorModel { ErrorTitle = "Ngoại lệ", ErrorDetail = ex.Message };
                        Response.RedirectToRoute("Notification_Error", null);
                    }
                    finally
                    {
                        filmBLL.Dispose();
                    }
                }
                else
                {
                    // Xử lý khi tagId không hợp lệ
                    Response.RedirectToRoute("Notification_Error", null);
                }
            }
            else
            {
                // Xử lý khi không có tagId trong URL
                Response.RedirectToRoute("Notification_Error", null);
            }
        }

        private async Task SearchFilmsByTag(int tagId)
        {
            using (FilmBLL filmBLL = new FilmBLL())
            {
                // Lấy danh sách phim theo tagId
                filmInfos = await filmBLL.GetFilmsByTagAsync(tagId);
            }
        }
    }
}
