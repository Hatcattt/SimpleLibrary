using DAL.DB;
using Microsoft.EntityFrameworkCore;

namespace BU.Services
{
    /// <summary>
    /// Service class used to get data with date or timestramp concept.
    /// </summary>
    public class TimeStampService
    {
        /// <summary>
        /// Get a list of the latest publications added in the application.
        /// The maxRecord parameter must be between 1 and int.MaxValue.
        /// </summary>
        /// <param name="maxRecord">The max record to add in the list.</param>
        /// <returns>A list with latest publications added, or an empty list if maxRecord is incorrect.</returns>
        public static IList<DAL.DB.Publication> GetLastPublicationsAdded(int maxRecord)
        {
            if (maxRecord >= 1 && maxRecord < int.MaxValue)
            {
                using var DB = new SimpleLibraryContext();
                return DB.Publications
                    .OrderByDescending(P => P.CreateAt)
                    .Take(maxRecord)
                    .Include("PublicationCopies")
                    .ToList();
            }
            return new List<DAL.DB.Publication>();
        }
    }
}