using BU.Entities;
using DAL.DB;
using DAL.Entities;
using DAL.Services;
using Microsoft.IdentityModel.Tokens;
using Microsoft.Win32;
using System;
using System.Collections;
using System.IO;
using System.Security.Policy;
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
            CoverImageView.Source = new BitmapImage(new Uri(CoverImage.DEFAUT_IMAGE_PATH, UriKind.Relative));
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
                DatePickerPublisher.SelectedDate = gBook.PublishedDate;
                DescriptionInput.Text = gBook.Description;
                LanguageInput.Text = gBook.Language;
                CoverImageView.Source = new BitmapImage(new Uri(gBook.CoverFilePath ?? CoverImage.DEFAUT_IMAGE_PATH, UriKind.RelativeOrAbsolute));
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
                var image = new CoverImage(CoverImageView.Source.ToString(), ISBNinputText.Text);

                var newPublication = new DAL.DB.Publication()
                {
                    Isbn = ISBNinputText.Text,
                    Title = TitleInput.Text,
                    SubTitle = gBook?.SubTitle ?? string.Empty,
                    Publisher = PublisherInput.Text,
                    PublishedDate = DatePickerPublisher.SelectedDate,
                    Description = DescriptionInput.Text,
                    Location = BU.Services.ShelfService.GetLocationOf(shelf, theme),
                    Language = LanguageInput.Text,
                    LetterRow = TitleInput.Text[..1],
                    CoverFilePath = CoverImage.IsFromAPI(image.ImagePath) ? image.ImagePath : image.ImageName,
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
                MessageBox.Show("Your input that you whote seems to have bad value(s).\n", "Bad input", MessageBoxButton.OK, MessageBoxImage.Information);
            }
        }

        private void DatePickerDateToNow(object sender, RoutedEventArgs e)
        {
            DatePickerPublisher.SelectedDate = DateTime.Now;
        }

        /// <summary>
        /// Copy an user source to the main source folder, with a filename base on the ISBN of a Book and return the new path.
        /// </summary>
        /// <param name="basePath">the path of the source</param>
        /// <param name="isbn">The code for the filename</param>
        /// <returns>the new path of the copied source</returns>
        private bool CopyAnImage(string basePath, string isbn)
        {
            if (basePath.IsNullOrEmpty() || isbn.IsNullOrEmpty())
            {
                return false;
            }
            string path = Path.Combine(Environment.CurrentDirectory, "Covers", isbn + ".jpg");
            try
            {
                File.Copy(basePath, path);
                return true;
            } catch (Exception ex)
            {

            }
            return false;
        }

        private void UploadUserImage(object sender, RoutedEventArgs e)
        {
            if (ISBNinputText.Text.IsNullOrEmpty())
            {
                MessageBox.Show("Please, write at least the ISBN of the book.", "Isbn not found", MessageBoxButton.OK, MessageBoxImage.Information);
                return;
            }

            OpenFileDialog fileDialog = new()
            {
                Title = "Select a source",
                Filter = "JPEG (*.jpg;*.jpeg)|*.jpg;*.jpeg;",
            };

            if (fileDialog.ShowDialog() == true)
            {
                try
                {
                    BitmapImage image = new BitmapImage();

                    image.BeginInit();
                    image.UriSource = new Uri(fileDialog.FileName, UriKind.Relative);
                    image.EndInit();

                    if (image.PixelHeight <= 500 && image.PixelWidth <= 400)
                    {
                        CoverImageView.Source = image;
                    }
                    else
                    {
                        MessageBox.Show("Please, choose an smaller source (MAX : 256px / 200px)");
                        return;
                    }
                }
                catch (Exception ex)
                {
                    // LOOG
                    MessageBox.Show(ex.Message);
                }
            }
        }
    }
}
