part of 'ranking_bloc.dart';

abstract class RankingState {}

class RankingInitial extends RankingState {}

class RankingLoading extends RankingState {}

class RankingLoaded extends RankingState {
  final String result;

  RankingLoaded({required this.result});
}

class RankingError extends RankingState {
  final String message;
  RankingError(this.message);
}