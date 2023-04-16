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
            var shelf = DB.Shelves.Find(1);
            var theme = DB.Themes.Find(17);
            var compoToDelete = DB.ShelfCompositions.Where(SC => SC.Shelf == shelf && SC.Theme == theme).FirstOrDefault();
            Console.WriteLine(compoToDelete.Shelf.ShelfName + " " + compoToDelete.Theme.ThemeName);
            Console.WriteLine(DB.ShelfCompositions.Count());
            DB.ShelfCompositions.Remove(compoToDelete);

            Console.WriteLine(DB.ShelfCompositions.Where(SC => SC.Shelf == shelf && SC.Theme == theme).FirstOrDefault().Theme.ThemeName);
            //var shelfCompoToDelete = DB.ShelfCompositions
            //    .Where(SC => SC.Theme.ThemeId == theme.ThemeId && SC.Shelf.ShelfId == shelf.ShelfId)
            //    .SingleOrDefault();

            //if (shelfCompoToDelete != null)
            //{
            //    DB.ShelfCompositions.Remove(shelfCompoToDelete);
            //    return true;
            //}
        }
    }
}