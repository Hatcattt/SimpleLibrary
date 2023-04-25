using DAL.DB;
using Microsoft.EntityFrameworkCore;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace BU.Services
{
    public class AuthorService
    {
        public static List<DAL.DB.Author> GetAuthors()
        {
            using var DB = new SimpleLibraryContext();
            return DB.Authors
                .Include("AuthorPublications.Publication")
                .ToList();
        }
    }
    
}
