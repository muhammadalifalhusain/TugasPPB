import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'model_kontak.dart';

class DbHelper {
  static final DbHelper _instance = DbHelper._internal();
  static Database? _database;

  // Nama tabel dan kolom-kolomnya
  final String tableName = 'tableKontak';
  final String columnId = 'id';
  final String columnName = 'name';
  final String columnMobileNo = 'mobileNo';
  final String columnEmail = 'email';
  final String columnCompany = 'company';

  DbHelper._internal();

  factory DbHelper() => _instance;

  // Getter database
  Future<Database?> get _db async {
    if (_database != null) return _database;
    _database = await _initDb();
    return _database;
  }

  // Inisialisasi database
  Future<Database?> _initDb() async {
    String databasePath = await getDatabasesPath();
    String path = join(databasePath, 'kontak.db');
    return await openDatabase(path, version: 1, onCreate: _onCreate);
  }

  // Membuat tabel jika belum ada
  Future<void> _onCreate(Database db, int version) async {
    var sql = '''CREATE TABLE $tableName(
      $columnId INTEGER PRIMARY KEY, 
      $columnName TEXT,
      $columnMobileNo TEXT,
      $columnEmail TEXT,
      $columnCompany TEXT
    )''';
    await db.execute(sql);
  }

  // Menyimpan kontak ke database
  Future<int?> saveKontak(Kontak kontak) async {
    var dbClient = await _db;
    return await dbClient!.insert(tableName, kontak.toMap());
  }

  // Mengambil semua kontak
  Future<List?> getAllKontak() async {
    var dbClient = await _db;
    var result = await dbClient!.query(tableName, columns: [
      columnId, columnName, columnMobileNo, columnEmail, columnCompany
    ]);
    return result.toList();
  }

  // Mengupdate kontak
  Future<int?> updateKontak(Kontak kontak) async {
    var dbClient = await _db;
    return await dbClient!.update(
      tableName, kontak.toMap(),
      where: '$columnId = ?', whereArgs: [kontak.id]
    );
  }

  // Menghapus kontak
  Future<int?> deleteKontak(int id) async {
    var dbClient = await _db;
    return await dbClient!.delete(
      tableName, where: '$columnId = ?', whereArgs: [id]
    );
  }
}
