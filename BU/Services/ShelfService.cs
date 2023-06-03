using BU.Entities;
using DAL;
using DAL.DB;
using Microsoft.EntityFrameworkCore;
using Microsoft.IdentityModel.Tokens;
using System;
using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace BU.Services
{
    public class ShelfService
    {
        #region Utilities Services Methods

        /// <summary>
        /// Get all the themes of a shelf.
        /// </summary>
        /// <param name="shelf">The shelf to search</param>
        /// <returns>A list of all theme in the shelf.</returns>
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

        /// <summary>
        /// Get all shelves from the database.
        /// </summary>
        /// <returns>A list of all shelves</returns>
        public static List<Shelf> GetShelves()
        {
            using var DB = new SimpleLibraryContext();
            return DB.Shelves
                .Include("ShelfCompositions.Theme")
                .Include("ShelfCompositions.Publications")
                .ToList();
        }

        /// <summary>
        /// Return the shelf passed in parameter if found in the database.
        /// </summary>
        /// <param name="shelf">The shelf to search.</param>
        /// <returns>The shelf founded, otherwise return null.</returns>
        private static DAL.DB.Shelf? ShelfExist(Shelf shelf)
        {
            using var DB = new SimpleLibraryContext();
            return DB.Shelves
                .Where(S => S.ShelfName == shelf.ShelfName || S.ShelfId == shelf.ShelfId)
                .FirstOrDefault() ?? null;
        }

        /// <summary>
        /// Return the theme passed in parameter if found in the database.
        /// </summary>
        /// <param name="theme">The theme to search.</param>
        /// <returns>The theme founded, otherwise return null.</returns>
        private static DAL.DB.Theme? ThemeExist(Theme theme)
        {
            using var DB = new SimpleLibraryContext();
            return DB.Themes
                .Where(T => T.ThemeName == theme.ThemeName || T.ThemeId == theme.ThemeId)
                .FirstOrDefault() ?? null;
        }

        /// <summary>
        /// Return the shelf composition passed in parameter if found in the database.
        /// </summary>
        /// <param name=composition">The composition to search.</param>
        /// <returns>The shelf composition founded, otherwise return null.</returns>
        public static ShelfComposition? ShelfCompositionExist(ShelfComposition composition)
        {
            using var DB = new SimpleLibraryContext();
            return DB.ShelfCompositions
                .Where(SC => (SC.Shelf == composition.Shelf && SC.Theme == composition.Theme) || SC.ShelfCompositionId == composition.ShelfCompositionId)
                .FirstOrDefault() ?? null;
        }

        /// <summary>
        /// Get all the themes from the database.
        /// </summary>
        /// <returns>A list of all themes in the database.</returns>
        public static List<DAL.DB.Theme> GetThemes()
        {
            using var DB = new SimpleLibraryContext();
            return DB.Themes.ToList();
        }


        /// <summary>
        /// Get the composition (location) by shelf and theme.
        /// </summary>
        /// <param name="shelf">the shelf associed</param>
        /// <param name="theme">the theme associed</param>
        /// <returns></returns>
        public static ShelfComposition? GetComposition(Shelf shelf, Theme theme)
        {
            using var DB = new SimpleLibraryContext();
            return DB.ShelfCompositions
                .Where(SC => SC.ShelfId == shelf.ShelfId && SC.ThemeId == theme.ThemeId)
                .SingleOrDefault() ?? null;
        }

        /// <summary>
        /// Return the location(ID) of a theme composition.
        /// </summary>
        /// <param name="shelf">The shelf to search</param>
        /// <param name="theme">The theme to search</param>
        /// <returns>The location of the shelf composition if found, otherwise return -1.</returns>
        public static int GetLocationOf(Shelf shelf, Theme theme)
        {
            using var DB = new SimpleLibraryContext();
            if (shelf != null && theme != null)
            {
                return DB.ShelfCompositions
                    .Where(SC => SC.Shelf.ShelfId == shelf.ShelfId && SC.Theme.ThemeId == theme.ThemeId)
                    .First().ShelfCompositionId;
            }
            return -1;
        }
        #endregion
        #region CRUD ServiceResult Methods

        /// <summary>
        /// Add a new shelf in the database.
        /// </summary>
        /// <param name="shelf">The shelf to add.</param>
        /// <returns>ServiceResult with data if the operation succeeds, otherwise returns no data.</returns>
        /// <exception cref="ArgumentNullException">If shelf is null.</exception>
        public static BU.Entities.ServiceResult<Shelf> AddNewShelf(Shelf shelf)
        {
            if (shelf == null)
            {
                throw new Common.Exceptions.AppNullArgException($"{nameof(shelf)} cannot be null!");
            }
            if (ShelfExist(shelf) != null)
            {
                return new Entities.ServiceResult<Shelf>()
                {
                    ErrorCode = Entities.StandardErrorCode.AlreadyExist,
                    Status = Entities.ServiceResultStatus.KO,
                    Message = "Cannot add this shelf, it already exists!",
                    ImageBox = Entities.ImageBox.Warning
                };
            }
            var validation = new DAL.ShelfValidation(shelf);
            if (validation.ContainError())
            {
                return new ServiceResult<Shelf>
                {
                    Status = ServiceResultStatus.KO,
                    ErrorCode = StandardErrorCode.BadInput,
                    Message = $"Wrong inputs for the shelf!\n\n{validation.Errors} ",
                    ImageBox = ImageBox.Warning
                };
            }
            using var DB = new SimpleLibraryContext();
            DB.Shelves.Add(shelf);
            DB.SaveChanges();

            return new ServiceResult<Shelf>()
            {
                Status = Entities.ServiceResultStatus.OK,
                Message = $"{shelf.ShelfName} create successfully!",
                ImageBox = Entities.ImageBox.Information,
                Value = shelf
            };
        }

        /// <summary>
        /// Edit a shelf in the database.
        /// </summary>
        /// <param name="shelf">The shelf to edit</param>
        /// <param name="newName">The new name for the shelf</param>
        /// <returns>ServiceResult with data if operation success, otherwise Status KO.</returns>
        public static BU.Entities.ServiceResult<Shelf> EditShelf(Shelf shelf, string newName)
        {
            if (shelf == null)
            {
                throw new Common.Exceptions.AppNullArgException($"{nameof(shelf)} cannot be null for editing!");
            }
            using var DB = new SimpleLibraryContext();
            var shelfToEdit = DB.Shelves.Find(shelf.ShelfId);
            if (shelfToEdit == null)
            {
                throw new Common.Exceptions.AppException($"{nameof(shelf)} not found!");
            }

            shelfToEdit.ShelfName = newName;

            var validation = new DAL.ShelfValidation(shelfToEdit);
            if (validation.ContainError())
            {
                return new ServiceResult<Shelf>
                {
                    Status = ServiceResultStatus.KO,
                    ErrorCode = StandardErrorCode.BadInput,
                    Message = $"Wrong inputs for the shelf!\n\n{validation.Errors} ",
                    ImageBox = ImageBox.Warning
                };
            }
            DB.SaveChanges();
            return new ServiceResult<Shelf>()
            {
                Status = ServiceResultStatus.OK,
                Message = "Shelf updated successfully!",
                ImageBox = ImageBox.Information,
                Value = shelfToEdit
            };
        }

        /// <summary>
        /// Delete a shelf from the database.
        /// </summary>
        /// <param name="shelf">The shelf to delete</param>
        /// <returns>Service result with status OK.</returns>
        /// <exception cref="Common.Exceptions.AppNullArgException">If shelf is null.</exception>
        public static ServiceResult DeleteShelf(Shelf shelf)
        {
            if (shelf == null)
            {
                throw new Common.Exceptions.AppNullArgException($"{nameof(shelf)} cannot be null!");
            }

            using var DB = new SimpleLibraryContext();
            DB.Shelves.Remove(shelf);
            DB.SaveChanges();
            return new ServiceResult()
            {
                Status = ServiceResultStatus.OK,
                Message = "Shelf deleted successfully!",
                ImageBox = Entities.ImageBox.Information
            };
        }

        /// <summary>
        /// Add a new theme in the database.
        /// </summary>
        /// <param name="theme">The theme to add.</param>
        /// <returns>ServiceResult with data if the operation succeeds, otherwise returns no data.</returns>
        /// <exception cref="ArgumentNullException">If theme is null.</exception>
        public static BU.Entities.ServiceResult<Theme> AddNewTheme(Theme theme)
        {
            if (theme == null)
            {
                throw new Common.Exceptions.AppNullArgException($"{nameof(theme)} cannot be null!");
            }
            if (ThemeExist(theme) != null)
            {
                return new Entities.ServiceResult<Theme>()
                {
                    ErrorCode = Entities.StandardErrorCode.AlreadyExist,
                    Status = Entities.ServiceResultStatus.KO,
                    Message = "Cannot add this theme, it already exists!",
                    ImageBox = Entities.ImageBox.Warning
                };
            }
            var validation = new DAL.ThemeValidation(theme);
            if (validation.ContainError())
            {
                return new ServiceResult<Theme>
                {
                    Status = ServiceResultStatus.KO,
                    ErrorCode = StandardErrorCode.BadInput,
                    Message = $"Wrong inputs for the theme!\n\n{validation.Errors} ",
                    ImageBox = ImageBox.Warning
                };
            }
            using var DB = new SimpleLibraryContext();
            DB.Themes.Add(theme);
            DB.SaveChanges();

            return new ServiceResult<Theme>()
            {
                Status = Entities.ServiceResultStatus.OK,
                Message = $"{theme.ThemeName} create successfully!",
                ImageBox = Entities.ImageBox.Information,
                Value = theme
            };
        }

        /// <summary>
        /// Edit a theme in the database.
        /// </summary>
        /// <param name="theme">The theme to edit</param>
        /// <param name="newName">The new name for the theme</param>
        /// <returns></returns>
        public static BU.Entities.ServiceResult<Theme> EditTheme(Theme theme, string newName)
        {
            if (theme == null)
            {
                throw new Common.Exceptions.AppNullArgException($"{nameof(theme)} cannot be null for editing!");
            }
            using var DB = new SimpleLibraryContext();
            var themeToEdit = DB.Themes.Find(theme.ThemeId);
            if (themeToEdit == null)
            {
                throw new Common.Exceptions.AppException($"{nameof(theme)} not found!");
            }

            themeToEdit.ThemeName = newName;

            var validation = new DAL.ThemeValidation(themeToEdit);
            if (validation.ContainError())
            {
                return new ServiceResult<Theme>
                {
                    Status = ServiceResultStatus.KO,
                    ErrorCode = StandardErrorCode.BadInput,
                    Message = $"Wrong inputs for the theme!\n\n{validation.Errors} ",
                    ImageBox = ImageBox.Warning
                };
            }
            DB.SaveChanges();
            return new ServiceResult<Theme>()
            {
                Status = ServiceResultStatus.OK,
                Message = "Theme updated successfully!",
                ImageBox = ImageBox.Information,
                Value = theme
            };
        }

        /// <summary>
        /// Delete a theme from the database.
        /// </summary>
        /// <param name="theme">The theme to delete</param>
        /// <returns>Service result with status OK.</returns>
        /// <exception cref="Common.Exceptions.AppNullArgException">If theme is null.</exception>
        public static ServiceResult DeleteTheme(Theme theme)
        {
            if (theme == null)
            {
                throw new Common.Exceptions.AppNullArgException($"{nameof(theme)} cannot be null!");
            }

            using var DB = new SimpleLibraryContext();
            DB.Themes.Remove(theme);
            DB.SaveChanges();

            return new ServiceResult()
            {
                Status = ServiceResultStatus.OK,
                Message = "Theme deleted successfully!",
                ImageBox = Entities.ImageBox.Information
            };
        }

        /// <summary>
        /// Add a new shelf composition in the database.
        /// </summary>
        /// <param name="shelfComposition">The shelf composition to add.</param>
        /// <returns>ServiceResult with data if the operation succeeds, otherwise returns no data.</returns>
        /// <exception cref="ArgumentNullException">If shelfComposition is null.</exception>
        public static BU.Entities.ServiceResult<ShelfComposition> AddNewShelfComposition(ShelfComposition shelfComposition)
        {
            if (shelfComposition == null)
            {
                throw new Common.Exceptions.AppNullArgException($"{nameof(shelfComposition)} cannot be null!");
            }
            if (ShelfCompositionExist(shelfComposition) != null)
            {
                return new Entities.ServiceResult<ShelfComposition>()
                {
                    ErrorCode = Entities.StandardErrorCode.AlreadyExist,
                    Status = Entities.ServiceResultStatus.KO,
                    Message = "Cannot add this composition, it already exists!",
                    ImageBox = Entities.ImageBox.Warning
                };
            }
            var compositionToAdd = new ShelfComposition()
            {
                ShelfId = shelfComposition.ShelfId,
                ThemeId = shelfComposition.ThemeId,
            };
            using var DB = new SimpleLibraryContext();
            DB.ShelfCompositions.Add(compositionToAdd);
            DB.SaveChanges();

            return new ServiceResult<ShelfComposition>()
            {
                Status = Entities.ServiceResultStatus.OK,
                Message = $"Composition create successfully!",
                ImageBox = Entities.ImageBox.Information,
                Value = shelfComposition
            };
        }

        /// <summary>
        /// Delete a shelf composition from the database by it's shelf and theme.
        /// </summary>
        /// <param name="shelf">The shelf associed</param>
        /// /// <param name="theme">the theme associed</param>
        /// <returns>Service result with status OK.</returns>
        /// <exception cref="Common.Exceptions.AppNullArgException">If shelf or theme is null.</exception>
        public static ServiceResult DeleteShelfComposition(Shelf shelf, Theme theme)
        {
            if (shelf == null || theme == null)
            {
                throw new Common.Exceptions.AppNullArgException($"{nameof(shelf)} or {nameof(theme)} cannot be null!");
            }

            using var DB = new SimpleLibraryContext();
            var compoToDelete = GetComposition(shelf, theme);
            if (compoToDelete == null)
            {
                throw new Common.Exceptions.AppNullArgException($"{nameof(compoToDelete)} cannot delete null composition!");
            }
            DB.ShelfCompositions.Remove(compoToDelete);
            DB.SaveChanges();

            return new ServiceResult()
            {
                Status = ServiceResultStatus.OK,
                Message = "Composition deleted successfully!",
                ImageBox = Entities.ImageBox.Information
            };
        }
        #endregion
    }
}
