using System;
using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace WpfApp.ViewModel
{
    public class HomeViewModel : BaseViewModel
    {
        #region Propreties

        private ObservableCollection<DAL.DB.Publication> lastPublicationsCreate;
        public ObservableCollection<DAL.DB.Publication> LastPublicationsCreate
        {
            get { return lastPublicationsCreate; }
            set
            {
                if (lastPublicationsCreate != value)
                {
                    lastPublicationsCreate = value;
                    NotifyPropertyChanged(nameof(LastPublicationsCreate));
                }
            }
        }

        private ObservableCollection<DAL.DB.Publication> lastPublicationsUpdate;
        public ObservableCollection<DAL.DB.Publication> LastPublicationsUpdate
        {
            get { return lastPublicationsUpdate; }
            set
            {
                if (lastPublicationsUpdate != value)
                {
                    lastPublicationsUpdate = value;
                    NotifyPropertyChanged(nameof(LastPublicationsUpdate));
                }
            }
        }

        private int totalPublication;
        public int TotalPublication
        {
            get { return totalPublication; }
            set
            {
                if (totalPublication != value)
                {
                    totalPublication = value;
                    NotifyPropertyChanged(nameof(TotalPublication));
                }
            }
        }

        #endregion

        public HomeViewModel()
        {
            lastPublicationsCreate = new ObservableCollection<DAL.DB.Publication>();
        }
    }
}
