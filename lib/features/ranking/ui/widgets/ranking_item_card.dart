import 'package:flutter/material.dart';
import '../../../../core/constants/dimens.dart';
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
      elevation: 1,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: const BorderSide(
          color: Colors.grey,
          width: 0.5,
        ),
      ),
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(Dimens.paddingMedium),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(right: Dimens.paddingMedium),
              child: Text(
                item.position.toString(),
                style: Theme.of(context).textTheme.displayLarge!.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.title,
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      color: Colors.black,
                    ),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                  const SizedBox(height: Dimens.paddingSmall),
                  Text(
                    item.description,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Colors.grey,
                    ),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                  ),
                  const SizedBox(height: Dimens.paddingSmall),
                  if (item.rating != null)
                    RatingStars(rating: item.rating!),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
