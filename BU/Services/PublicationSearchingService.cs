using DAL.DB;
using Microsoft.EntityFrameworkCore;
using Microsoft.IdentityModel.Tokens;

namespace BU.Services
{
    /// <summary>
    /// Class used for the searching system.
    /// </summary>
    public class PublicationSearchingService
    {
        /// <summary>
        /// Get a list of publications whose title begins with a sequence.
        /// </summary>
        /// <param name="sequence">The sequence to search</param>
        /// <returns>A list of publications</returns>
        public static List<Publication> GetPublicationsStartWithTitle(string sequence)
        {
            using var DB = new SimpleLibraryContext();
            return DB.Publications
                .Where(P => P.Title.ToLower().StartsWith(sequence.ToLower()))
                .Include("LocationNavigation.Shelf")
                .Include("LocationNavigation.Theme")
                .Include("PublicationCopies")
                .Include("AuthorPublications.Author")
                .ToList();
        }

        /// <summary>
        /// Get a list of publications whose ISBN begins with a sequence.
        /// </summary>
        /// <param name="sequence">The sequence to search</param>
        /// <returns>A list of publications</returns>
        public static List<Publication> GetPublicationsStartWithISBN(string sequence)
        {
            using var DB = new SimpleLibraryContext();
            return DB.Publications
                .Where(P => P.Isbn.ToLower().StartsWith(sequence.ToLower()))
                .Include("LocationNavigation.Shelf")
                .Include("LocationNavigation.Theme")
                .Include("PublicationCopies")
                .Include("AuthorPublications.Author")
                .ToList();
        }

        /// <summary>
        /// Get a list of publications of a shelf.
        /// </summary>
        /// <param name="sequence">The shelf to search</param>
        /// <returns>A list of publications</returns>
        public static List<Publication> GetPublicationsOf(DAL.DB.Shelf shelf)
        {
            using var DB = new SimpleLibraryContext();
            return DB.Publications
                .Where(P => P.LocationNavigation.Shelf == shelf)
                .Include("LocationNavigation.Shelf")
                .Include("LocationNavigation.Theme")
                .Include("PublicationCopies")
                .Include("AuthorPublications.Author")
                .ToList();
        }
    }
}
