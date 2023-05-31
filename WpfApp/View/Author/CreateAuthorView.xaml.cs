using DAL.DB;
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
    /// Interaction logic for CreateAuthorView.xaml
    /// </summary>
    public partial class CreateAuthorView : Window
    {
        public bool HaveCreate{ get; set; }
        public CreateAuthorView()
        {
            InitializeComponent();
            this.ShowDialog();
        }

        /// <summary>
        /// Close this window.
        /// </summary>
        private void QuitAuthorViewButton_Click(object sender, RoutedEventArgs e)
        {
            this.Close();
        }

        private void CreateAuthorButton_Click(object sender, RoutedEventArgs e)
        {
            var newAuthor = new DAL.DB.Author()
            {
                AuthorName = AuthorNameInput.Text,
                Nationality = AuthorNationalityInput.Text,
            };
            var createAuthor = BU.Services.AuthorService.CreateAuthor(newAuthor);
            MessageBox.Show(createAuthor.Message, "A message from the system.", MessageBoxButton.OK, (MessageBoxImage)createAuthor.ImageBox);

            if (createAuthor.Status == BU.Entities.ServiceResultStatus.OK)
            {
                HaveCreate = true;
                this.Close();
                return;
            }
            HaveCreate = false;
        }
    }
}
