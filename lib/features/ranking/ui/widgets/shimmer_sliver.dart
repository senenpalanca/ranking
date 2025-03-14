import 'package:flutter/material.dart';
import '../../../../core/constants/dimens.dart';

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
                //  Could be used shimmer package as well
                final value = 0.6 + (0.3 * _controller.value);
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
        childCount: widget.count,
      ),
    );
  }
}
