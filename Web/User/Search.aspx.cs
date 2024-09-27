using Common;
using Common.Upload;
using Data.BLL;
using Data.DTO;
using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using System.Web;
using System.Web.Mvc;
using Web.Models;

namespace Web.User
{
    public partial class Search : System.Web.UI.Page
    {
        protected List<FilmInfo> filmInfos;
        protected string keyword;

        protected async void Page_Load(object sender, EventArgs e)
        {
            try
            {
                string searchContent = Request.QueryString["input"];
                keyword = searchContent;
                await SearchFilms(searchContent);
            }
            catch (Exception ex)
            {
                Session["error"] = new ErrorModel { ErrorTitle = "Ngoại lệ", ErrorDetail = ex.Message };
                Response.RedirectToRoute("Notification_Error", null);
            }
        }
       
        public async Task<List<FilmInfo>> SearchFilms(string searchContent)
        {

            if (string.IsNullOrEmpty(searchContent))
            {
                Response.RedirectToRoute("User_Home", null);
            }
                using (FilmBLL filmBLL = new FilmBLL())
                {
                    filmInfos = await filmBLL.SeachFilmsAsync(searchContent);
                }
                if (filmInfos != null)
                {
                    filmInfos = filmInfos.GroupBy(f => f.ID).Select(g => g.First()).ToList();
                    foreach (FilmInfo filmInfo in filmInfos)
                    {
                        if (string.IsNullOrEmpty(filmInfo.thumbnail))
                            filmInfo.thumbnail = VirtualPathUtility
                                .ToAbsolute(string.Format("{0}/Default/default.png", FileUpload.ImageFilePath));
                        else
                            filmInfo.thumbnail = VirtualPathUtility
                                .ToAbsolute(string.Format("{0}/{1}", FileUpload.ImageFilePath, filmInfo.thumbnail));

                        Rating rating = new Rating(filmInfo.upvote, filmInfo.downvote);
                        filmInfo.scoreRating = rating.SolveScore();
                        filmInfo.url = GetRouteUrl("User_FilmDetail", new { slug = filmInfo.name.TextToUrl(), id = filmInfo.ID });
                    }
                }
                return filmInfos;
        }
    }
}