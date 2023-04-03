using System;
using System.Collections.Generic;

namespace DAL.DB;

public partial class PublicationStateEnum
{
    public int PublicationStateId { get; set; }

    public string PublicationState { get; set; } = null!;

    public virtual ICollection<PublicationCopy> PublicationCopies { get; } = new List<PublicationCopy>();
}
