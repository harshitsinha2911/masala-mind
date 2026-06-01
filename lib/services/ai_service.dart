import 'dart:convert';
import 'package:http/http.dart' as http;

class AIService {

  static const String apiKey =
      "YOUR_API_KEY_HERE";

  static Future<List<String>> generateRecipes(
      String ingredients) async {

    final response = await http.post(
      Uri.parse(
        "https://openrouter.ai/api/v1/chat/completions",
      ),
      headers: {
        "Authorization": "Bearer $apiKey",
        "Content-Type": "application/json",
      },
      body: jsonEncode({
        "model": "google/gemma-3n-e4b-it",
        "messages": [
          {
            "role": "user",
            "content": """
You are an Indian cooking assistant.

Available ingredients:
$ingredients

Suggest exactly 5 Indian recipes.

Rules:
- Return only recipe names.
- One recipe per line.
- No numbering.
- No explanations.
"""
          }
        ]
      }),
    );

    print(response.body);

    if (response.statusCode == 200) {

      final data = jsonDecode(response.body);

      final text =
    data["choices"][0]["message"]["content"];

print("========== GEMMA RESPONSE ==========");
print(text);
print("TYPE:");
print(text.runtimeType);
print("====================================");

return text
    .toString()
    .split('\n')
    .where((line) => line.trim().isNotEmpty)
    .map((line) => line.trim())
    .toList();
    }

    throw Exception(
      "Status ${response.statusCode}: ${response.body}",
    );
  }
}