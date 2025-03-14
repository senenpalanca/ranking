
import 'package:flutter/material.dart';

import '../../../../core/constants/dimens.dart';

class ShimmerSliver extends StatelessWidget {
  final int count;
  const ShimmerSliver({Key? key, required this.count}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
            (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: Dimens.paddingMedium, vertical: Dimens.paddingSmall),
            child: TweenAnimationBuilder<double>(
              duration: const Duration(milliseconds: 1000),
              tween: Tween(begin: 0.6, end: 0.9),
              curve: Curves.easeInOut,
              builder: (context, value, child) {
                final colorValue = (value * 255).toInt();
                return Container(
                  height: 120,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    gradient: LinearGradient(
                      colors: [
                        Colors.grey[300]!,
                        Color.fromARGB(255, colorValue, colorValue, colorValue),
                      ],
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                    ),
                  ),
                );
              },
            ),
          );
        },
        childCount: count,
      ),
    );
  }
}
