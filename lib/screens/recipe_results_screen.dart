import 'package:flutter/material.dart';

class RecipeResultsScreen extends StatelessWidget {

  final String ingredients;

  const RecipeResultsScreen({
    super.key,
    required this.ingredients,
  });

  @override
  Widget build(BuildContext context) {

    final recipes = [
      "Paneer Bhurji",
      "Kadai Paneer",
      "Paneer Masala",
      "Paneer Stir Fry",
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text("Suggested Recipes"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
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

            Text(ingredients),

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
                      title:
                          Text(recipes[index]),
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