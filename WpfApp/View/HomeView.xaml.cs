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
        private readonly HomeViewModel homeVM;
        private readonly static int minPublicationDisplay = 5;
        private readonly static int maxPublicationDisplay = 15;
        public HomeView()
        {
            InitializeComponent();
            homeVM = new HomeViewModel();
            homeVM.LastPublicationsCreate = new ObservableCollection<DAL.DB.Publication>(BU.Services.TimeStampService.GetLastPublicationsAdded(maxPublicationDisplay));
            this.DataContext = homeVM;
        }
    }
}
