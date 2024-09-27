﻿using Common;
using Common.Upload;
using Data.BLL;
using Data.DTO;
using System;
using System.Text;
using System.Threading.Tasks;
using System.Web;
using System.Web.UI;
using Web.Models;

namespace Web.User
{
    public partial class FilmDetail : System.Web.UI.Page
    {
        protected FilmInfo filmInfo;
        protected string title_HeadTag;
        protected string keywords_MetaTag;
        protected string description_MetaTag;
        protected string hyplnkUpvote;
        protected string hyplnkDownvote;
        protected string hyplnkSearch;
        protected string userId;

        protected async void Page_Load(object sender, EventArgs e)
        {
            try
            {
                hyplnkSearch = GetRouteUrl("User_Search", null);
                hyplnkUpvote = GetRouteUrl("User_UpvoteFilm", null);
                hyplnkDownvote = GetRouteUrl("User_DownvoteFilm", null);
                await GetFilmById();
                userId = GetUserId();
                GenerateHeadTag();
            }
            catch (Exception ex)
            {
                Session["error"] = new ErrorModel { ErrorTitle = "Ngoại lệ", ErrorDetail = ex.Message };
                Response.RedirectToRoute("Notification_Error", null);
            }
        }



        private string GetFilmId()
        {
            object obj = Page.RouteData.Values["id"];
            if (obj == null)
                return null;
            return obj.ToString();
        }

        private string GetUserId()
        {
            object obj = Session["userSession"];
            if (obj == null)
                return null;

            UserSession userSession = (UserSession)obj;
            return userSession.userId;
        }

        private async Task GetFilmById()
        {
            string id = GetFilmId();
            if (id == null)
            {
                Response.RedirectToRoute("User_Home", null);
            }
            else
            {
                using (FilmBLL filmBLL = new FilmBLL())
                {
                    filmBLL.IncludeCategory = true;
                    filmBLL.IncludeTag = true;
                    filmBLL.IncludeCountry = true;
                    filmBLL.IncludeLanguage = true;
                    filmBLL.IncludeDirector = true;
                    filmBLL.IncludeCast = true;
                    filmInfo = await filmBLL.GetFilmAsync(id);
                }

                if (filmInfo == null)
                {
                    Response.RedirectToRoute("User_Home", null);
                }
                else
                {
                    Rating rating = new Rating(filmInfo.upvote, filmInfo.downvote);
                    filmInfo.starRating = rating.SolveStar();
                    filmInfo.scoreRating = rating.SolveScore();

                    if (string.IsNullOrEmpty(filmInfo.thumbnail))
                        filmInfo.thumbnail = VirtualPathUtility
                            .ToAbsolute(string.Format("{0}/Default/default.png", FileUpload.ImageFilePath));
                    else
                        filmInfo.thumbnail = VirtualPathUtility
                            .ToAbsolute(string.Format("{0}/{1}", FileUpload.ImageFilePath, filmInfo.thumbnail));

                    filmInfo.url = GetRouteUrl("User_Watch", new { slug = filmInfo.name.TextToUrl(), id = filmInfo.ID });
                }
            }
        }

        private void GenerateHeadTag()
        {
            if (filmInfo != null)
            {
                title_HeadTag = filmInfo.name;
                description_MetaTag = (string.Format("{0}...", filmInfo.description.TakeStr(100))).Replace("\n", " ");

                StringBuilder stringBuilder = new StringBuilder();
                foreach (TagInfo tagInfo in filmInfo.Tags)
                {
                    stringBuilder.Append(string.Format("{0}, ", tagInfo.name));
                }
                keywords_MetaTag = stringBuilder.ToString().TrimEnd(' ').TrimEnd(',');
            }
        }
    }
}