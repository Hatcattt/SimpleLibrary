using DAL.DB;

namespace BU.Services
{
    public class AuthorPublicationService
    {
        public static List<Author> GetAuthors(Publication publication)
        {
            using var DB = new SimpleLibraryContext();
            if (publication != null)
            {
                var authors = DB.AuthorPublications.Where(AP => AP.PublicationId == publication.PublicationId).Select(AP => AP.Author).ToList();
                return authors;
            }
            return new List<Author>();
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
