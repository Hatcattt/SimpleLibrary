using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace BU.Entities
{
    /// <summary>
    /// Represent the state of a publication copy.
    /// </summary>
    public enum PublicationState
    {
        Unreadable = -1,
        Readable = 1,
        Unknown = 0
    }
}
