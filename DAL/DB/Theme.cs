using System;
using System.Collections.Generic;

namespace DAL.DB;

public partial class Theme
{
    public int ThemeId { get; set; }

    public string ThemeName { get; set; } = null!;

    public virtual ICollection<ShelfComposition> ShelfCompositions { get; } = new List<ShelfComposition>();
}
