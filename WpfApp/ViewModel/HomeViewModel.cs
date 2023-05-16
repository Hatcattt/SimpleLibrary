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

        #endregion

        public HomeViewModel()
        {
            lastPublicationsCreate = new ObservableCollection<DAL.DB.Publication>();
        }
    }
}
