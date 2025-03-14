import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/constants/colors.dart';
import '../bloc/ranking/ranking_bloc.dart';

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
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
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
            child: TextField(
              focusNode: searchFocusNode,
              controller: textController,
              onChanged: (text) {
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
          BlocBuilder<RankingBloc, RankingState>(
            builder: (context, state) {
              Widget childIcon;
              if (state is RankingLoading) {
                childIcon = const SizedBox(
                  width: 24,
                  height: 24,
                  child: CircularProgressIndicator(
                    color: Colors.white,
                    strokeWidth: 2,
                  ),
                );
              } else if (state is RankingLoaded || state is RankingError) {
                childIcon = const Icon(Icons.close, color: Colors.white);
              } else {
                childIcon = const Icon(Icons.arrow_forward, color: Colors.white);
              }
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
                child: childIcon,
              );
            },
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
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) => true;
}
