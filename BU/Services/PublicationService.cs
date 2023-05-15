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

        /// <summary>
        /// Get the first publication.
        /// </summary>
        /// <returns>The first publication</returns>
        public static Publication GetFirstPublication()
        {
            using var DB = new SimpleLibraryContext();
            return DB.Publications.First();
        }

        /// <summary>
        /// Get a publication by his id.
        /// </summary>
        /// <param name="id">The id to search</param>
        /// <returns>The publication</returns>
        public static Publication? GetPublication(int id)
        {
            using var DB = new SimpleLibraryContext();
            return DB.Publications.SingleOrDefault(x => x.PublicationId == id);
        }
        public static void RemovePublication(Publication publication) { }
        public static void UpdatePublication(Publication publication) { }


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
                return $"{publication.Title} {publication.SubTitle}";

            }
            return "";
        }

        /// <summary>
        /// Add a new publication inside the Database.
        /// Return a new ServiceResult with datas if status is OK, otherwise return without.
        /// </summary>
        /// <param name="publication">The publication to add inside the Database.</param>
        /// <returns>A new ServiceResult with or without datas.</returns>
        /// <exception cref="ArgumentException">If the publiction is null.</exception>
        public static ServiceResult<Publication> AddNewPublication(Publication publication)
        {
            if (publication == null)
            {
               throw new ArgumentNullException("Publication cannot be null.");
            }

            using var DB = new SimpleLibraryContext();
            var publicationExist = DB.Publications.Where(P => P.Isbn == publication.Isbn).FirstOrDefault();
            
            if (publicationExist == null)
            {
                DB.Publications.Add(publication);
                DB.SaveChanges();
            } else
            {
                return new ServiceResult<Publication>()
                {
                    Status = ServiceResultStatus.KO,
                    ErrorCode = StandardErrorCode.AlreadyExist,
                    Message = "The publication you want to add already exists inside the system."
                };
            }
            return new ServiceResult<Publication>()
            {
                Status = ServiceResultStatus.OK,
                Value = publication,
                Message = "Publication added successfully!"
            };
        }

        public static void AddPublicationCopies(Publication publication, Entities.PublicationState publicationState, int number)
        {
            using var DB = new SimpleLibraryContext();
            Publication publicationToCopy = GetPublication(publication.PublicationId);

            int numberOfCopiesToAdd = number > 0 ? number : 0;
            for (int i = 0; i < numberOfCopiesToAdd; i++)
            {
                PublicationCopy newCopy = new PublicationCopy()
                {
                    PublicationId = publication.PublicationId,
                    PublicationState = (int)publicationState,
                };

                DB.PublicationCopies.Add(newCopy);
            }
            DB.SaveChanges();
        }
    }
}
