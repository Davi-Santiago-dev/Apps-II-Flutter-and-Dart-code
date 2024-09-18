import 'package:flutter/material.dart';
import '../models/book.dart';
import '../services/book_service.dart'; // Certifique-se de ter um arquivo com este nome e caminho
import '../widgets/book_list_item.dart';
import '../widgets/dialogs.dart'; // Importando o arquivo dialogs

class CatalogPage extends StatefulWidget {
  const CatalogPage({super.key});

  @override
  _CatalogPageState createState() => _CatalogPageState();
}

class _CatalogPageState extends State<CatalogPage> {
  late Future<List<Book>> _booksFuture;
  final BookService _bookService = BookService();

  @override
  void initState() {
    super.initState();
    _refreshBooks(); // Carregar livros ao iniciar
  }

  void _refreshBooks() {
    setState(() {
      _booksFuture = _bookService.getBooks(); // Atualizar lista de livros
    });
  }

  void _addBook(Book book) async {
    await _bookService.addBook(book);
    _refreshBooks();
  }

  void _editBook(int id, Book updatedBook) async {
    await _bookService.editBook(id, updatedBook);
    _refreshBooks();
  }

  void _removeBook(int id) async {
    await _bookService.removeBook(id);
    _refreshBooks();
  }

 void _showEditBookDialog(BuildContext context, Book book) {
    showEditBookDialog(
      context,
      book.id!,
      (id, updatedBook) {
        _editBook(id, updatedBook);
      },
      book,
    );
  }

void _showAddBookDialog(BuildContext context) {
  showAddBookDialog(
    context,
    (book) {
      _addBook(book);
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
              _showAddBookDialog(context);
            },
          ),
        ],
        leading: Builder(
          builder: (context) => IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
          ),
        ),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Color(0xFFE5BA00),
              ),
              child: Text('Catálogo'),
            ),
            ListTile(
              leading: const Icon(Icons.book),
              title: const Text('Livros'),
              onTap: () {
                Navigator.pop(context); // Fechar o Drawer
                // Navegar para a página de Livros (se houver)
              },
            ),
            ListTile(
              leading: const Icon(Icons.bookmark),
              title: const Text('Quadrinhos'),
              onTap: () {
                Navigator.pop(context); // Fechar o Drawer
                // Navegar para a página de Quadrinhos (se houver)
              },
            ),
            ListTile(
              leading: const Icon(Icons.movie),
              title: const Text('Filmes'),
              onTap: () {
                Navigator.pop(context); // Fechar o Drawer
                // Navegar para a página de Filmes (se houver)
              },
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text('Configurações'),
              onTap: () {
                Navigator.pop(context); // Fechar o Drawer
                // Navegar para a página de Configurações
              },
            ),
            ListTile(
              leading: const Icon(Icons.brightness_6),
              title: const Text('Trocar Tema'),
              onTap: () {
                Navigator.pop(context); // Fechar o Drawer
                // Trocar o tema
              },
            ),
          ],
        ),
      ),
      body: FutureBuilder<List<Book>>(
        future: _booksFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Erro: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('Nenhum livro encontrado.'));
          }

          final books = snapshot.data!;

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(8.0),
                color: const Color(0xFF161518),
                child: Text(
                  'Exibindo ${books.length} livros.',
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
                    final book = books[index];
                    return BookListItem(
                      book: book,
                      onEdit: () => _showEditBookDialog(context, book),
                      onRemove: () => _removeBook(book.id!),
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
