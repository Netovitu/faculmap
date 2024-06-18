import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  factory DatabaseHelper() => _instance;
  static Database? _database;

  DatabaseHelper._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'qrcode.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE qrcode(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        code TEXT,
        image TEXT
      )
    ''');

    await db.insert('qrcode', {'code': '001', 'image': 'assets/maps/mapa_1.png'});
    await db.insert('qrcode', {'code': '002', 'image': 'assets/maps/mapa_2.png'});
    await db.insert('qrcode', {'code': '003', 'image': 'assets/maps/mapa_3.png'});
  }

  Future<Map<String, dynamic>?> getQRCode(String code) async {
    Database db = await database;
    List<Map<String, dynamic>> results = await db.query('qrcode', where: 'code = ?', whereArgs: [code]);
    if (results.isNotEmpty) {
      return results.first;
    } else {
      return null;
    }
  }
}
