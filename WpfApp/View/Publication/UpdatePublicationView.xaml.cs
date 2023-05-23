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
    /// Interaction logic for UpdatePublicationView.xaml
    /// </summary>
    public partial class UpdatePublicationView : Window
    {
        //private readonly DAL.DB.Publication publicationToEdit;
        private ViewModel.PublicationViewModel publicationVM;

        public UpdatePublicationView(ViewModel.PublicationViewModel publicationVM)
        {
            InitializeComponent();
            if (publicationVM != null && publicationVM.PublicationSelected != null)
            {
                this.publicationVM = new ViewModel.PublicationViewModel();
               
                this.DataContext = publicationVM;
                this.comboboxShelf.ItemsSource = BU.Services.ShelfService.GetShelves();
                this.comboboxTheme.ItemsSource = BU.Services.ShelfCompositionService.GetThemesOf(publicationVM.PublicationSelected.LocationNavigation.Shelf);
                this.ShowDialog();
            } else
            {
                this.Close();
                MessageBox.Show("Please, select a publication to edit.", "No selection", MessageBoxButton.OK, MessageBoxImage.Information);
            }
        }

        private void LoadThemeOfShelfSelected(object sender, SelectionChangedEventArgs e)
        {
            this.comboboxTheme.ItemsSource = BU.Services.ShelfCompositionService.GetThemesOf((DAL.DB.Shelf)comboboxShelf.SelectedItem);
        }

        private void DatePickerDateToNow(object sender, RoutedEventArgs e)
        {
            DatePickerPublisher.SelectedDate = DateTime.Now;
        }
    }
}
