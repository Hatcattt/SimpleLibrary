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

        private int goodCopies;
        public int GoodCopies
        {
            get
            {
                return goodCopies;
            }
            set
            {
                if (goodCopies != value)
                {
                    goodCopies = value;
                    NotifyPropertyChanged(nameof(GoodCopies));
                }
            }
        }

        private int badCopies;
        public int BadCopies
        {
            get
            {
                return badCopies;
            }
            set
            {
                if (badCopies != value)
                {
                    badCopies = value;
                    NotifyPropertyChanged(nameof(BadCopies));
                }
            }
        }

        private int unknownCopies;
        public int UnknownCopies
        {
            get
            {
                return unknownCopies;
            }
            set
            {
                if (unknownCopies != value)
                {
                    unknownCopies = value;
                    NotifyPropertyChanged(nameof(UnknownCopies));
                }
            }
        }

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

        private string location = string.Empty;
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

        private string fullTitle = string.Empty;
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

        private ObservableCollection<DAL.DB.AuthorPublication> authorPublications;
        public ObservableCollection<DAL.DB.AuthorPublication> AuthorPublications
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
            authorPublications = new ObservableCollection<DAL.DB.AuthorPublication>();
            publicationCopies = new ObservableCollection<DAL.DB.PublicationCopy>();
            coverImagePath = BU.Entities.CoverConstants.DEFAUT_IMAGE_PATH;
            goodCopies = 0; badCopies = 0;  unknownCopies = 0;
        }

        #region Methods


        #endregion
    }
}
