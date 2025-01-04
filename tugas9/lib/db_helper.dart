import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static Database? _database;
  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }
  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'products.db');
    return openDatabase(
      path,
      onCreate: (db, version) async {
        await db.execute(''' 
          CREATE TABLE products(
            id INTEGER PRIMARY KEY,
            name TEXT,
            category TEXT,
            price REAL,
            description TEXT,
            image TEXT
          )
        ''');
      },
      version: 1,
    );
  }
  Future<void> insertDefaultProducts() async {
    final db = await database;
    var result = await db.query('products');
    if (result.isNotEmpty) return; 
    await db.insert('products', {
      'name': 'RuangTamu',
      'price': 23000000,
      'description': 'Nikmati waktu berkualitas bersama orang terkasih di Sofa Keluarga Nyaman kami. Didesain dengan kenyamanan maksimal, sofa ini dilengkapi dengan bantalan empuk dan bahan berkualitas yang tahan lama. Dengan desain modern yang stylish dan pilihan warna yang beragam, sofa ini akan menjadi elemen kunci dalam menciptakan atmosfer hangat di ruang keluarga Anda. ',
      'image': 'assets/images/foto1.jpg',
    });
    await db.insert('products', {
      'name': 'RuangKeluarga',
      'price': 15000000,
      'description': 'Nikmati waktu berkualitas bersama orang terkasih di Sofa Keluarga Nyaman kami. Didesain dengan kenyamanan maksimal, sofa ini dilengkapi dengan bantalan empuk dan bahan berkualitas yang tahan lama. Dengan desain modern yang stylish dan pilihan warna yang beragam, sofa ini akan menjadi elemen kunci dalam menciptakan atmosfer hangat di ruang keluarga Anda. ',
      'image': 'assets/images/foto2.jpg',
    });
    await db.insert('products', {
      'name': 'RuangSantai',
      'price': 18000000,
      'description': 'Nikmati waktu berkualitas bersama orang terkasih di Sofa Keluarga Nyaman kami. Didesain dengan kenyamanan maksimal, sofa ini dilengkapi dengan bantalan empuk dan bahan berkualitas yang tahan lama. Dengan desain modern yang stylish dan pilihan warna yang beragam, sofa ini akan menjadi elemen kunci dalam menciptakan atmosfer hangat di ruang keluarga Anda. ',
      'image': 'assets/images/foto3.jpg',
    });
    await db.insert('products', {
      'name': 'RuangTV',
      'price': 10000000,
      'description': 'Nikmati waktu berkualitas bersama orang terkasih di Sofa Keluarga Nyaman kami. Didesain dengan kenyamanan maksimal, sofa ini dilengkapi dengan bantalan empuk dan bahan berkualitas yang tahan lama. Dengan desain modern yang stylish dan pilihan warna yang beragam, sofa ini akan menjadi elemen kunci dalam menciptakan atmosfer hangat di ruang keluarga Anda. ',
      'image': 'assets/images/foto4.jpg',
    });
    await db.insert('products', {
      'name': 'KursiKekinian',
      'price': 10000000,
      'description': 'Nikmati waktu berkualitas bersama orang terkasih di Sofa Keluarga Nyaman kami. Didesain dengan kenyamanan maksimal, sofa ini dilengkapi dengan bantalan empuk dan bahan berkualitas yang tahan lama. Dengan desain modern yang stylish dan pilihan warna yang beragam, sofa ini akan menjadi elemen kunci dalam menciptakan atmosfer hangat di ruang keluarga Anda. ',
      'image': 'assets/images/foto5.jpg',
    });
    await db.insert('products', {
      'name': 'RuangKumpul',
      'price': 30000000,
      'description': 'Nikmati waktu berkualitas bersama orang terkasih di Sofa Keluarga Nyaman kami. Didesain dengan kenyamanan maksimal, sofa ini dilengkapi dengan bantalan empuk dan bahan berkualitas yang tahan lama. Dengan desain modern yang stylish dan pilihan warna yang beragam, sofa ini akan menjadi elemen kunci dalam menciptakan atmosfer hangat di ruang keluarga Anda. ',
      'image': 'assets/images/foto6.jpg',
    });
  }
  Future<void> insertProduct(Map<String, dynamic> product) async {
    final db = await database;
    await db.insert(
      'products',
      product,
      conflictAlgorithm: ConflictAlgorithm.replace, // Replace the existing entry if there is a conflict
    );
  }
  Future<List<Map<String, dynamic>>> getAllProducts() async {
    final db = await database;
    return await db.query('products');
  }
  Future<void> updateProduct(Map<String, dynamic> product) async {
    final db = await database;
    await db.update(
      'products',
      product,
      where: 'id = ?',
      whereArgs: [product['id']],
    );
  }
  Future<void> deleteProduct(int id) async {
    final db = await database;
    await db.delete(
      'products',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
