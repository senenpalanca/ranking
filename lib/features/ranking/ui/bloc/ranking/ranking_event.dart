part of 'ranking_bloc.dart';

abstract class RankingEvent {}

class FetchRankingEvent extends RankingEvent {
  final String prompt;
  FetchRankingEvent(this.prompt);
}

class ClearRankingEvent extends RankingEvent {}
