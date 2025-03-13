class RankingItem {
  final String title;
  final String description;
  final String? imageUrl;
  final double? rating;

  RankingItem({
    required this.title,
    required this.description,
    this.imageUrl,
    this.rating,
  });

  factory RankingItem.fromJson(Map<String, dynamic> json) {
    return RankingItem(
      title: json['title'] as String,
      description: json['description'] as String,
      imageUrl: json['imageUrl'] as String?,
      rating: (json['rating'] as num?)?.toDouble(),
    );
  }
}
