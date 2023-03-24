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
            var shelf = DB.Shelves.First();
            var liste = BU.Services.ShelfCompositionService.GetThemesOf(shelf);
            foreach (var theme in liste)
            {
                Console.WriteLine(theme.ThemeName);
            }
        }
    }
}