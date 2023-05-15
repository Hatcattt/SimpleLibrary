﻿using DAL.DB;
using Microsoft.Extensions.FileSystemGlobbing.Internal;
using Microsoft.IdentityModel.Tokens;
using Newtonsoft.Json.Linq;
using System;
using System.Collections.Generic;
using System.Globalization;
using System.Linq;
using System.Text;
using System.Text.RegularExpressions;
using System.Threading.Tasks;

namespace DAL.Services
{
    public class GoogleBookApiToJson
    {
        private static readonly HttpClient client = new HttpClient();
        private static readonly string ISBN_REGEX = "^[0-9]*";
        private static readonly string BASE_URL = "https://www.googleapis.com/books/v1/volumes?q=isbn:";
        public const string DEFAULT_JSON = "https://www.googleapis.com/books/v1/volumes?q=isbn:-1";

        public static async Task<string> GetJsonAsyncBy(string isbn)
        {

            var url = IsbnIsValide(isbn) ? BASE_URL + isbn : DEFAULT_JSON;

            using var response = await client.GetAsync(url);

            if (response.IsSuccessStatusCode)
            {
                return await response.Content.ReadAsStringAsync();
            }
            return DEFAULT_JSON;
        }

        private static bool IsbnIsValide(string isbn)
        {
            return Regex.IsMatch(isbn, ISBN_REGEX) && ! isbn.IsNullOrEmpty() && isbn.Length >= 3;
        }

        public static string GetISBN(JToken? jToken)
        {
            return (string?)jToken?["industryIdentifiers"]?[0]?["identifier"] ?? string.Empty;
        }

        public static string GetTitle(JToken? jToken)
        {
            return (string?)jToken?["title"] ?? string.Empty;
        }

        public static string GetSubTitle(JToken? jToken)
        {
            return (string?)jToken?["subTitle"] ?? string.Empty;
        }

        public static string GetPublisher(JToken? jToken)
        {
            return (string?)jToken?["publisher"] ?? string.Empty;
        }

        public static string GetDescription(JToken? jToken)
        {
            return (string?)jToken?["description"] ?? string.Empty;
        }

        public static Uri GetCoverThumbnail(JToken? jToken)
        {
            var uriJson = (string?)jToken?["imageLinks"]?["thumbnail"] ?? @"image\Covers\DEFAULT.jpg";
            return new Uri(uriJson, UriKind.RelativeOrAbsolute);
        }

        public static DateTime? GetPublishedDate(JToken? jToken)
        {
            try
            {
                return (DateTime?)jToken?["publishedDate"] ?? null;
            }
            catch (System.FormatException fex)
            {
                // LOOOOOGGGGG !!
                Console.WriteLine(fex.Message);
                return null;
            }
        }

        public static List<string> GetAuthors(JToken? jToken)
        {
            var list = jToken?["authors"];
            return list == null ? new List<string>() : list.Select(t => (string)t).ToList();
        }

        public static string GetLanguage(JToken? jToken)
        {
            return (string?)jToken?["language"] ?? string.Empty;
        }
    }
}
