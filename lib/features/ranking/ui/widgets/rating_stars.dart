import 'package:flutter/material.dart';

/// A widget that displays a row of rating stars.
///
/// The widget shows [maxStars] icons, filling with [filledColor] the ones
/// corresponding to the [rating] value (using [Icons.star]) and leaving the
/// remaining icons outlined (using [Icons.star_border]) with [unfilledColor].
class RatingStars extends StatelessWidget {
  final double rating;
  final int maxStars;
  final double starSize;
  final Color filledColor;
  final Color unfilledColor;

  const RatingStars({
    Key? key,
    required this.rating,
    this.maxStars = 5,
    this.starSize = 20.0,
    this.filledColor = Colors.amber,
    this.unfilledColor = Colors.grey,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.end,
      children: List.generate(maxStars, (index) {
        return Icon(
          index < rating ? Icons.star : Icons.star_border,
          size: starSize,
          color: index < rating ? filledColor : unfilledColor,
        );
      }),
    );
  }
}
