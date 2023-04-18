using DAL.DB;
using System;
using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.IO;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Text;
using System.Threading.Tasks;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Controls.Primitives;
using System.Windows.Data;
using System.Windows.Documents;
using System.Windows.Input;
using System.Windows.Media;
using System.Windows.Media.Imaging;
using System.Windows.Navigation;
using System.Windows.Shapes;
using static System.Net.Mime.MediaTypeNames;

namespace WpfApp.View.Publication
{
    /// <summary>
    /// Interaction logic for PublicationView.xaml
    /// </summary>
    public partial class PublicationView : UserControl
    {
        ViewModel.PublicationViewModel publicationVM = new ViewModel.PublicationViewModel();

        public PublicationView()
        {
            InitializeComponent();
            PopulateAndBind();
        }

        private void PopulateAndBind()
        {
            this.DataContext = publicationVM;
            foreach(var publi in publicationVM.Publications)
            {
                publi.CoverFilePath = "/image/Covers/content.jpg";
            }
        }

        private void ListView_SelectionChanged(object sender, SelectionChangedEventArgs e)
        {
            publicationVM.AuthorPublications = new ObservableCollection<DAL.DB.AuthorPublication>(BU.Services.PublicationService.GetAuthorsOf(publicationVM.PublicationSelected));
            publicationVM.PublicationCopies = new ObservableCollection<DAL.DB.PublicationCopy>(BU.Services.PublicationService.GetPublicationCopies(publicationVM.PublicationSelected));
            publicationVM.FullTitleName = publicationVM.PublicationSelected.Title + " " + publicationVM.PublicationSelected.SubTitle;
        }

        private void Label_MouseDown(object sender, MouseButtonEventArgs e)
        {
            MessageBox.Show("Cliqued!");
        }

        private void Label_MouseEnter(object sender, MouseEventArgs e)
        {
            ShelfLinkLabel.Background = Brushes.LightBlue;
        }

        private void ShelfLinkLabel_MouseLeave(object sender, MouseEventArgs e)
        {
            ShelfLinkLabel.ClearValue(BackgroundProperty);
        }

        private void MyImage_MouseEnter(object sender, MouseEventArgs e)
        {

        }

        private void MyImage_MouseLeave(object sender, MouseEventArgs e)
        {

        }
    }
}
