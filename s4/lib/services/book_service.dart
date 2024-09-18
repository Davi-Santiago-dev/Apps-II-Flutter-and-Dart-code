import '../models/book.dart';
import 'book_database.dart';

class BookService {
  Future<void> addBook(Book book) async {
    await BookDatabase.instance.createBook(book);
  }

  Future<void> editBook(int id, Book updatedBook) async {
    await BookDatabase.instance.updateBook(id, updatedBook);
  }

  Future<void> removeBook(int id) async {
    await BookDatabase.instance.deleteBook(id);
  }

  Future<List<Book>> getBooks() async {
    return await BookDatabase.instance.readAllBooks();
  }
}
