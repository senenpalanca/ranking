import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/constants/dimens.dart';
import '../../domain/get_ranking_use_case.dart';
import '../bloc/ranking_bloc.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ranking Demo'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(Dimens.paddingMedium),
        child: Column(
          children: [
            TextField(
              controller: _promptController,
              decoration: const InputDecoration(
                labelText: 'Enter your prompt',
              ),
            ),
            const SizedBox(height: Dimens.paddingMedium),
            ElevatedButton(
              onPressed: () {
                final prompt = _promptController.text.trim();
                if (prompt.isNotEmpty) {
                  // Dispatch an event to the bloc
                  context.read<RankingBloc>().add(FetchRankingEvent(prompt));
                }
              },
              child: const Text('Fetch Ranking'),
            ),
            const SizedBox(height: Dimens.paddingMedium),
            Expanded(
              child: BlocBuilder<RankingBloc, RankingState>(
                builder: (context, state) {
                  if (state is RankingInitial) {
                    return const Text('Enter a prompt to get ranking.');
                  } else if (state is RankingLoading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is RankingLoaded) {
                    return SingleChildScrollView(
                      child: Text(state.result),
                    );
                  } else if (state is RankingError) {
                    return Text(
                      state.message,
                      style: const TextStyle(color: Colors.red),
                    );
                  }
                  return const SizedBox();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
