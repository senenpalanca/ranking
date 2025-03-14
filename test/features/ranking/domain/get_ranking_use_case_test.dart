import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:ranking/features/ranking/domain/get_ranking_use_case.dart';
import 'package:ranking/features/ranking/data/ranking_repository.dart';
import 'package:ranking/features/ranking/data/models/ranking_item.dart';

// Create a mock class for RankingRepository.
class MockRankingRepository extends Mock implements RankingRepository {}

void main() {
  late MockRankingRepository mockRepository;
  late GetRankingUseCase useCase;

  setUp(() {
    mockRepository = MockRankingRepository();
    useCase = GetRankingUseCase(mockRepository);
  });

  group('GetRankingUseCase', () {
    test('should return a list of RankingItem when valid JSON array is returned', () async {
      const prompt = 'test prompt';
      const jsonResponse = '''
      [
        {"position": 1, "title": "Item 1", "description": "Description 1", "rating": 5},
        {"position": 2, "title": "Item 2", "description": "Description 2", "rating": 4}
      ]
      ''';
      when(() => mockRepository.getRanking(prompt))
          .thenAnswer((_) async => jsonResponse);

      final result = await useCase.execute(prompt);

      expect(result.length, 2);
      expect(result[0].title, 'Item 1');
      expect(result[0].position, 1);
      expect(result[0].rating, 5);
      expect(result[1].title, 'Item 2');
      expect(result[1].position, 2);
      expect(result[1].rating, 4);
    });

    test('should return an empty list when JSON is not an array', () async {
      const prompt = 'test prompt';
      const jsonResponse = '{"key": "value"}'; // Not an array.
      when(() => mockRepository.getRanking(prompt))
          .thenAnswer((_) async => jsonResponse);

      final result = await useCase.execute(prompt);

      expect(result, isEmpty);
    });

    test('should return an empty list when JSON is malformed', () async {
      const prompt = 'test prompt';
      const jsonResponse = 'invalid json';
      when(() => mockRepository.getRanking(prompt))
          .thenAnswer((_) async => jsonResponse);

      final result = await useCase.execute(prompt);

      expect(result, isEmpty);
    });
  });
}
