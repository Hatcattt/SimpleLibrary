using System;
using System.Collections.Generic;
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
using System.Windows.Shapes;
using WpfApp.ViewModel;

namespace WpfApp.View.Author
{
    /// <summary>
    /// Interaction logic for EditAuthorView.xaml
    /// </summary>
    public partial class EditAuthorView : Window
    {
        ViewModel.AuthorViewModel authorVM;

        public EditAuthorView(DAL.DB.Author author)
        {
            InitializeComponent();
            this.authorVM = new AuthorViewModel();
            this.authorVM.AuthorSelected = author;
            this.DataContext = this.authorVM;
            this.ShowDialog();
        }

        private void QuitAuthorViewButton_Click(object sender, RoutedEventArgs e)
        {
            this.Close();
        }

        private void SaveAuthorChangesButton_Click(object sender, RoutedEventArgs e)
        {

            if (BU.Services.AuthorService.EditAuthor(authorVM.AuthorSelected, AuthorNameInput.Text, AuthorNationalityInput.Text) != -1)
            {
                MessageBox.Show("author renamed!");
            }
            else
            {
                MessageBox.Show("An error occur");
            }
        }
    }
}
