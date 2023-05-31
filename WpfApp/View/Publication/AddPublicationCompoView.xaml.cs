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

namespace WpfApp.View.Publication
{
    /// <summary>
    /// Interaction logic for AddPublicationCompoView.xaml
    /// </summary>
    public partial class AddPublicationCompoView : Window
    {
        public DAL.DB.AuthorPublication AuthorPublication { get; set; }
        public bool HaveSaved { get; set; }
        public AddPublicationCompoView(DAL.DB.Author author)
        {
            InitializeComponent();
            AuthorPublication = new DAL.DB.AuthorPublication();
            AuthorNameInput.Text = author.AuthorName;
            AuthorPublication.Author = author;
            this.ShowDialog();
        }

        private void AddAuthorPublicationButton_Click(object sender, RoutedEventArgs e)
        {
            AuthorPublication.AuthorFunction = AuthorFunctionInput.Text == "" ? null : AuthorFunctionInput.Text;
            HaveSaved = true;
            this.Close();
        }

        private void CancelPublicationCompoButton_Click(object sender, RoutedEventArgs e)
        {
            HaveSaved = false;
            this.Close();
        }
    }
}
