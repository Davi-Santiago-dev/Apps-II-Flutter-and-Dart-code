import 'package:flutter/material.dart';

class Book {
  final int? id; // ID é opcional pois pode ser gerado automaticamente
  final String title;
  final String author;
  final String imagePath;

  Book({
    this.id,
    required this.title,
    required this.author,
    required this.imagePath,
  });

  /// Converte um [Book] para um [Map] para ser salvo no SQLite.
  Map<String, dynamic> toMap() {
    return {
      'id': id, // O ID é incluído no map, mas será null para novos livros
      'title': title,
      'author': author,
      'imagePath': imagePath,
    };
  }

  /// Converte um [Map] para um [Book].
  static Book fromMap(Map<String, dynamic> map) {
    return Book(
      id: map['id'] as int?, // Garante que o ID seja tratado como opcional
      title: map['title'] as String,
      author: map['author'] as String,
      imagePath: map['imagePath'] as String,
    );
  }
}
