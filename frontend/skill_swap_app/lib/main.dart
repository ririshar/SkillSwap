import 'package:flutter/material.dart';
import 'screens/homescreen.dart';

// Starts the Flutter app
void main() {
  runApp(const SkillSwapApp());
}

// Main app widget
class SkillSwapApp extends StatelessWidget {
  const SkillSwapApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // Removes the debug banner from the app
      debugShowCheckedModeBanner: false,

      // Sets the app title
      title: 'SkillSwap',

      // Sets the app theme
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),

      // Loads the first screen of the app
      home: const HomeScreen(),
    );
  }
}
