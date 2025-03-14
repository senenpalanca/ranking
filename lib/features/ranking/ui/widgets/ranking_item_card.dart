import 'package:flutter/material.dart';
import 'package:ranking/features/ranking/ui/widgets/ranking_chip.dart';
import '../../../../core/constants/dimens.dart';
import '../../data/models/ranking_item.dart';
import 'rating_stars.dart';

class RankingItemCard extends StatefulWidget {
  final RankingItem item;

  const RankingItemCard({
    Key? key,
    required this.item,
  }) : super(key: key);

  @override
  _RankingItemCardState createState() => _RankingItemCardState();
}

class _RankingItemCardState extends State<RankingItemCard> {
  bool isExpanded = false;

  void _toggleExpand() {
    setState(() {
      isExpanded = !isExpanded;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _toggleExpand,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 100),
        curve: Curves.easeInOut,
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
                if(widget.item.position != null) Padding(
                  padding: const EdgeInsets.only(right: Dimens.paddingSmall),
                  child: RankingChip(position: widget.item.position!),
                ),

                Expanded(
                  child: Text(
                    widget.item.title,
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
            AnimatedCrossFade(
              firstChild: Text(
                widget.item.description,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Colors.grey,
                ),
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
              ),
              secondChild: Text(
                widget.item.description,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Colors.grey[800],
                ),
              ),
              crossFadeState: isExpanded
                  ? CrossFadeState.showSecond
                  : CrossFadeState.showFirst,
              duration: const Duration(milliseconds: 300),
            ),
            if (widget.item.rating != null) ...[
              const SizedBox(height: Dimens.paddingSmall),
              RatingStars(rating: widget.item.rating!),
            ],
          ],
        ),
      ),
    );
  }
}


