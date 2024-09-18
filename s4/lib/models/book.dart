import 'package:flutter/material.dart';

class Book {
  final int? id;
  final String title;
  final String author;
  final String imagePath;

  Book({
    this.id,
    required this.title,
    required this.author,
    required this.imagePath,
  });

  // Converte um Book para um Map para ser salvo no SQLite
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'author': author,
      'imagePath': imagePath,
    };
  }

  // Converte um Map para um Book
  static Book fromMap(Map<String, dynamic> map) {
    return Book(
      id: map['id'],
      title: map['title'],
      author: map['author'],
      imagePath: map['imagePath'],
    );
  }
}
