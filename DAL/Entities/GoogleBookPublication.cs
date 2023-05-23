using BU.Entities;
using DAL.Services;
using Newtonsoft.Json.Linq;

namespace DAL.Entities
{
    /// <summary>
    /// Représente une classe qui sera générée à partir d'une Google Book API pour créer une nouvelle Publication.
    /// </summary>
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
                if (JsonAsContent())
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
            Isbn = GoogleBookApiToJson.GetISBN(volumeInfo);
            Title = GoogleBookApiToJson.GetTitle(volumeInfo);
            SubTitle = GoogleBookApiToJson.GetSubTitle(volumeInfo);
            Publisher = GoogleBookApiToJson.GetPublisher(volumeInfo);
            PublishedDate = GoogleBookApiToJson.GetPublishedDate(volumeInfo);
            Description = GoogleBookApiToJson.GetDescription(volumeInfo);
            CoverFilePath = GoogleBookApiToJson.GetCoverThumbnail(volumeInfo);
            Language = GoogleBookApiToJson.GetLanguage(volumeInfo);
            Authors = GoogleBookApiToJson.GetAuthors(volumeInfo);
            LetterRow = Title[..1].Length >= 1 ? Title[..1] : "0"; // REVOIR
        }

        public bool JsonAsContent()
        {
            return (int?)jsonContent["totalItems"] > 0;
        }
    }
}
