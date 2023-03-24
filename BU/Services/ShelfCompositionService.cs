using DAL.DB;
using Microsoft.EntityFrameworkCore;

namespace BU.Services
{
    /// <summary>
    /// Service class used to manage the composition of shelves inside the library system.
    /// </summary>
    public class ShelfCompositionService
    {
        public static List<DAL.DB.Shelf> GetShelves()
        {
            using var DB = new SimpleLibraryContext();
            return DB.Shelves
                .Include("ShelfCompositions")
                .ToList();
        }

        public static List<DAL.DB.Theme> GetThemes()
        {
            using var DB = new SimpleLibraryContext();
            return DB.Themes
                .ToList();
        }

        public static List<DAL.DB.Theme> GetThemesOf(Shelf shelf)
        {
            if (shelf != null)
            {
                using var DB = new SimpleLibraryContext();
                return DB.ShelfCompositions
                    .Where(S => S.Shelf.ShelfId == shelf.ShelfId)
                    .Select(S => S.Theme).ToList();
            }
            return new List<Theme>();
        }

        public static List<DAL.DB.Publication> GetPublicationsBy(Shelf shelf)
        {
            if (shelf != null)
            {
                using var DB = new SimpleLibraryContext();
                return DB.Publications
                    .Where(P => P.LocationNavigation.Shelf.ShelfId == shelf.ShelfId)
                    .ToList();
            }
            return new List<Publication>();
        }
    }
}
