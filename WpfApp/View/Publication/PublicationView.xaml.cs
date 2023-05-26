using Microsoft.IdentityModel.Tokens;
using System.Collections.ObjectModel;
using System.Windows;
using System.Windows.Controls;

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
                publicationVM.CoverImagePath = publicationVM.PublicationSelected.CoverFilePath;
                publicationVM.AuthorPublications = new ObservableCollection<DAL.DB.Author>(BU.Services.AuthorPublicationService.GetAuthors(publicationVM.PublicationSelected));
            }
            else
            {
                publicationVM.FullTitle = "";
                publicationVM.Location = "";
                publicationVM.CoverImagePath = "";
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
            _ = new View.Publication.CreatePublicationView();
            publicationVM.Publications = new ObservableCollection<DAL.DB.Publication>(BU.Services.PublicationService.GetPublications());
        }

        private void DeletePublicationButton_Click(object sender, RoutedEventArgs e)
        {
            if (publicationVM.PublicationSelected == null)
            {
                return;
            }

            var messageBoxChoice = MessageBox.Show("Are you sure you want to delete this publication? L'auteur ne sera plus référencé.", "Are you sure?", MessageBoxButton.YesNo, MessageBoxImage.Question);
            if (messageBoxChoice == MessageBoxResult.Yes)
            {
                var result = BU.Services.PublicationService.DeletePublication(publicationVM.PublicationSelected);
                MessageBox.Show(result.Message, "Information from the system.", MessageBoxButton.OK, (MessageBoxImage)result.ImageBox);
                if (result.Status == BU.Entities.ServiceResultStatus.OK)
                {
                    publicationVM.Publications = new ObservableCollection<DAL.DB.Publication>(BU.Services.PublicationService.GetPublications());
                    InputSearch.Text = string.Empty;
                    return;
                }
            }
        }

        private void Combobox_SelectionChanged(object sender, SelectionChangedEventArgs e)
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

        private void ComboboxShelf_SelectionChanged(object sender, SelectionChangedEventArgs e)
        {
            var shelfSelected = (DAL.DB.Shelf)comboboxShelf.SelectedValue;
            publicationVM.Publications = new ObservableCollection<DAL.DB.Publication>(BU.Services.PublicationSearchingService.GetPublicationsOf(shelfSelected));
        }

        private void EditPublicationButton_Click(object sender, RoutedEventArgs e)
        {
            if (publicationVM.PublicationSelected == null)
            {
                return;
            }
            _ = new View.Publication.UpdatePublicationView(publicationVM);
            publicationVM.Publications = new ObservableCollection<DAL.DB.Publication>(BU.Services.PublicationService.GetPublications());
        }
    }
}
