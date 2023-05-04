using DAL.Entities;
using DAL.Services;
using Microsoft.IdentityModel.Tokens;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.NetworkInformation;
using System.Text;
using System.Threading;
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
    /// Interaction logic for CreatePublicationView.xaml
    /// </summary>
    public partial class CreatePublicationView : Window
    {
        ViewModel.PublicationViewModel publicationVM;

        public CreatePublicationView()
        {
            InitializeComponent();
            publicationVM = new ViewModel.PublicationViewModel();
            this.DataContext = publicationVM;
            this.ShowDialog();
        }

        private void SavePublicationChangesButton_Click(object sender, RoutedEventArgs e)
        {

        }

        private void QuitPublicationViewButton_Click(object sender, RoutedEventArgs e)
        {
            this.Close();
        }

        private async void SearchWithAPIButton_Click(object sender, RoutedEventArgs e)
        {
            string isbn = ISBNinputText.Text;
            var json = await GoogleBookApiToJson.GetJsonAsyncBy(isbn);
            var gBook = new GoogleBookPublication(json);

            TitleInput.Text = gBook.Title;
            PublisherInput.Text = gBook.Publisher;
            DescriptionInput.Text = gBook.Description;
            publicationVM.CoverImageURL = gBook.CoverFilePath;
        }
    }
}
