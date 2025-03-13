import '../../../core/network/api_client.dart';

class RankingRepository {
  final ApiClient apiClient;

  RankingRepository(this.apiClient);

  Future<String> getRanking(String prompt) async {
    final finalPrompt = """
    You are an expert aggregator. Please respond with a valid JSON array representing a ranking sorted by popularity (most popular first).
    The user prompt is: "$prompt"
    
    Instructions:
    1. Detect the language used in the user's prompt and respond in that same language.
    2. The array must contain less than 1000 items, but try to show at least 10 results, if possible.
    3. Each item should include at least "title" (string) and "description" (string).
    4. If an image is available, include "imageUrl" (string). Otherwise, omit "imageUrl".
    5. If a rating is available, it must be an integer from 1 to 5. Otherwise, omit "rating".
    6. Provide no text outside the JSON array. Do not include backticks or code fences.
    7. Ensure the final output is valid JSON (no trailing commas, no extra keys, no explanations).
    
    Do not include any introductory text, disclaimers, or explanations beyond the valid JSON array.
    """;

    const endpoint = '/v1/chat/completions';
    final requestBody = {
      "model": "gpt-3.5-turbo",
      "messages": [
        {
          "role": "user",
          "content": finalPrompt,
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
