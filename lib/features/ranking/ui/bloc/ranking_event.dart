part of 'ranking_bloc.dart';

@immutable
abstract class RankingEvent {}

class FetchRankingEvent extends RankingEvent {
  final String prompt;
  FetchRankingEvent(this.prompt);
}