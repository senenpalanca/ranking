
import 'package:flutter/material.dart';

class RatingStars extends StatelessWidget {
  final double rating;

  const RatingStars({
    Key? key,
    required this.rating,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(rating.toInt(), (index) {
        return const Icon(
          Icons.star,
          size: 20,
        );
      }),
    );
  }
}
