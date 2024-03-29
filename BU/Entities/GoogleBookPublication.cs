﻿using BU.Entities;
using DAL.Services;
using Newtonsoft.Json.Linq;

namespace BU.Entities
{
    /// <summary>
    /// Représente une classe qui sera générée à partir d'une Google Book API pour créer une nouvelle Publication.
    /// </summary>
    public class GoogleBookPublication
    {
        #region Propreties

        private readonly JObject jsonContent;
        private readonly JToken? volumeInfo;

        public string Json { get; private set; } = LibraryGoogleAgentService.DEFAULT_JSON;

        public string Isbn { get; private set; } = string.Empty;

        public string Title { get; private set; } = string.Empty;

        public string SubTitle { get; private set; } = string.Empty;

        public string LetterRow { get; private set; } = string.Empty;

        public string Publisher { get; private set; } = string.Empty;

        public DateTime? PublishedDate { get; private set; } = null;

        public string Description { get; private set; } = string.Empty;

        public string Language { get; private set; } = string.Empty;

        public string? CoverFilePath { get; private set; }

        public List<string> Authors { get; private set; } = new List<string>();

        #endregion

        /// <summary>
        /// Constructeur de cette classe.
        /// Parse un json et lie les données aux propriétés de cette classe.
        /// </summary>
        /// <param name="json">le json à parser</param>
        public GoogleBookPublication(string json)
        {
            try
            {
                Json = json;
                jsonContent = JObject.Parse(Json);
                if (JsonHaveContent())
                {
                    volumeInfo = jsonContent["items"]?[0]?["volumeInfo"];
                    LinkPropreties();
                }
            } catch (Exception ex)
            {
                throw new Exception($"Problem with Json Parser. See Message :\n{ex.Message}");
            }
        }

        private void LinkPropreties()
        {
            Isbn = LibraryGoogleAgentService.GetISBN(volumeInfo);
            Title = LibraryGoogleAgentService.GetTitle(volumeInfo);
            SubTitle = LibraryGoogleAgentService.GetSubTitle(volumeInfo);
            Publisher = LibraryGoogleAgentService.GetPublisher(volumeInfo);
            PublishedDate = LibraryGoogleAgentService.GetPublishedDate(volumeInfo);
            Description = LibraryGoogleAgentService.GetDescription(volumeInfo);
            CoverFilePath = LibraryGoogleAgentService.GetCoverThumbnail(volumeInfo);
            Language = LibraryGoogleAgentService.GetLanguage(volumeInfo);
            Authors = LibraryGoogleAgentService.GetAuthors(volumeInfo);
            LetterRow = Title[..1].Length >= 1 ? Title[..1] : "0"; // REVOIR
        }

        /// <summary>
        /// Check if the json have content.
        /// </summary>
        /// <returns>True if json have content, false otherwise.</returns>
        public bool JsonHaveContent()
        {
            return (int?)jsonContent["totalItems"] > 0;
        }
    }
}
