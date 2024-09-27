using Common.Mail;
using System.Configuration;

namespace Web.App_Start
{
    public class EmailConfig
    {
        public static void RegisterEmail()
        {
            EMail.Address = ConfigurationManager.AppSettings["EmailAddress"];
            EMail.Password = ConfigurationManager.AppSettings["EmailPassword"];
        }
    }
}