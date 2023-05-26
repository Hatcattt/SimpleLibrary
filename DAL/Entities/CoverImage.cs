using Microsoft.Extensions.Configuration;
using Microsoft.IdentityModel.Tokens;

namespace BU.Entities
{
    /// <summary>
    /// Constants for the cover image of a publication.
    /// </summary>
    public class CoverConstants
    {
        /// <summary>
        /// The maximum size of an image in pixel.
        /// </summary>
        public const int IMAGE_MAX_SIZE = 1000;
        /// <summary>
        /// The default image extention.
        /// </summary>
        public const string IMAGE_EXTENTION = ".jpg";
        /// <summary>
        /// The default image path. It's located inside the application project.
        /// </summary>
        public const string DEFAUT_IMAGE_PATH = @"\Images\Covers\DEFAULT.jpg";
        /// <summary>
        /// The main cover folder for image storing proccess. Depend on the appsettings.json
        /// </summary>
        public static readonly string? COVER_MAIN_FOLDER = new ConfigurationBuilder()
            .AddJsonFile("appsettings.json")
            .Build()
            .GetSection("AppSettings")["CoverFolderPath"];
    }

    /// <summary>
    /// This class represent the cover image of a publication.
    /// </summary>
    public class CoverImage
    {
        private string imageName;
        /// <summary>
        /// The name of the image.
        /// </summary>
        public string ImageName
        {
            get { return imageName; }
            set { imageName = value; }
        }
        private string imagePath;
        /// <summary>
        /// The file path of the image.
        /// </summary>
        public string ImagePath
        {
            get { return imagePath; }
            set { imagePath = value; }
        }
        /// <summary>
        /// The Isbn code of the image, from the publication.
        /// </summary>
        public readonly string Isbn;

        /// <summary>
        /// Constructor of a coverimage associed with an isbn publication code.
        /// Generate the name of the file with the isbn + an image extention.
        /// </summary>
        /// <param name="imagePath">The path of the image</param>
        /// <param name="isbn">The isbn code of a publication</param>
        /// <exception cref="ArgumentNullException">If the isbn is null or empty</exception>
        public CoverImage(string imagePath, string isbn)
        {
            if (isbn.IsNullOrEmpty())
            {
                throw new ArgumentNullException(nameof(isbn) + " isbn cannot be null or empty.");
            }
            this.imagePath = imagePath.IsNullOrEmpty() ? CoverConstants.DEFAUT_IMAGE_PATH : imagePath;
            this.Isbn = isbn;
            this.imageName = $"{isbn}{CoverConstants.IMAGE_EXTENTION}";
        }
    }
}
