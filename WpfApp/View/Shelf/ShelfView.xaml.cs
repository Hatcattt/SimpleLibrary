using DAL.DB;
using System.Collections.ObjectModel;
using System.Windows;
using System.Windows.Controls;
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
            shelfVM.Shelves = new ObservableCollection<DAL.DB.Shelf>(BU.Services.ShelfService.GetShelves());
            shelfVM.Themes = new ObservableCollection<DAL.DB.Theme>(BU.Services.ShelfService.GetThemes());
            if (shelfVM.SelectedShelf != null)
            {
                shelfVM.ThemesOfShelf = new ObservableCollection<Theme>(BU.Services.ShelfService.GetThemesOf(shelfVM.SelectedShelf));
            }
            this.DataContext = shelfVM;
        }

        private void AddNewShelfButton_Click(object sender, RoutedEventArgs e)
        {
            var newShelf = new DAL.DB.Shelf()
            {
                ShelfName = shelfInputText.Text
            };
            var createdShelf = BU.Services.ShelfService.AddNewShelf(newShelf);
            MessageBox.Show(createdShelf.Message, "A message from the system.", MessageBoxButton.OK, (MessageBoxImage)createdShelf.ImageBox);

            if (createdShelf.Status == BU.Entities.ServiceResultStatus.OK)
            {
                shelfVM.Shelves = new ObservableCollection<DAL.DB.Shelf>(BU.Services.ShelfService.GetShelves());
            }
        }

        private void EditShelfButton_Click(object sender, RoutedEventArgs e)
        {
            if (shelfVM.SelectedShelf != null)
            {
                var shelfEdited = BU.Services.ShelfService.EditShelf(shelfVM.SelectedShelf, shelfInputText.Text);
                MessageBox.Show(shelfEdited.Message, "A message from the system.", MessageBoxButton.OK, (MessageBoxImage)shelfEdited.ImageBox);
                shelfVM.Shelves = new ObservableCollection<DAL.DB.Shelf>(BU.Services.ShelfService.GetShelves());
            }
        }

        private void DeleteShelfButton_Click(object sender, RoutedEventArgs e)
        {
            if (shelfVM.SelectedShelf != null)
            {
                var deleteChoice = MessageBox.Show("Are you sure? All related publications will also be deleted.", "Delete shelf?", MessageBoxButton.YesNo, MessageBoxImage.Exclamation);
                if (deleteChoice == MessageBoxResult.Yes)
                {
                    var deleteShelf = BU.Services.ShelfService.DeleteShelf(shelfVM.SelectedShelf);
                    MessageBox.Show(deleteShelf.Message, "A message from the system.", MessageBoxButton.OK, (MessageBoxImage)deleteShelf.ImageBox);
                    shelfVM.Shelves = new ObservableCollection<DAL.DB.Shelf>(BU.Services.ShelfService.GetShelves());
                }
            }
        }

        private void AddNewThemeButton_Click(object sender, RoutedEventArgs e)
        {
            var newTheme = new DAL.DB.Theme()
            {
                ThemeName = themeInput.Text
            };
            var createdTheme = BU.Services.ShelfService.AddNewTheme(newTheme);
            MessageBox.Show(createdTheme.Message, "A message from the system.", MessageBoxButton.OK, (MessageBoxImage)createdTheme.ImageBox);

            if (createdTheme.Status == BU.Entities.ServiceResultStatus.OK)
            {
                shelfVM.Themes = new ObservableCollection<DAL.DB.Theme>(BU.Services.ShelfService.GetThemes());
            }
        }

        private void EditThemeButton_Click(object sender, RoutedEventArgs e)
        {
            if (shelfVM.SelectedTheme != null)
            {
                var themeEdited = BU.Services.ShelfService.EditTheme(shelfVM.SelectedTheme, themeInput.Text);
                MessageBox.Show(themeEdited.Message, "A message from the system.", MessageBoxButton.OK, (MessageBoxImage)themeEdited.ImageBox);
                shelfVM.Themes = new ObservableCollection<DAL.DB.Theme>(BU.Services.ShelfService.GetThemes());
            }
        }

        private void DeleteThemeButton_Click(object sender, RoutedEventArgs e)
        {
            if (shelfVM.SelectedTheme!= null)
            {
                var deleteChoice = MessageBox.Show("Are you sure? All related publications will also be deleted.", "Delete theme?", MessageBoxButton.YesNo, MessageBoxImage.Exclamation);
                if (deleteChoice == MessageBoxResult.Yes)
                {
                    var deleteTheme = BU.Services.ShelfService.DeleteTheme(shelfVM.SelectedTheme);
                    MessageBox.Show(deleteTheme.Message, "A message from the system.", MessageBoxButton.OK, (MessageBoxImage)deleteTheme.ImageBox);
                    shelfVM.Themes = new ObservableCollection<DAL.DB.Theme>(BU.Services.ShelfService.GetThemes());
                    shelfVM.Shelves = new ObservableCollection<DAL.DB.Shelf>(BU.Services.ShelfService.GetShelves());
                }
            }
        }

        private void AddShelfComposition_Click(object sender, RoutedEventArgs e)
        {
            if (shelfVM.SelectedShelf != null && shelfVM.SelectedTheme != null)
            {
                var newComposition = new DAL.DB.ShelfComposition()
                {
                    Shelf = shelfVM.SelectedShelf,
                    ShelfId = shelfVM.SelectedShelf.ShelfId,
                    Theme = shelfVM.SelectedTheme,
                    ThemeId = shelfVM.SelectedTheme.ThemeId,
                };
                var createdComposition = BU.Services.ShelfService.AddNewShelfComposition(newComposition);
                MessageBox.Show(createdComposition.Message, "A message from the system.", MessageBoxButton.OK, (MessageBoxImage)createdComposition.ImageBox);

                if (createdComposition.Status == BU.Entities.ServiceResultStatus.OK)
                {
                    shelfVM.Themes = new ObservableCollection<DAL.DB.Theme>(BU.Services.ShelfService.GetThemes());
                    shelfVM.Shelves = new ObservableCollection<DAL.DB.Shelf>(BU.Services.ShelfService.GetShelves());
                }
            }
        }

        private void DeleteShelfComposition_Click(object sender, RoutedEventArgs e)
        {
            if (shelfVM.SelectedShelf != null && shelfVM.SelectedTheme!= null)
            {
                var deleteChoice = MessageBox.Show("Are you sure? All related publications will also be deleted.", "Delete composition?", MessageBoxButton.YesNo, MessageBoxImage.Exclamation);
                if (deleteChoice == MessageBoxResult.Yes)
                {
                    var deleteCompo = BU.Services.ShelfService.DeleteShelfComposition(shelfVM.SelectedShelf, shelfVM.SelectedTheme);
                    MessageBox.Show(deleteCompo.Message, "A message from the system.", MessageBoxButton.OK, (MessageBoxImage)deleteCompo.ImageBox);
                    if (deleteCompo.Status == BU.Entities.ServiceResultStatus.OK)
                    {
                        shelfVM.Themes = new ObservableCollection<DAL.DB.Theme>(BU.Services.ShelfService.GetThemes());
                        shelfVM.Shelves = new ObservableCollection<DAL.DB.Shelf>(BU.Services.ShelfService.GetShelves());
                    }
                }
            }
        }

        private void DataGrid_SelectionChanged(object sender, SelectionChangedEventArgs e)
        {
            if (shelfVM.SelectedShelf != null)
            {
                shelfVM.ThemesOfShelf = new ObservableCollection<Theme>(BU.Services.ShelfService.GetThemesOf(shelfVM.SelectedShelf));
            }
        }
    }
}
