import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../features/ranking/data/ranking_repository.dart';
import '../../features/ranking/domain/get_ranking_use_case.dart';
import '../constants/constants.dart';
import '../network/api_client.dart';

/// AppDependencies is a StatelessWidget that provides the app dependencies by using the Provider package.
class AppDependencies extends StatelessWidget {
  final Widget child;

  const AppDependencies({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final apiClient = ApiClient(
      baseUrl: 'https://api.openai.com',
      apiKey: openAIApiKey,
    );

    final rankingRepository = RankingRepository(apiClient);

    final getRankingUseCase = GetRankingUseCase(rankingRepository);

    return MultiProvider(
      providers: [
        Provider<RankingRepository>.value(value: rankingRepository),
        Provider<GetRankingUseCase>.value(value: getRankingUseCase),
      ],
      child: child,
    );
  }
}
