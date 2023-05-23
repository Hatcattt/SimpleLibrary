using Microsoft.IdentityModel.Tokens;

namespace BU.Entities
{
    /// <summary>
    /// This class represent the cover image of a publication.
    /// </summary>
    public class CoverImage
    {
        public const string COVER_ROOT_DIR = @"\Images\Covers\";
        public const string IMAGE_EXTENTION = ".jpg";
        public static readonly string DEFAUT_IMAGE_PATH = COVER_ROOT_DIR + "DEFAULT.jpg";

        public string ImageName { get; set; }
        public string? ImagePath { get; set; }

        public readonly string Isbn;

        /// <summary>
        /// Constructor of a coverimage associed with an isbn publication code.
        /// </summary>
        /// <param name="isbn">The isbn code of a publication</param>
        public CoverImage(string imagePath, string isbn)
        {
            if (isbn.IsNullOrEmpty())
            {
                throw new ArgumentNullException(nameof(isbn) + " isbn cannot be null.");
            }
            Isbn = isbn;
            ImagePath = imagePath;
            ImageName = Isbn + IMAGE_EXTENTION;
        }

        public static bool IsFromAPI(string imagePath)
        {
            return ! imagePath.IsNullOrEmpty() && imagePath.StartsWith("http");
        }
    }
}
