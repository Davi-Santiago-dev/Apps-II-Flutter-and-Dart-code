import 'package:flutter/material.dart';
import '../models/book.dart';

class BookListItem extends StatelessWidget {
  final Book book;
  final VoidCallback onEdit;
  final VoidCallback onRemove;

  const BookListItem({
    super.key,
    required this.book,
    required this.onEdit,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    print(book.imagePath);
    return ListTile(
      leading: AspectRatio(
        aspectRatio: 0.9, // Proporção de 90% (largura) em relação à altura
        child: book.imagePath.isNotEmpty
            ? Image.asset(
                book.imagePath.replaceAll('\\', '/'),
              )
            : Container(
                color: Colors.grey[100],
                child: const Icon(Icons.book, color: Colors.grey),
              ),
      ),
      title: Text(
        book.title,
        style: const TextStyle(color: Colors.white),
      ),
      subtitle: Text(
        book.author,
        style: const TextStyle(color: Colors.white70),
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            icon: const Icon(Icons.edit, color: Colors.white),
            onPressed: onEdit,
          ),
          IconButton(
            icon: const Icon(Icons.delete, color: Colors.red),
            onPressed: onRemove,
          ),
        ],
      ),
    );
  }
}
