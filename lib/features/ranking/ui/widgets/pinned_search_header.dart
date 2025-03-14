import 'package:flutter/material.dart';

import '../../../../core/constants/colors.dart';

class PinnedSearchHeader extends SliverPersistentHeaderDelegate {
  final VoidCallback onSearch;
  final TextEditingController textController;

  PinnedSearchHeader({
    required this.onSearch,
    required this.textController,
  });

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      padding: const EdgeInsets.only(left: 18, top: 8, bottom: 8, right: 8),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin:  Alignment.center,
          end: Alignment.bottomCenter,
          colors: [
            AppColors.background,
            AppColors.background,
            Colors.white24,
          ],
        ),

      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: textController,
              onSubmitted: (_) => onSearch(),
              decoration: InputDecoration(
                hintText: 'Enter your prompt',
                filled: true,
                fillColor: Colors.grey[200],
                contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
              ),
              style: const TextStyle(color: Colors.black),
            ),
          ),
          const SizedBox(width: 4),
          ElevatedButton(
            onPressed: onSearch,
            style: ElevatedButton.styleFrom(
              shape: const CircleBorder(),
              backgroundColor: Colors.black
            ),
            child: const Icon(
              Icons.arrow_forward,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );

  }

  @override
  double get minExtent => 60;
  @override
  double get maxExtent => 60;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return false;
  }
}
