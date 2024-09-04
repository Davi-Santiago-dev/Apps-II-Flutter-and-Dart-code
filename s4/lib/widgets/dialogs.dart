import 'package:flutter/material.dart';
import '../models/book.dart';

void _showAddBookDialog(BuildContext context, Function(Book) onAddBook) {
  String title = '';
  String author = '';

  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: const Text('Adicionar Novo Livro'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              decoration: const InputDecoration(labelText: 'Título'),
              onChanged: (value) {
                title = value;
              },
            ),
            TextField(
              decoration: const InputDecoration(labelText: 'Autor'),
              onChanged: (value) {
                author = value;
              },
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('Cancelar'),
          ),
          TextButton(
            onPressed: () {
              onAddBook(Book(title: title, author: author));
              Navigator.of(context).pop();
            },
            child: const Text('Adicionar'),
          ),
        ],
      );
    },
  );
}
