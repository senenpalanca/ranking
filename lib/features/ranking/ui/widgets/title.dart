import 'package:flutter/material.dart';

import '../../../../core/constants/dimens.dart';

/// RankingTitle is a StatelessWidget that displays the title and subtitle of the ranking page.
/// Also, it fades the subtitle based on the fadeValue.
class RankingTitle extends StatelessWidget {
  final double fadeValue;
  const RankingTitle({super.key, required this.fadeValue});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const NeverScrollableScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          const Text(
            'AI Ranking',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: Dimens.paddingXSmall),
          Opacity(
            opacity: fadeValue,
            child: Text(
              'Ranking of prompts generated by AI',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w300,
                color: Colors.grey[600],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
