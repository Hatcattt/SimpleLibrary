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

namespace WpfApp.Controls
{
    /// <summary>
    /// This control is a integer counter. User can add one or retreive one.
    /// </summary>
    public partial class CounterControl : UserControl
    {
        /// <summary>
        /// The value to asign.
        /// </summary>
        public int Value
        {
            get { return (int)GetValue(ValueProperty); }
            set { SetValue(ValueProperty, value); }
        }

        /// <summary>
        /// Register the value as a proprety.
        /// </summary>
        public static readonly DependencyProperty ValueProperty =
            DependencyProperty.Register("Value", typeof(int), typeof(CounterControl), new PropertyMetadata(0));

        /// <summary>
        /// The header of the groupBox
        /// </summary>
        public string GroupBoxHeader
        {
            get { return (string)GetValue(ValueProperty); }
            set { SetValue(ValueProperty, value); }
        }

        public static readonly DependencyProperty HeaderProperty =
            DependencyProperty.Register("GroupBoxHeader", typeof(string), typeof(CounterControl), new PropertyMetadata(null));

        public CounterControl()
        {
            InitializeComponent();
        }

        private void AddOne(object sender, RoutedEventArgs e)
        {
            if (Value < int.MaxValue)
            {
                Value++;
            }
        }

        private void RemoveOne(object sender, RoutedEventArgs e)
        {
            if (Value > 0)
            {
                Value--;
            }
        }

        private void ResetCounter(object sender, RoutedEventArgs e)
        {
            Value = 0;
        }
    }
}
