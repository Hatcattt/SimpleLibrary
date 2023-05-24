using DAL.DB;
using Microsoft.EntityFrameworkCore;
using Newtonsoft.Json;
using Newtonsoft.Json.Linq;
using System;
using System.Net;
using System.Net.Http.Headers;
using System.Net.Http;
using DAL.Entities;
using DAL.Services;

namespace ConsoleApp
{
    /// <summary>
    /// Class used to lunch the program.
    /// </summary>
    public class Program
    {

        static async Task Main(string[] args)
        {
            //string isbn = "9782800180083";
            //using var client = new HttpClient();
            //var result = await client.GetStringAsync($"https://www.googleapis.com/books/v1/volumes?q=isbn:{isbn}");
            //Console.WriteLine(result);

            //var json = await GoogleBookApiToJson.GetJsonAsyncBy(isbn);
            //var gBook = new GoogleBookPublication(json);

            //Console.WriteLine($"Isbn  : {gBook.Isbn}\nTitle : {gBook.Title}\nCover : {gBook.CoverFilePath}");
        }
    }

}