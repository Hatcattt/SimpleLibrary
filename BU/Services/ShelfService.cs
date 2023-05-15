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
        #region Shelf

        public static int GetLocationOf(Shelf shelf, Theme theme)
        {
            using var DB = new SimpleLibraryContext();
            if (shelf != null || theme != null)
            {
                return DB.ShelfCompositions.Where(SC => SC.Shelf.ShelfId == shelf.ShelfId && SC.Theme.ThemeId == theme.ThemeId).First().ShelfCompositionId;
            }
            return 0;
        }
        public static Shelf GetShelf(int shelfId)
        {
            using var DB = new SimpleLibraryContext();
            return DB.Shelves.Where(S => S.ShelfId == shelfId).First();
        }

        public static Shelf GetFirstShelf()
        {
            using var DB = new SimpleLibraryContext();
            var firstItem = DB.Shelves.First();
            if (firstItem != null )
            {
                return firstItem;
            }
            return new Shelf();
        }

        public static List<Shelf> GetShelves()
        {
            using var DB = new SimpleLibraryContext();
            return DB.Shelves
                .Include("ShelfCompositions.Theme")
                .Include("ShelfCompositions.Publications")
                .ToList();
        }

        private static bool ShelfExist(string shelfName)
        {
            if (shelfName != null)
            {
                using var DB = new SimpleLibraryContext();
                var atLeastOneShelfExist = DB.Shelves.Where(S => S.ShelfName == shelfName).FirstOrDefault();
                return atLeastOneShelfExist != null;
            }
            return false;
        }

        public static int AddShelf(Shelf shelf)
        {
            using var DB = new SimpleLibraryContext();
            if (shelf != null && ! ShelfExist(shelf.ShelfName))
            {
                DB.Shelves.Add(shelf);
                DB.SaveChanges();
                return shelf.ShelfId;
            }
            return -1;
        }

        public static int RenameShelf(Shelf shelf, string shelfName)
        {
            if (shelf != null && shelfName.Length > 0 && ! ShelfExist(shelfName))
            {
                using var DB = new SimpleLibraryContext();

                DB.Shelves.Where(S => S.ShelfId == shelf.ShelfId).First().ShelfName = char.ToUpper(shelfName[0]) + shelfName[1..];
                DB.SaveChanges();
                return shelf.ShelfId;
            }
            return -1;
        }

        public static bool DeleteShelf(Shelf shelf)
        {
            if (shelf != null)
            {
                using var DB = new SimpleLibraryContext();

                DB.Shelves.Remove(shelf);
                DB.SaveChanges();
                return true;
            }
            return false;
        }
        #endregion

        #region Theme
        public static bool ThemeExist(Theme theme)
        {
            if (theme != null)
            {
                using var DB = new SimpleLibraryContext();
                var atLeastOneThemExist = DB.Themes.Where(T => T.ThemeName == theme.ThemeName).FirstOrDefault();
                return atLeastOneThemExist != null;
            }
            return false;
        }

        public static bool ShelfCompositionExist(Shelf shelf, Theme theme)
        {
            if (shelf != null && theme != null)
            {
                using var DB = new SimpleLibraryContext();
                var atLeastOneThemExist = DB.ShelfCompositions.Where(SC => SC.Shelf == shelf && SC.Theme == theme).FirstOrDefault();
                return atLeastOneThemExist != null;
            }
            return false;
        }

        public static Theme GetTheme(int themeId)
        {
            using var DB = new SimpleLibraryContext();
            return DB.Themes.Where(T => T.ThemeId == themeId).First();
        }

        public static List<DAL.DB.Theme> GetThemes()
        {
            using var DB = new SimpleLibraryContext();
            return DB.Themes.ToList();
        }

        public static int AddTheme(Theme theme)
        {
            using var DB = new SimpleLibraryContext();
            if (theme != null && ! ThemeExist(theme))
            {
                DB.Themes.Add(theme);
                DB.SaveChanges();
                return theme.ThemeId;
            }
            return -1;
        }

        public static ShelfComposition AddShelfComposition(Theme theme, Shelf shelfTarget)
        {
            try
            {
                using var DB = new SimpleLibraryContext();
                if (theme != null && shelfTarget != null)
                {
                    var newSc = new ShelfComposition() { Theme = theme, ShelfId = shelfTarget.ShelfId };
                    DB.ShelfCompositions.Add(newSc);
                    DB.SaveChanges();
                    return newSc;
                }
                return new ShelfComposition();
            } catch (Exception ex)
            {
                // looog
                return new ShelfComposition();
            }
        }

        public static int RenameTheme(Theme theme, string themeName)
        {
            if (theme != null && themeName.Length > 0 && theme.ThemeName != themeName)
            {
                using var DB = new SimpleLibraryContext();

                DB.Themes
                    .Where(T => T.ThemeId == theme.ThemeId)
                    .First().ThemeName = char.ToUpper(themeName[0]) + themeName[1..];
                DB.SaveChanges();
                return theme.ThemeId;
            }
            return -1;
        }

        public static int DeleteTheme(Theme theme)
        {
            if (theme != null)
            {
                using var DB = new SimpleLibraryContext();
                DB.Themes.Remove(theme);
                DB.SaveChanges();
                return 0;
            }
            return -1;
        }

        //public static int AddShelfComposition(Shelf shelf, Theme theme)
        //{
        //    if (shelf != null && theme != null && ! ShelfCompositionExist(shelf, theme))
        //    {
        //        using var DB = new SimpleLibraryContext();
        //        var newComposition = new ShelfComposition() { ShelfId = shelf.ShelfId, ThemeId = theme.ThemeId };
        //        DB.ShelfCompositions.Add(newComposition);
        //        DB.SaveChanges();
        //        return newComposition.ShelfCompositionId;
        //    }
        //    return -1;
        //}

        public static bool DeleteShelfComposition(Theme theme, Shelf shelf)
        {
            if (theme != null && shelf != null)
            {
                using var DB = new SimpleLibraryContext();
                var shelfCompoToDelete = DB.ShelfCompositions
                    .Where(SC => SC.Theme.ThemeId == theme.ThemeId && SC.Shelf.ShelfId == shelf.ShelfId)
                    .SingleOrDefault();

                if( shelfCompoToDelete != null)
                {
                    DB.ShelfCompositions.Remove(shelfCompoToDelete);
                    DB.SaveChanges();
                    return true;
                }
            }
            return false;
        }
        #endregion
    }
}
