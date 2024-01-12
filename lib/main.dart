import 'package:cooking_recipe_app/presentation/jsap/creation_devis_screen.dart';
import 'package:flutter/material.dart';
import 'package:cooking_recipe_app/injection_container.dart';

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
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
          titleTextStyle: TextStyle(
              color: Colors.black, fontSize: 25, fontWeight: FontWeight.w500),
          elevation: 0,
          iconTheme: IconThemeData(
            color: Color(0xffAB5F1C),
          ),
        ),

        scaffoldBackgroundColor: const Color(0xffF5F5F5),

        elevatedButtonTheme: const ElevatedButtonThemeData(
          style: ButtonStyle(
            backgroundColor: MaterialStatePropertyAll(
              Color(0xffAB5F1C),
            ),
          ),
        ),
        // colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFFA95050)),
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.black, background: const Color(0xffF5F5F5), ),
        // colorSchemeSeed: Colors.black,
        useMaterial3: false,
      ),
      // home: const JsapHomeScreen(),
      home: const CreationDevisScreen(),
      // home: const HomeScreen(),
    );
  }
}
