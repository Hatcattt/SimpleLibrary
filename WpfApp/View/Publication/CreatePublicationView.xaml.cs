using DAL.DB;
using DAL.Entities;
using DAL.Services;
using System;
using System.Collections;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Media.Imaging;

namespace WpfApp.View.Publication
{
    /// <summary>
    /// Interaction logic for CreatePublicationView.xaml
    /// </summary>
    public partial class CreatePublicationView : Window
    {

        private GoogleBookPublication? gBook;

        public CreatePublicationView()
        {
            InitializeComponent();
            this.comboboxShelf.ItemsSource = BU.Services.ShelfService.GetShelves();
            CoverImage.Source = new BitmapImage(new Uri(GoogleBookPublication.DEFAULT_COVER_PATH, UriKind.Absolute));
            this.ShowDialog();
        }

        private void CancelPublicationCreationButton_Click(object sender, RoutedEventArgs e)
        {
            this.Close();
        }

        private async void SearchPublicationWithAPIButton_Click(object sender, RoutedEventArgs e)
        {
            string isbn = ISBNinputText.Text;

            var json = await GoogleBookApiToJson.GetJsonAsyncBy(isbn);
            gBook = new GoogleBookPublication(json);

            if (gBook.JsonAsContent())
            {
                ISBNinputText.Text = gBook.Isbn;
                TitleInput.Text = (gBook.Title + " " + gBook.SubTitle).Trim();
                PublisherInput.Text = gBook.Publisher;
                PublishedDatePicker.SelectedDate = gBook.PublishedDate;
                DescriptionInput.Text = gBook.Description;
                LanguageInput.Text = gBook.Language;
                CoverImage.Source = new BitmapImage(new Uri(gBook.CoverFilePath, UriKind.RelativeOrAbsolute));
                AuthorsLV.ItemsSource = gBook.Authors;
            } else
            {
                MessageBox.Show("Publication not found.\nMake sure your isbn is valid.", "Publication not found", MessageBoxButton.OK, MessageBoxImage.Exclamation);
            }
        }

        private void LoadThemeOfShelfSelected(object sender, SelectionChangedEventArgs e)
        {
            this.comboboxTheme.ItemsSource = BU.Services.ShelfCompositionService.GetThemesOf((DAL.DB.Shelf)comboboxShelf.SelectedItem);
        }

        private void CreateNewPublicationButton_Click(object sender, RoutedEventArgs e)
        {
            var shelf = (DAL.DB.Shelf)comboboxShelf.SelectedValue;
            var theme = (DAL.DB.Theme)comboboxTheme.SelectedValue;

            if (shelf != null && theme != null && TitleInput.Text.Length >= 1)
            {
                var newPublication = new DAL.DB.Publication()
                {
                    Isbn = ISBNinputText.Text,
                    Title = TitleInput.Text,
                    SubTitle = gBook?.SubTitle ?? string.Empty,
                    Publisher = PublisherInput.Text,
                    PublishedDate = PublishedDatePicker.SelectedDate,
                    Description = DescriptionInput.Text,
                    Location = BU.Services.ShelfService.GetLocationOf(shelf, theme),
                    Language = LanguageInput.Text,
                    LetterRow = TitleInput.Text[..1],
                    CoverFilePath = gBook?.CoverFilePath ?? GoogleBookPublication.DEFAULT_COVER_PATH,
                    CreateAt = DateTime.Now,
                };

                var result = BU.Services.PublicationService.AddNewPublication(newPublication);
                if (result.Status == BU.Entities.ServiceResultStatus.OK)
                {
                    BU.Services.PublicationService.AddPublicationCopies(newPublication, BU.Entities.PublicationState.Readable, (int)goodCopy.Value);
                    BU.Services.PublicationService.AddPublicationCopies(newPublication, BU.Entities.PublicationState.Unreadable, (int)badCopy.Value);
                    BU.Services.PublicationService.AddPublicationCopies(newPublication, BU.Entities.PublicationState.Unknown, (int)unknownCopy.Value);
                }
                MessageBox.Show(result.Message, "A message from the system", MessageBoxButton.OK, (MessageBoxImage)result.ImageBox);
            } else
            {
                MessageBox.Show("Not enought input. Please insert more informations about the publication.\n", "Not enought input", MessageBoxButton.OK, MessageBoxImage.Information);
            }
        }
    }
}
