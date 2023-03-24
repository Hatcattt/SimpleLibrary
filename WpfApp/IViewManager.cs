using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Controls;

namespace WpfApp
{
    /// <summary>
    /// Interface qui reprend les méthodes permettant de gérer le positionnement des vues dans l'application.
    /// Cette interface doit être implémentée par la fenêtre principale et utilisée par les différentes vues 
    /// de l'application.
    /// </summary>
    public interface IViewManager
    {
        /// <summary>
        /// Positionne la vue passée en paramètre comme vue courante
        /// </summary>
        /// <param name="currentView"></param>
        public void SetCurrentView(UserControl currentView);

        /// <summary>
        /// Positionne une des vues principales de l'application
        /// </summary>
        /// <param name="currentAppView"></param>
        public void SetCurrentView(Enums.AppView currentAppView);
    }
}
