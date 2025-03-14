import 'package:flutter/material.dart';
import 'package:ranking/features/ranking/ui/widgets/ranking_chip.dart';
import '../../../../core/constants/dimens.dart';
import '../../data/models/ranking_item.dart';
import 'rating_stars.dart';

class RankingItemPopup extends StatelessWidget {
  final RankingItem item;

  const RankingItemPopup({Key? key, required this.item}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: const EdgeInsets.all(20),
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: IntrinsicHeight(
        child: Container(
          constraints: BoxConstraints(
            maxHeight: MediaQuery.of(context).size.height * 0.8,
          ),
          padding: const EdgeInsets.all(Dimens.paddingMedium),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  RankingChip(position: item.position!),
                  IconButton(
                    icon: const Icon(Icons.close, color: Colors.black),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                ],
              ),
              const SizedBox(height: Dimens.paddingSmall),
              Text(
                item.title,
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: Dimens.paddingSmall),
              Expanded(
                child: SingleChildScrollView(
                  child: Text(
                    item.description,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Colors.grey[800],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: Dimens.paddingSmall),
              if (item.rating != null) RatingStars(rating: item.rating!),
              const SizedBox(height: Dimens.paddingSmall),
        
            ],
          ),
        ),
      ),
    );
  }
}
