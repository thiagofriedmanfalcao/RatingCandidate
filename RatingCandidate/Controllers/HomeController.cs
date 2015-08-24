using System;
using System.Collections;
using System.Collections.Generic;
using System.Web.Mvc;
using System.Net.Mail;
using System.Net;

namespace RatingCandidate.Controllers
{
    public class HomeController : Controller
    {
        public ActionResult Index()
        {
            return View();
        }

        [HttpPost]
        public bool SendEmail(string name, string email, Array arrayFrontEnd, Array arrayBackEnd, Array arrayMobile)
        {
            bool criterion = false;
            bool sucess = true;
            string subject = string.Empty;
            string content = string.Empty;
            IDictionary<int, string> dictionary = new Dictionary<int, string>();

            if (Convert.ToInt32(arrayFrontEnd.GetValue(0)) >= 7 || 10 <= Convert.ToInt32(arrayFrontEnd.GetValue(0)) &&
                Convert.ToInt32(arrayFrontEnd.GetValue(1)) >= 7 || 10 <= Convert.ToInt32(arrayFrontEnd.GetValue(1)) &&
                Convert.ToInt32(arrayFrontEnd.GetValue(2)) >= 7 || 10 <= Convert.ToInt32(arrayFrontEnd.GetValue(2)))
            {
                criterion = true;
                subject = string.Concat("Obrigado por se candidatar ", name);
                content = "Obrigado por se candidatar, assim que tivermos uma vaga disponível para programador Front-End entraremos em contato.";
                dictionary.Add(1, string.Concat(subject, "|", content));
            }

            if (Convert.ToInt32(arrayBackEnd.GetValue(0)) >= 7 || 10 <= Convert.ToInt32(arrayBackEnd.GetValue(0)) &&
                     Convert.ToInt32(arrayBackEnd.GetValue(1)) >= 7 || 10 <= Convert.ToInt32(arrayBackEnd.GetValue(1)))
            {
                criterion = true;
                subject = string.Concat("Obrigado por se candidatar ", name);
                content = "Obrigado por se candidatar, assim que tivermos uma vaga disponível para programador Back-End entraremos em contato.";
                dictionary.Add(2, string.Concat(subject, "|", content));
            }

            if (Convert.ToInt32(arrayMobile.GetValue(0)) >= 7 || 10 <= Convert.ToInt32(arrayMobile.GetValue(0)) &&
                     Convert.ToInt32(arrayMobile.GetValue(1)) >= 7 || 10 <= Convert.ToInt32(arrayMobile.GetValue(1)))
            {
                criterion = true;
                subject = string.Concat("Obrigado por se candidatar ", name);
                content = "Obrigado por se candidatar, assim que tivermos uma vaga disponível para programador Mobile entraremos em contato.";
                dictionary.Add(3, string.Concat(subject, "|", content));
            }

            if (!criterion)
            {
                subject = string.Concat("Obrigado por se candidatar ", name);
                content = "Obrigado por se candidatar, assim que tivermos uma vaga disponível para programador entraremos em contato.";
                dictionary.Add(4, string.Concat(subject, "|", content));
            }

            foreach (var item in dictionary)
            {
                List<string> stringList = new List<string>(item.Value.Split(new string[] { "|" }, StringSplitOptions.None));

                sucess = SendEmailToClient(email, stringList[0], stringList[1]);

                if (!sucess)
                    break;
            }

            if (!sucess)
                return false;
            else
                return true;
        }

        public bool SendEmailToClient(string email, string subject, string content)
        {
            SmtpClient smtpClient = new SmtpClient();
            NetworkCredential basicCredential = new NetworkCredential("programadorPleno@hotmail.com", "meuspedidos123");
            MailMessage message = new MailMessage();
            MailAddress fromAddress = new MailAddress("programadorPleno@hotmail.com");

            smtpClient.EnableSsl = true;
            smtpClient.Port = 587;
            smtpClient.Host = "smtp.live.com";
            smtpClient.UseDefaultCredentials = false;
            smtpClient.Credentials = basicCredential;

            message.From = fromAddress;
            message.Subject = subject;
            message.Body = content;
            message.To.Add(email);

            try
            {
                smtpClient.Send(message);
                return true;
            }
            catch (Exception ex)
            {
                return false;
            }
        }

    }
}
