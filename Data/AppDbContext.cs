using Microsoft.EntityFrameworkCore;
using TcgApi.Models;

namespace TcgApi.Data;

public class AppDbContext(DbContextOptions<AppDbContext> options) : DbContext(options)
{
    public DbSet<User> Users { get; set; } = null!;
    public DbSet<WaitlistEntry> WaitlistEntries { get; set; } = null!;
    public DbSet<Collection> Collections { get; set; } = null!;
    public DbSet<Card> Cards { get; set; } = null!;

    protected override void OnModelCreating(ModelBuilder modelBuilder)
    {
        modelBuilder.Entity<User>()
            .HasIndex(u => u.GoogleId)
            .IsUnique();

        modelBuilder.Entity<User>()
            .HasIndex(u => u.Email)
            .IsUnique();

        modelBuilder.Entity<WaitlistEntry>()
            .HasIndex(w => w.Email)
            .IsUnique();

        modelBuilder.HasPostgresEnum<CardType>();
        modelBuilder.HasPostgresEnum<CardRarity>();

        modelBuilder.Entity<Collection>()
            .ToTable("collections")
            .Property(c => c.Id).HasDefaultValueSql("gen_random_uuid()");

        modelBuilder.Entity<Card>()
            .ToTable("cards")
            .Property(c => c.Id).HasDefaultValueSql("gen_random_uuid()");

        modelBuilder.Entity<Card>()
            .HasIndex(c => c.CollectionId);

        modelBuilder.Entity<Card>()
            .HasIndex(c => c.Rarity);

        modelBuilder.Entity<Card>()
            .HasIndex(c => new { c.CollectionId, c.CardNumber })
            .IsUnique();

        modelBuilder.Entity<Card>()
            .HasOne(c => c.Collection)
            .WithMany(col => col.Cards)
            .HasForeignKey(c => c.CollectionId)
            .OnDelete(DeleteBehavior.Cascade);
    }
}
