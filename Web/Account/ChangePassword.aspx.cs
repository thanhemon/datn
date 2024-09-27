using Data.BLL;
using System;
using System.Threading.Tasks;
using System.Web;
using System.Web.UI;
using Web.Models;

namespace Web.Account
{
    public partial class ChangePassword : System.Web.UI.Page
    {
        protected string userId;
        protected void Page_Load(object sender, EventArgs e)
        {

            userId = GetUserId();
        }
        private string GetUserId()
        {
            object obj = Session["userSession"];
            if (obj == null)
                return null;

            UserSession userSession = (UserSession)obj;
            return userSession.userId;
        }
        protected async void btnChangePassword_Click(object sender, EventArgs e)
        {
            // Validate inputs
            string oldPassword = txtOldPassword.Text.Trim();
            string newPassword = txtNewPassword.Text.Trim();
            string confirmPassword = txtConfirmPassword.Text.Trim();
            if (oldPassword.Length < 6 || newPassword.Length < 6 || confirmPassword.Length < 6)
            {
                Response.Write("<script>alert('Mật khẩu phải trên 6 kí tự.');</script>");
                return;
            }
            if (IsValid)
            {
                    bool passwordUpdated = await UpdatePassword(oldPassword,newPassword);
                    if (passwordUpdated)
                    {
                        Response.Write("<script>alert('Password changed successfully.');</script>");
                    Response.RedirectToRoute("User_Home", null);
                }
                    else
                    {
                        // Show error message
                        Response.Write("<script>alert('Không thể đổi mật khẩu vui lòng thử lại');</script>");
                    }
            }
        }

        private async Task<bool> UpdatePassword(string newPassword, string oldPassword)
        {
            UserBLL.CreateNewPasswordState createNewPasswordState;
            using (UserBLL userBLL = new UserBLL())
            {
                bool check = await userBLL.CreateNewPasswordAndCheckAsync(userId,oldPassword, newPassword);
                return check;
            }

        }
    }
}
