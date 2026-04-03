namespace TcgApi.Models;

public enum CardType
{
    Deity,
    Spirit,
    Ceremony,
    Legend,
    Artifact
}

public enum CardRarity
{
    Common,
    Uncommon,
    Rare
}

public class Card
{
    public Guid Id { get; set; }
    public Guid CollectionId { get; set; }
    public string Name { get; set; } = string.Empty;
    public CardType Type { get; set; }
    public CardRarity Rarity { get; set; }
    public int CardNumber { get; set; }
    public string? IllustrationUrl { get; set; }
    public string? FlavorText { get; set; }
    public DateTime CreatedAt { get; set; } = DateTime.UtcNow;

    public Collection Collection { get; set; } = null!;
}
