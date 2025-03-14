import 'package:flutter/material.dart';
import '../../../../core/constants/dimens.dart';

/// A sliver that displays a custom shimmer effect as a placeholder while loading.
/// It generates a list of shimmer containers based on the provided [count].
class ShimmerSliver extends StatefulWidget {
  final int count;

  const ShimmerSliver({Key? key, required this.count}) : super(key: key);

  @override
  ShimmerSliverState createState() => ShimmerSliverState();
}

class ShimmerSliverState extends State<ShimmerSliver>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
            (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: Dimens.paddingMedium,
              vertical: Dimens.paddingSmall,
            ),
            child: AnimatedBuilder(
              animation: _controller,
              builder: (context, child) {
                // Calculate a value between 0.6 and 0.9
                final shimmerValue = 0.6 + (0.3 * _controller.value);
                final colorValue = (shimmerValue * 255).toInt();

                return Container(
                  height: 120,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    gradient: LinearGradient(
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                      colors: [
                        Colors.grey[300]!,
                        Color.fromARGB(255, colorValue, colorValue, colorValue),
                      ],
                    ),
                  ),
                );
              },
            ),
          );
        },
        childCount: widget.count,
      ),
    );
  }
}
