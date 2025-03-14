part of 'ranking_bloc.dart';


abstract class RankingState extends Equatable {
  const RankingState();

  @override
  List<Object?> get props => [];
}

class RankingInitial extends RankingState {
  const RankingInitial();
}

class RankingLoading extends RankingState {
  const RankingLoading();
}

class RankingLoaded extends RankingState {
  final List<RankingItem> items;
  const RankingLoaded(this.items);

  @override
  List<Object?> get props => [items];
}

class RankingError extends RankingState {
  final String message;
  const RankingError(this.message);

  @override
  List<Object?> get props => [message];
}

