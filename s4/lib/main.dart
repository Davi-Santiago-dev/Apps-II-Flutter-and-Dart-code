import 'package:flutter/material.dart';
import 'screens/catalog_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: const Color(0xFFE5BA00),
        brightness: Brightness.dark, // Ajusta o tema para modo escuro
        scaffoldBackgroundColor: const Color(0xFF242226),
        appBarTheme: AppBarTheme(
          backgroundColor: const Color(0xFFE5BA00),
          iconTheme: const IconThemeData(color: Colors.black),
        ),
        textTheme: const TextTheme(
          bodyLarge: TextStyle(color: Colors.white),
          bodyMedium: TextStyle(color: Colors.white70),
        ),
      ),
      home: const CatalogPage(),
    );
  }
}
