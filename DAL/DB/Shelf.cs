using System;
using System.Collections.Generic;

namespace DAL.DB;

public partial class Shelf
{
    public int ShelfId { get; set; }

    public string ShelfName { get; set; } = null!;

    public virtual ICollection<ShelfComposition> ShelfCompositions { get; } = new List<ShelfComposition>();
}
