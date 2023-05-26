using Microsoft.Win32;
using System;
using System.Windows.Media.Imaging;
using System.Windows.Media;
using System.Windows;

namespace WpfApp.Interfaces
{
    /// <summary>
    /// Provide an unique default static method to upload an image from disk.
    /// </summary>
    public class ICoverManager
    {
        /// <summary>
        /// Open a file dialog that user can upload his image.
        /// </summary>
        /// <returns>Une new image source if success operation, othewise return null.</returns>
        public static ImageSource? UploadImageFromDisk()
        {
            OpenFileDialog fileDialog = new()
            {
                Title = "Select a source",
                Filter = "JPEG (*.jpg;*.jpeg)|*.jpg;*.jpeg;",
                InitialDirectory = BU.Entities.CoverConstants.COVER_MAIN_FOLDER,
            };

            if (fileDialog.ShowDialog() == true)
            {
                try
                {
                    BitmapImage image = new BitmapImage();

                    image.BeginInit();
                    image.UriSource = new Uri(fileDialog.FileName, UriKind.Relative);
                    image.EndInit();

                    if (image.PixelHeight <= BU.Entities.CoverConstants.IMAGE_MAX_SIZE && image.PixelWidth <= BU.Entities.CoverConstants.IMAGE_MAX_SIZE)
                    {
                        return image;
                    }
                    MessageBox.Show(
                        $"Please, choose an smaller image source (MAX : {BU.Entities.CoverConstants.IMAGE_MAX_SIZE}px / {BU.Entities.CoverConstants.IMAGE_MAX_SIZE}px)", 
                        "Wrong image size", 
                        MessageBoxButton.OK, 
                        MessageBoxImage.Information);
                }
                catch (Exception ex)
                {
                    MessageBox.Show(
                        $"An error occur with your image!\n\n{ex.Message}", 
                        "Error durring proccess.", 
                        MessageBoxButton.OK, 
                        MessageBoxImage.Error);
                }
            }
            return null;
        }
    }
}
