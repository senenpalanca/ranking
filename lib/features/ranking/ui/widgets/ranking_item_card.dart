import 'package:flutter/material.dart';
import 'package:ranking/features/ranking/ui/widgets/ranking_chip.dart';
import '../../../../core/constants/dimens.dart';
import '../../data/models/ranking_item.dart';
import 'rating_stars.dart';

/// A card widget that displays a ranking item with a title, a truncated description,
/// an optional rating, and an outlined chip indicating its position.
///
/// When tapped, the [onTap] callback is invoked.
class RankingItemCard extends StatelessWidget {
  final RankingItem item;
  final VoidCallback? onTap;

  const RankingItemCard({
    Key? key,
    required this.item,
    this.onTap,
  }) : super(key: key);

  /// Builds the header row containing the ranking chip and title.
  Widget _buildHeader(BuildContext context) {
    return Row(
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
    );
  }

  /// Builds the description text.
  Widget _buildDescription(BuildContext context) {
    return Text(
      item.description,
      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
        color: Colors.grey,
      ),
      overflow: TextOverflow.ellipsis,
      maxLines: 2,
    );
  }

  /// Builds the rating widget if a rating exists.
  Widget _buildRating(BuildContext context) {
    if (item.rating != null) {
      return Column(
        children: [
          const SizedBox(height: Dimens.paddingSmall),
          RatingStars(rating: item.rating!),
        ],
      );
    }
    return const SizedBox.shrink();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
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
            _buildHeader(context),
            const SizedBox(height: Dimens.paddingSmall),
            _buildDescription(context),
            _buildRating(context),
          ],
        ),
      ),
    );
  }
}
