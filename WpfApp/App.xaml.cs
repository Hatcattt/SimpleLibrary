using System;
using System.Windows;
using System.Windows.Threading;
using WpfApp.Helpers;

namespace WpfApp
{
    /// <summary>
    /// Interaction logic for App.xaml
    /// </summary>
    public partial class App : Application
    {
        protected override void OnStartup(StartupEventArgs e)
        {
            base.OnStartup(e);

            // Gestionnaire d'exceptions global
            DispatcherUnhandledException += AppDispatcherUnhandledException;
        }

        private void AppDispatcherUnhandledException(object sender, DispatcherUnhandledExceptionEventArgs e)
        {
            // Empêche l'application de planter à cause de l'exception
            e.Handled = true;

            // Appel de la méthode de gestion d'exceptions avec l'exception non attrapée
            ExceptionHelper.HandleException(e.Exception, "An unhandled error occurred.");
            Application.Current.Shutdown();
        }

        private void LogException(Exception exception)
        {
            // stringbuilder
            // on récupère la signature de l'application qui est en train de s'excécuter.

        }
    }
}
