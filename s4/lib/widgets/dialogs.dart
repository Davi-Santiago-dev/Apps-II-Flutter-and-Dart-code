import 'package:flutter/material.dart';
import '../models/book.dart';

void _showAddBookDialog(BuildContext context, Function(Book) onAddBook) {
  String title = '';
  String author = '';
  String imagePath = ''; // Corrigido para imagePath

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
            TextField(
              decoration: const InputDecoration(labelText: 'Caminho da Imagem'),
              onChanged: (value) {
                imagePath = value; // Corrigido para imagePath
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
              if (title.isNotEmpty && author.isNotEmpty && imagePath.isNotEmpty) {
                onAddBook(Book(
                  title: title,
                  author: author,
                  imagePath: imagePath, // Corrigido para imagePath
                ));
                Navigator.of(context).pop();
              } else {
                // Mostrar um alerta se algum campo estiver vazio
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Por favor, preencha todos os campos')),
                );
              }
            },
            child: const Text('Adicionar'),
          ),
        ],
      );
    },
  );
}
