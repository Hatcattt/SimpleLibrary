using DAL.DB;
using Microsoft.EntityFrameworkCore;
using Microsoft.IdentityModel.Tokens;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace BU.Services
{
    public class ShelfService
    {
        public static List<DAL.DB.Shelf> GetShelves()
        {
            using var DB = new SimpleLibraryContext();
            return DB.Shelves
                .Include("ShelfCompositions.Theme")
                .ToList();
        }

        //public static List<Publication> GetPublicationsIn(DAL.DB.Shelf theme)
        //{
        //    using var DB = new SimpleLibraryContext();
        //    return DB.ShelfCompositions.Where(PC => PC.Shelf == theme).Select(P => P.Publications).ToList();
        //}

        public static DAL.DB.Shelf GetFirstShelf()
        {
            using var DB = new SimpleLibraryContext();
            return DB.Shelves.First();
        }

        public static Shelf GetShelf(int shelfId)
        {
            using var DB = new SimpleLibraryContext();
            return DB.Shelves.Where(S => S.ShelfId == shelfId).First();
        }

        public static Theme GetTheme(int themeId)
        {
            using var DB = new SimpleLibraryContext();
            return DB.Themes.Where(T => T.ThemeId == themeId).First();
        }

        public static int AddShelf(Shelf shelf)
        {
            using var DB = new SimpleLibraryContext();
            if (shelf != null)
            {
                DB.Shelves.Add(shelf);
                DB.SaveChanges();
                return shelf.ShelfId;
            }
            return -1;
        }

        public static int AddTheme(Theme theme, Shelf shelfTarget)
        {
            using var DB = new SimpleLibraryContext();
            if (theme != null && shelfTarget != null)
            {
                DB.Themes.Add(theme);
                DB.ShelfCompositions.Add(new ShelfComposition() { ThemeId = theme.ThemeId, ShelfId = shelfTarget.ShelfId });
                DB.SaveChanges();
                return theme.ThemeId;
            }
            return -1;
        }

        public static int RenameShelf(Shelf shelf, string shelfName)
        {
            if ( shelf != null && shelfName.Length > 0)
            {
                using var DB = new SimpleLibraryContext();

                DB.Shelves.Where(S => S.ShelfId == shelf.ShelfId).First().ShelfName = shelfName;
                DB.SaveChanges();
                return shelf.ShelfId;
            }
            return -1;
        }

        public static int RenameTheme(Theme theme, string shelfName)
        {
            if (theme != null && shelfName.Length > 0)
            {
                using var DB = new SimpleLibraryContext();

                DB.Themes.Where(T => T.ThemeId == theme.ThemeId).First().ThemeName = shelfName;
                DB.SaveChanges();
                return theme.ThemeId;
            }
            return -1;
        }

        public static Boolean DeleteShelf(Shelf shelf)
        {
            if (shelf != null)
            {
                using var DB = new SimpleLibraryContext();

                foreach (var sc in DB.ShelfCompositions.Where(sc => sc.ShelfId == shelf.ShelfId))
                {
                    DB.ShelfCompositions.Remove(sc);
                }
                DB.Shelves.Remove(shelf);
                DB.SaveChanges();
                return true;
            }
            return false;
        }
    }
}
