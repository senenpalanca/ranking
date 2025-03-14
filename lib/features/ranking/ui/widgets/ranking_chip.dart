import 'package:flutter/material.dart';
import 'package:ranking/core/constants/colors.dart';

import '../../../../core/constants/dimens.dart';

/// RankingChip is a StatelessWidget that displays a chip with the ranking position and changes color based on the position.
class RankingChip extends StatelessWidget {
  final int position;

  const RankingChip({Key? key, required this.position}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String label;
    Color borderColor;
    Color textColor;

    switch (position) {
      case 1:
        label = '1st';
        borderColor = AppColors.gold;
        textColor = borderColor;
        break;
      case 2:
        label = '2nd';
        borderColor =  AppColors.silver;
        textColor = borderColor;
        break;
      case 3:
        label = '3rd';
        borderColor =  AppColors.bronze;
        textColor = borderColor;
        break;
      default:
        label = '$position° ';
        borderColor = Colors.grey;
        textColor = Colors.grey;
    }

    return Container(
        decoration:  BoxDecoration(
          border: Border.all(color: borderColor),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: Dimens.paddingSmall, vertical:  Dimens.paddingXXSmall),
          child: Text(
            label,
            style: TextStyle(
              color: textColor,
              fontWeight: FontWeight.bold,
            ),
          ),
        )
    )
    ;
  }
}