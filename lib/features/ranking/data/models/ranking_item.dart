class RankingItem {
  final String title;
  final String description;
  final double? rating;
  final int? position;

  RankingItem({
    required this.title,
    required this.description,
    required this.position,
    this.rating,
  });

  factory RankingItem.fromJson(Map<String, dynamic> json) {
    return RankingItem(
      title: json['title'] as String,
      description: json['description'] as String,
      position: json['position'] as int?,
      rating: (json['rating'] as num?)?.toDouble(),
    );
  }
}
