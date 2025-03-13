import '../../../core/network/api_client.dart';

class RankingRepository {
  final ApiClient apiClient;

  RankingRepository(this.apiClient);

  Future<String> getRanking(String prompt) async {
    const endpoint = '/v1/chat/completions';
    final requestBody = {
      "model": "gpt-3.5-turbo",
      "messages": [
        {
          "role": "user",
          "content": prompt,
        }
      ],
      "max_tokens": 300
    };

    final responseData = await apiClient.post(endpoint, requestBody);
    // For OpenAI, `choices[0].message.content` holds the main text output.
    final content = responseData['choices'][0]['message']['content'];
    return content;
  }
}
