using DAL.DB;

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
            var publications = new List<Publication>();

            DB.Publications.ToList().ForEach(p =>
            {
                if (p.Title.ToLower().StartsWith(sequence.ToLower()))
                {
                    publications.Add(p);
                }
            });

            return publications;
        }

        /// <summary>
        /// Get a list of publications whose publisher begins with a sequence.
        /// </summary>
        /// <param name="sequence">The sequence to search</param>
        /// <returns>A list of publications</returns>
        public static List<Publication> GetPublicationsStartWithPublisher(string sequence)
        {
            using var DB = new SimpleLibraryContext();
            var publications = new List<Publication>();

            DB.Publications.ToList().ForEach(p =>
            {
                if (p.Publisher.ToLower().StartsWith(sequence.ToLower()))
                {
                    publications.Add(p);
                }
            });

            return publications;
        }

        /// <summary>
        /// Get a list of publications whose ISBN begins with a sequence.
        /// </summary>
        /// <param name="sequence">The sequence to search</param>
        /// <returns>A list of publications</returns>
        public static List<Publication> GetPublicationsStartWithISBN(string sequence)
        {
            using var DB = new SimpleLibraryContext();
            var publications = new List<Publication>();

            DB.Publications.ToList().ForEach(p =>
            {
                if (p.Isbn.ToLower().StartsWith(sequence.ToLower()))
                {
                    publications.Add(p);
                }
            });

            return publications;
        }
    }
}
