using DAL.DB;
using Microsoft.IdentityModel.Tokens;
using System;
using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Data;
using System.Windows.Documents;
using System.Windows.Input;
using System.Windows.Media;
using System.Windows.Media.Imaging;
using System.Windows.Navigation;
using System.Windows.Shapes;

namespace WpfApp.View.Author
{
    /// <summary>
    /// Interaction logic for AuthorView.xaml
    /// </summary>
    public partial class AuthorView : UserControl
    {
        ViewModel.AuthorViewModel authorVM = new ViewModel.AuthorViewModel();

        public AuthorView()
        {
            InitializeComponent();
            PopulateAndBind();
        }

        private void PopulateAndBind()
        {
            this.DataContext = authorVM;
        }

        private void CreateAuthorButton_Click(object sender, RoutedEventArgs e)
        {
            var createAuthorView = new CreateAuthorView();
            if (createAuthorView.HaveCreate)
            {
                authorVM.Authors = new ObservableCollection<DAL.DB.Author>(BU.Services.AuthorService.GetAuthors());
            }
        }

        private void EditAuthorButton_Click(object sender, RoutedEventArgs e)
        {
            if (authorVM.AuthorSelected != null)
            {
                var editView = new EditAuthorView(authorVM.AuthorSelected);
                if (editView.HaveSaved == true)
                {
                    authorVM.Authors = new ObservableCollection<DAL.DB.Author>(BU.Services.AuthorService.GetAuthors());
                }
            }
        }

        private void DeleteAuthorButton_Click(object sender, RoutedEventArgs e)
        {
            if (authorVM.AuthorSelected != null)
            {
                var deleteAuthor = BU.Services.AuthorService.DeleteAuthor(authorVM.AuthorSelected);
                MessageBox.Show(deleteAuthor.Message, "A message from the system.", MessageBoxButton.OK, (MessageBoxImage)deleteAuthor.ImageBox);
                authorVM.Authors = new ObservableCollection<DAL.DB.Author>(BU.Services.AuthorService.GetAuthors());
            }
        }

        private void TextBoxSearch_TextChanged(object sender, TextChangedEventArgs e)
        {
            if (textBoxSearch.Text.IsNullOrEmpty())
            {
                authorVM.Authors = new ObservableCollection<DAL.DB.Author>(BU.Services.AuthorService.GetAuthors());
                return;
            }
            authorVM.Authors = new ObservableCollection<DAL.DB.Author>(BU.Services.AuthorService.GetAuthorsStartWith(textBoxSearch.Text));
        }

        private void ResetSearchBarTextButton_Click(object sender, RoutedEventArgs e)
        {
            textBoxSearch.Text = string.Empty;
        }
    }
}
