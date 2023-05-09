using System.Windows;

namespace WpfApp
{
    public class AppConstant
    {
        public const double APP_WINDOWS_SIZE_MIN_WIDTH = 380;
        public const string APP_TITLE = "SimpleLibrary";
        public const string APP_VERSION = "1.0 - [ IN PROGRESS ]";

        public class Notification
        {
            public string title;
            public string message;

            public static void Display_Info(string message, string title)
            {
                MessageBox.Show(message, title, MessageBoxButton.OK, MessageBoxImage.Information);

            }

            public static void Display_Error(string message, string title)
            {
                MessageBox.Show(message, title, MessageBoxButton.OK, MessageBoxImage.Error);
            }
        }
    }
}
