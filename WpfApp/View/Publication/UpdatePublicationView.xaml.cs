using Microsoft.IdentityModel.Tokens;
using System;
using System.Windows;
using System.Windows.Controls;

namespace WpfApp.View.Publication
{
    /// <summary>
    /// Interaction logic for UpdatePublicationView.xaml
    /// </summary>
    public partial class UpdatePublicationView : Window
    {
        /// <summary>
        /// Indicate if this view has saved the datacontext successfully.
        /// </summary>
        public bool HaveSaved { get; set; }
        private ViewModel.PublicationViewModel publicationVM;

        public UpdatePublicationView(ViewModel.PublicationViewModel publicationVM)
        {
            InitializeComponent();
            if (publicationVM == null || publicationVM.PublicationSelected == null)
            {
                throw new Common.Exceptions.AppException($"{nameof(publicationVM)} or {nameof(publicationVM.PublicationSelected)} cannot be null!");
            }
            this.publicationVM = new ViewModel.PublicationViewModel();
            this.DataContext = publicationVM;
            this.comboboxShelf.ItemsSource = BU.Services.ShelfService.GetShelves();
            this.comboboxTheme.ItemsSource = BU.Services.ShelfCompositionService.GetThemesOf(publicationVM.PublicationSelected.LocationNavigation.Shelf);
            this.ShowDialog();
        }

        private void LoadThemeOfShelfSelected(object sender, SelectionChangedEventArgs e)
        {
            this.comboboxTheme.ItemsSource = BU.Services.ShelfCompositionService.GetThemesOf((DAL.DB.Shelf)comboboxShelf.SelectedItem);
        }

        private void DatePickerDateToNow(object sender, RoutedEventArgs e)
        {
            DatePickerPublisher.SelectedDate = DateTime.Now;
        }

        private void ChangeCoverImageButton_Click(object sender, RoutedEventArgs e)
        {
            if (ISBNinputText.Text.IsNullOrEmpty())
            {
                MessageBox.Show("Please wrote at least the ISBN of the book as it's used to generate imagename.", "Wrong isbn", MessageBoxButton.OK, MessageBoxImage.Information);
                return;
            }

            var imageUploaded = Interfaces.ICoverManagerUpload.UploadImageFromDisk();
            if (imageUploaded != null)
            {
                CoverImageView.Source = imageUploaded;
            }
        }

        private void CancelPublicationEditionButton_Click(object sender, RoutedEventArgs e)
        {
            this.Close();
            HaveSaved = false;
        }

        private void UpdatePublicationButton_Click(object sender, RoutedEventArgs e)
        {
            HaveSaved = true;
        }
    }
}
