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
                if (_selectedShelf != value)
                {
                    _selectedShelf = value;
                    NotifyPropertyChanged(nameof(SelectedShelf));
                }
            }
        }

        private string _shelfAddInputText;
        public string ShelfAddInputText
        {
            get { return _shelfAddInputText; }
            set
            {
                _shelfAddInputText = value;
                NotifyPropertyChanged(nameof(ShelfAddInputText));
            }
        }

        private string _shelfRenameInputText;
        public string ShelfRenameInputText
        {
            get { return _shelfRenameInputText; }
            set
            {
                if (_shelfRenameInputText != value)
                {
                    _shelfRenameInputText = value;
                    NotifyPropertyChanged(nameof(ShelfRenameInputText));
                }
            }
        }

        private ObservableCollection<DAL.DB.Shelf> shelves;
        public ObservableCollection<DAL.DB.Shelf> Shelves
        {
            get { return shelves; }
            set
            {
                if (shelves != value)
                {
                    shelves = value;
                    NotifyPropertyChanged(nameof(Shelves));
                }
            }
        }

        private DAL.DB.Theme? _selectedTheme;
        public DAL.DB.Theme? SelectedTheme
        {
            get => _selectedTheme;
            set
            {
                if (_selectedTheme != value)
                {
                    _selectedTheme = value;
                    NotifyPropertyChanged(nameof(SelectedTheme));
                }
            }
        }

        private string _themeAddInputText;
        public string ThemeAddInputText
        {
            get { return _themeAddInputText; }
            set
            {
                _themeAddInputText = value;
                //NotifyPropertyChanged(nameof(ThemeAddInputText));
            }
        }

        private string _themeRenameInputText;
        public string ThemeRenameInputText
        {
            get { return _themeRenameInputText; }
            set
            {
                if (_themeRenameInputText != value)
                {
                    _themeRenameInputText = value;
                    NotifyPropertyChanged(nameof(ThemeRenameInputText));
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
            _shelfAddInputText = string.Empty;
            _shelfRenameInputText = string.Empty;
            _themeAddInputText = string.Empty;
            _themeRenameInputText = string.Empty;

            shelves = new ObservableCollection<DAL.DB.Shelf>(BU.Services.ShelfService.GetShelves());
            themes = new ObservableCollection<Theme>(BU.Services.ShelfCompositionService.GetThemesOf(SelectedShelf));
        }

        public bool AddShelf()
        {
            if (ShelfAddInputText.Length > 0)
            {
                var newShelf = BU.Services.ShelfService.AddShelf(new DAL.DB.Shelf() { ShelfName = ShelfAddInputText });
                MessageBox.Show("Shelf " 
                    + BU.Services.ShelfService.GetShelf(newShelf).ShelfName 
                    + " added successfully!", "Success", MessageBoxButton.OK, MessageBoxImage.Information);
                return true;
            }
            return false;
        }

        public bool RenameShelf()
        {
            if (SelectedShelf != null && ShelfRenameInputText.Length > 0)
            {
                BU.Services.ShelfService.RenameShelf(SelectedShelf, ShelfRenameInputText);
                MessageBox.Show("Shelf was renamed sucessfully!", "Success", MessageBoxButton.OK, MessageBoxImage.Information);
                return true;
            }
            return false;
        }

        public bool DeleteShelf()
        {
            if (SelectedShelf != null)
            {
                var userChoice = MessageBox.Show("Are you sure you want to delete " 
                    + SelectedShelf.ShelfName 
                    + "?", "Delete a Shelf", MessageBoxButton.YesNo, MessageBoxImage.Question);
                if (userChoice == MessageBoxResult.Yes)
                {
                    BU.Services.ShelfService.DeleteShelf(SelectedShelf);
                    MessageBox.Show("Shelf Deleted sucessfully!", "Success", MessageBoxButton.OK, MessageBoxImage.Information);
                    return true;
                }
            }
            return false;
        }

        public bool AddTheme()
        {
            if (ThemeAddInputText.Length > 0)
            {
                var newTheme = BU.Services.ShelfService.AddTheme(new Theme() { ThemeName = ThemeAddInputText }, SelectedShelf);
                MessageBox.Show("Theme "
                    + BU.Services.ShelfService.GetTheme(newTheme).ThemeName
                    + " added successfully!", "Success", MessageBoxButton.OK, MessageBoxImage.Information);
                return true;
            }
            return false;
        }

        public bool RenameTheme()
        {
            if (SelectedTheme != null)
            {
                BU.Services.ShelfService.RenameTheme(SelectedTheme, ThemeRenameInputText);
                MessageBox.Show("Theme was renamed sucessfully!", "Success", MessageBoxButton.OK, MessageBoxImage.Information);
                return true;
            }
            return false;
        }
    }
}
