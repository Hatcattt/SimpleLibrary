using BU.Entities;
using DAL.DB;
using Microsoft.EntityFrameworkCore;
using Microsoft.IdentityModel.Tokens;

namespace BU.Services
{
    public class AuthorService
    {
        static int minAuthorLenght = 2;
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
            if (authorName.Length >= minAuthorLenght && author != null)
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
                        ImageBox = Entities.ImageBox.Information
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
                    ImageBox = Entities.ImageBox.Information
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

        private static bool AuthorExist(Author newAuthor)
        {
            using var DB = new SimpleLibraryContext();
            return DB.Authors.Find(newAuthor.AuthorId) != null;
        }

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
    }
    
}
