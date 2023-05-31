using DAL.DB;
using Microsoft.Data.SqlClient;
using Microsoft.Extensions.Configuration;
using System.Drawing;
using System.IO;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Media;
using WpfApp.Enums;

namespace WpfApp
{
    /// <summary>
    /// Interaction logic for MainWindow.xaml
    /// </summary>
    public partial class MainWindow : Window , IViewManager
    {
        /// <summary>
        /// Init the main windows and set the current view as Home.
        /// </summary>
        public MainWindow()
        {
            InitializeComponent();
            SetCurrentView(AppView.Home);
            var appName = new ConfigurationBuilder()
                .AddJsonFile("appsettings.json")
                .Build()
                .GetSection("AppSettings")["AppName"];
            var appVersion = new ConfigurationBuilder()
                .AddJsonFile("appsettings.json")
                .Build()
                .GetSection("AppSettings")["AppVersion"];
            AppInfo.Text = $"{appName} - Version : {appVersion}";
        }

        /// <summary>
        /// Set the current view by AppView enum.
        /// </summary>
        /// <param name="currentAppView">The view to set.</param>
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

        /// <summary>
        /// Set the author view when user clic on the button.
        /// </summary>
        public void AuthorViewButton_Click(object sender, RoutedEventArgs e)
        {
            SetCurrentView(AppView.Author);
        }

        /// <summary>
        /// Set the publication view when user clic on the button.
        /// </summary>
        private void PublicationViewButton_Click(object sender, RoutedEventArgs e)
        {
            SetCurrentView(AppView.Publication);
        }

        /// <summary>
        /// Set the home view when user clic on the button.
        /// </summary>
        private void HomeView_Click(object sender, RoutedEventArgs e)
        {
            SetCurrentView(AppView.Home);
        }

        /// <summary>
        /// Set the shelf view when user clic on the button.
        /// </summary>
        private void ShelfView_Click(object sender, RoutedEventArgs e)
        {
            SetCurrentView(AppView.Shelf);
        }

        /// <summary>
        /// Shutdown the application when user clic on the menu item.
        /// </summary>
        private void MenuItemExit_Click(object sender, RoutedEventArgs e)
        {
            Application.Current.Shutdown();
        }

        /// <summary>
        /// Display a new about windows when user clic on the menu item.
        /// </summary>
        private void MenuItemAbout_Click(object sender, RoutedEventArgs e)
        {
            _ = new AboutWindow();
        }

        /// <summary>
        /// Set the author view when user clic on the button.
        /// </summary>
        public void SetCurrentView(UserControl currentView)
        {
            CurrentViewPlaceHolder.Content = currentView;
        }
    }
}
