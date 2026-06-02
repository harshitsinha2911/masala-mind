import 'package:flutter/material.dart';
import '../services/ai_service.dart';
import 'recipe_detail_screen.dart';

class RecipeResultsScreen extends StatefulWidget {
  final String ingredients;

  const RecipeResultsScreen({
    super.key,
    required this.ingredients,
  });

  @override
  State<RecipeResultsScreen> createState() =>
      _RecipeResultsScreenState();
}

class _RecipeResultsScreenState
    extends State<RecipeResultsScreen> {

  List<String> recipes = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchRecipes();
  }

  Future<void> fetchRecipes() async {
    try {

      final result =
          await AIService.generateRecipes(
        widget.ingredients,
      );

      setState(() {
        recipes = result;
        isLoading = false;
      });

    } catch (e) {

      setState(() {
        isLoading = false;
      });

      ScaffoldMessenger.of(context)
          .showSnackBar(
        SnackBar(
          content: Text(
            e.toString(),
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Suggested Recipes",
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: isLoading

            ? const Center(
                child:
                    CircularProgressIndicator(),
              )

            : Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start,
                children: [

                  Text(
                    "Ingredients:",
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge,
                  ),

                  const SizedBox(height: 10),

                  Text(widget.ingredients),

                  const SizedBox(height: 30),

                  Text(
                    "Recipes",
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge,
                  ),

                  const SizedBox(height: 10),

                  Expanded(
                    child: ListView.builder(
                      itemCount: recipes.length,
                      itemBuilder:
                          (context, index) {

                        return Card(
  child: ListTile(
    leading: const Icon(
      Icons.restaurant,
    ),

    title: Text(
      recipes[index],
    ),

    trailing: const Icon(
      Icons.arrow_forward_ios,
    ),

    onTap: () {

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) =>
              RecipeDetailScreen(
                recipeName: recipes[index],
                userIngredients: widget.ingredients,
          ),
        ),
      );
    },
  ),
);
                      },
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}