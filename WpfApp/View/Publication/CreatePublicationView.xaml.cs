using DAL.DB;
using DAL.Entities;
using DAL.Services;
using Microsoft.IdentityModel.Tokens;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.NetworkInformation;
using System.Text;
using System.Threading;
using System.Threading.Tasks;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Data;
using System.Windows.Documents;
using System.Windows.Input;
using System.Windows.Media;
using System.Windows.Media.Imaging;
using System.Windows.Shapes;
using static System.Net.Mime.MediaTypeNames;

namespace WpfApp.View.Publication
{
    /// <summary>
    /// Interaction logic for CreatePublicationView.xaml
    /// </summary>
    public partial class CreatePublicationView : Window
    {
        View.Publication.PublicationView newPublicationVM = new();
        GoogleBookPublication gBook;
        public CreatePublicationView()
        {
            InitializeComponent();
            this.DataContext = newPublicationVM;
            this.comboboxShelf.ItemsSource = BU.Services.ShelfService.GetShelves();
            this.ShowDialog();
        }

        private void QuitPublicationViewButton_Click(object sender, RoutedEventArgs e)
        {
            this.Close();
        }

        private async void SearchWithAPIButton_Click(object sender, RoutedEventArgs e)
        {
            string isbn = ISBNinputText.Text;

            var json = await GoogleBookApiToJson.GetJsonAsyncBy(isbn);
            gBook = new GoogleBookPublication(json);

            if (gBook.JsonAsContent())
            {
                ISBNinputText.Text = gBook.Isbn;
                TitleInput.Text = gBook.Title + " " + gBook.SubTitle;
                PublisherInput.Text = gBook.Publisher;
                PublishedDatePicker.SelectedDate = gBook.PublishedDate;
                DescriptionInput.Text = gBook.Description;
                LanguageInput.Text = gBook.Language;
                CoverImage.Source = new BitmapImage(gBook.CoverFilePath);
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

        private void CreateANewPublication_Click(object sender, RoutedEventArgs e)
        {
            try
            {
                var shelf = (DAL.DB.Shelf)comboboxShelf.SelectedValue;
                var theme = (DAL.DB.Theme)comboboxTheme.SelectedValue;

                if (shelf != null && theme != null)
                {
                    using var DB = new SimpleLibraryContext();
                    var newPublication = new DAL.DB.Publication()
                    {
                        Isbn = ISBNinputText.Text,
                        Title = TitleInput.Text,
                        //SubTitle = gBook.SubTitle,
                        Publisher = PublisherInput.Text,
                        PublishedDate = PublishedDatePicker.SelectedDate,
                        Description = DescriptionInput.Text,
                        Location = BU.Services.ShelfService.GetShelfComposition(shelf, theme),
                        Language = LanguageInput.Text,
                        LetterRow = TitleInput.Text[..1],
                        //CoverFilePath = gBook.CoverFilePath.ToString(),
                    };
                    DB.Publications.Add(newPublication);
                    DB.SaveChanges();
                } else
                {
                    MessageBox.Show("Please choose a shelf and a theme!", "Warning", MessageBoxButton.OK, MessageBoxImage.Warning);
                }
            } catch (Exception ex)
            {
                MessageBox.Show($"{ex.Message}\n{ex.InnerException.Message}", "ERROR",MessageBoxButton.OK, MessageBoxImage.Error);
            }
        }
    }
}
