using System;
using System.Collections.Generic;

namespace DAL.DB;

public partial class AuthorPublication
{
    public int AuthorPublicationId { get; set; }

    public int AuthorId { get; set; }

    public int PublicationId { get; set; }

    public string? AuthorFunction { get; set; }

    public virtual Author Author { get; set; } = null!;

    public virtual Publication Publication { get; set; } = null!;
}
