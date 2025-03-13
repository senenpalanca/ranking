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

    return [];
  }
}
