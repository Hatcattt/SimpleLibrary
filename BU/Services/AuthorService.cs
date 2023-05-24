using BU.Entities;
using DAL.DB;
using Microsoft.EntityFrameworkCore;
using Microsoft.IdentityModel.Tokens;

namespace BU.Services
{
    /// <summary>
    /// Classe de service utilisée pour gérer les auteurs dans la base de données.
    /// </summary>
    public class AuthorService
    {
        static int minAuthorNameLenght = 2;

        /// <summary>
        /// Get all the authors from de datbase, with include publications.
        /// </summary>
        /// <returns>A list of authors</returns>
        public static List<DAL.DB.Author> GetAuthors()
        {
            using var DB = new SimpleLibraryContext();
            return DB.Authors
                .Include("AuthorPublications.Publication")
                .ToList();
        }

        /// <summary>
        /// Modifies an author in the database if found.
        /// </summary>
        /// <param name="author">The author to modify</param>
        /// <param name="authorName">The new name for the author</param>
        /// <param name="nationality">The new nationality for the author</param>
        /// <returns>ServiceResult with data if the operation succeeds, otherwise returns no data.</returns>
        /// <exception cref="ArgumentNullException">If the author is null</exception>
        public static BU.Entities.ServiceResult<Author> EditAuthor(Author author, string authorName, string nationality)
        {
            if (authorName.Length >= minAuthorNameLenght && author != null)
            {
                using var DB = new SimpleLibraryContext();
                var authorToEdit = DB.Authors.Find(author.AuthorId);
                if (authorToEdit != null)
                {
                    authorToEdit.AuthorName = authorName;
                    authorToEdit.Nationality = nationality ?? null;
                    DB.SaveChanges();

                    return new Entities.ServiceResult<Author>()
                    {
                        Status = Entities.ServiceResultStatus.OK,
                        Message = nameof(author) + " modify successfully!",
                        ImageBox = Entities.ImageBox.Information,
                        Value = authorToEdit
                    };
                }
            }
            return new Entities.ServiceResult<Author>()
            {
                ErrorCode = Entities.StandardErrorCode.BadInput,
                Status = Entities.ServiceResultStatus.KO,
                Message = "Please make sure to have a name for the author.",
                ImageBox = Entities.ImageBox.Warning
            };
        }

        /// <summary>
        /// Add an new author in the database.
        /// </summary>
        /// <param name="newAuthor">The newest author to add</param>
        /// <returns>ServiceResult with data if the operation succeeds, otherwise returns no data.</returns>
        public static ServiceResult<Author> CreateAuthor(DAL.DB.Author newAuthor)
        {
            if (newAuthor != null && ! newAuthor.AuthorName.IsNullOrEmpty() && ! AuthorExist(newAuthor))
            {
                using var DB = new SimpleLibraryContext();
                DB.Authors.Add(newAuthor);
                DB.SaveChanges();

                return new Entities.ServiceResult<Author>()
                {
                    Status = Entities.ServiceResultStatus.OK,
                    Message = nameof(newAuthor) + " create successfully!",
                    ImageBox = Entities.ImageBox.Information,
                    Value = newAuthor
                };
            }
            return new Entities.ServiceResult<Author>()
            {
                ErrorCode = Entities.StandardErrorCode.BadInput,
                Status = Entities.ServiceResultStatus.KO,
                Message = "Please make sure to have a name for the new author.",
                ImageBox = Entities.ImageBox.Warning
            };
        }

        /// <summary>
        /// Delete an author from the database.
        /// </summary>
        /// <param name="author"></param>
        /// <returns>ServiceResult with status OK if the operation succeeds, otherwise returns status KO.</returns>
        public static ServiceResult<Author> DeleteAuthor(DAL.DB.Author author)
        {
            if (author != null)
            {
                try
                {
                    using var DB = new SimpleLibraryContext();
                    DB.Authors.Remove(author);
                    DB.SaveChanges();

                    return new Entities.ServiceResult<Author>()
                    {
                        Status = Entities.ServiceResultStatus.OK,
                        Message = "Author deleted successfully!",
                        ImageBox = Entities.ImageBox.Information
                    };

                } catch (Exception ex)
                {
                    return new Entities.ServiceResult<Author>()
                    {
                        Status = ServiceResultStatus.KO,
                        Message = ex.Message,
                        ErrorCode = StandardErrorCode.GenericError,
                        ImageBox = ImageBox.Warning
                    };
                }
            }

            return new Entities.ServiceResult<Author>()
            {
                ErrorCode = Entities.StandardErrorCode.BadInput,
                Status = Entities.ServiceResultStatus.KO,
                Message = "Please make sure to have a name for the new author.",
                ImageBox = Entities.ImageBox.Warning
            };
        }


        /// <summary>
        /// Check if an exist in the database.
        /// </summary>
        /// <param name="author">The author to check.</param>
        /// <returns>True if the author exist, false otherwise.</returns>
        private static bool AuthorExist(Author author)
        {
            using var DB = new SimpleLibraryContext();
            return DB.Authors.Find(author.AuthorId) != null;
        }
    }
    
}
