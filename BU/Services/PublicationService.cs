using BU.Entities;
using BU.Enums;
using DAL.DB;
using Microsoft.EntityFrameworkCore;

namespace BU.Services
{
    /// <summary>
    /// Service class used to manipulate some publications datas from the library system.
    /// </summary>
    public class PublicationService
    {
        #region Utilities Services Methods
        /// <summary>
        /// Check if a publication existe in the database.
        /// </summary>
        /// <param name="publication">The publication to check.</param>
        /// <returns>True if at least one publication exist, othewise false.</returns>
        public static bool IsPublicationExist(DAL.DB.Publication publication)
        {
            if (publication != null)
            {
                using var DB = new SimpleLibraryContext();
                var publicationExist = DB.Publications
                    .Where(P => P.Isbn == publication.Isbn)
                    .FirstOrDefault();

                return publicationExist != null;
            }
            return false;
        }

        /// <summary>
        /// Get the first publication of the database if found, or a default publication.
        /// </summary>
        /// <returns>The first publication if found, or a default.</returns>
        public static Publication GetFirstPublication()
        {
            using var DB = new SimpleLibraryContext();
            return DB.Publications.FirstOrDefault() ?? new Publication();
        }

        /// <summary>
        /// Get a publication by his publicationId.
        /// </summary>
        /// <param name="publicationId">The publicationId to search</param>
        /// <returns>The publication if found, otherwise a new instance of a publication.</returns>
        public static Publication GetPublication(int publicationId)
        {
            using var DB = new SimpleLibraryContext();
            return DB.Publications.SingleOrDefault(x => x.PublicationId == publicationId) ?? new Publication();
        }

        /// <summary>
        /// Get all publications from the library system into a list.
        /// </summary>
        /// <returns>A list of all publications</returns>
        public static List<Publication> GetPublications()
        {
            using var DB = new SimpleLibraryContext();
            return DB.Publications
                .Include("LocationNavigation.Shelf")
                .Include("LocationNavigation.Theme")
                .Include("PublicationCopies")
                .Include("AuthorPublications.Author")
                .ToList();
        }

        /// <summary>
        /// Get all the publications of an author.
        /// </summary>
        /// <param name="author">The author of the publication(s).</param>
        /// <returns>A list of publication by his author.</returns>
        public static List<Publication> GetPublicationsOf(Author author)
        {
            if (author != null)
            {
                using var DB = new SimpleLibraryContext();
                return DB.AuthorPublications
                    .Where(AP => AP.Author.AuthorId == author.AuthorId)
                    .Select(AP => AP.Publication)
                    .ToList();
            }
            return new List<Publication>();
        }

        public static List<PublicationCopy> GetPublicationCopies(Publication publication)
        {
            using var DB = new SimpleLibraryContext();
            return DB.PublicationCopies
                .Where(PC => PC.PublicationId == publication.PublicationId)
                .Include("PublicationStateNavigation")
                .ToList();
        }

        /// <summary>
        /// Get the fulltitle of a publication in a string format.
        /// Concat the title and the subtitle.
        /// </summary>
        /// <param name="publication">The publication to search</param>
        /// <returns>The full title in a string format.</returns>
        public static string GetFullTitle(Publication publication)
        {
            if (publication != null)
            {
                return $"{publication.Title} {publication.SubTitle}".Trim();
            }
            return "";
        }
        #endregion

        #region CRUD ServiceResult Methods
        /// <summary>
        /// Add a new publication in the database.
        /// </summary>
        /// <param name="publication">The publication to add.</param>
        /// <returns>ServiceResult with data if the operation succeeds, otherwise returns no data.</returns>
        /// <exception cref="ArgumentNullException">If publiction is null.</exception>
        public static ServiceResult<Publication> AddNewPublication(Publication publication)
        {
            if (publication == null)
            {
               throw new Common.Exceptions.AppException($"{nameof(publication)} cannot be null!");
            }

            using var DB = new SimpleLibraryContext();

            if (IsPublicationExist(publication))
            {
                return new ServiceResult<Publication>()
                {
                    Status = ServiceResultStatus.KO,
                    ErrorCode = StandardErrorCode.AlreadyExist,
                    Message = "The publication you want to add already exists inside the system and cannot be added.",
                    ImageBox = ImageBox.Warning
                };
            }

            DB.Publications.Add(publication);
            DB.SaveChanges();

            return new ServiceResult<Publication>()
            {
                Status = ServiceResultStatus.OK,
                Message = "Publication added successfully!",
                ImageBox = ImageBox.Information,
                Value = publication
            };
        }

        /// <summary>
        /// Edit a publication in the database.
        /// </summary>
        /// <param name="publication">The publication to edit.</param>
        /// <returns>ServiceResult with data if the operation succeeds, otherwise returns no data.</returns>
        /// <exception cref="ArgumentNullException">If publiction is null.</exception>
        public static ServiceResult<Publication> EditPublication(Publication publication)
        {
            if (publication == null)
            {
                throw new Common.Exceptions.AppException($"{nameof(publication)} cannot be null!");
            }

            using var DB = new SimpleLibraryContext();

            if (IsPublicationExist(publication))
            {
                return new ServiceResult<Publication>()
                {
                    Status = ServiceResultStatus.KO,
                    ErrorCode = StandardErrorCode.AlreadyExist,
                    Message = "The publication you want to add already exists inside the system and cannot be added.",
                    ImageBox = ImageBox.Warning
                };
            }

            DB.Publications.Add(publication);
            DB.SaveChanges();

            return new ServiceResult<Publication>()
            {
                Status = ServiceResultStatus.OK,
                Message = "Publication added successfully!",
                ImageBox = ImageBox.Information,
                Value = publication
            };
        }

        /// <summary>
        /// Delete a publication from the database.
        /// </summary>
        /// <param name="publication">The publication to delete.</param>
        /// <returns>ServiceResult with status OK if the operation succeeds, otherwise returns KO.</returns>
        /// <exception cref="ArgumentNullException">If publiction is null.</exception>
        public static ServiceResult<Publication> DeletePublication(Publication publication)
        {
            if (publication == null)
            {
                throw new Common.Exceptions.AppException($"{nameof(publication)} cannot be null!");
            }

            try
            {
                using var DB = new SimpleLibraryContext();
                DB.Publications.Remove(publication);
                DB.SaveChanges();
                return new ServiceResult<Publication>()
                {
                    Status = ServiceResultStatus.OK,
                    Message = "Publication deleted successfully!",
                    ImageBox = ImageBox.Information
                };

            } catch (Exception ex)
            {
                throw new Common.Exceptions.AppException($"Error during the deletion of a publication: {ex.Message}");
            }
        }

        /// <summary>
        /// Add one or more copies of the publication in the database.
        /// </summary>
        /// <param name="publication"></param>
        /// <param name="publicationState"></param>
        /// <param name="number"></param>
        public static void AddPublicationCopies(Publication publication, Enums.PublicationState publicationState, int number)
        {
            if (publication == null)
            {
                throw new ArgumentNullException("The publication to copy cannot be null.");
            }

            if (number > 0)
            {
                using var DB = new SimpleLibraryContext();
                Publication publicationToCopy = GetPublication(publication.PublicationId);

                int numberOfCopiesToAdd = number > 0 ? number : 0;

                for (int i = 0; i < numberOfCopiesToAdd; i++)
                {
                    PublicationCopy newCopy = new PublicationCopy()
                    {
                        PublicationId = publication.PublicationId,
                        PublicationState = (int)publicationState
                    };

                    DB.PublicationCopies.Add(newCopy);
                }
                DB.SaveChanges();
            }
        }

        public static void ChangeCoverFilePath(Publication publication, string destination)
        {
            using var DB = new SimpleLibraryContext();
            Publication publicationToEdit = GetPublication(publication.PublicationId);
            publicationToEdit.CoverFilePath = destination;
            DB.SaveChanges();
        }
        #endregion
    }
}
