using Microsoft.IdentityModel.Tokens;
using System.Collections.Generic;
using System.Collections.ObjectModel;

namespace WpfApp.ViewModel
{
    public class PublicationViewModel : BaseViewModel
    {
        #region Propreties
        
        public List<string> PropertiesSearch { get; } = new List<string>() { "Isbn", "Title", "Publisher", "Language", "Shelf", "Theme" };
        public List<string> Languages { get; } = new List<string>() { "EN", "FR", "ES", "DE", "IT", "PT", "RU", "ZH", "JA", "KO" };

        private string coverImagePath;
        public string CoverImagePath
        {
            get
            {
                return coverImagePath.IsNullOrEmpty() ? BU.Entities.CoverConstants.DEFAUT_IMAGE_PATH : coverImagePath;
            }
            set
            {
                if (coverImagePath != value)
                {
                    coverImagePath = value;
                    NotifyPropertyChanged(nameof(CoverImagePath));
                }
            }
        }

        private string location = "";
        public string Location
        {
            get { return location; }
            set
            {
                if (location != value)
                {
                    location = value;
                    NotifyPropertyChanged(nameof(Location));
                }
            }
        }

        private string fullTitle = "";
        public string FullTitle
        {
            get { return fullTitle; }
            set
            {
                if (fullTitle != value)
                {
                    fullTitle = value;
                    NotifyPropertyChanged(nameof(FullTitle));
                }
            }
        }

        private DAL.DB.Publication? publicationSelected;
        public DAL.DB.Publication? PublicationSelected
        {
            get { return publicationSelected; }
            set
            {
                if (publicationSelected != value)
                {
                    publicationSelected = value;
                    NotifyPropertyChanged(nameof(PublicationSelected));
                }
            }
        }

        private ObservableCollection<DAL.DB.Publication> publications;
        public ObservableCollection<DAL.DB.Publication> Publications
        {
            get { return publications; }
            set
            {
                if (publications != value)
                {
                    publications = value;
                    NotifyPropertyChanged(nameof(Publications));
                }
            }
        }

        private ObservableCollection<DAL.DB.Author> authorPublications;
        public ObservableCollection<DAL.DB.Author> AuthorPublications
        {
            get { return authorPublications; }
            set
            {
                if (authorPublications != value)
                {
                    authorPublications = value;
                    NotifyPropertyChanged(nameof(AuthorPublications));
                }
            }
        }

        private ObservableCollection<DAL.DB.PublicationCopy> publicationCopies;
        public ObservableCollection<DAL.DB.PublicationCopy> PublicationCopies
        {
            get { return publicationCopies; }
            set
            {
                if (publicationCopies != value)
                {
                    publicationCopies = value;
                    NotifyPropertyChanged(nameof(PublicationCopies));
                }
            }
        }

        #endregion

        public PublicationViewModel()
        {
            publications = new ObservableCollection<DAL.DB.Publication>();
            authorPublications = new ObservableCollection<DAL.DB.Author>();
            publicationCopies = new ObservableCollection<DAL.DB.PublicationCopy>();
            coverImagePath = BU.Entities.CoverConstants.DEFAUT_IMAGE_PATH;
        }

        #region Methods


        #endregion
    }
}
