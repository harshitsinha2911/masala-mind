import 'package:flutter/material.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(const MasalaMindApp());
}

class MasalaMindApp extends StatelessWidget {
  const MasalaMindApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'MasalaMind',
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),
      home: const HomeScreen(),
    );
  }
}