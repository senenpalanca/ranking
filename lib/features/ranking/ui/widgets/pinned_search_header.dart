import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/constants/colors.dart';
import '../../../../core/constants/dimens.dart';
import '../bloc/ranking/ranking_bloc.dart';

// A custom SliverPersistentHeaderDelegate that displays a search header.
/// It contains a TextField and a button whose icon changes according to the [RankingBloc]'s state.
class PinnedSearchHeader extends SliverPersistentHeaderDelegate {
  final TextEditingController textController;
  final FocusNode searchFocusNode;

  PinnedSearchHeader({
    required this.textController,
    required this.searchFocusNode,
  });

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: Dimens.paddingMedium, vertical: Dimens.paddingSmall),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.center,
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
            //TODO: If reusing this widget, consider creating a custom widget for the text field
            child: TextField(
              focusNode: searchFocusNode,
              controller: textController,
              onChanged: (text) {
                // Consider removing or debouncing this event to avoid excessive bloc calls.
                context.read<RankingBloc>().add(ClearRankingEvent());
              },
              onSubmitted: (text) {
                context.read<RankingBloc>().add(FetchRankingEvent(text));
                searchFocusNode.unfocus();
              },
              decoration: InputDecoration(
                hintText: 'Enter your prompt',
                filled: true,
                fillColor: Colors.grey[200],
                contentPadding: const EdgeInsets.symmetric(horizontal: Dimens.paddingMedium, vertical: 12),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
              ),
              style: const TextStyle(color: Colors.black),
            ),
          ),
          const SizedBox(width: Dimens.paddingXSmall),
          BlocBuilder<RankingBloc, RankingState>(
            builder: (context, state) {
              return ElevatedButton(
                onPressed: () {
                  if (state is RankingLoaded || state is RankingError) {
                    textController.clear();
                    context.read<RankingBloc>().add(ClearRankingEvent());
                    searchFocusNode.unfocus();
                  } else {
                    context.read<RankingBloc>().add(FetchRankingEvent(textController.text));
                    searchFocusNode.unfocus();
                  }
                },
                style: ElevatedButton.styleFrom(
                  shape: const CircleBorder(),
                  backgroundColor: Colors.black,
                ),
                child: _buildButtonIcon(state),
              );
            },
          ),
        ],
      ),
    );
  }

  /// Returns the appropriate icon based on the [RankingState].
  Widget _buildButtonIcon(RankingState state) {
    if (state is RankingLoading) {
      return const SizedBox(
        width: 20,
        height: 20,
        child: CircularProgressIndicator(
          color: Colors.white,
          strokeWidth: 2,
        ),
      );
    } else if (state is RankingLoaded || state is RankingError) {
      return const Icon(Icons.close, color: Colors.white);
    }
    return const Icon(Icons.arrow_forward, color: Colors.white);
  }

  @override
  double get minExtent => 60;

  @override
  double get maxExtent => 60;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) => true;
}
