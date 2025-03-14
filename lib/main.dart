import 'package:flutter/material.dart';

import 'core/injection/app_dependencies.dart';
import 'features/ranking/ui/screens/ranking_page.dart';

void main() {
  runApp(
    const AppDependencies(
      child: RankingApp(),
    ),
  );
}

class RankingApp extends StatelessWidget {
  const RankingApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'RankingApp',
      home: RankingPage(),
    );
  }
}

