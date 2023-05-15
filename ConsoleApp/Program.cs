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
            using var DB = new SimpleLibraryContext();
            var firstPubli = DB.PublicationCopies.First();
            Console.WriteLine(firstPubli.PublicationState);
        }
    }

}