﻿using Data.BLL.Installation;
using Data.Config;
using System;
using System.Threading;
using System.Web;
using Web.Models;

namespace Web.Install
{
    public partial class Index : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected async void btnInstall_Click(object sender, EventArgs e)
        {
            try
            {
                DBInstallation.SqlFilePath = HttpContext.Current.Server.MapPath("~/Install/Movie.sql");
                await DBInstallation.RunAsync();

                Thread.Sleep(500);

                MigrationConfig.Migrate();

                Response.RedirectToRoute("User_Home", null);
            }
            catch (Exception ex)
            {
                Session["error"] = new ErrorModel { ErrorTitle = "Ngoại lệ", ErrorDetail = ex.Message };
                Response.RedirectToRoute("Notification_Error", null);
            }
        }
    }
}