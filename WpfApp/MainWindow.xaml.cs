using DAL.DB;
using Microsoft.Data.SqlClient;
using Microsoft.Extensions.Configuration;
using System.IO;
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
            SetCurrentView(AppView.Home);
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

        private void MenuItem_Click(object sender, RoutedEventArgs e)
        {
            //var config = new ConfigurationBuilder()
            //    .SetBasePath(Directory.GetCurrentDirectory())
            //    .AddJsonFile("appsettings.json", true, true)
            //    .Build();

            //string connectionString = config.GetConnectionString("SimpleLibrary");
            //string backupFilePath = string.Empty;

            //// Afficher la boîte de dialogue Enregistrer sous pour enregistrer le fichier de sauvegarde
            //var saveFileDialog = new Microsoft.Win32.SaveFileDialog();
            //saveFileDialog.Filter = "Fichier SQL (*.sql)|*.sql";
            //saveFileDialog.Title = "Enregistrer la sauvegarde sous";
            //saveFileDialog.ShowDialog();

            //if (!string.IsNullOrEmpty(saveFileDialog.FileName))
            //{
            //    backupFilePath = saveFileDialog.FileName;

            //    // Créer la commande SQL pour sauvegarder la base de données
            //    string backupCommand = $"BACKUP DATABASE [{"SimpleLibrary"}] TO DISK = '{backupFilePath}' WITH FORMAT, MEDIANAME = 'SqlBackup', NAME = 'Full Backup of {"SimpleLibrary"}';";

            //    // Exécuter la commande SQL pour sauvegarder la base de données
            //    using (SqlConnection connection = new SqlConnection(connectionString))
            //    {
            //        connection.Open();
            //        using (SqlCommand command = new SqlCommand(backupCommand, connection))
            //        {
            //            try
            //            {
            //                command.ExecuteNonQuery();
            //            } catch (System.Exception ex)
            //            {
            //                ex.GetBaseException();
            //                MessageBox.Show(ex.Message,"Error", MessageBoxButton.OK, MessageBoxImage.Err);
            //            }
            //            finally { connection.Close(); }
                        
            //        }
            //    }

            //    MessageBox.Show("Sauvegarde effectuée avec succès.");
            //}
        }
    }
}
