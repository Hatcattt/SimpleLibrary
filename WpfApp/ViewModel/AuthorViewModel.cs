using System;
using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace WpfApp.ViewModel
{
    public class AuthorViewModel : BaseViewModel
    {
        #region Properties
        private DAL.DB.Author? authorSelected;
        public DAL.DB.Author? AuthorSelected
        {
            get { return authorSelected; }
            set
            {
                if (authorSelected != value)
                {
                    authorSelected = value;
                    NotifyPropertyChanged(nameof(AuthorSelected));
                }
            }
        }

        private ObservableCollection<DAL.DB.Author> authors;
        public ObservableCollection<DAL.DB.Author> Authors
        {
            get { return authors; }
            set
            {
                if (authors != value)
                {
                    authors = value;
                    NotifyPropertyChanged(nameof(Authors));
                }
            }
        }

        #endregion

        public AuthorViewModel()
        {
            this.authors = new ObservableCollection<DAL.DB.Author>(BU.Services.AuthorService.GetAuthors());
        }
    }
}
