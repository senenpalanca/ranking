import 'dart:convert';

import '../data/models/ranking_item.dart';
import '../data/ranking_repository.dart';

/// A use case that retrieves a ranking from the repository and parses it into a list of [RankingItem].
class GetRankingUseCase {
  final RankingRepository _repository;

  GetRankingUseCase(this._repository);

  /// Retrieves a ranking from the repository and returns a list of [RankingItem].
  Future<List<RankingItem>> execute(String prompt) async {
    final responseText = await _repository.getRanking(prompt);
    return _parseResponse(responseText);
  }

  /// Parses the response text into a list of [RankingItem].
  List<RankingItem> _parseResponse(String responseText) {
    try {
      final decoded = json.decode(responseText);

      if (decoded is List) {
        return decoded.map((item) => RankingItem.fromJson(item as Map<String, dynamic>)).toList();
      } else {
        return [];
      }
    } catch (e) {
      return [];
    }
  }
}
