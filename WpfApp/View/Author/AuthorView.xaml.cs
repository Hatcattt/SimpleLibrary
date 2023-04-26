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

        private void Button_Click_1(object sender, RoutedEventArgs e)
        {
            _ = new AboutWindow();
        }

        private void EditAuthor_Click(object sender, RoutedEventArgs e)
        {
            if (authorVM.AuthorSelected != null)
            {
                _ = new EditAuthorView(authorVM.AuthorSelected);
            }
        }
    }
}
