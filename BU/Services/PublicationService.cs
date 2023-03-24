using DAL.DB;

namespace BU.Services
{
    /// <summary>
    /// Service class used to manipulate some publications datas from the library system.
    /// </summary>
    public class PublicationService
    {

        public static int GetCopieCount(int id)
        {
            using var DB = new SimpleLibraryContext();
            var lib = DB.Publications.SingleOrDefault(x => x.PublicationId == id);
            return lib.PublicationCopies.Count();

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

        /// <summary>
        /// Get a publication by his title.
        /// </summary>
        /// <param name="title">The title to search</param>
        /// <returns>The publication</returns>
        public static Publication GetPublication(string title)
        {
            using var DB = new SimpleLibraryContext();
            return DB.Publications.SingleOrDefault(x => x.Title == title);
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
            return DB.Publications.ToList();
        }

        public static int GetCopyCountOfPublication(Publication p)
        {
            using var DB = new SimpleLibraryContext();
            var publication = DB.Publications.Where(P => P.PublicationId == p.PublicationId).SingleOrDefault();

            if (publication != null)
            {
                var goodCopy = publication.PublicationCopies.Where(p => p.PublicationState.Equals("Good")).Count();
                return goodCopy;
            }
            return -1;
        }
    }
}
