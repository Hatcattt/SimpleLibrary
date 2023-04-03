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
        /// Get a publication by his id.
        /// </summary>
        /// <param name="id">The id to search</param>
        /// <returns>The publication</returns>
        public static Publication? GetPublication(int id)
        {
            using var DB = new SimpleLibraryContext();
            return DB.Publications.SingleOrDefault(x => x.PublicationId == id);
        }

        public static void CreatePublication(Publication publication) { }
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
                .ToList();
        }

        public static List<AuthorPublication> GetAuthorsOf(Publication publication)
        {
            using var DB = new SimpleLibraryContext();
            return DB.AuthorPublications
                .Where(AP => AP.Publication.PublicationId == publication.PublicationId)
                .Include("Author")
                .ToList();
        }

        public static List<PublicationCopy> GetPublicationCopies(Publication publication)
        {
            using var DB = new SimpleLibraryContext();
            return DB.PublicationCopies
                .Where(PC => PC.PublicationId == publication.PublicationId)
                .ToList();
        }
    }
}
