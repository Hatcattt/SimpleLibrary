using BU.Entities;
using DAL.DB;
using Microsoft.IdentityModel.Tokens;
using System;
using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.Linq;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Media.Imaging;
using WpfApp.ViewModel;

namespace WpfApp.View.Publication
{
    /// <summary>
    /// Interaction logic for CreatePublicationView.xaml
    /// </summary>
    public partial class CreatePublicationView : Window
    {
        public bool HaveSaved { get; set; }
        private BU.Entities.GoogleBookPublication? gBook;
        public static readonly List<string> Functions = new() { "Creator", "Writer", "Drawer", "Cover", "Preface", "Unknown" };

        public CreatePublicationView()
        {
            InitializeComponent();
            this.comboboxShelf.ItemsSource = BU.Services.ShelfService.GetShelves();
            this.cbBoxAuthor.ItemsSource = BU.Services.AuthorService.GetAuthors();
            FunctionCombobox.ItemsSource = Functions;
            CoverImageView.Source = new BitmapImage(new Uri(CoverConstants.DEFAUT_IMAGE_PATH, UriKind.Relative));
            this.ShowDialog();
        }

        private void CancelPublicationCreationButton_Click(object sender, RoutedEventArgs e)
        {
            this.Close();
        }

        private async void SearchPublicationWithAPIButton_Click(object sender, RoutedEventArgs e)
        {
            AuthorsLV.Items.Clear();
            string isbn = ISBNinputText.Text;

            var json = await DAL.Services.LibraryGoogleAgentService.GetJsonAsyncBy(isbn);
            gBook = new BU.Entities.GoogleBookPublication(json);

            if (gBook.JsonHaveContent())
            {
                ISBNinputText.Text = gBook.Isbn;
                TitleInput.Text = (gBook.Title + " " + gBook.SubTitle).Trim();
                PublisherInput.Text = gBook.Publisher;
                DatePickerPublisher.SelectedDate = gBook.PublishedDate;
                DescriptionInput.Text = gBook.Description;
                LanguageInput.Text = gBook.Language;
                CoverImageView.Source = new BitmapImage(new Uri(gBook.CoverFilePath ?? CoverConstants.DEFAUT_IMAGE_PATH, UriKind.RelativeOrAbsolute));

                foreach(var authorName in gBook.Authors)
                {
                    AuthorsLV.Items.Add(new AuthorPublication() { Author = new DAL.DB.Author() { AuthorName = authorName }, AuthorFunction = Functions.Last() });
                }
            } else
            {
                MessageBox.Show("Publication not found!\nMake sure your isbn is valid.", "Publication not found", MessageBoxButton.OK, MessageBoxImage.Exclamation);
            }
        }

        private void LoadThemeOfShelfSelected(object sender, SelectionChangedEventArgs e)
        {
            this.comboboxTheme.ItemsSource = BU.Services.ShelfService.GetThemesOf((DAL.DB.Shelf)comboboxShelf.SelectedItem);
        }

        private void CreateNewPublicationButton_Click(object sender, RoutedEventArgs e)
        {
            var shelf = (DAL.DB.Shelf)comboboxShelf.SelectedValue;
            var theme = (DAL.DB.Theme)comboboxTheme.SelectedValue;

            var image = new CoverImage(CoverImageView.Source.ToString());

            var newPublication = new DAL.DB.Publication()
            {
                Isbn = ISBNinputText.Text.Trim(),
                Title = TitleInput.Text.Trim(),
                Publisher = PublisherInput.Text.Trim().IsNullOrEmpty() ? DAL.AuthorValidation.DEFAULT_PUBLISHER : PublisherInput.Text.Trim(),
                PublishedDate = DatePickerPublisher.SelectedDate,
                Description = DescriptionInput.Text.Trim(),
                Location = BU.Services.ShelfService.GetLocationOf(shelf, theme),
                Language = LanguageInput.Text.Trim(),
                LetterRow = BU.Services.PublicationService.GetLetterRow(TitleInput.Text.Trim()),
                CoverFilePath = image.ImagePath.Trim(),
                CreateAt = DateTime.Now,
            };

            var result = BU.Services.PublicationService.AddNewPublication(newPublication);
            if (result.Status == BU.Entities.ServiceResultStatus.OK)
            {
                BU.Services.PublicationService.AddPublicationCopies(newPublication, BU.Enums.PublicationState.Readable, (int)goodCopy.Value);
                BU.Services.PublicationService.AddPublicationCopies(newPublication, BU.Enums.PublicationState.Unreadable, (int)badCopy.Value);
                BU.Services.PublicationService.AddPublicationCopies(newPublication, BU.Enums.PublicationState.Unknown, (int)unknownCopy.Value);
                HaveSaved = true;

                int authorCreated = 0;
                foreach (DAL.DB.AuthorPublication authorP in AuthorsLV.Items)
                {
                    var authorToCreate = BU.Services.AuthorService.AuthorExist(authorP.Author);
                    if (authorToCreate == null)
                    {
                        authorToCreate = BU.Services.AuthorService.CreateAuthor(authorP.Author).Value;
                        authorCreated++;
                    }
                    BU.Services.PublicationService.AddNewAuthorPublication(newPublication, authorToCreate, authorP.AuthorFunction);
                }
                if (authorCreated > 0)
                {
                    MessageBox.Show($"{authorCreated} author(s) have been added automatically.", "Author added automatically", MessageBoxButton.OK, MessageBoxImage.Information);
                }
            }
            MessageBox.Show(result.Message, "A message from the system", MessageBoxButton.OK, (MessageBoxImage)result.ImageBox);
        }

        private void UploadUserImageButton_Click(object sender, RoutedEventArgs e)
        {
            MessageBox.Show("This feature has not yet been implemented! Please wait for an update...", "Not implemented", MessageBoxButton.OK, MessageBoxImage.Stop);
            //var imageUploaded = Interfaces.ICoverManagerUpload.UploadImageFromDisk();
            //if (imageUploaded != null)
            //{
            //    CoverImageView.Source = imageUploaded;
            //}
        }

        private void AddAuthorPublicationInListButton_Click(object sender, RoutedEventArgs e)
        {
            var author = (DAL.DB.Author)cbBoxAuthor.SelectedItem;
            string? authorFunction = FunctionCombobox.SelectedItem?.ToString();

            if (author != null)
            {
                var newAuthorPublication = new DAL.DB.AuthorPublication() { Author = author, AuthorFunction = authorFunction };

                if (!AuthorExistsInAuthorListView(newAuthorPublication.Author, newAuthorPublication.AuthorFunction))
                {
                    AuthorsLV.Items.Add(newAuthorPublication);
                    return;
                }
                MessageBox.Show("An author with the same function already exists for this publication.", "Cannot add this author", MessageBoxButton.OK, MessageBoxImage.Information);
            }
        }

        private void RemoveAuthorPublicationFromListButton_Click(object sender, RoutedEventArgs e)
        {
            if (AuthorsLV.SelectedItem == null)
            {
                MessageBox.Show("Selecte on the grid, then delete it.", "Select authorName", MessageBoxButton.OK, MessageBoxImage.Warning);
                return;
            }
            AuthorsLV.Items.Remove(AuthorsLV.SelectedItem);
        }

        private void ChangeAuthorFunctionInListButton_Click(object sender, RoutedEventArgs e)
        {
            DAL.DB.AuthorPublication selectedAuthorPublication = (DAL.DB.AuthorPublication)AuthorsLV.SelectedItem;
            if (selectedAuthorPublication != null)
            {
                string? authorFunction = FunctionCombobox.SelectedItem == null ? null : FunctionCombobox.SelectedItem.ToString();
                if (AuthorExistsInAuthorListView(selectedAuthorPublication.Author, authorFunction))
                {
                    MessageBox.Show("An author with the same function already exists for this publication.", "Cannot edit this author publication", MessageBoxButton.OK, MessageBoxImage.Information);
                    return;
                }
                selectedAuthorPublication.AuthorFunction = authorFunction;
                AuthorsLV.Items.Refresh();
                return;

            }
            MessageBox.Show("Select an author to edit his function.", "Select an author", MessageBoxButton.OK, MessageBoxImage.Information);
        }

        private bool AuthorExistsInAuthorListView(DAL.DB.Author author, string? authorFunction)
        {
            foreach (var item in AuthorsLV.Items)
            {
                var authorInListView = (DAL.DB.AuthorPublication)item;
                if (authorInListView.Author.AuthorName == author.AuthorName && authorInListView.AuthorFunction == authorFunction)
                {
                    return true;
                }
            }
            return false;
        }

        private void AuthorsLV_SelectionChanged(object sender, SelectionChangedEventArgs e)
        {
            DAL.DB.AuthorPublication authorPublicationSelected = (DAL.DB.AuthorPublication)AuthorsLV.SelectedItem;
            if (authorPublicationSelected != null)
            {
                FunctionCombobox.SelectedItem = authorPublicationSelected.AuthorFunction;
            }
        }
    }
}
