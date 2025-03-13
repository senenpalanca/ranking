import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../domain/get_ranking_use_case.dart';

part 'ranking_event.dart';
part 'ranking_state.dart';

class RankingBloc extends Bloc<RankingEvent, RankingState> {
  final GetRankingUseCase _getRankingUseCase;

  RankingBloc(this._getRankingUseCase) : super(RankingInitial()) {
    on<FetchRankingEvent>(_onFetchRanking);
  }

  Future<void> _onFetchRanking(
      FetchRankingEvent event,
      Emitter<RankingState> emit,
      ) async {
    emit(RankingLoading());

    try {
      final response = await _getRankingUseCase.execute(event.prompt);

      emit(RankingLoaded(result: response.toString()));
    } catch (e) {
      emit(RankingError('Error fetching ranking: $e'));
    }
  }
}
