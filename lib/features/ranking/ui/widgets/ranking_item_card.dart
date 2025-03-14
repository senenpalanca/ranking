import 'package:flutter/material.dart';
import 'package:ranking/features/ranking/ui/widgets/ranking_chip.dart';
import '../../../../core/constants/dimens.dart';
import '../../data/models/ranking_item.dart';
import 'rating_stars.dart';

class RankingItemCard extends StatelessWidget {
  final RankingItem item;
  final VoidCallback? onTap;

  const RankingItemCard({
    Key? key,
    required this.item,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(Dimens.paddingMedium),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.grey, width: 0.5),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (item.position != null)
                  Padding(
                    padding: const EdgeInsets.only(right: Dimens.paddingSmall),
                    child: RankingChip(position: item.position!),
                  ),
                Expanded(
                  child: Text(
                    item.title,
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          color: Colors.black,
                        ),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                ),
              ],
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
            if (item.rating != null) ...[
              const SizedBox(height: Dimens.paddingSmall),
              RatingStars(rating: item.rating!),
            ],
          ],
        ),
      ),
    );
  }
}
