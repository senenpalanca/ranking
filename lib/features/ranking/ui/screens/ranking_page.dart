import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ranking/features/ranking/ui/widgets/empty_box.dart';
import 'package:ranking/features/ranking/ui/widgets/title.dart';

import '../../../../core/constants/colors.dart';
import '../../../../core/constants/dimens.dart';
import '../../domain/get_ranking_use_case.dart';
import '../bloc/ranking/ranking_bloc.dart';
import '../widgets/pinned_search_header.dart';
import '../widgets/ranking_item_card.dart';
import '../widgets/ranking_item_popup.dart';
import '../widgets/shimmer_sliver.dart';


class RankingPage extends StatelessWidget {
  const RankingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) {
        final getRankingUseCase = context.read<GetRankingUseCase>();
        return RankingBloc(getRankingUseCase);
      },
      child: const _RankingView(),
    );
  }
}

class _RankingView extends StatefulWidget {
  const _RankingView({Key? key}) : super(key: key);

  @override
  State<_RankingView> createState() => _RankingViewState();
}

class _RankingViewState extends State<_RankingView> {
  final TextEditingController _promptController = TextEditingController();
  final FocusNode _searchFocusNode = FocusNode();

  final expandedHeight = 170.0;
  final collapsedHeight = 58.0;

  @override
  void dispose() {
    _promptController.dispose();
    _searchFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: AppColors.background,
        child: SafeArea(
          child: CustomScrollView(
            slivers: [
              SliverAppBar(
                pinned: true,
                floating: false,
                scrolledUnderElevation: 0,
                expandedHeight: expandedHeight,
                collapsedHeight: collapsedHeight,
                backgroundColor: AppColors.background,
                flexibleSpace: LayoutBuilder(
                  builder: (context, constraints) {
                    final currentHeight = constraints.biggest.height;
                    double fadeValue = (currentHeight - 80) / (expandedHeight - collapsedHeight);
                    fadeValue = fadeValue.clamp(0.0, 1.0);

                    return FlexibleSpaceBar(
                      titlePadding: const EdgeInsets.only(left: Dimens.paddingMedium, bottom: Dimens.paddingMedium, top: Dimens.paddingMedium),
                      title: RankingTitle(fadeValue: fadeValue),
                      background: Container(
                        color: AppColors.background,
                      ),
                      collapseMode: CollapseMode.pin,
                    );
                  },
                ),
              ),
              SliverPersistentHeader(
                pinned: true,
                delegate: PinnedSearchHeader(
                  textController: _promptController,
                  searchFocusNode: _searchFocusNode,
                ),
              ),
              BlocBuilder<RankingBloc, RankingState>(
                builder: (context, state) {
                  if (state is RankingInitial) {
                    return const SliverFillRemaining(
                      hasScrollBody: false,
                      child: Center(
                        child: EmptyBox()
                      ),
                    );
                  } else if (state is RankingLoading) {
                    return const ShimmerSliver(count: 6);
                  } else if (state is RankingLoaded) {
                    final items = state.items;
                    return SliverList(
                      delegate: SliverChildBuilderDelegate(
                        (context, index) {
                          final item = items[index];
                          return Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal:  Dimens.paddingMedium,
                              vertical:  Dimens.paddingSmall,
                            ),
                            child: TweenAnimationBuilder<double>(
                              duration: const Duration(milliseconds: 500),
                              tween: Tween(begin: 0.0, end: 1.0),
                              builder: (context, value, child) {
                                return Opacity(
                                  opacity: value,
                                  child: RankingItemCard(item: item, onTap: () => _onTapItem(item, context),),
                                );
                              },
                            ),
                          );
                        },
                        childCount: items.length,
                      ),
                    );
                  } else if (state is RankingError) {
                    return SliverFillRemaining(
                      hasScrollBody: false,
                      child: Center(
                        child: Text(
                          'Error: ${state.message}',
                          style: const TextStyle(color: Colors.red),
                        ),
                      ),
                    );
                  } else {
                    return SliverFillRemaining(child: Container());
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }



  void _onTapItem(item, context) {
    showDialog(
      context: context,
      builder: (context) => RankingItemPopup(item: item),
    );
  }
}
