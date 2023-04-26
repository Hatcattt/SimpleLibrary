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

namespace WpfApp.View.Author
{
    /// <summary>
    /// Interaction logic for EditAuthorView.xaml
    /// </summary>
    public partial class EditAuthorView : Window
    {
        ViewModel.AuthorViewModel authorVM = new ViewModel.AuthorViewModel();

        public EditAuthorView(DAL.DB.Author author)
        {
            authorVM.AuthorSelected = author;
            AuthorNameInput.Text = authorVM.AuthorSelected.AuthorName;

            this.DataContext = authorVM;
            InitializeComponent();
            this.ShowDialog();
        }

        private void Button_Click(object sender, RoutedEventArgs e)
        {
            this.Close();
        }

        private void Button_Click_2(object sender, RoutedEventArgs e)
        {

            if (BU.Services.AuthorService.RenameAuthor(authorVM.AuthorSelected, AuthorNameInput.Text) != -1)
            {
                MessageBox.Show("author renamed!");
            } else
            {
                MessageBox.Show("An error occur");
            }
        }
    }
}
