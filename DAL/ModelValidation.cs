using DAL.DB;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DAL
{
    /// <summary>
    /// Represents all the "validations" for the database model (like a pseudo validation).
    /// </summary>
    public static class ModelValidation
    {
        /// <summary>
        /// Constants for the Author model.
        /// </summary>
        public static class AuthorValidation
        {
            /// <summary>
            /// The minimum string lenght for the authorName.
            /// </summary>
            public const int MIN_AUTHOR_NAME_LENGHT = 2;
            /// <summary>
            /// The maximum string lenght for the authorName.
            /// </summary>
            public const int MAX_AUTHOR_NAME_LENGHT = 50;
            /// <summary>
            /// The maximum string lenght for the authorNationality.
            /// </summary>
            public const int MAX_AUTHOR_NATIONALITY_LENGHT = 3;

            /// <summary>
            /// Check if the constants match to parameters in the validation method.
            /// </summary>
            /// <param name="authorName">The name to check</param>
            /// <param name="authorNationality">The nationatily to check</param>
            /// <returns>True if rules are respected, false otherwise.</returns>
            public static bool ValidationPass(string authorName, string authorNationality)
            {
                return
                    authorName.Length >= MIN_AUTHOR_NAME_LENGHT && authorName.Length <= MAX_AUTHOR_NAME_LENGHT &&
                    authorNationality.Length <= MAX_AUTHOR_NATIONALITY_LENGHT;
            }
        }
    }
}
