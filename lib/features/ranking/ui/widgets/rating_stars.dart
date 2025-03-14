
import 'package:flutter/material.dart';

class RatingStars extends StatelessWidget {
  final double rating;

  const RatingStars({
    Key? key,
    required this.rating,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const int maxStars = 5;
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.end,
      children: List.generate(maxStars, (index) {
        return Icon(
          index < rating ? Icons.star : Icons.star_border,
          size: 20,
          color: index < rating ? Colors.amber : Colors.grey,
        );
      }),
    );
  }

}
