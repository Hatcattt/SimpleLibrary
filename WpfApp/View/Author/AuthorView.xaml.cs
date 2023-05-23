using DAL.DB;
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
            _ = new CreateAuthorView();
            authorVM.Authors = new ObservableCollection<DAL.DB.Author>(BU.Services.AuthorService.GetAuthors());
        }

        private void EditAuthorButton_Click(object sender, RoutedEventArgs e)
        {
            if (authorVM.AuthorSelected != null)
            {
                var test = new EditAuthorView(authorVM.AuthorSelected);
                if (! test.IsActive)
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
    }
}
