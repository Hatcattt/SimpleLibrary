using BU.Entities;
using DAL.DB;
using Microsoft.EntityFrameworkCore;
using Microsoft.IdentityModel.Tokens;
using System;
using System.Collections.ObjectModel;
using System.Linq;
using System.Windows;
using System.Windows.Controls;

namespace WpfApp.View.Publication
{
    /// <summary>
    /// Interaction logic for UpdatePublicationView.xaml
    /// </summary>
    public partial class UpdatePublicationView : Window
    {
        /// <summary>
        /// Indicate if this view has saved the datacontext successfully.
        /// </summary>
        public bool HaveSaved { get; set; }
        private readonly ViewModel.PublicationViewModel publicationVM = new();

        public UpdatePublicationView(DAL.DB.Publication publication)
        {
            InitializeComponent();
           
            if (publication == null)
            {
                throw new Common.Exceptions.AppException($"{nameof(publication)} cannot be null!");
            }
            this.publicationVM.PublicationSelected = BU.Services.PublicationService.GetPublication(publication.PublicationId);
            publicationVM.GoodCopies = BU.Services.PublicationService.GetCopiesCount(publicationVM.PublicationSelected, BU.Enums.PublicationState.Readable);
            publicationVM.BadCopies = BU.Services.PublicationService.GetCopiesCount(publicationVM.PublicationSelected, BU.Enums.PublicationState.Unreadable);
            publicationVM.UnknownCopies = BU.Services.PublicationService.GetCopiesCount(publicationVM.PublicationSelected, BU.Enums.PublicationState.Unknown);
            this.cbBoxAuthor.ItemsSource = BU.Services.AuthorService.GetAuthors();
            FunctionCombobox.ItemsSource = CreatePublicationView.Functions;
            foreach (var authorPublication in this.publicationVM.PublicationSelected.AuthorPublications)
            {
                AuthorsLV.Items.Add(authorPublication);
            }
            this.DataContext = this.publicationVM;
            this.ShowDialog();
        }

        private void AddAuthorPublicationInListButton_Click(object sender, RoutedEventArgs e)
        {
            var author = (DAL.DB.Author)cbBoxAuthor.SelectedItem;
            string? authorFunction = FunctionCombobox.SelectedItem == null ? null : FunctionCombobox.SelectedItem.ToString();

            if (author != null)
            {
                var newAuthorPublication = new DAL.DB.AuthorPublication() { Author = author, AuthorFunction = authorFunction };

                if (!AuthorExistsInAuthorListView(newAuthorPublication.Author, newAuthorPublication.AuthorFunction))
                {
                    AuthorsLV.Items.Add(newAuthorPublication);
                    return;
                }
                MessageBox.Show("An author with the same function already exists for this publication.", "Cannot add this author", MessageBoxButton.OK, MessageBoxImage.Information);
            }
        }

        private void RemoveAuthorPublicationFromListButton_Click(object sender, RoutedEventArgs e)
        {
            if (AuthorsLV.SelectedItem == null)
            {
                MessageBox.Show("Selecte on the grid, then delete it.", "Select authorName", MessageBoxButton.OK, MessageBoxImage.Warning);
                return;
            }
            AuthorsLV.Items.Remove(AuthorsLV.SelectedItem);
        }

        private void AuthorsLV_SelectionChanged(object sender, SelectionChangedEventArgs e)
        {
            DAL.DB.AuthorPublication authorPublicationSelected = (DAL.DB.AuthorPublication)AuthorsLV.SelectedItem;
            if (authorPublicationSelected != null)
            {
                FunctionCombobox.SelectedItem = authorPublicationSelected.AuthorFunction;
            }
        }

        private void ChangeAuthorFunctionInListButton_Click(object sender, RoutedEventArgs e)
        {
            DAL.DB.AuthorPublication selectedAuthorPublication = (DAL.DB.AuthorPublication)AuthorsLV.SelectedItem;
            if (selectedAuthorPublication != null)
            {
                string? authorFunction = FunctionCombobox.SelectedItem?.ToString();
                if (AuthorExistsInAuthorListView(selectedAuthorPublication.Author, authorFunction))
                {
                    MessageBox.Show("An author with the same function already exists for this publication.", "Cannot edit this author publication", MessageBoxButton.OK, MessageBoxImage.Information);
                    return;
                }
                selectedAuthorPublication.AuthorFunction = authorFunction;
                AuthorsLV.Items.Refresh();
                return;

            }
            MessageBox.Show("Select an author to change his function.", "Select an author", MessageBoxButton.OK, MessageBoxImage.Information);
        }

        private bool AuthorExistsInAuthorListView(DAL.DB.Author author, string? authorFunction)
        {
            foreach (var item in AuthorsLV.Items)
            {
                var authorInListView = (DAL.DB.AuthorPublication)item;
                if (authorInListView.Author.AuthorName == author.AuthorName && authorInListView.AuthorFunction == authorFunction)
                {
                    return true;
                }
            }
            return false;
        }

        private void UploadUserImageButton_Click(object sender, RoutedEventArgs e)
        {
            MessageBox.Show("This feature has not yet been implemented! Please wait for an update...", "Not implemented", MessageBoxButton.OK, MessageBoxImage.Stop);
            //var imageUploaded = Interfaces.ICoverManagerUpload.UploadImageFromDisk();
            //if (imageUploaded != null)
            //{
            //    CoverImageView.Source = imageUploaded;
            //}
        }

        private void CancelPublicationEditionButton_Click(object sender, RoutedEventArgs e)
        {
            this.Close();
            HaveSaved = false;
        }

        private void SavePublicationChangesButton_Click(object sender, RoutedEventArgs e)
        {
            var publicationEdited = BU.Services.PublicationService.UpdatePublication(publicationVM.PublicationSelected);
            if (publicationEdited.Status == ServiceResultStatus.OK && publicationEdited.Value != null)
            {
                BU.Services.PublicationService.DeleteAuthorPublications(publicationEdited.Value);
                foreach (DAL.DB.AuthorPublication authorPublication in AuthorsLV.Items)
                {
                    BU.Services.PublicationService.AddNewAuthorPublication(publicationEdited.Value, authorPublication.Author, authorPublication.AuthorFunction);
                }
                BU.Services.PublicationService.UpdatePublicationCopies(publicationVM.PublicationSelected, goodCopy.Value, badCopy.Value, unknownCopy.Value);
                HaveSaved = true;
            }
            MessageBox.Show(publicationEdited.Message, "Information about the system", MessageBoxButton.OK, (MessageBoxImage)publicationEdited.ImageBox);
            this.Close();
        }
    }
}
