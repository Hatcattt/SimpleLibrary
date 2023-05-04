using Microsoft.Extensions.FileSystemGlobbing.Internal;
using Microsoft.IdentityModel.Tokens;
using Newtonsoft.Json.Linq;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Text.RegularExpressions;
using System.Threading.Tasks;

namespace DAL.Services
{
    public class GoogleBookApiToJson
    {
        private static string ISBN_REGEX = "^[0-9]*";
        private static string BASE_URL = "https://www.googleapis.com/books/v1/volumes?q=isbn:";
        public const string DEFAULT_JSON = @"{'totalItems': 0}";

        public static async Task<string> GetJsonAsyncBy(string isbn)
        {
            if (IsbnIsValide(isbn))
            {
                using var client = new HttpClient();

                var url = BASE_URL + isbn;
                using var response = await client.GetAsync(url);

                if (response.IsSuccessStatusCode)
                {
                    return await response.Content.ReadAsStringAsync();
                }
            }
            return DEFAULT_JSON;
        }

        private static bool IsbnIsValide(string isbn)
        {
            return Regex.IsMatch(isbn, ISBN_REGEX) && ! isbn.IsNullOrEmpty();
        }

        public static string GetISBN(JToken? jToken)
        {
            return (string?)jToken?["industryIdentifiers"]?[0]?["identifier"] ?? string.Empty;
        }

        public static string GetTitle(JToken? jToken)
        {
            return (string?)jToken?["title"] ?? string.Empty;
        }

        public static string GetPublisher(JToken? jToken)
        {
            return (string?)jToken?["publisher"] ?? string.Empty;
        }

        public static string GetDescription(JToken? jToken)
        {
            return (string?)jToken?["description"] ?? string.Empty;
        }

        public static string GetCoverThumbnail(JToken? jToken)
        {
            return (string?)jToken?["imageLinks"]?["thumbnail"] ?? string.Empty;
        }
    }
}
