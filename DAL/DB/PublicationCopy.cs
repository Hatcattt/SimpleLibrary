using System;
using System.Collections.Generic;

namespace DAL.DB;

public partial class PublicationCopy
{
    public int PublicationCopyId { get; set; }

    public int PublicationId { get; set; }

    public int PublicationState { get; set; }

    public virtual Publication Publication { get; set; } = null!;

    public virtual PublicationStateEnum PublicationStateNavigation { get; set; } = null!;
}
