using BU.Entities;
using DAL;
using DAL.DB;
using Microsoft.IdentityModel.Tokens;
using System;
using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows;
using System.Windows.Controls;

namespace WpfApp.ViewModel
{
    public class PublicationViewModel : BaseViewModel
    {
        #region Propreties
        
        public List<string> PropertiesSearch { get; } = new List<string>() { "Isbn", "Title", "Publisher", "Language", "Shelf", "Theme" };
        public List<string> Languages { get; } = new List<string>() { "EN", "FR", "ES", "DE", "IT", "PT", "RU", "ZH", "JA", "KO" };

        private string coverImageURL;
        public string CoverImageURL
        {
            get { return coverImageURL.IsNullOrEmpty() ? @"\image\Covers\DEFAULT.jpg" : coverImageURL; }
            set
            {
                if (coverImageURL != value)
                {
                    coverImageURL = value;
                    NotifyPropertyChanged(nameof(CoverImageURL));
                }
            }
        }

        private string location = "";
        public string Location
        {
            get { return location; }
            set
            {
                if (location != value && value != null)
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
            coverImageURL = @"/image/Covers/DEFAULT.jpg";
        }

        #region Methods


        #endregion
    }
}
