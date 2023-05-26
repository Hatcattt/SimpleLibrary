using BU.Entities;
using DAL.Services;
using Microsoft.Extensions.Configuration;
using Microsoft.IdentityModel.Tokens;
using Microsoft.Win32;
using System;
using System.IO;
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

        private BU.Entities.GoogleBookPublication? gBook;

        public CreatePublicationView()
        {
            InitializeComponent();
            this.comboboxShelf.ItemsSource = BU.Services.ShelfService.GetShelves();
            CoverImageView.Source = new BitmapImage(new Uri(CoverConstants.DEFAUT_IMAGE_PATH, UriKind.Relative));
            this.ShowDialog();
        }

        private void CancelPublicationCreationButton_Click(object sender, RoutedEventArgs e)
        {
            this.Close();
        }

        private async void SearchPublicationWithAPIButton_Click(object sender, RoutedEventArgs e)
        {
            string isbn = ISBNinputText.Text;

            var json = await DAL.Services.LibraryGoogleAgentService.GetJsonAsyncBy(isbn);
            gBook = new BU.Entities.GoogleBookPublication(json);

            if (gBook.JsonAsContent())
            {
                ISBNinputText.Text = gBook.Isbn;
                TitleInput.Text = (gBook.Title + " " + gBook.SubTitle).Trim();
                PublisherInput.Text = gBook.Publisher;
                DatePickerPublisher.SelectedDate = gBook.PublishedDate;
                DescriptionInput.Text = gBook.Description;
                LanguageInput.Text = gBook.Language;
                CoverImageView.Source = new BitmapImage(new Uri(gBook.CoverFilePath ?? CoverConstants.DEFAUT_IMAGE_PATH, UriKind.RelativeOrAbsolute));
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
                    CoverFilePath = image.ImagePath,
                    CreateAt = DateTime.Now,
                };

                var result = BU.Services.PublicationService.AddNewPublication(newPublication);
                if (result.Status == BU.Entities.ServiceResultStatus.OK)
                {
                    //BU.Services.PublicationService.AddPublicationCopies(newPublication, BU.Enums.PublicationState.Readable, (int)goodCopy.Value);
                    //BU.Services.PublicationService.AddPublicationCopies(newPublication, BU.Enums.PublicationState.Unreadable, (int)badCopy.Value);
                    //BU.Services.PublicationService.AddPublicationCopies(newPublication, BU.Enums.PublicationState.Unknown, (int)unknownCopy.Value);
                }
                //if (! image.IsFromAPI())
                //{
                //    var destination = new ConfigurationBuilder()
                //    .AddJsonFile("appsettings.json")
                //    .Build()
                //    .GetSection("AppSettings")["CoverFolderPath"] + image.ImageName;

                //    Common.FileProcess.CopyImageToDisk(image.ImagePath, destination);
                //    BU.Services.PublicationService.ChangeCoverFilePath(newPublication, destination);
                //}
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

        private void UploadUserImageButton_Click(object sender, RoutedEventArgs e)
        {
            if (ISBNinputText.Text.IsNullOrEmpty())
            {
                MessageBox.Show("Please wrote at least the ISBN of the book as it's used to generate image name.", "Wrong isbn", MessageBoxButton.OK, MessageBoxImage.Information);
                return;
            }

            var imageUploaded = Interfaces.ICoverManager.UploadImageFromDisk();
            if (imageUploaded != null)
            {
                CoverImageView.Source = imageUploaded;
            }
        }

        private void CheckBoxHelp_Click(object sender, RoutedEventArgs e)
        {
            MessageBox.Show("Si vous selectionner cette option, vous serez rediriger vers le menu de Copy management après l'ajout de la publication.", "Manage publication copy after?", MessageBoxButton.OK, MessageBoxImage.Information);

        }
    }
}
