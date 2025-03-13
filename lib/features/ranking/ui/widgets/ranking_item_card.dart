import 'package:flutter/material.dart';
import '../../data/models/ranking_item.dart';
import 'rating_stars.dart';

class RankingItemCard extends StatelessWidget {
  final RankingItem item;

  const RankingItemCard({
    Key? key,
    required this.item,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              item.title,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 8),

            Text(
              item.description,
              style: Theme.of(context).textTheme.bodyMedium,
            ),

            if (item.imageUrl != null) ...[
              const SizedBox(height: 12),
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(
                  item.imageUrl!,
                  errorBuilder: (ctx, _, __) => const Icon(Icons.broken_image),
                ),
              ),
            ],

            if (item.rating != null) ...[
              const SizedBox(height: 12),
              RatingStars(rating: item.rating!),
            ],
          ],
        ),
      ),
    );
  }
}
