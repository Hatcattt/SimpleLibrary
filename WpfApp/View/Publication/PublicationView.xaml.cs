using DAL.DB;
using Microsoft.IdentityModel.Tokens;
using System;
using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.IO;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Text;
using System.Threading.Tasks;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Controls.Primitives;
using System.Windows.Data;
using System.Windows.Documents;
using System.Windows.Input;
using System.Windows.Media;
using System.Windows.Media.Imaging;
using System.Windows.Navigation;
using System.Windows.Shapes;
using static System.Net.Mime.MediaTypeNames;

namespace WpfApp.View.Publication
{
    /// <summary>
    /// Interaction logic for PublicationView.xaml
    /// </summary>
    public partial class PublicationView : UserControl
    {
        ViewModel.PublicationViewModel publicationVM = new ViewModel.PublicationViewModel();

        public PublicationView()
        {
            InitializeComponent();
            PopulateAndBind();
        }

        private void PopulateAndBind()
        {
            this.DataContext = publicationVM;
            foreach (var publi in publicationVM.Publications)
            {
                publi.CoverFilePath = "/image/Covers/content.jpg";
            }
        }

        private void ListView_SelectionChanged(object sender, SelectionChangedEventArgs e)
        {
            if (publicationVM.PublicationSelected != null)
            {
                publicationVM.FullTitleName = publicationVM.PublicationSelected.Title + " " + publicationVM.PublicationSelected.SubTitle;
                publicationVM.FullLocation = publicationVM.PublicationSelected.LocationNavigation.Shelf.ShelfName + " - " + publicationVM.PublicationSelected.LocationNavigation.Theme.ThemeName + " - " + publicationVM.PublicationSelected.LetterRow;
            } else
            {
                publicationVM.FullTitleName = string.Empty;
                publicationVM.FullLocation = string.Empty;
            }
            //publicationVM.PublicationCopies = new ObservableCollection<DAL.DB.PublicationCopy>(BU.Services.PublicationService.GetPublicationCopies(publicationVM.PublicationSelected));
        }

        private void TextBox_TextChanged(object sender, TextChangedEventArgs e)
        {
            if (InputSearch.Text.IsNullOrEmpty())
            {
                publicationVM.Publications = new ObservableCollection<DAL.DB.Publication>(BU.Services.PublicationService.GetPublications());
                return;
            }
            switch (cbBox.SelectedItem)
            {
                case "Isbn":
                    publicationVM.Publications = new ObservableCollection<DAL.DB.Publication>(BU.Services.PublicationSearchingService.GetPublicationsStartWithISBN(InputSearch.Text));
                    break;

                case "Title":
                    publicationVM.Publications = new ObservableCollection<DAL.DB.Publication>(BU.Services.PublicationSearchingService.GetPublicationsStartWithTitle(InputSearch.Text));
                    break;
            }
        }

        private void ResetSearchInputButton_Click(object sender, RoutedEventArgs e)
        {
            InputSearch.Text = string.Empty;
        }
    }
}
