using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows;

namespace WpfApp.Helpers
{
    public static class ExceptionHelper
    {
        public static void HandleException(Exception ex, string message)
        {
            // Log de l'exception
            LogException(ex, message);

            if (ex.InnerException != null)
            {
                MessageBox.Show(message + "\n\n" + ex.InnerException.Message, "Error", MessageBoxButton.OK, MessageBoxImage.Error);
            } else
            {
                MessageBox.Show(message + "\n\n" + ex.Message, "Error", MessageBoxButton.OK, MessageBoxImage.Error);
            }
            // Affichage du message d'erreur dans une MessageBox
            
        }

        private static void LogException(Exception ex, string message)
        {
            // Code pour enregistrer l'exception dans un fichier de logs
        }
    }
}
