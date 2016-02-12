using HtmlAgilityPack;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Net;
using System.Text.RegularExpressions;
using System.Threading.Tasks;
using System.Timers;
using System.Web;

namespace OnBoardService.Models
{
    public class GMDTalkShowUtility
    {
        private static GMDTalkShowUtility _instance = null;
        public static GMDTalkShowUtility Instance
        {
            get
            {
                if (_instance == null)
                {
                    _instance = new GMDTalkShowUtility();
                }
                return _instance;
            }
        }
        public List<GMDTalkShow> ShowList { get; private set; }
        private Timer timer;
        private GMDTalkShowUtility()
        {
            Refresh();
            timer = new Timer(3600000);
            timer.Elapsed += (sender, e) =>
            {
                Refresh();
            };
            timer.Start();
        }

        public void Refresh()
        {
            try
            {
                ShowList = GMDTalkShow.LoadAll();

            }
            catch
            {
                ShowList = new List<GMDTalkShow>();
            }
        }
    }

    public class TalkShowLink
    {
        public string Content;
        public string Url;
    }
    public class GMDTalkShow
    {
        public string Title { get; private set; }
        public string SourceUrl { get; private set; }

        public List<TalkShowLink> Links { get; private set; }

        public GMDTalkShow(string url)
        {
            SourceUrl = url;
        }

        public async Task<bool> LoadFromUrlAsync()
        {
            string html = await GetPageHtmlAsync(SourceUrl).ConfigureAwait(false);
            HtmlDocument htmlDoc = new HtmlDocument();
            htmlDoc.LoadHtml(html);

            Title = ExtractTitle(htmlDoc);
            ExtractLinks(htmlDoc);

            return true;
        }
        private string ExtractTitle(HtmlDocument htmlDoc)
        {
            HtmlNode node = htmlDoc.GetElementbyId("main");
            HtmlNodeCollection nodes = node.SelectNodes("article/div/h1");
            return HttpUtility.HtmlDecode(nodes.FirstOrDefault().InnerText);
        }

        private void ExtractLinks(HtmlDocument htmlDoc)
        {
            HtmlNode node = htmlDoc.GetElementbyId("main");
            HtmlNodeCollection nodes = node.SelectNodes("article/div/p");
            List<HtmlNode> links = nodes.Where(n => n.InnerText.Contains("h。t。t。")).ToList();
            if (links.Count > 3)
            {
                Links = new List<TalkShowLink>();
                for (int i = 0; i < 3; i++)
                {
                    Regex pattern = new Regex(@"[。\s]|[\n]{2}");
                    string content = HttpUtility.HtmlDecode(pattern.Replace(links[i].InnerText, ""));
                    int linkStartPos = content.IndexOf("http");
                    TalkShowLink link = new TalkShowLink() { Content = content.Substring(0, linkStartPos - 1), Url = content.Substring(linkStartPos) };
                    Links.Add(link);
                }
            }
        }
        public static async Task<string> GetPageHtmlAsync(string url)
        {
            HttpWebRequest request = WebRequest.Create(url) as HttpWebRequest;
            HttpWebResponse response = await request.GetResponseAsync().ConfigureAwait(false) as HttpWebResponse;
            string html;
            using (StreamReader reader = new StreamReader(response.GetResponseStream()))
            {
                html = await reader.ReadToEndAsync().ConfigureAwait(false);
            }
            return html;
        }

        public static List<GMDTalkShow> LoadAll()
        {
            string html = GMDTalkShow.GetPageHtmlAsync("http://gmdwith.us").Result;
            HtmlDocument htmlDoc = new HtmlDocument();
            htmlDoc.LoadHtml(html);
            HtmlNode node = htmlDoc.GetElementbyId("text-4");
            HtmlNodeCollection nodes = node.SelectNodes("div/a");
            List<GMDTalkShow> talkShowList = new List<GMDTalkShow>();
            foreach (HtmlNode n in nodes)
            {
                string url = n.GetAttributeValue("href", "");
                if (url != "")
                {
                    GMDTalkShow talkShow = new GMDTalkShow(url);
                    bool result = talkShow.LoadFromUrlAsync().Result;
                    if (result)
                    {
                        talkShowList.Add(talkShow);
                    }
                }
            }
            return talkShowList;
        }

    }
}