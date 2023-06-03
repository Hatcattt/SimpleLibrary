using DAL.DB;
using System;
using System.Collections.ObjectModel;
using System.Windows;

namespace WpfApp.ViewModel
{
    public class ShelfViewModel : BaseViewModel
    {
        #region Propreties
        private DAL.DB.Shelf? _selectedShelf;
        public DAL.DB.Shelf? SelectedShelf
        {
            get => _selectedShelf;
            set
            {
                _selectedShelf = value;
                NotifyPropertyChanged(nameof(SelectedShelf));
            }
        }

        private string shelfInputText = "";
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

        private string themeInputText = "";
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

        /// <summary>
        /// Constructor of this viewmodel.
        /// </summary>
        public ShelfViewModel()
        {
            shelves = new ObservableCollection<Shelf>();
            themes = new ObservableCollection<Theme>();
            themesOfShelf = new ObservableCollection<Theme>();
        }
    }
}
