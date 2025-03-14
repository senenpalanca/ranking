import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:ranking/features/ranking/data/models/ranking_item.dart';
import 'package:ranking/features/ranking/domain/get_ranking_use_case.dart';
import 'package:ranking/features/ranking/ui/bloc/ranking/ranking_bloc.dart';

class MockGetRankingUseCase extends Mock implements GetRankingUseCase {}

void main() {
  late RankingBloc rankingBloc;
  late MockGetRankingUseCase mockGetRankingUseCase;
  const testPrompt = 'test prompt';

  final List<RankingItem> testItems = [
    RankingItem(
      position: 1,
      title: 'Test Title 1',
      description: 'Test Description 1',
      rating: 5,
    ),
    RankingItem(
      position: 2,
      title: 'Test Title 2',
      description: 'Test Description 2',
      rating: 4,
    ),
  ];

  setUp(() {
    mockGetRankingUseCase = MockGetRankingUseCase();
    rankingBloc = RankingBloc(mockGetRankingUseCase);
  });

  tearDown(() {
    rankingBloc.close();
  });

  group('RankingBloc Tests', () {
    blocTest<RankingBloc, RankingState>(
      'emits [RankingLoading, RankingLoaded] when FetchRankingEvent is added and use case returns data',
      build: () {
        // Stub the execute method to return our testItems
        when(() => mockGetRankingUseCase.execute(testPrompt))
            .thenAnswer((_) async => testItems);
        return rankingBloc;
      },
      act: (bloc) => bloc.add(FetchRankingEvent(testPrompt)),
      expect: () => [
        const RankingLoading(),
        RankingLoaded(testItems),
      ],
      verify: (_) {
        verify(() => mockGetRankingUseCase.execute(testPrompt)).called(1);
      },
    );

    blocTest<RankingBloc, RankingState>(
      'emits [RankingLoading, RankingError] when FetchRankingEvent is added and use case throws error',
      build: () {
        when(() => mockGetRankingUseCase.execute(testPrompt))
            .thenThrow(Exception('API Error'));
        return rankingBloc;
      },
      act: (bloc) => bloc.add(FetchRankingEvent(testPrompt)),
      expect: () => [
        const RankingLoading(),
        isA<RankingError>().having((error) => error.message, 'message', contains('API Error')),
      ],
    );

    blocTest<RankingBloc, RankingState>(
      'emits [RankingInitial] when ClearRankingEvent is added',
      build: () => rankingBloc,
      act: (bloc) => bloc.add(ClearRankingEvent()),
      expect: () => [
        const RankingInitial(),
      ],
    );
  });
}
