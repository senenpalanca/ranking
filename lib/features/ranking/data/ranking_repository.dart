import 'dart:convert';

import '../../../core/network/api_client.dart';

/// A repository for fetching ranking data using the OpenAI API.
class RankingRepository {
  final ApiClient apiClient;

  RankingRepository(this.apiClient);

  /// Fetches a ranking from the OpenAI API with the given [prompt].
  ///
  /// It returns a JSON inside a string representing a ranking sorted by popularity (most popular first).
  Future<String> getRanking(String prompt) async {
    final finalPrompt = """
    You are an expert aggregator. Please respond with a valid JSON array representing a ranking sorted by popularity (most popular first).
    The user prompt is: "$prompt"
    
    Instructions:
    1. Detect the language used in the user's prompt and respond in that same language. This is very important.
    2. The array must contain less than 100 items.
    3. Each item should include at least "title" (string), "description" (string),  "position" (int) and "rating" (int).
    4. If a rating is available, it must be an integer from 1 to 5.
    5. Provide no text outside the JSON array. Do not include backticks or code fences.
    6. Ensure the final output is valid JSON (no trailing commas, no extra keys, no explanations).
    7. Please, the JSON content should be in the user's prompt language, and all the entries of the JSON have to be in the same language.
    8. Try to add as much information as possible inside description field.
    9. If the user's prompt specifies a number (e.g., '30'), the JSON array must contain exactly that number of items.
    Do not include any introductory text, disclaimers, or explanations beyond the valid JSON array. 
    
    The items must be sorted by popularity (most popular first) and the 'position' field must reflect this order starting from 1 and increasing sequentially.
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
      "max_tokens": 3000
    };

    final responseData = await apiClient.post(endpoint, requestBody);
    // For OpenAI, `choices[0].message.content` holds the main text output.
    final content = responseData['choices'][0]['message']['content'];
    return utf8.decode(content.codeUnits);
  }
}
