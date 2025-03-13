import 'package:flutter/material.dart';

import 'package:flutter/material.dart';

import 'core/injection/app_dependencies.dart';
import 'features/ranking/ui/screens/ranking_page.dart';

void main() {
  runApp(
    const AppDependencies(
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(

        primarySwatch: Colors.blue,
      ),
      home: const RankingPage(),
    );
  }
}

