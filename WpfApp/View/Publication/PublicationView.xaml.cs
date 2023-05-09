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
            DataContext = publicationVM;
            publicationVM.Publications = new ObservableCollection<DAL.DB.Publication>(BU.Services.PublicationService.GetPublications());
            comboboxShelf.ItemsSource = BU.Services.ShelfService.GetShelves();
            comboboxShelf.Visibility = Visibility.Collapsed;
            labelSearch.Content = "Search By";
        }

        private void ListView_SelectionChanged(object sender, SelectionChangedEventArgs e)
        {
            if (publicationVM.PublicationSelected != null)
            {
                publicationVM.Location = BU.Services.LocationService.GetLocation(publicationVM.PublicationSelected);
                publicationVM.FullTitle = BU.Services.PublicationService.GetFullTitle(publicationVM.PublicationSelected);
                publicationVM.CoverImageURL = publicationVM.PublicationSelected.CoverFilePath ?? @"/image/Covers/DEFAULT.jpg";
                publicationVM.AuthorPublications = new ObservableCollection<DAL.DB.Author>(BU.Services.AuthorPublicationService.GetAuthors(publicationVM.PublicationSelected));
            }
            else
            {
                publicationVM.FullTitle = "";
                publicationVM.Location = "";
                publicationVM.CoverImageURL = @"/image/Covers/DEFAULT.jpg";
            }
        }

        private void TextBox_TextChanged(object sender, TextChangedEventArgs e)
        {
            if (InputSearch.Text.IsNullOrEmpty())
            {
                publicationVM.Publications = new ObservableCollection<DAL.DB.Publication>(BU.Services.PublicationService.GetPublications());
            }
            switch (cbBox.SelectedItem)
            {
                case "Isbn":
                    publicationVM.Publications = new ObservableCollection<DAL.DB.Publication>(BU.Services.PublicationSearchingService.GetPublicationsStartWithISBN(InputSearch.Text));
                    break;

                case "Title":
                    publicationVM.Publications = new ObservableCollection<DAL.DB.Publication>(BU.Services.PublicationSearchingService.GetPublicationsStartWithTitle(InputSearch.Text));
                    break;

                case "Shelf":
                    publicationVM.Publications = new ObservableCollection<DAL.DB.Publication>(BU.Services.PublicationSearchingService.GetPublicationsOf((DAL.DB.Shelf)comboboxShelf.SelectedValue));
                    break;
            }
        }

        private void ResetSearchInputButton_Click(object sender, RoutedEventArgs e)
        {
            InputSearch.Text = string.Empty;
        }

        private void AddNewPublicationButton_Click(object sender, RoutedEventArgs e)
        {
            _ = new CreatePublicationView();
        }

        private void DeletePublication(object sender, RoutedEventArgs e)
        {
            try
            {
                var tempPublis = publicationVM.Publications;

                using var DB = new SimpleLibraryContext();
                DB.Publications.Remove(publicationVM.PublicationSelected);
                DB.SaveChanges();
                publicationVM.Publications = new ObservableCollection<DAL.DB.Publication>(BU.Services.PublicationService.GetPublications());
                ResetSearchInputButton_Click(sender, e);

                MessageBox.Show("Publication successfully deleted!", "Operation OK", MessageBoxButton.OK, MessageBoxImage.Information);

            }
            catch (Exception ex)
            {
                MessageBox.Show($"{ex.Message}\n{ex.InnerException.Message}", "ERROR", MessageBoxButton.OK, MessageBoxImage.Error);
            }
        }

        private void cbBox_SelectionChanged(object sender, SelectionChangedEventArgs e)
        {
            if (cbBox.SelectedItem.ToString() == "Shelf")
            {
                comboboxShelf.Visibility = Visibility.Visible;
                InputSearch.IsEnabled = false;
                labelSearch.Content = "Filter By";
            } else
            {
                publicationVM.Publications = new ObservableCollection<DAL.DB.Publication>(BU.Services.PublicationService.GetPublications());
                comboboxShelf.Visibility = Visibility.Collapsed;
                InputSearch.IsEnabled = true;
                labelSearch.Content = "Search By";
            }
        }

        private void comboboxShelf_SelectionChanged(object sender, SelectionChangedEventArgs e)
        {
            publicationVM.Publications = new ObservableCollection<DAL.DB.Publication>(BU.Services.PublicationSearchingService.GetPublicationsOf((DAL.DB.Shelf)comboboxShelf.SelectedValue));
        }
    }
}
