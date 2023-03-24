using System;
using System.Collections.Generic;

namespace DAL.DB;

public partial class Author
{
    public int AuthorId { get; set; }

    public string AuthorName { get; set; } = null!;

    public string? Nationality { get; set; }

    public virtual ICollection<AuthorPublication> AuthorPublications { get; } = new List<AuthorPublication>();
}
