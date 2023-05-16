using System;
using System.Collections.Generic;

namespace DAL.DB;

public partial class Publication
{
    public int PublicationId { get; set; }

    public string Isbn { get; set; } = null!;

    public string Title { get; set; } = null!;

    public string? SubTitle { get; set; }

    public int Location { get; set; }

    public string? LetterRow { get; set; }

    public string Publisher { get; set; } = null!;

    public DateTime? PublishedDate { get; set; }

    public string? Language { get; set; }

    public short? NumberOfPages { get; set; }

    public string? Description { get; set; }

    public string? CoverFilePath { get; set; }

    public DateTime? CreateAt { get; set; }

    public DateTime? UpdateAt { get; set; }

    public virtual ICollection<AuthorPublication> AuthorPublications { get; } = new List<AuthorPublication>();

    public virtual ShelfComposition LocationNavigation { get; set; } = null!;

    public virtual ICollection<PublicationCopy> PublicationCopies { get; } = new List<PublicationCopy>();
}
