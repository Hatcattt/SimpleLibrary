using DAL.Services;
using Newtonsoft.Json.Linq;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DAL.Entities
{
    public class GoogleBookPublication
    {
        #region Propreties

        private JObject jsonContent;
        private JToken? volumeInfo;

        public string Json { get; private set; } = GoogleBookApiToJson.DEFAULT_JSON;

        public string Isbn { get; private set; } = string.Empty;

        public string Title { get; private set; } = string.Empty;

        public string SubTitle { get; private set; } = string.Empty;

        public string LetterRow { get; private set; } = string.Empty;

        public string Publisher { get; private set; } = string.Empty;

        public DateTime? PublishedDate { get; private set; } = new DateTime();

        public string Description { get; private set; } = string.Empty;

        public string CoverFilePath { get; private set; } = string.Empty;

        #endregion

        public GoogleBookPublication(string json)
        {
            Json = json;
            jsonContent = JObject.Parse(Json);
            if ((int)jsonContent["totalItems"] > 0)
            {
                volumeInfo = jsonContent["items"][0]["volumeInfo"];
                LinkPropreties();
            }
        }

        private void LinkPropreties()
        {
            Isbn = GoogleBookApiToJson.GetISBN(volumeInfo);
            Title = GoogleBookApiToJson.GetTitle(volumeInfo);
            Publisher = GoogleBookApiToJson.GetPublisher(volumeInfo);
            Description = GoogleBookApiToJson.GetDescription(volumeInfo);
            CoverFilePath = GoogleBookApiToJson.GetCoverThumbnail(volumeInfo);
        }
        
  //"kind": "books#volumes",
  //"totalItems": 1,
  //"items": [
  //  {
  //    "kind": "books#volume",
  //    "id": "9u6ODwAAQBAJ",
  //    "etag": "d8Pq8edY3E0",
  //    "selfLink": "https://www.googleapis.com/books/v1/volumes/9u6ODwAAQBAJ",
  //    "volumeInfo": {
  //      "title": "Explorateurs de l'espace",
  //      "subtitle": "Voyage aux frontières de l'univers",
  //      "authors": [
  //        "Michel Tognini",
  //        "Hélène Courtois",
  //        "Jean-Yves Le Gall"
  //      ],
  //      "publisher": "Dunod",
    }
}
