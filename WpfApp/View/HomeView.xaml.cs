using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Data;
using System.Windows.Documents;
using System.Windows.Input;
using System.Windows.Media;
using System.Windows.Media.Imaging;
using System.Windows.Navigation;
using System.Windows.Shapes;
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
            inputFilter.Text = minPublicationDisplay.ToString();
            homeVM.LastPublicationsCreate = new ObservableCollection<DAL.DB.Publication>(BU.Services.TimeStampService.GetLastPublicationsAdded(minPublicationDisplay));
            this.DataContext = homeVM;
        }

        private void inputFilter_TextChanged(object sender, TextChangedEventArgs e)
        {
            int number = 0;

            if (int.TryParse(inputFilter.Text, out number))
            {
                number = int.Parse(inputFilter.Text);
                if (number >= minPublicationDisplay && number <= maxPublicationDisplay)
                {
                    homeVM.LastPublicationsCreate = new ObservableCollection<DAL.DB.Publication>(BU.Services.TimeStampService.GetLastPublicationsAdded(number));
                }
            }
        }
    }
}
