using Microsoft.IdentityModel.Tokens;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Text;
using System.Threading.Tasks;

namespace DAL
{
    public class PublicationCover
    {
        private string coverName;
        private string coverFilePath;
        private int publicationID;

        public PublicationCover(int publicationID)
        {
            this.publicationID = publicationID;
        }
        //private readonly string url;
        //private static readonly string baseDirPath = Directory.GetCurrentDirectory();
        //private readonly string filePath;
        //private string imageFormat = ".jpg";
        //public string FilePath { get; private set; }

        //public PublicationCover(string url, int publicationID)
        //{
        //    this.url = url;
        //    filePath = baseDirPath + @"\..\..\WpfApp\image\";
        //}
    }
}
