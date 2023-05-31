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
    /// Interaction logic for EditAuthorView.xaml. This window is used to edit an author.
    /// </summary>
    public partial class EditAuthorView : Window
    {
        public bool HaveSaved { get; set; }
        ViewModel.AuthorViewModel authorVM = new AuthorViewModel();

        /// <summary>
        /// Constructor of this window. Accept an author to edit it.
        /// </summary>
        /// <param name="author">The author to edit.</param>
        /// <exception cref="Common.Exceptions.AppException">If author is null.</exception>
        public EditAuthorView(DAL.DB.Author author)
        {
            if (author == null)
            {
                throw new Common.Exceptions.AppException("The author cannot be null!");
            }
            InitializeComponent();
            this.authorVM.AuthorSelected = author;
            this.DataContext = this.authorVM;
            this.ShowDialog();
        }

        /// <summary>
        /// Close the current window.
        /// </summary>
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
            if (authorVM.AuthorSelected == null)
            {
                return;
            }
            var result = BU.Services.AuthorService.EditAuthor(authorVM.AuthorSelected, AuthorNameInput.Text, AuthorNationalityInput.Text);
            MessageBox.Show(result.Message, "A message from the system.", MessageBoxButton.OK, (MessageBoxImage)result.ImageBox);

            if (result.Status == BU.Entities.ServiceResultStatus.OK)
            {
                HaveSaved = true;
                this.Close();
                return;
            }
            HaveSaved = false;
        }
    }
}
