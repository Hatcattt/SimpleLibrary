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

        private string fullLocation;
        public string FullLocation
        {
            get { return fullLocation; }
            set
            {
                if (fullLocation != value)
                {
                    fullLocation = value;
                    NotifyPropertyChanged(nameof(FullLocation));
                }
            }
        }

        private string fullTitleName;
        public string FullTitleName
        {
            get { return fullTitleName; }
            set
            {
                if (fullTitleName != value)
                {
                    fullTitleName = value;
                    NotifyPropertyChanged(nameof(FullTitleName));
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
            publications = new ObservableCollection<DAL.DB.Publication>(BU.Services.PublicationService.GetPublications());
            authorPublications = new ObservableCollection<DAL.DB.AuthorPublication>();
            PublicationCopies = new ObservableCollection<DAL.DB.PublicationCopy>();
        }

        #region Methods


        #endregion
    }
}
