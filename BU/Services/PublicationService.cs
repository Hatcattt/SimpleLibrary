using BU.Entities;
using BU.Enums;
using DAL;
using DAL.DB;
using Microsoft.EntityFrameworkCore;
using Microsoft.IdentityModel.Tokens;

namespace BU.Services
{
    /// <summary>
    /// Service class used to manipulate some publications datas from the library system.
    /// </summary>
    public class PublicationService
    {
        #region Utilities Services Methods

        /// <summary>
        /// Return the publication passed in parameter if found in the database.
        /// </summary>
        /// <param name="publication">The publication to search.</param>
        /// <returns>The publication founded, otherwise return null.</returns>
        public static DAL.DB.Publication? PublicationExist(DAL.DB.Publication publication)
        {
            using var DB = new SimpleLibraryContext();
            return DB.Publications
                .Where(P => P.Isbn == publication.Isbn || P.PublicationId == publication.PublicationId)
                .FirstOrDefault() ?? null;
        }

        /// <summary>
        /// Get a publication by his publicationId.
        /// </summary>
        /// <param name="publicationId">The publicationId to search</param>
        /// <returns>The publication if found, otherwise a new instance of a publication.</returns>
        public static Publication GetPublication(int publicationId)
        {
            using var DB = new SimpleLibraryContext();
            return DB.Publications
                .Include("LocationNavigation.Shelf")
                .Include("LocationNavigation.Theme")
                .Include("AuthorPublications")
                .Include("AuthorPublications.Author")
                .SingleOrDefault(x => x.PublicationId == publicationId) ?? new Publication();
        }

        /// <summary>
        /// Get all publications with multiples include from the library system into a list.
        /// </summary>
        /// <returns>A list of all publications</returns>
        public static List<Publication> GetPublications()
        {
            using var DB = new SimpleLibraryContext();
            return DB.Publications
                .Include("LocationNavigation.Shelf")
                .Include("LocationNavigation.Theme")
                .Include("PublicationCopies")
                .Include("AuthorPublications")
                .Include("AuthorPublications.Author")
                .ToList();
        }

        /// <summary>
        /// Get the location of a publication in a string format.
        /// </summary>
        /// <param name="publication">The publication to search</param>
        /// <returns>The location in a string format, or empty string if publication is null.</returns>
        public static string GetLocation(Publication? publication)
        {
            if (publication == null)
            {
                return string.Empty;
            }
            var location = publication.LocationNavigation;
            return $"{location.Shelf.ShelfName} : {location.Theme.ThemeName}";
        }

        /// <summary>
        /// Get the number of copies of a publication for a publicationState.
        /// </summary>
        /// <param name="publication">The publication to count copies</param>
        /// <param name="publicationState">The state of a publication</param>
        /// <returns>The number of copies, or 0 if publication is null.</returns>
        public static int GetCopiesCount(Publication? publication, PublicationState publicationState)
        {
            if (publication == null)
            {
                return 0;
            }

            using var DB = new SimpleLibraryContext();
            return DB.PublicationCopies
                .Where(PC => PC.PublicationId == publication.PublicationId && PC.PublicationState == (int)publicationState)
                .Count();
        }

        /// <summary>
        /// Get a list of authorpublication for a publication.
        /// </summary>
        /// <param name="publication">The publication of author(s)</param>
        /// <returns>A list of authorpublication for a publication, or an empty list of publication is null.</returns>
        public static List<AuthorPublication> GetAuthorPublications(Publication? publication)
        {
            using var DB = new SimpleLibraryContext();
            if (publication == null)
            {
                return new List<AuthorPublication>();
            }
            var authors = DB.AuthorPublications
                .Where(AP => AP.PublicationId == publication.PublicationId)
                .Include("Author")
                .ToList();
            return authors;
        }

        /// <summary>
        /// Get the cover file path of a publication. If the publication is null or the cover is null, the default cover file path is aplied.
        /// </summary>
        /// <param name="publication">The publication to get the cover.</param>
        /// <returns>The cover file path of the publication, or the default cover file path.</returns>
        public static string GetCoverImagePath(Publication? publication)
        {
            if (publication == null || publication.CoverFilePath == null)
            {
                return CoverConstants.DEFAUT_IMAGE_PATH;
            }
            return publication.CoverFilePath;
        }

        /// <summary>
        /// Get the letter row of a publication by his title.
        /// </summary>
        /// <param name="title">The title to get the letter row.</param>
        /// <returns>The first letter in the title, or empty string.</returns>
        public static string GetLetterRow(string title)
        {
            return title.Length >= 1 ? title[..1] : string.Empty;
        }

        /// <summary>
        /// Get the number of publication in the database.
        /// </summary>
        /// <returns>The number of publication in the database.</returns>
        public static int GetNumberOfPublication()
        {
            using var DB = new SimpleLibraryContext();
            return DB.Publications.Count();
        }

        public static bool AuthorPublicationExist(Publication publication, Author author, string? authorFunction)
        {
            using var DB = new SimpleLibraryContext();
            var AP = DB.AuthorPublications.Where(AP => AP.Publication == publication && AP.Author == author && AP.AuthorFunction == authorFunction).SingleOrDefault() ?? null;
            return AP != null;
        }
        #endregion

        #region CRUD ServiceResult Methods
        /// <summary>
        /// Add a new publication in the database.
        /// </summary>
        /// <param name="publication">The publication to add.</param>
        /// <returns>ServiceResult with data if the operation succeeds, otherwise returns no data.</returns>
        /// <exception cref="ArgumentNullException">If publication is null.</exception>
        public static ServiceResult<Publication> AddNewPublication(Publication publication)
        {
            if (publication == null)
            {
               throw new Common.Exceptions.AppException($"{nameof(publication)} cannot be null!");
            }

            if (PublicationExist(publication) != null)
            {
                return new ServiceResult<Publication>()
                {
                    Status = ServiceResultStatus.KO,
                    ErrorCode = StandardErrorCode.AlreadyExist,
                    Message = "The publication you want to add already exists inside the system and cannot be added.",
                    ImageBox = ImageBox.Warning
                };
            }
            var validation = new DAL.PublicationValidation(publication);
            if (validation.ContainError())
            {
                return new ServiceResult<Publication>
                {
                    Status = ServiceResultStatus.KO,
                    ErrorCode = StandardErrorCode.BadInput,
                    Message = $"Wrong inputs for the publication!\n\n{validation.Errors} ",
                    ImageBox = ImageBox.Warning
                };
            }

            using var DB = new SimpleLibraryContext();
            DB.Publications.Add(publication);
            DB.SaveChanges();

            return new ServiceResult<Publication>()
            {
                Status = ServiceResultStatus.OK,
                Message = "Publication added successfully!",
                ImageBox = ImageBox.Information,
                Value = publication
            };
        }

        /// <summary>
        /// Update a publication from the database.
        /// </summary>
        /// <param name="publication">The publication to edit</param>
        /// <returns>Service result with data if operation success, otherwhile no data with error.</returns>
        /// <exception cref="Common.Exceptions.AppNullArgException"></exception>
        public static ServiceResult<DAL.DB.Publication> UpdatePublication(Publication publication)
        {
            if (publication == null)
            {
                throw new Common.Exceptions.AppNullArgException(nameof(publication) + " cannot be null for editing!");
            }
            using var DB = new SimpleLibraryContext();
            var publicationToEdit = DB.Publications.Find(publication.PublicationId);

            if (publicationToEdit == null)
            {
                throw new Common.Exceptions.AppException(nameof(publication) + " can't found the publication!");
            }

            publicationToEdit.Isbn = publication.Isbn;
            publicationToEdit.Title = publication.Title;
            publicationToEdit.Publisher = publication.Publisher.IsNullOrEmpty() ? DAL.AuthorValidation.DEFAULT_PUBLISHER : publication.Publisher;
            publicationToEdit.PublishedDate = publication.PublishedDate;
            publicationToEdit.Description = publication.Description;
            publicationToEdit.LetterRow = GetLetterRow(publication.Title);
            publicationToEdit.UpdateAt = DateTime.Now;
            publicationToEdit.CoverFilePath = publication.CoverFilePath;

            var validation = new DAL.PublicationValidation(publicationToEdit);
            if (validation.ContainError())
            {
                return new ServiceResult<Publication>
                {
                    Status = ServiceResultStatus.KO,
                    ErrorCode = StandardErrorCode.BadInput,
                    Message = $"Wrong inputs for the publication!\n\n{validation.Errors} ",
                    ImageBox = ImageBox.Warning
                };
            }
            DB.SaveChanges();
            return new ServiceResult<Publication>()
            {
                Status = ServiceResultStatus.OK,
                Message = "Publication updated successfully!",
                ImageBox = ImageBox.Information,
                Value = publicationToEdit
            };
        }

        /// <summary>
        /// Delete a publication from the database. All AuthorPublication will be removed too.
        /// </summary>
        /// <param name="publication">The publication to delete.</param>
        /// <returns>ServiceResult with status OK.</returns>
        /// <exception cref="ArgumentNullException">If publiction is null.</exception>
        public static ServiceResult DeletePublication(Publication publication)
        {
            if (publication == null)
            {
                throw new Common.Exceptions.AppException($"{nameof(publication)} cannot be null!");
            }

            using var DB = new SimpleLibraryContext();
            DB.Publications.Remove(publication);
            DB.SaveChanges();
            return new ServiceResult()
            {
                Status = ServiceResultStatus.OK,
                Message = "Publication deleted successfully!",
                ImageBox = ImageBox.Information
            };
        }

        /// <summary>
        /// Add one or more copies of a publication in the database. The number of copy must be smaller than int.MaxValue .
        /// </summary>
        /// <param name="publication">The publication to copy.</param>
        /// <param name="publicationState">The publication state (lisibility).</param>
        /// <param name="number">The number of copy.</param>
        /// <exception cref="ArgumentNullException">If the publication is null.</exception>
        public static void AddPublicationCopies(Publication publication, Enums.PublicationState publicationState, int number)
        {
            if (publication == null)
            {
                throw new Common.Exceptions.AppNullArgException("Cannot copy null value for a publication!");
            }

            if (number > 0 && number < int.MaxValue)
            {
                using var DB = new SimpleLibraryContext();

                for (int i = 0; i < number; i++)
                {
                    PublicationCopy newCopy = new PublicationCopy()
                    {
                        PublicationId = publication.PublicationId,
                        PublicationState = (int)publicationState
                    };
                    DB.PublicationCopies.Add(newCopy);
                }
                DB.SaveChanges();
            }
        }

        /// <summary>
        /// Add a new author publication in the database if not exists.
        /// </summary>
        /// <param name="publication">The publication to associed</param>
        /// <param name="author">The author of the publication</param>
        /// <param name="authorFunction">The function of the author</param>
        /// <returns>New service validation with status OK.</returns>
        /// <exception cref="Common.Exceptions.AppNullArgException">If author or publication is null.</exception>
        public static ServiceResult<DAL.DB.AuthorPublication> AddNewAuthorPublication(Publication publication, Author author, string? authorFunction)
        {
            if (author == null || publication == null)
            {
                throw new Common.Exceptions.AppNullArgException($"{nameof(author)} or {nameof(publication)} cannot be null!");
            }
            using var DB = new SimpleLibraryContext();
            if (AuthorPublicationExist(publication, author, authorFunction))
            {
                return new ServiceResult<AuthorPublication>()
                {
                    Status = ServiceResultStatus.KO,
                    ErrorCode = StandardErrorCode.AlreadyExist,
                    Message = "Cannot add this author publication, already exist!"
                };
            }
            var newAuthorPublication = new DAL.DB.AuthorPublication()
            {
                AuthorId = author.AuthorId,
                PublicationId = publication.PublicationId,
                AuthorFunction = authorFunction
            };
            DB.AuthorPublications.Add(newAuthorPublication);
            DB.SaveChanges();

            return new ServiceResult<AuthorPublication>()
            {
                Status = ServiceResultStatus.OK,
                Message = "Author Publication added successfully!",
            };
        }

        /// <summary>
        /// Delete All author publication of a publication from the database.
        /// </summary>
        /// <param name="publication">The publication to search.</param>
        /// <returns>Service result with Status OK.</returns>
        /// <exception cref="Common.Exceptions.AppNullArgException">If publication is null.</exception>
        public static ServiceResult<DAL.DB.AuthorPublication> DeleteAuthorPublications(Publication publication)
        {
            if (publication == null)
            {
                throw new Common.Exceptions.AppNullArgException($"{nameof(publication)} cannot be null!");
            }
            using var DB = new SimpleLibraryContext();
            var list = DB.AuthorPublications
                .Where(AP => AP.PublicationId == publication.PublicationId)
                .ToList();

            foreach (var authorPublication in list)
            {
                DB.AuthorPublications.Remove(authorPublication);
            }
            DB.SaveChanges();

            return new ServiceResult<AuthorPublication>()
            {
                Status = ServiceResultStatus.OK,
                Message = "Author publication deleted successfully!"
            };
        }

        /// <summary>
        /// Change copies of a publication. Remove all existing copies and recreate news.
        /// </summary>
        /// <param name="publication">The publication to search</param>
        /// <param name="state">The state of a publication</param>
        /// <param name="numberOfCopy">The number to copy</param>
        /// <exception cref="Common.Exceptions.AppNullArgException">If publication is null.</exception>
        public static void ChangeCopy(Publication publication, PublicationState state, int numberOfCopy)
        {
            if (publication == null)
            {
                throw new Common.Exceptions.AppNullArgException(nameof(publication) + " cannot be null to update copies!");
            }
            using var DB = new SimpleLibraryContext();
            var copies = DB.PublicationCopies
                .Where(PC => PC.PublicationId == publication.PublicationId && PC.PublicationState == (int)state)
                .ToList();

            if (copies.Count != numberOfCopy)
            {
                RemoveAllCopies(publication, state);
                AddPublicationCopies(publication, state, numberOfCopy);
            }
        }

        /// <summary>
        /// Removes all the copies of a publication by his state.
        /// </summary>
        /// <param name="publication">The publication to search</param>
        /// <param name="state">The state of a publication</param>
        /// <exception cref="Common.Exceptions.AppNullArgException">If publication is null.</exception>
        public static void RemoveAllCopies(DAL.DB.Publication publication, PublicationState state)
        {
            if (publication == null)
            {
                throw new Common.Exceptions.AppNullArgException(nameof(publication) + " : cannot delete an null object !");
            }
            using var DB = new SimpleLibraryContext();
            var copies = DB.PublicationCopies
                .Where(PC => PC.PublicationId == publication.PublicationId && PC.PublicationState == (int)state)
                .ToList();
            foreach(var copy in copies)
            {
                DB.PublicationCopies.Remove(copy);
            }
            DB.SaveChanges();
        }

        /// <summary>
        /// Update all copies of a pubication.
        /// </summary>
        /// <param name="publication">The publication to search</param>
        /// <param name="goodCopies">Number of good copy</param>
        /// <param name="badCopies">Number of bad copy</param>
        /// <param name="unknownCopies">Number of unknown copy</param>
        /// <returns>Service result with OK status code.</returns>
        /// <exception cref="Common.Exceptions.AppNullArgException">If publication is null.</exception>
        public static ServiceResult<DAL.DB.PublicationCopy> UpdatePublicationCopies(Publication publication, int goodCopies, int badCopies, int unknownCopies)
        {
            if (publication == null)
            {
                throw new Common.Exceptions.AppNullArgException(nameof(publication) + " cannot be null to update copies!");
            }
            ChangeCopy(publication, PublicationState.Readable, goodCopies);
            ChangeCopy(publication, PublicationState.Unreadable, badCopies);
            ChangeCopy(publication, PublicationState.Unknown, unknownCopies);
            return new ServiceResult<PublicationCopy>()
            {
                Status = ServiceResultStatus.OK,
                Message = "Copies updated!"
            };
        }
        #endregion
    }
}
