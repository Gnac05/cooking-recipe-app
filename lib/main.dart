import 'package:cooking_recipe_app/presentation/screen/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:cooking_recipe_app/config/di.dart';

void main() {
  setup();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white.withOpacity(0.955),
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFFA95050)),
        useMaterial3: true,
      ),
      home: const HomeScreen(),
    );
  }
}
