using static DAL.ModelValidation;
using BU.Entities;
using DAL.DB;
using Microsoft.EntityFrameworkCore;
using Microsoft.IdentityModel.Tokens;
using DAL;
using static System.Net.Mime.MediaTypeNames;

namespace BU.Services
{
    /// <summary>
    /// Classe de service utilisée pour gérer les auteurs dans la base de données.
    /// </summary>
    public class AuthorService
    {
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
        /// Modifies an author in the database if found. A verification is made to validate the paramaters.
        /// </summary>
        /// <param name="author">The author to modify</param>
        /// <param name="authorName">The new name for the author</param>
        /// <param name="nationality">The new nationality for the author</param>
        /// <returns>ServiceResult with toEdit if the operation succeeds, otherwise returns no toEdit.</returns>
        /// <exception cref="Common.Exceptions.AppException">If author or authorName are null.</exception>
        public static BU.Entities.ServiceResult<Author> EditAuthor(Author author, string authorName, string? nationality = null)
        {
            if (author == null || authorName == null)
            {
                throw new Common.Exceptions.AppException("The author to modify or the authorName in parameter cannot be null!");
            }

            if (AuthorValidation.ValidationPass(authorName, nationality ?? "X"))
            {
                using var DB = new SimpleLibraryContext();
                var toEdit = DB.Authors.Find(author.AuthorId);
                if (toEdit == null)
                {
                    throw new Common.Exceptions.AppException("The author was not found!");
                }
                toEdit.AuthorName = authorName;
                toEdit.Nationality = nationality;
                DB.SaveChanges();

                return new Entities.ServiceResult<Author>()
                {
                    Status = Entities.ServiceResultStatus.OK,
                    Message = $"{authorName} modify successfully!",
                    ImageBox = Entities.ImageBox.Information,
                    Value = toEdit
                };
            }
            return new Entities.ServiceResult<Author>()
            {
                ErrorCode = Entities.StandardErrorCode.BadInput,
                Status = Entities.ServiceResultStatus.KO,
                Message = "Bad inputs for the author!",
                ImageBox = Entities.ImageBox.Warning
            };
        }

        /// <summary>
        /// Add an new author in the database and check if exist before.
        /// </summary>
        /// <param name="author">The newest author to add</param>
        /// <returns>ServiceResult with author as data if the operation succeeds, otherwise returns no data.</returns>
        public static ServiceResult<Author> CreateAuthor(DAL.DB.Author author)
        {
            if (author == null)
            {
                throw new Common.Exceptions.AppException("The author in parameter cannot be null!");
            }
            var newAuthor = AuthorExist(author);
            if (newAuthor == null && AuthorValidation.ValidationPass(author.AuthorName, author.Nationality ?? "X"))
            {
                using var DB = new SimpleLibraryContext();
                DB.Authors.Add(author);
                DB.SaveChanges();

                return new Entities.ServiceResult<Author>()
                {
                    Status = Entities.ServiceResultStatus.OK,
                    Message = $"{author.AuthorName} create successfully!",
                    ImageBox = Entities.ImageBox.Information,
                    Value = author
                };
            }
            return new Entities.ServiceResult<Author>()
            {
                ErrorCode = Entities.StandardErrorCode.AlreadyExist,
                Status = Entities.ServiceResultStatus.KO,
                Message = "Bad inputs for the author or an author with the same name already exists!",
                ImageBox = Entities.ImageBox.Warning
            };
        }

        /// <summary>
        /// Deletes an author from the database. All 
        /// </summary>
        /// <param name="author"></param>
        /// <returns>ServiceResult with status OK if the operation succeeds, otherwise returns status KO.</returns>
        public static ServiceResult<Author> DeleteAuthor(DAL.DB.Author author)
        {
            if (author == null)
            {
                throw new Common.Exceptions.AppException("The author or in parameter cannot be null!");
            }
            using var DB = new SimpleLibraryContext();
            DB.Authors.Remove(author);
            DB.SaveChanges();

            return new Entities.ServiceResult<Author>()
            {
                Status = Entities.ServiceResultStatus.OK,
                Message = "Author deleted successfully!",
                ImageBox = Entities.ImageBox.Information
            };
        }

        /// <summary>
        /// Return the author passed in parameter if found in the database.
        /// </summary>
        /// <param name="author">The author to search.</param>
        /// <returns>The author founded, otherwise return null.</returns>
        public static DAL.DB.Author? AuthorExist(Author author)
        {
            using var DB = new SimpleLibraryContext();
            return DB.Authors.Where(A => A.AuthorName == author.AuthorName || A.AuthorId == author.AuthorId).FirstOrDefault() ?? null;
        }

        /// <summary>
        /// Return the author with the same name if exist, or null.
        /// </summary>
        /// <param name="author">The author name to search.</param>
        /// <returns>The author founded, otherwise return null.</returns>
        public static DAL.DB.Author? AuthorExist(string authorName)
        {
            using var DB = new SimpleLibraryContext();
            return DB.Authors.Where(A => A.AuthorName == authorName).FirstOrDefault() ?? null;
        }

        public static IList<Author> GetAuthorsStartWith(string text)
        {
            using var DB = new SimpleLibraryContext();
            return DB.Authors.Where(A => A.AuthorName.ToLower().StartsWith(text.ToLower()))
                .Include("AuthorPublications.Publication")
                .ToList();
        }
    }
    
}
