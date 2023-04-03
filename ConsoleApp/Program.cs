using DAL.DB;
using Microsoft.EntityFrameworkCore;
using System;

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
            var sh = new Shelf() { ShelfName = "DBZ" };
            Console.WriteLine(BU.Services.ShelfService.ShelfExist(sh));
        }
    }
}