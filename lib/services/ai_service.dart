import 'dart:convert';
import 'package:http/http.dart' as http;

class AIService {

  static const String apiKey =
      "YOUR_OPENROUTER_API_KEY";

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

    if (response.statusCode == 200) {

      final data = jsonDecode(response.body);

      final text =
          data["choices"][0]["message"]["content"];

      return text
          .toString()
          .split('\n')
          .where((line) => line.trim().isNotEmpty)
          .map((line) => line.trim())
          .toList();
    }

    throw Exception(
      "Status ${response.statusCode}",
    );
  }

  static Future<String> generateRecipeDetails(
    String recipeName,
    String userIngredients,
) async {

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
        "max_tokens": 1200,
        "messages": [
          {
            "role": "user",
            "content": """
Recipe Name:
$recipeName

User Ingredients:
$userIngredients

Generate a detailed recipe for:

$recipeName

Return ONLY valid JSON.

{
  "recipe_name":"",
  "serves":"",
  "time":"",
  "difficulty":"",
  "ingredients_english":[],
  "ingredients_hindi":[],
  "available_ingredients":[],
  "missing_ingredients":[],
  "english_steps":[],
  "hindi_steps":[]
}

Rules:
- Compare recipe ingredients with user ingredients.
- Put matching ingredients in available_ingredients.
- Put remaining ingredients in missing_ingredients.
- Return ONLY JSON.
- No markdown.
- No explanation.
- Maximum 8 ingredients.
- Maximum 6 steps.

IMPORTANT:

Generate recipes suitable for Indian households.

Use commonly available Indian ingredients.

Avoid:
- canned tomatoes
- chicken broth
- celery
- parsley
- cilantro
- exotic western ingredients

Prefer:
- fresh tomatoes
- onions
- ginger
- garlic
- green chilli
- Indian masalas
- curd
- cream
- butter
- ghee
- coriander

Recipes should feel like something an Indian family would cook at home.
"""
          }
        ]
      }),
    );

    if (response.statusCode == 200) {

  final data = jsonDecode(response.body);

  print("========== RAW RESPONSE ==========");
  print(data["choices"][0]["message"]["content"]);
  print("==================================");

  return data["choices"][0]
         ["message"]["content"]
         .toString();
}

    throw Exception(
      "Status ${response.statusCode}",
    );
  }
}