﻿using DAL.Services;
using Microsoft.IdentityModel.Tokens;
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

        private readonly JObject jsonContent;
        private readonly JToken? volumeInfo;

        public string Json { get; private set; } = GoogleBookApiToJson.DEFAULT_JSON;

        public string Isbn { get; private set; } = string.Empty;

        public string Title { get; private set; } = string.Empty;

        public string SubTitle { get; private set; } = string.Empty;

        public string LetterRow { get; private set; } = string.Empty;

        public string Publisher { get; private set; } = string.Empty;

        public DateTime PublishedDate { get; private set; } = new DateTime();

        public string Description { get; private set; } = string.Empty;

        public string Language { get; private set; } = string.Empty;

        public Uri CoverFilePath { get; private set; } = new Uri(@"image/Covers/DEFAULT.jpg",  UriKind.Relative);

        public List<string> Authors { get; private set; } = new List<string>();

        #endregion

        public GoogleBookPublication(string json)
        {
            Json = json;
            jsonContent = JObject.Parse(Json);
            if (JsonAsContent())
            {
                volumeInfo = jsonContent["items"]?[0]?["volumeInfo"];
                LinkPropreties();
            }
        }

        private void LinkPropreties()
        {
            Isbn = GoogleBookApiToJson.GetISBN(volumeInfo);
            Title = GoogleBookApiToJson.GetTitle(volumeInfo);
            SubTitle = GoogleBookApiToJson.GetSubTitle(volumeInfo);
            Publisher = GoogleBookApiToJson.GetPublisher(volumeInfo);
            PublishedDate = GoogleBookApiToJson.GetPublishedDate(volumeInfo);
            Description = GoogleBookApiToJson.GetDescription(volumeInfo);
            CoverFilePath = GoogleBookApiToJson.GetCoverThumbnail(volumeInfo);
            Language = GoogleBookApiToJson.GetLanguage(volumeInfo);
            Authors = GoogleBookApiToJson.GetAuthors(volumeInfo);
            LetterRow = Title[..1];
        }

        public bool JsonAsContent()
        {
            return (int?)jsonContent["totalItems"] > 0;
        }
    }
}