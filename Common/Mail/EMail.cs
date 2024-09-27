using System.Net;
using System.Net.Mail;

namespace Common.Mail
{
    public class EMail
    {
        public static string Address = "admin@gmail.com";
        public static string Password = null;

        public void Send(string sendTo, string subject, string message)
        {
            using (SmtpClient smtp = new SmtpClient())
            {
                smtp.Host = "smtp.gmail.com";
                smtp.Port = 587;
                smtp.EnableSsl = true;
                                                     smtp.Credentials = new NetworkCredential("askeladdemon@gmail.com", "thanhemon7111" );
                smtp.Send("askeladdemon@gmail.com", sendTo, subject, message);
            }
        }
    }
}
