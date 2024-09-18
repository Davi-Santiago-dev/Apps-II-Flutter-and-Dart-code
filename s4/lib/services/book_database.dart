import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/book.dart';

class BookDatabase {
  static final BookDatabase instance = BookDatabase._init();

  static Database? _database;

  BookDatabase._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('books.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);
    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future<void> _createDB(Database db, int version) async {
    const idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    const textType = 'TEXT NOT NULL';

    await db.execute('''
      CREATE TABLE books (
        id $idType,
        title $textType,
        author $textType,
        imagePath $textType
      )
    ''');
  }

  Future<void> createBook(Book book) async {
    final db = await instance.database;
    await db.insert('books', book.toMap());
  }

  Future<List<Book>> readAllBooks() async {
    final db = await instance.database;
    final maps = await db.query('books');

    return List.generate(maps.length, (i) {
      return Book(
        title: maps[i]['title'] as String,
        author: maps[i]['author'] as String,
        imagePath: maps[i]['imagePath'] as String,
      );
    });
  }

  Future<void> updateBook(int id, Book book) async {
    final db = await instance.database;
    await db.update(
      'books',
      book.toMap(),
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<void> deleteBook(int id) async {
    final db = await instance.database;
    await db.delete(
      'books',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
