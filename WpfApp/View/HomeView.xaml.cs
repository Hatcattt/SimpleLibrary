using System.Windows.Controls;
using WpfApp.ViewModel;
using System.Collections.ObjectModel;

namespace WpfApp.View
{
    /// <summary>
    /// Interaction logic for HomeView.xaml
    /// </summary>
    public partial class HomeView : UserControl
    {
        private const int MAX_VIEW = 15;
        private readonly HomeViewModel homeVM;
        public HomeView()
        {
            InitializeComponent();
            homeVM = new HomeViewModel();
            homeVM.LastPublicationsCreate = new ObservableCollection<DAL.DB.Publication>(BU.Services.TimeStampService.GetLastPublicationsAdded(MAX_VIEW));
            homeVM.LastPublicationsUpdate = new ObservableCollection<DAL.DB.Publication>(BU.Services.TimeStampService.GetLastPublicationsUpdated(MAX_VIEW));
            homeVM.TotalPublication = BU.Services.PublicationService.GetNumberOfPublication();
            this.DataContext = homeVM;
        }
    }
}
