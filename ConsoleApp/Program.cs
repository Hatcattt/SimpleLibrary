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
            var json = await GoogleBookApiToJson.GetJsonAsyncBy("9782033200282");
            var gBook = new GoogleBookPublication(json);

            Console.WriteLine($"Isbn  : {gBook.Isbn}\nTitle : {gBook.Title}\nCover : {gBook.CoverFilePath}");
        }
    }

}