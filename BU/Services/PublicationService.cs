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
        /// Get all publications with multiples include from the library system into a list.
        /// </summary>
        /// <returns>A list of all publications</returns>
        public static List<Publication> GetPublications()
        {
            using var DB = new SimpleLibraryContext();
            return DB.Publications
                .Include("LocationNavigation.Shelf")
                .Include("LocationNavigation.Theme")
                .Include("PublicationCopies")
                .Include("AuthorPublications")
                .Include("AuthorPublications.Author")
                .ToList();
        }

        /// <summary>
        /// Get the location of a publication in a string format.
        /// </summary>
        /// <param name="publication">The publication to search</param>
        /// <returns>The location in a string format, or empty string if publication is null.</returns>
        public static string GetLocation(Publication? publication)
        {
            if (publication == null)
            {
                return string.Empty;
            }
            var location = publication.LocationNavigation;
            return $"{location.Shelf.ShelfName} : {location.Theme.ThemeName}";
        }

        /// <summary>
        /// Get the fulltitle of a publication in a string format.
        /// Concat the title and the subtitle.
        /// </summary>
        /// <param name="publication">The publication to search</param>
        /// <returns>The full title in a string format, or empty string if publication is null.</returns>
        public static string GetFullTitle(Publication? publication)
        {
            if (publication == null)
            {
                return string.Empty;
            }
            return $"{publication.Title} {publication.SubTitle}".Trim(); ;
        }

        /// <summary>
        /// Get the number of copies of a publication for a publicationState.
        /// </summary>
        /// <param name="publication">The publication to count copies</param>
        /// <param name="publicationState">The state of a publication</param>
        /// <returns>The number of copies, or 0 if publication is null.</returns>
        public static int GetCopiesCount(Publication? publication, PublicationState publicationState)
        {
            if (publication == null)
            {
                return 0;
            }

            using var DB = new SimpleLibraryContext();
            return DB.PublicationCopies
                .Where(PC => PC.PublicationId == publication.PublicationId && PC.PublicationState == (int)publicationState)
                .Count();
        }

        /// <summary>
        /// Get a list of authorpublication for a publication.
        /// </summary>
        /// <param name="publication">The publication of author(s)</param>
        /// <returns>A list of authorpublication for a publication, or an empty list of publication is null.</returns>
        public static List<AuthorPublication> GetAuthorPublication(Publication? publication)
        {
            using var DB = new SimpleLibraryContext();
            if (publication == null)
            {
                return new List<AuthorPublication>();
            }
            var authors = DB.AuthorPublications
                .Where(AP => AP.PublicationId == publication.PublicationId)
                .Include("Author")
                .ToList();
            return authors;
        }

        #endregion

        #region CRUD ServiceResult Methods
        /// <summary>
        /// Add a new publication in the database.
        /// </summary>
        /// <param name="publication">The publication to add.</param>
        /// <returns>ServiceResult with data if the operation succeeds, otherwise returns no data.</returns>
        /// <exception cref="ArgumentNullException">If publication is null.</exception>
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
        /// Delete a publication from the database. All AuthorPublication will be removed too.
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

            using var DB = new SimpleLibraryContext();
            DB.Publications.Remove(publication);
            DB.SaveChanges();
            return new ServiceResult<Publication>()
            {
                Status = ServiceResultStatus.OK,
                Message = "Publication deleted successfully!",
                ImageBox = ImageBox.Information
            };
        }

        /// <summary>
        /// Add one or more copies of a publication in the database. The number of copy must be smaller than int.MaxValue .
        /// </summary>
        /// <param name="publication">The publication to copy.</param>
        /// <param name="publicationState">The publication state (lisibility).</param>
        /// <param name="number">The number of copy.</param>
        /// <exception cref="ArgumentNullException">If the publication is null.</exception>
        public static void AddPublicationCopies(Publication publication, Enums.PublicationState publicationState, int number)
        {
            if (publication == null)
            {
                throw new Common.Exceptions.AppNullArgException("Cannot copy null value for a publication!");
            }

            if (number > 0 && number < int.MaxValue)
            {
                using var DB = new SimpleLibraryContext();

                for (int i = 0; i < number; i++)
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

        /// <summary>
        /// Add a new author publication in the database.
        /// </summary>
        /// <param name="author">The author of the publication</param>
        /// <param name="publication">The publication to associed</param>
        /// <param name="authorFunction">The function of the author</param>
        /// <returns>New service result with status OK.</returns>
        /// <exception cref="Common.Exceptions.AppNullArgException">If author or publication is null.</exception>
        public static ServiceResult<DAL.DB.AuthorPublication> AddNewAuthorPublication(Author? author, Publication publication, string? authorFunction)
        {
            if (author == null || publication == null)
            {
                throw new Common.Exceptions.AppNullArgException($"{nameof(author)} or {nameof(publication)} cannot be null!");
            }

            using var DB = new SimpleLibraryContext();
            var newAuthorPublication = new DAL.DB.AuthorPublication()
            {
                AuthorId = author.AuthorId,
                PublicationId = publication.PublicationId,
                AuthorFunction = authorFunction
            };
            DB.AuthorPublications.Add(newAuthorPublication);
            DB.SaveChanges();

            return new ServiceResult<AuthorPublication>()
            {
                Status = ServiceResultStatus.OK,
                Message = "Author Publication added successfully!",
            };
        }

        /// <summary>
        /// Get the cover file path of a publication. If the publication is null or the cover is null, the default cover file path is aplied.
        /// </summary>
        /// <param name="publication">The publication to get the cover.</param>
        /// <returns>The cover file path of the publication, or the default cover file path.</returns>
        public static string GetCoverImagePath(Publication? publication)
        {
            if (publication == null || publication.CoverFilePath == null)
            {
                return CoverConstants.DEFAUT_IMAGE_PATH;
            }
            return publication.CoverFilePath;
        }
        #endregion
    }
}
