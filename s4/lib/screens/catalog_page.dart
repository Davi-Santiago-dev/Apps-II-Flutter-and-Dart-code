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
    Book(title: 'Blue Lock Vol 7', author: 'Muneyuki Kaneshiro'),
    Book(title: 'Quincas Borba', author: 'Machado de Assis'),
    Book(title: 'Feliz Ano Velho', author: 'Marcelo Rubens Paiva'),
  ];

  // Função para adicionar um novo livro
  void _addBook(Book book) {
    setState(() {
      books.add(book);
    });
    // Aqui você pode adicionar o código para salvar no banco de dados
  }

  // Função para editar um livro existente
  void _editBook(int index, Book updatedBook) {
    setState(() {
      books[index] = updatedBook;
    });
    // Aqui você pode adicionar o código para atualizar o banco de dados
  }

  // Função para remover um livro
  void _removeBook(int index) {
    setState(() {
      books.removeAt(index);
    });
    // Aqui você pode adicionar o código para remover do banco de dados
  }

  // Método para exibir o diálogo de edição de livro
  void _showEditBookDialog(BuildContext context, int index, Function(int, Book) onEditBook) {
    Book book = books[index];
    
    // Controladores de Texto para inicializar os campos com os valores atuais do livro
    TextEditingController titleController = TextEditingController(text: book.title);
    TextEditingController authorController = TextEditingController(text: book.author);

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
                onEditBook(index, Book(title: titleController.text, author: authorController.text));
                Navigator.of(context).pop();
              },
              child: const Text('Salvar'),
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
          // Barra fina com a quantidade de livros
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(8.0),
            color: const Color(0xFF161518),
            child: Text(
              'Exibindo ${books.length} livros, quadrinhos, filmes e jogos.',
              style: const TextStyle(color: Colors.white),
            ),
          ),
          // Corpo principal da página
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

class _showAddBookDialog {
  _showAddBookDialog(BuildContext context, void Function(Book book) addBook);
}

