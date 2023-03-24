using System;
using System.Collections.Generic;

namespace DAL.DB;

public partial class ShelfComposition
{
    public int ShelfCompositionId { get; set; }

    public int ShelfId { get; set; }

    public int ThemeId { get; set; }

    public virtual ICollection<Publication> Publications { get; } = new List<Publication>();

    public virtual Shelf Shelf { get; set; } = null!;

    public virtual Theme Theme { get; set; } = null!;
}
