using DAL.DB;
using Microsoft.IdentityModel.Tokens;
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
using System.Windows.Navigation;
using System.Windows.Shapes;
using WpfApp.ViewModel;

namespace WpfApp.View.Shelf
{
    /// <summary>
    /// Interaction logic for ShelfView.xaml
    /// </summary>
    public partial class ShelfView : UserControl
    {
        private readonly ShelfViewModel shelfVM = new ShelfViewModel();

        public ShelfView()
        {

            InitializeComponent();
            PopulateAndBind();
        }

        private void PopulateAndBind()
        {
            shelfVM.Shelves = new ObservableCollection<DAL.DB.Shelf>(BU.Services.ShelfService.GetShelves());
            shelfVM.Themes = new ObservableCollection<Theme>(BU.Services.ShelfCompositionService.GetThemesOf(shelfVM.SelectedShelf));
            DataContext = shelfVM;
        }

        private void AddShelfButton_Click(object sender, RoutedEventArgs e)
        {
            if (shelfVM.AddShelf())
            {
                PopulateAndBind();
            }
        }

        /// <summary>
        /// ATTENTION ici !
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        private void DeleteButton_Click(object sender, RoutedEventArgs e)
        {
            if (shelfVM.DeleteShelf())
            {
                PopulateAndBind();
            }
        }

        private void ShelfRenameButtonClick(object sender, RoutedEventArgs e)
        {
            if (shelfVM.RenameShelf())
            {
                PopulateAndBind();
            }
        }

        private void ThemeRenameButton_Click(object sender, RoutedEventArgs e)
        {
            if (shelfVM.RenameTheme())
            {
                shelfVM.Themes = new ObservableCollection<Theme>(BU.Services.ShelfCompositionService.GetThemesOf(shelfVM.SelectedShelf));
            }
        }

        private void ThemeAddButton_Click(object sender, RoutedEventArgs e)
        {
            if (shelfVM.AddTheme())
            {
                shelfVM.Themes = new ObservableCollection<Theme>(BU.Services.ShelfCompositionService.GetThemesOf(shelfVM.SelectedShelf));
            }
        }

        private void ListView_SelectionChanged_1(object sender, SelectionChangedEventArgs e)
        {
            shelfVM.Themes = new ObservableCollection<Theme>(BU.Services.ShelfCompositionService.GetThemesOf(shelfVM.SelectedShelf));
        }
    }
}
