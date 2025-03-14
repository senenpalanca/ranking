import 'dart:convert';

import '../data/models/ranking_item.dart';
import '../data/ranking_repository.dart';

class GetRankingUseCase {
  final RankingRepository _repository;

  GetRankingUseCase(this._repository);

  Future<List<RankingItem>> execute(String prompt) async {
    final responseText = await _repository.getRanking(prompt);
    return _parseResponse(responseText);
  }

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
