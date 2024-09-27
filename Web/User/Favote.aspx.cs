using Data.BLL;
using System;
using System.Threading.Tasks;
using System.Web.UI;
using System.Web.UI.WebControls;
using Web.Models;

namespace Web.User
{
    public partial class Favote : System.Web.UI.Page
    {
        private UserSession userSession;
        protected bool enableShowButton;

        protected async void Page_Load(object sender, EventArgs e)
        {
            enableShowButton = false;
            try
            {
                GetUserSession();

                if (userSession != null && !IsPostBack)
                {
                    await BindFavoriteFilmsAsync();
                }
            }
            catch (Exception ex)
            {
                Session["error"] = new ErrorModel { ErrorTitle = "Ngoại lệ", ErrorDetail = ex.Message };
                Response.RedirectToRoute("Notification_Error", null);
            }
        }

        private void GetUserSession()
        {
            object obj = Session["userSession"];
            if (obj == null)
            {
                txtState.InnerText = "Bạn vui lòng đăng nhập để xem được phim yêu thích!";
                enableShowButton = false;
            }
            else
            {
                userSession = (UserSession)obj;
                enableShowButton = true;
            }
        }

        private async Task BindFavoriteFilmsAsync()
        {
            using (var voteBLL = new FilmBLL())
            {
                try
                {
                    var favoriteFilms = await voteBLL.GetVotedFilmsByUserIdAsync(userSession.userId);

                    dlWatchedList.DataSource = favoriteFilms;
                    dlWatchedList.DataBind();
                }
                catch (Exception ex)
                {
                    txtState.InnerText = "Error retrieving favorite films: " + ex.Message;
                    dlWatchedList.DataBind();
                }
            }
        }

        // Update this method to be async
        protected async void dlWatchedList_ItemCommand(object source, DataListCommandEventArgs e)
        {
            if (e.CommandName == "DeleteFilm")
            {
                string filmId = e.CommandArgument.ToString();
                if (!string.IsNullOrEmpty(filmId))
                {
                    await DeleteFilmAsync(filmId); // Use await instead of .Wait()
                }
            }
        }

        private async Task DeleteFilmAsync(string filmId)
        {
            try
            {
                using (var voteBLL = new FilmBLL())
                {
                    var result = await voteBLL.DeleteVotedFilmAsync(userSession.userId, filmId);

                    if (result == UpdateState.Success)
                    {
                        // Re-bind the DataList to reflect the deletion.
                        await BindFavoriteFilmsAsync();
                    }
                    else
                    {
                        txtState.InnerText = "Could not delete the film. Please try again.";
                    }
                }
            }
            catch (Exception ex)
            {
                txtState.InnerText = "Error occurred while deleting the film: " + ex.Message;
            }
        }
    }
}
