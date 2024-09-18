import 'package:flutter/material.dart';
import '../models/book.dart';
import '../widgets/book_list_item.dart';

class CatalogPage extends StatefulWidget {
  const CatalogPage({super.key});

  @override
  _CatalogPageState createState() => _CatalogPageState();
}

class _CatalogPageState extends State<CatalogPage> {
  final List<Book> books = [
    Book(title: 'Blue Lock Vol 7', author: 'Muneyuki Kaneshiro', imagePath: 'lib/src/assets/images/blue_lock_vol_7.jpg'),
    Book(title: 'Quincas Borba', author: 'Machado de Assis', imagePath: 'lib/src/assets/images/quincas_borba.jpg'),
    Book(title: 'Feliz Ano Velho', author: 'Marcelo Rubens Paiva', imagePath: 'lib/src/assets/images/feliz_ano_velho.jpg'),
  ];

  void _addBook(Book book) {
    setState(() {
      books.add(book);
    });
  }

  void _editBook(int index, Book updatedBook) {
    setState(() {
      books[index] = updatedBook;
    });
  }

  void _removeBook(int index) {
    setState(() {
      books.removeAt(index);
    });
  }

  void _showEditBookDialog(BuildContext context, int index, Function(int, Book) onEditBook) {
    Book book = books[index];
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
                onEditBook(index, Book(
                  title: titleController.text,
                  author: authorController.text,
                  imagePath: imageController.text,
                ));
                Navigator.of(context).pop();
              },
              child: const Text('Salvar'),
            ),
          ],
        );
      },
    );
  }

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
                onAddBook(Book(title: title, author: author, imagePath: imagePath));
                Navigator.of(context).pop();
              },
              child: const Text('Adicionar'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF242226),
      appBar: AppBar(
        backgroundColor: const Color(0xFFE5BA00),
        title: const Text('Catálogo Geral'),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              // Ação para pesquisa
            },
          ),
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              _showAddBookDialog(context, _addBook);
            },
          ),
        ],
        leading: IconButton(
          icon: const Icon(Icons.menu),
          onPressed: () {
            // Ação para abrir o menu
          },
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(8.0),
            color: const Color(0xFF161518),
            child: Text(
              'Exibindo ${books.length} livros, quadrinhos, filmes e jogos.',
              style: const TextStyle(color: Colors.white),
            ),
          ),
          Expanded(
            child: ListView.separated(
              itemCount: books.length,
              separatorBuilder: (context, index) => const Divider(
                color: Color(0xFF484848),
              ),
              itemBuilder: (context, index) {
                return BookListItem(
                  book: books[index],
                  onEdit: () => _showEditBookDialog(context, index, _editBook),
                  onRemove: () => _removeBook(index),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
