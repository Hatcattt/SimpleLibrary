using DAL.DB;

namespace BU.Services
{
    public class AuthorPublicationService
    {
        public static List<Author> GetAuthorsPublication(Publication publication)
        {
            using var DB = new SimpleLibraryContext();
            var authors = new List<Author>();
            // 
            return authors;
        }

        /// <summary>
        /// Set an author to a publication.
        /// </summary>
        /// <param name="author">The author to set</param>
        /// <param name="publication">The publication to set</param>
        /// <returns>true if success, false otherwise</returns>
        public static bool SetAuthorPublication(Author author, Publication publication)
        {
            return true;
        }
    }
}
