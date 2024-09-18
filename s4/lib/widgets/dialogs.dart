import 'package:flutter/material.dart';
import '../models/book.dart';

void showAddBookDialog(BuildContext context, Function(Book) onAddBook) {
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

void showEditBookDialog(BuildContext context, int index, Function(int, Book) onEditBook, Book book) {
  TextEditingController titleController = TextEditingController(text: book.title);
  TextEditingController authorController = TextEditingController(text: book.author);
  TextEditingController imageController = TextEditingController(text: book.imagePath);

  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: const Text('Editar Livro'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              decoration: const InputDecoration(labelText: 'Título'),
              controller: titleController,
            ),
            TextField(
              decoration: const InputDecoration(labelText: 'Autor'),
              controller: authorController,
            ),
            TextField(
              decoration: const InputDecoration(labelText: 'Caminho da Imagem'),
              controller: imageController,
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
              if (titleController.text.isNotEmpty && authorController.text.isNotEmpty && imageController.text.isNotEmpty) {
                onEditBook(index, Book(
                  title: titleController.text,
                  author: authorController.text,
                  imagePath: imageController.text,
                ));
                Navigator.of(context).pop();
              } else {
                // Mostrar um alerta se algum campo estiver vazio
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Por favor, preencha todos os campos')),
                );
              }
            },
            child: const Text('Salvar'),
          ),
        ],
      );
    },
  );
}
