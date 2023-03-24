using System;
using System.Collections.Generic;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Configuration;

namespace DAL.DB;

public partial class SimpleLibraryContext : DbContext
{
    public SimpleLibraryContext()
    {
    }

    public SimpleLibraryContext(DbContextOptions<SimpleLibraryContext> options)
        : base(options)
    {
    }

    public virtual DbSet<Author> Authors { get; set; }

    public virtual DbSet<AuthorPublication> AuthorPublications { get; set; }

    public virtual DbSet<Publication> Publications { get; set; }

    public virtual DbSet<PublicationCopy> PublicationCopies { get; set; }

    public virtual DbSet<Shelf> Shelves { get; set; }

    public virtual DbSet<ShelfComposition> ShelfCompositions { get; set; }

    public virtual DbSet<Theme> Themes { get; set; }

    protected override void OnConfiguring(DbContextOptionsBuilder optionsBuilder)
    {
        if (!optionsBuilder.IsConfigured)
        {
            var config = new ConfigurationBuilder()
                .SetBasePath(Directory.GetCurrentDirectory())
                .AddJsonFile("appsettings.json", true, true)
                .Build();

            optionsBuilder
                .UseLazyLoadingProxies()
                .UseSqlServer(config[$"ConnectionStrings:SimpleLibrary"]);
        }
    }

    protected override void OnModelCreating(ModelBuilder modelBuilder)
    {
        modelBuilder.Entity<Author>(entity =>
        {
            entity.ToTable("Author");

            entity.Property(e => e.AuthorId).HasColumnName("AuthorID");
            entity.Property(e => e.AuthorName).HasMaxLength(50);
            entity.Property(e => e.Nationality).HasMaxLength(3);
        });

        modelBuilder.Entity<AuthorPublication>(entity =>
        {
            entity.ToTable("AuthorPublication");

            entity.Property(e => e.AuthorPublicationId).HasColumnName("AuthorPublicationID");
            entity.Property(e => e.AuthorFunction).HasMaxLength(50);
            entity.Property(e => e.AuthorId).HasColumnName("AuthorID");
            entity.Property(e => e.PublicationId).HasColumnName("PublicationID");

            entity.HasOne(d => d.Author).WithMany(p => p.AuthorPublications)
                .HasForeignKey(d => d.AuthorId)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("FK_AuthorPublication_Author");

            entity.HasOne(d => d.Publication).WithMany(p => p.AuthorPublications)
                .HasForeignKey(d => d.PublicationId)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("FK_AuthorPublication_Publication");
        });

        modelBuilder.Entity<Publication>(entity =>
        {
            entity.ToTable("Publication");

            entity.HasIndex(e => e.Isbn, "IX_Publication").IsUnique();

            entity.HasIndex(e => e.Isbn, "IX_Unique_Publication_ISBN").IsUnique();

            entity.Property(e => e.PublicationId).HasColumnName("PublicationID");
            entity.Property(e => e.CoverFilePath).HasMaxLength(250);
            entity.Property(e => e.Isbn)
                .HasMaxLength(20)
                .HasColumnName("ISBN");
            entity.Property(e => e.Language).HasMaxLength(3);
            entity.Property(e => e.PublishedDate).HasColumnType("date");
            entity.Property(e => e.Publisher).HasMaxLength(100);
            entity.Property(e => e.SubTitle)
                .HasMaxLength(100)
                .IsFixedLength();
            entity.Property(e => e.Title).HasMaxLength(100);

            entity.HasOne(d => d.LocationNavigation).WithMany(p => p.Publications)
                .HasForeignKey(d => d.Location)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("FK_Publication_ShelfComposition");
        });

        modelBuilder.Entity<PublicationCopy>(entity =>
        {
            entity.ToTable("PublicationCopy");

            entity.Property(e => e.PublicationCopyId).HasColumnName("PublicationCopyID");
            entity.Property(e => e.PublicationId).HasColumnName("PublicationID");
            entity.Property(e => e.PublicationState).HasMaxLength(50);

            entity.HasOne(d => d.Publication).WithMany(p => p.PublicationCopies)
                .HasForeignKey(d => d.PublicationId)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("FK_PublicationCopy_Publication");
        });

        modelBuilder.Entity<Shelf>(entity =>
        {
            entity.ToTable("Shelf");

            entity.HasIndex(e => e.ShelfName, "IX_Unique_Shelf").IsUnique();

            entity.Property(e => e.ShelfId).HasColumnName("ShelfID");
            entity.Property(e => e.ShelfName).HasMaxLength(50);
        });

        modelBuilder.Entity<ShelfComposition>(entity =>
        {
            entity.ToTable("ShelfComposition");

            entity.Property(e => e.ShelfCompositionId).HasColumnName("ShelfCompositionID");
            entity.Property(e => e.ShelfId).HasColumnName("ShelfID");
            entity.Property(e => e.ThemeId).HasColumnName("ThemeID");

            entity.HasOne(d => d.Shelf).WithMany(p => p.ShelfCompositions)
                .HasForeignKey(d => d.ShelfId)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("FK_ShelfComposition_Shelf");

            entity.HasOne(d => d.Theme).WithMany(p => p.ShelfCompositions)
                .HasForeignKey(d => d.ThemeId)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("FK_ShelfComposition_Theme");
        });

        modelBuilder.Entity<Theme>(entity =>
        {
            entity.ToTable("Theme");

            entity.HasIndex(e => e.ThemeName, "IX_Unique_Theme").IsUnique();

            entity.Property(e => e.ThemeId).HasColumnName("ThemeID");
            entity.Property(e => e.ThemeName).HasMaxLength(50);
        });

        OnModelCreatingPartial(modelBuilder);
    }

    partial void OnModelCreatingPartial(ModelBuilder modelBuilder);
}
