import 'package:flutter/material.dart';
import 'ingredient_input_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("MasalaMind"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            const Icon(
              Icons.restaurant_menu,
              size: 100,
              color: Colors.orange,
            ),

            const SizedBox(height: 20),

            const Text(
              "Understand Your Kitchen.\nCook Smarter.",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 50),

            SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton(
                onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const IngredientInputScreen(),
                    ),
            );
     },
                child: const Text(
                  "Enter Ingredients",
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ),

            const SizedBox(height: 15),

            SizedBox(
              width: double.infinity,
              height: 55,
              child: OutlinedButton(
                onPressed: () {
                    Navigator.push(
                     context,
                    MaterialPageRoute(
                        builder: (context) => const IngredientInputScreen(),
               ),
        );
    },
                child: const Text(
                  "Scan Ingredients",
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}