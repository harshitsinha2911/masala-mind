import 'dart:convert';
import 'package:flutter/material.dart';
import '../services/ai_service.dart';

class RecipeDetailScreen extends StatefulWidget {
  final String recipeName;
  final String userIngredients;

  const RecipeDetailScreen({
    super.key,
    required this.recipeName,
    required this.userIngredients,
  });

  @override
  State<RecipeDetailScreen> createState() =>
      _RecipeDetailScreenState();
}

class _RecipeDetailScreenState
    extends State<RecipeDetailScreen> {

  Map<String, dynamic>? recipeData;
  bool isLoading = true;
  bool isHindi = false;

  @override
  void initState() {
    super.initState();
    loadRecipe();
  }

  Future<void> loadRecipe() async {
    try {
      final result =
          await AIService.generateRecipeDetails(
  widget.recipeName,
  widget.userIngredients,
);
    print("RESPONSE LENGTH = ${result.length}");

      String cleanJson = result
          .replaceAll("```json", "")
          .replaceAll("```", "")
          .trim();

      print("========== CLEAN JSON ==========");
      print(cleanJson);
      print("===============================");

      setState(() {
        recipeData = jsonDecode(cleanJson);
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        recipeData = {
          "error": e.toString(),
        };
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {

    if (isLoading) {
      return Scaffold(
        appBar: AppBar(
          title: Text(widget.recipeName),
        ),
        body: const Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    if (recipeData!.containsKey("error")) {
      return Scaffold(
        appBar: AppBar(
          title: Text(widget.recipeName),
        ),
        body: Center(
          child: Text(
            recipeData!["error"],
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.recipeName),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment:
                CrossAxisAlignment.start,
            children: [

              Text(
                recipeData!["recipe_name"],
                style: const TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 15),

              Text(
                "🍽 Serves: ${recipeData!["serves"]}",
                style: const TextStyle(
                  fontSize: 18,
                ),
              ),

              const SizedBox(height: 8),

              Text(
                "⏱ ${recipeData!["time"]}",
                style: const TextStyle(
                  fontSize: 18,
                ),
              ),

              const SizedBox(height: 8),

              Text(
                "⭐ ${recipeData!["difficulty"]}",
                style: const TextStyle(
                  fontSize: 18,
                ),
              ),

              const SizedBox(height: 25),

              Row(
                children: [

                  const Text(
                    "Language",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const Spacer(),

                  Text(
                    isHindi
                        ? "हिन्दी"
                        : "English",
                  ),

                  Switch(
                    value: isHindi,
                    onChanged: (value) {
                      setState(() {
                        isHindi = value;
                      });
                    },
                  ),
                ],
              ),

              const SizedBox(height: 25),

              const Text(
                "Ingredients",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 10),

              ...List.generate(
                isHindi
                    ? recipeData!["ingredients_hindi"]
                        .length
                    : recipeData![
                            "ingredients_english"]
                        .length,
                (index) => Padding(
                  padding:
                      const EdgeInsets.only(
                    bottom: 8,
                  ),
                  child: Text(
                    "• ${isHindi ? recipeData!["ingredients_hindi"][index] : recipeData!["ingredients_english"][index]}",
                    style: const TextStyle(
                      fontSize: 16,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 30),

              const Text(
                "Steps",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 10),

              ...List.generate(
                isHindi
                    ? recipeData!["hindi_steps"]
                        .length
                    : recipeData!["english_steps"]
                        .length,
                (index) => Padding(
                  padding:
                      const EdgeInsets.only(
                    bottom: 12,
                  ),
                  child: Text(
                    "${index + 1}. ${isHindi ? recipeData!["hindi_steps"][index] : recipeData!["english_steps"][index]}",
                    style: const TextStyle(
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}