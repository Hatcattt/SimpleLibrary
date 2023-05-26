using Microsoft.Extensions.Configuration;
using System;
using System.Text;
using System.Windows;
using System.Windows.Threading;

namespace WpfApp
{
    /// <summary>
    /// Interaction logic for App.xaml
    /// </summary>
    public partial class App : Application
    {
        /// <summary>
        /// Performs on the startup of the application.
        /// </summary>
        /// <param name="e"></param>
        protected override void OnStartup(StartupEventArgs e)
        {
            base.OnStartup(e);

            // Global exception handler
            DispatcherUnhandledException += AppDispatcherUnhandledException;
        }

        /// <summary>
        /// Dispatch the handler exception.
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        private void AppDispatcherUnhandledException(object sender, DispatcherUnhandledExceptionEventArgs e)
        {
            e.Handled = true;

            try
            {
                LogException(e.Exception);
            }
            catch { }

            string errorMessage = $"An erreur occur in the application, and the application crash. See the exceptions Message :\n\n{e.Exception}";
            MessageBox.Show(errorMessage, "Application crash.", MessageBoxButton.OK, MessageBoxImage.Error);
            Application.Current.Shutdown();
        }

        /// <summary>
        /// Log an exeption in a file. The filepath is in appsettings.json [AppSettings->LogFilePath].
        /// </summary>
        /// <param name="ex">The exception handled</param>
        private static void LogException(Exception ex)
        {
            StringBuilder errorMessageSB = new StringBuilder();
            errorMessageSB.Append($"{DateTime.Now}: ");

            string executingAssembly = System.Reflection.Assembly.GetExecutingAssembly().ToString();
            errorMessageSB.Append($"{executingAssembly} - ");

            if (ex != null)
            {
                errorMessageSB.Append($"{ex.ToString()}");
            } else
            {
                errorMessageSB.Append($"Unknown Exception!");
            }

            string message = errorMessageSB.ToString();

            try
            {
                string logFilePath = new ConfigurationBuilder()
                    .AddJsonFile("appsettings.json")
                    .Build()
                    .GetSection("AppSettings")["LogFilePath"] ?? "";

                System.IO.File.AppendAllText(logFilePath, message + Environment.NewLine);
            }
            catch (Exception exe)
            {
                var errorMessage = "Error during the log process." +
                    $"Check if your path is correct in the appsettings.json file [AppSettings->LogFilePath].\nSee the exception message :\n\n {exe}";
                MessageBox.Show(errorMessage, "Log process failed", MessageBoxButton.OK, MessageBoxImage.Information);
            }
        }
    }
}
