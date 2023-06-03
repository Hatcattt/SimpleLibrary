using System.Windows;
using System.Configuration;
using Microsoft.Extensions.Configuration;

namespace WpfApp
{
    /// <summary>
    /// Pop up a about window to see some details of this application.
    /// </summary>
    public partial class AboutWindow : Window
    {
        string? appVersion = new ConfigurationBuilder()
                    .AddJsonFile("appsettings.json")
                    .Build()
                    .GetSection("AppSettings")["AppVersion"];
        public AboutWindow()
        {
            InitializeComponent();
            AppVersion.Text = appVersion;
            this.ShowDialog();
        }

        private void CloseButton_Click(object sender, RoutedEventArgs e)
        {
            this.Close();
        }
    }
}
