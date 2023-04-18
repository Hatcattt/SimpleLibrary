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
using System.Windows.Input;
using System.Windows.Media.Effects;

namespace WpfApp.ViewModel
{
    public class ShelfViewModel : BaseViewModel
    {
        #region Propreties
        private DAL.DB.Shelf _selectedShelf;
        public DAL.DB.Shelf SelectedShelf
        {
            get => _selectedShelf;
            set
            {
                _selectedShelf = value;
                NotifyPropertyChanged(nameof(SelectedShelf));
            }
        }

        private string shelfInputText;
        public string ShelfInputText
        {
            get => shelfInputText;
            set
            {
                shelfInputText = value;
                NotifyPropertyChanged(nameof(ShelfInputText));
            }
        }

        private ObservableCollection<DAL.DB.Shelf> shelves;
        public ObservableCollection<DAL.DB.Shelf> Shelves
        {
            get { return shelves; }
            set
            {
                shelves = value;
                NotifyPropertyChanged(nameof(Shelves));
            }
        }

        private DAL.DB.Theme? _selectedTheme;
        public DAL.DB.Theme? SelectedTheme
        {
            get => _selectedTheme;
            set
            {
                _selectedTheme = value;
                NotifyPropertyChanged(nameof(SelectedTheme));
            }
        }

        private string themeInputText;
        public string ThemeInputText
        {
            get => themeInputText;
            set
            {
                themeInputText = value;
                NotifyPropertyChanged(nameof(ThemeInputText));
            }
        }


        private ObservableCollection<DAL.DB.Theme> themesOfShelf;
        public ObservableCollection<DAL.DB.Theme> ThemesOfShelf
        {
            get { return themesOfShelf; }
            set
            {
                if (themesOfShelf != value)
                {
                    themesOfShelf = value;
                    NotifyPropertyChanged(nameof(ThemesOfShelf));
                }
            }
        }

        private ObservableCollection<DAL.DB.Theme> themes;
        public ObservableCollection<DAL.DB.Theme> Themes
        {
            get { return themes; }
            set
            {
                if (themes != value)
                {
                    themes = value;
                    NotifyPropertyChanged(nameof(Themes));
                }
            }
        }
        #endregion

        public ShelfViewModel()
        {
            ShelfInputText = string.Empty;
            ThemeInputText = string.Empty;

            themes = new ObservableCollection<Theme>(BU.Services.ShelfService.GetThemes());
            shelves = new ObservableCollection<DAL.DB.Shelf>(BU.Services.ShelfService.GetShelves());
            themesOfShelf = new ObservableCollection<Theme>(BU.Services.ShelfCompositionService.GetThemesOf(SelectedShelf));
        }

        #region Methods
        public bool AddShelf()
        {
            if (ShelfInputText.IsNullOrEmpty())
            {
                return false;
            }
            var newShelfId = BU.Services.ShelfService.AddShelf(new DAL.DB.Shelf() { ShelfName = ShelfInputText });
            if (newShelfId != -1)
            {
                MessageBox.Show("Shelf "
               + BU.Services.ShelfService.GetShelf(newShelfId).ShelfName
               + " added successfully!", "Success", MessageBoxButton.OK, MessageBoxImage.Information);
                return true;
            }
            MessageBox.Show("Warning : shelf not added. Maybe this shelf already exist.", "Warning", MessageBoxButton.OK, MessageBoxImage.Warning);
            return false;
        }

        public bool RenameShelf()
        {
            if (BU.Services.ShelfService.RenameShelf(SelectedShelf, ShelfInputText) != -1)
            {
                MessageBox.Show("Shelf was renamed sucessfully!", "Success", MessageBoxButton.OK, MessageBoxImage.Information);
                return true;
            }
            MessageBox.Show("Warning : shelf not renamed. Maybe a shelf with the same name already exist.", "Warning", MessageBoxButton.OK, MessageBoxImage.Exclamation);
            return false;
        }

        public bool DeleteShelf()
        {
            if (MessageBox.Show("Are you sure you want to delete "
                    + SelectedShelf.ShelfName
                    + "?\nAll theme inside will be remove too.", "Delete a Shelf", MessageBoxButton.YesNo, MessageBoxImage.Question)
                    == MessageBoxResult.Yes)
            {
                if (BU.Services.ShelfService.DeleteShelf(SelectedShelf))
                {
                    MessageBox.Show("Shelf Deleted sucessfully!", "Success", MessageBoxButton.OK, MessageBoxImage.Information);
                    return true;
                }
            }
            return false;
        }

        public bool AddTheme()
        {
            if (ThemeInputText.Length > 0 && SelectedShelf != null)
            {
                int newThemeId = BU.Services.ShelfService.AddTheme(new Theme() { ThemeName = ThemeInputText }, SelectedShelf);
                MessageBox.Show("Theme "
                    + BU.Services.ShelfService.GetTheme(newThemeId).ThemeName
                    + " added successfully!", "Success", MessageBoxButton.OK, MessageBoxImage.Information);
                return true;
            }
            return false;
        }

        public bool RenameTheme()
        {
            if (SelectedTheme != null)
            {
                BU.Services.ShelfService.RenameTheme(SelectedTheme, ThemeInputText);
                MessageBox.Show("Theme was renamed sucessfully!", "Success", MessageBoxButton.OK, MessageBoxImage.Information);
                return true;
            }
            return false;
        }

        public bool DeleteTheme()
        {
            if (SelectedTheme != null)
            {
                var userChoice = MessageBox.Show("Are you sure you want to delete "
                    + SelectedTheme.ThemeName
                    + "?", "Delete a theme", MessageBoxButton.YesNo, MessageBoxImage.Question);
                if (userChoice == MessageBoxResult.Yes)
                {
                    if (BU.Services.ShelfService.DeleteTheme(SelectedTheme) == 0)
                    {
                        MessageBox.Show("Shelf Deleted sucessfully!", "Success", MessageBoxButton.OK, MessageBoxImage.Information);
                        return true;
                    }
                    MessageBox.Show("An error occur during the proccess", "Warning", MessageBoxButton.OK, MessageBoxImage.Warning);
                    return false;
                }
                return false;
            }
            MessageBox.Show("No theme selected!", "Oups", MessageBoxButton.OK, MessageBoxImage.Information);
            return false;
        }

        public bool AddShelfComposition()
        {
            if (BU.Services.ShelfService.AddShelfComposition(SelectedShelf, SelectedTheme) != -1)
            {
                MessageBox.Show("New composition added successfully!", "Success", MessageBoxButton.OK, MessageBoxImage.Information);
                return true;
            }
            MessageBox.Show(
                "You can't create this new shlef composition.\n" +
                "Maybe this theme already exist inside the selected shelf.", "Warning", MessageBoxButton.OK, MessageBoxImage.Exclamation);
            return false;
        }

        public bool DeleteShelfComposition()
        {
            if (SelectedTheme != null && SelectedShelf != null)
            {
                var userChoice = MessageBox.Show("Are you sure you want to delete this theme inside this shelf ?", "Delete a composition", MessageBoxButton.YesNo, MessageBoxImage.Question);
                if (userChoice == MessageBoxResult.Yes)
                {
                    if (BU.Services.ShelfService.DeleteShelfComposition(SelectedTheme, SelectedShelf))
                    {
                        MessageBox.Show("Shelf Composition deleted successfully!", "Success", MessageBoxButton.OK, MessageBoxImage.Information);
                        return true;
                    }
                }
            }
            return false;
        }
        #endregion
    }
}
