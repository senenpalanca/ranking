import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/models/ranking_item.dart';
import '../../../domain/get_ranking_use_case.dart';

part 'ranking_event.dart';
part 'ranking_state.dart';

class RankingBloc extends Bloc<RankingEvent, RankingState> {
  final GetRankingUseCase _getRankingUseCase;
  String _currentQuery = '';

  RankingBloc(this._getRankingUseCase) : super(RankingInitial()) {
    on<FetchRankingEvent>(_onFetchRanking);
    on<ClearRankingEvent>(_onClearRanking);
  }

  Future<void> _onClearRanking(
      ClearRankingEvent event,
      Emitter<RankingState> emit,
      ) async {
    _currentQuery = '';
    emit(RankingInitial());
  }

  Future<void> _onFetchRanking(
      FetchRankingEvent event,
      Emitter<RankingState> emit,
      ) async {
    _currentQuery = event.prompt;
    emit(RankingLoading());

    try {
      final items = await _getRankingUseCase.execute(event.prompt);
      if (_currentQuery == event.prompt) {
        emit(RankingLoaded(items));
      } else {
      }
    } catch (e) {
      if (_currentQuery == event.prompt) {
        emit(RankingError('Error fetching ranking: $e'));
      }
    }
  }
}
