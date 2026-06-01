import 'package:flutter/material.dart';
import 'recipe_results_screen.dart';

class IngredientInputScreen extends StatefulWidget {
  const IngredientInputScreen({super.key});

  @override
  State<IngredientInputScreen> createState() =>
      _IngredientInputScreenState();
}

class _IngredientInputScreenState
    extends State<IngredientInputScreen> {

  final TextEditingController controller =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Enter Ingredients"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [

            TextField(
              controller: controller,
              maxLines: 5,
              decoration: const InputDecoration(
                hintText:
                    "Example:\nPaneer\nOnion\nTomato",
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 20),

            SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton(
                onPressed: () {

  if (controller.text.trim().isEmpty) {

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text(
          "Please enter at least one ingredient",
        ),
      ),
    );

    return;
  }

  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) =>
          RecipeResultsScreen(
        ingredients: controller.text,
      ),
    ),
  );
},
                child: const Text(
                  "Suggest Recipes",
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}