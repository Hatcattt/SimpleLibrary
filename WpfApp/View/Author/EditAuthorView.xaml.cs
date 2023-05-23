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
using System.Windows.Shapes;
using WpfApp.ViewModel;

namespace WpfApp.View.Author
{
    /// <summary>
    /// Interaction logic for EditAuthorView.xaml
    /// </summary>
    public partial class EditAuthorView : Window
    {
        ViewModel.AuthorViewModel authorVM = new AuthorViewModel();

        public EditAuthorView(DAL.DB.Author author)
        {
            InitializeComponent();
            this.authorVM.AuthorSelected = author ?? throw new ArgumentNullException(nameof(author) + " cannot be null");
            this.DataContext = this.authorVM;
            this.ShowDialog();
        }

        private void QuitAuthorViewButton_Click(object sender, RoutedEventArgs e)
        {
            this.Close();
        }

        /// <summary>
        /// Call a method to edit the author selected if not null.
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        private void SaveAuthorChangesButton_Click(object sender, RoutedEventArgs e)
        {
            if (authorVM.AuthorSelected != null)
            {
                var editAuthor = BU.Services.AuthorService.EditAuthor(authorVM.AuthorSelected, AuthorNameInput.Text, AuthorNationalityInput.Text);
                MessageBox.Show(editAuthor.Message, "A message from the system.", MessageBoxButton.OK, (MessageBoxImage)editAuthor.ImageBox);
            }
            this.Close();
        }
    }
}
