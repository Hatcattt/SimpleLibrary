using DAL.DB;
using Microsoft.EntityFrameworkCore;

namespace BU.Services
{
    public class TimeStampService
    {
        public static IList<DAL.DB.Publication> GetLastPublicationsAdded(int maxRecord)
        {
            using var DB = new SimpleLibraryContext();
            return DB.Publications
                .OrderByDescending(P => P.CreateAt)
                .Take(maxRecord)
                .Include("PublicationCopies")
                .ToList();
        }
    }
}