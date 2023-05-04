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

        static void Main(string[] args)
        {
            GoogleBookPublication gbook = new GoogleBookPublication("9782100796489");

            Console.WriteLine(gbook.Isbn);
            Console.WriteLine(gbook.Title);
            Console.WriteLine(gbook.Publisher);
            Console.WriteLine(gbook.PublishedDate);
            Console.WriteLine(gbook.Description);
            Console.WriteLine(gbook.CoverFilePath);
            //IList<string> categoriesText = categories.Select(c => (string)c).ToList();
            //// Json.NET
            //// CodePlex
        }
    }

}