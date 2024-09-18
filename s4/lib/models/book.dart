import 'package:flutter/material.dart';

class Book {
  final String title;
  final String author;
  final String imagePath; // Campo para o caminho da imagem

  Book({
    required this.title,
    required this.author,
    required this.imagePath, // Inicialização do caminho da imagem
  });
}
