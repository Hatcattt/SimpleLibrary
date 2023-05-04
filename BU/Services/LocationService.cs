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
        /// Get the location of a publication in a string format.
        /// </summary>
        /// <param name="publication">The publication to search</param>
        /// <returns>The location in a string format.</returns>
        public static string GetLocation(Publication publication)
        {
            return $"{publication.LocationNavigation.Shelf.ShelfName} : {publication.LocationNavigation.Theme.ThemeName} : [ {publication.LetterRow} ]";
        }
    }
}
