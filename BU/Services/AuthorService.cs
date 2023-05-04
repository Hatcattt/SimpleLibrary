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
        static int minAuthorLenght = 2;
        public static List<DAL.DB.Author> GetAuthors()
        {
            using var DB = new SimpleLibraryContext();
            return DB.Authors
                .Include("AuthorPublications.Publication")
                .ToList();
        }

        public static int EditAuthor(Author author, string authorName, string nationality)
        {
            if (author != null && authorName.Length >= minAuthorLenght && nationality.Length >= minAuthorLenght)
            {
                using var DB = new SimpleLibraryContext();
                var authorToEdit = DB.Authors.Find(author.AuthorId);
                if (authorToEdit != null)
                {
                    authorToEdit.AuthorName = authorName;
                    authorToEdit.Nationality = nationality;
                    DB.SaveChanges();
                    return authorToEdit.AuthorId;
                }
            }
            return -1;
        }
    }
    
}
