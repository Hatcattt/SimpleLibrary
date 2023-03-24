using BU.Entities;
using DAL.DB;

namespace BU.Services
{
    /// <summary>
    /// Service class used to get the location of some objects from the library system.
    /// </summary>
    public class LocationService
    {
        /// <summary>
        /// Get the location of a publication.
        /// </summary>
        /// <param name="publication">The publication to search</param>
        /// <returns>The location</returns>
        public static Location GetLocation(Publication publication)
        {
            return new Location();
        }
    }
}
