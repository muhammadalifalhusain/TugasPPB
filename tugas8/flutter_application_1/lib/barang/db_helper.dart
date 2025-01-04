import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'barang_model.dart';
class DBHelper {
static Database? _database;
static const String tableName = 'barang';
Future<Database> get database async {
if (_database != null) return _database!;
_database = await initDatabase();
return _database!;
}
Future<Database> initDatabase() async {
final dbPath = await getDatabasesPath();
final path = join(dbPath, 'barang.db');
return openDatabase(
path,
version: 1,
onCreate: (db, version) {
return db.execute(
'''

CREATE TABLE $tableName (
id INTEGER PRIMARY KEY AUTOINCREMENT,
kdBrg TEXT NOT NULL,
nmBrg TEXT NOT NULL,
hrgBeli INTEGER NOT NULL,
hrgJual INTEGER NOT NULL,
stok INTEGER NOT NULL
)
''',
);
},
);
}
Future<int> insertBarang(Barang barang) async {
final db = await database;
return db.insert(tableName, barang.toMap());
}
Future<List<Barang>> fetchBarang() async {
final db = await database;
final List<Map<String, dynamic>> maps = await db.query(tableName);
return List.generate(
maps.length,
(i) => Barang.fromMap(maps[i]),
);
}
}