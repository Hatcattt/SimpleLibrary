using System.Windows;
using System.Windows.Controls;
using WpfApp.Enums;

namespace WpfApp
{
    /// <summary>
    /// Interaction logic for MainWindow.xaml
    /// </summary>
    public partial class MainWindow : Window , IViewManager
    {
        public MainWindow()
        {
            InitializeComponent();
            SetCurrentView(AppView.Publication);
        }

        public void SetCurrentView(AppView currentAppView)
        {
            switch (currentAppView)
            {
                case AppView.Home:
                    SetCurrentView(new View.HomeView());
                    break;
                case AppView.Shelf:
                    SetCurrentView(new View.Shelf.ShelfView());
                    break;
                case AppView.Author:
                    SetCurrentView(new View.Author.AuthorView());
                    break;
                case AppView.Publication:
                    SetCurrentView(new View.Publication.PublicationView());
                    break;
            }
        }

        private void AuthorViewButton_Click(object sender, RoutedEventArgs e)
        {
            SetCurrentView(AppView.Author);
        }

        private void PublicationViewButton_Click(object sender, RoutedEventArgs e)
        {
            SetCurrentView(AppView.Publication);
        }
        private void HomeView_Click(object sender, RoutedEventArgs e)
        {
            SetCurrentView(AppView.Home);
        }

        private void ShelfView_Click(object sender, RoutedEventArgs e)
        {
            SetCurrentView(AppView.Shelf);
        }

        private void MenuItemExit_Click(object sender, RoutedEventArgs e)
        {
            Application.Current.Shutdown();
        }

        private void MenuItemAbout_Click(object sender, RoutedEventArgs e)
        {
            _ = new AboutWindow();
        }

        public void SetCurrentView(UserControl currentView)
        {
            CurrentViewPlaceHolder.Content = currentView;
        }
    }
}
