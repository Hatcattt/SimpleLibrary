using DAL.DB;
using Microsoft.IdentityModel.Tokens;
using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Linq;
using System.Text;
using System.Text.RegularExpressions;
using System.Threading.Tasks;
using static Microsoft.EntityFrameworkCore.DbLoggerCategory.Model;

namespace DAL
{
    /// <summary>
    /// Abstract class used to validate data before adding it to the database.
    /// </summary>
    public abstract class ValidationModel
    {
        /// <summary>
        /// The model to validate.
        /// </summary>
        private readonly object model;
        /// <summary>
        /// All errors when bad validation.
        /// </summary>
        public StringBuilder Errors { get; private set; }

        /// <summary>
        /// Constructor of a validation model.
        /// </summary>
        /// <param name="model">The model to validate</param>
        /// <exception cref="Common.Exceptions.AppNullArgException">If model is null.</exception>
        public ValidationModel(object model)
        {
            this.model = model ?? throw new Common.Exceptions.AppNullArgException("The model to make a validation cannot be null!");
            Errors = new StringBuilder();
        }

        /// <summary>
        /// Indicates whether the model to be validated contains errors.
        /// </summary>
        /// <returns>True if validation model contains error, otherwise false.</returns>
        public bool ContainError()
        {
            return ! Errors.ToString().IsNullOrEmpty();
        }

        /// <summary>
        /// Error message when a proprety is null or empty, or the length of a proprety is greater than the recommended length for that proprety.
        /// </summary>
        /// <param name="proprety">The proprety to check</param>
        /// <param name="lenght">The lenght that can cause the error</param>
        /// <returns>A string of a error message.</returns>
        public static string CharactersIsNullOrGreater(string proprety, int lenght)
        {
            return $"- {proprety} cannot by empty or the number of characters cannot be greater than {lenght}.\n\n";
        }

        /// <summary>
        /// Error message when the length of a proprety is greater than the recommended length for that proprety.
        /// </summary>
        /// <param name="proprety">The proprety to check</param>
        /// <param name="lenght">The lenght that can cause the error</param>
        /// <returns>A string of a error message.</returns>
        public static string CharactersIsGreater(string proprety, int lenght)
        {
            return $"- {proprety} : the number of characters cannot be greater than {lenght}.\n\n";
        }

        /// <summary>
        /// Error message when proprety is null or missing.
        /// </summary>
        /// <param name="proprety">The proprety to check</param>
        /// <returns>A string of a error message.</returns>
        public static string PropretyIsMissing
            (string proprety)
        {
            return $"- You must have a value for the {proprety}.\n\n";
        }
    }

    /// <summary>
    /// Validation class for a publication model.
    /// </summary>
    public class PublicationValidation : ValidationModel
    {
        public const int MAX_ISBN_LENGHT = 20;
        public const int MAX_TITLE_LENGHT = 100;
        public const int LETTER_ROW_LENGHT = 1;
        public const int MAX_PUBLISHER_LENGHT = 100;
        public const int MAX_LANGUAGE_LENGHT = 3;
        public const int MIN_LOCATION = 1;

        /// <summary>
        /// Create a new validation instance for a publication model.
        /// </summary>
        /// <param name="publication">The publication to validate.</param>
        public PublicationValidation(Publication publication) : base(publication)
        {
            if (publication.Isbn.IsNullOrEmpty() || publication.Isbn.Length > MAX_ISBN_LENGHT)
            {
                Errors.Append(CharactersIsNullOrGreater("Isbn", MAX_ISBN_LENGHT));
            }
            if (publication.Title.IsNullOrEmpty() || publication.Title.Length > MAX_TITLE_LENGHT)
            {
                Errors.Append(CharactersIsNullOrGreater("Title", MAX_TITLE_LENGHT));
            }
            if (publication.Publisher.IsNullOrEmpty() || publication.Publisher.Length > MAX_PUBLISHER_LENGHT)
            {
                Errors.Append(CharactersIsNullOrGreater("Publisher", MAX_PUBLISHER_LENGHT));
            }
            if (publication.LetterRow.IsNullOrEmpty() || publication.LetterRow.Length != LETTER_ROW_LENGHT)
            {
                Errors.Append("- Letter row is based on the title. Title can't be null or empty!\n\n");
            }
            if (publication.Language?.Length > MAX_LANGUAGE_LENGHT)
            {
                Errors.Append(CharactersIsGreater("Language", MAX_LANGUAGE_LENGHT));
            }
            if (publication.Location < MIN_LOCATION)
            {
                Errors.Append(PropretyIsMissing("Location"));
            }
        }
    }

    /// <summary>
    /// Validation class for an author model instance.
    /// </summary>
    public class AuthorValidation : ValidationModel
    {
        /// <summary>
        /// The maximum string lenght for the authorName.
        /// </summary>
        public const int MAX_AUTHOR_NAME_LENGHT = 50;
        /// <summary>
        /// The maximum string lenght for the authorNationality.
        /// </summary>
        public const int MAX_AUTHOR_NATIONALITY_LENGHT = 3;

        public const string DEFAULT_PUBLISHER = "Unknown";

        /// <summary>
        /// Create a new validation instance for a author model.
        /// </summary>
        /// <param name="author">The author to validate.</param>
        public AuthorValidation(DAL.DB.Author author) : base(author)
        {
            if (author.AuthorName.IsNullOrEmpty() || author.AuthorName.Length > MAX_AUTHOR_NAME_LENGHT)
            {
                Errors.Append(CharactersIsNullOrGreater("Name", MAX_AUTHOR_NAME_LENGHT));
            }
            if (author.Nationality?.Length > MAX_AUTHOR_NATIONALITY_LENGHT)
            {
                Errors.Append(CharactersIsNullOrGreater("Nationality", MAX_AUTHOR_NATIONALITY_LENGHT));
            }
        }
    }

    /// <summary>
    /// Validation class for an Shelf model instance.
    /// </summary>
    public class ShelfValidation : ValidationModel
    {
        /// <summary>
        /// The maximum string lenght for the authorName.
        /// </summary>
        public const int MAX_SHELF_NAME_LENGHT = 50;

        /// <summary>
        /// Create a new validation instance for a shelf model.
        /// </summary>
        /// <param name="shelf">The shelf to validate.</param>
        public ShelfValidation(DAL.DB.Shelf shelf) : base(shelf)
        {
            if (shelf.ShelfName.IsNullOrEmpty() || shelf.ShelfName.Length > MAX_SHELF_NAME_LENGHT)
            {
                Errors.Append(CharactersIsNullOrGreater("Name", MAX_SHELF_NAME_LENGHT));
            }
        }
    }

    /// <summary>
    /// Validation class for an Theme model instance.
    /// </summary>
    public class ThemeValidation : ValidationModel
    {
        /// <summary>
        /// The maximum string lenght for the authorName.
        /// </summary>
        public const int MAX_THEME_NAME_LENGHT = 50;

        /// <summary>
        /// Create a new validation instance for a theme model.
        /// </summary>
        /// <param name="theme">The theme to validate.</param>
        public ThemeValidation(DAL.DB.Theme theme) : base(theme)
        {
            if (theme.ThemeName.IsNullOrEmpty() || theme.ThemeName.Length > MAX_THEME_NAME_LENGHT)
            {
                Errors.Append(CharactersIsNullOrGreater("Name", MAX_THEME_NAME_LENGHT));
            }
        }
    }
}
