import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

class DatabaseHelper {
  static Database? _database;

  // Membuat instance database
  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDatabase();
    return _database!;
  }

  // Inisialisasi database
  Future<Database> _initDatabase() async {
    final directory = await getApplicationDocumentsDirectory();
    String path = join(directory.path, 'products.db');

    return openDatabase(
      path,
      onCreate: (db, version) async {
        // Membuat tabel produk
        await db.execute('''
          CREATE TABLE products(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            name TEXT,
            category TEXT,
            price REAL,
            image TEXT
          )
        ''');
      },
      version: 1,
    );
  }

  // Menambahkan produk ke database
  Future<void> insertProduct(Map<String, dynamic> product) async {
    final db = await database;
    await db.insert(
      'products',
      product,
      conflictAlgorithm: ConflictAlgorithm.replace, // Replace jika data sudah ada
    );
  }

  // Mengambil semua data produk
  Future<List<Map<String, dynamic>>> getAllProducts() async {
    final db = await database;
    return await db.query('products');
  }
}
