import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  
  static final DatabaseHelper _instance = DatabaseHelper._();
  static Database? _database;

  DatabaseHelper._();

  factory DatabaseHelper() => _instance;

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await initDatabase();
    return _database!;
  }

  Future<Database> initDatabase() async {
    final String databasesPath = await getDatabasesPath();
    final String path = join(databasesPath, 'phone_database.db');

    return await openDatabase(path, version: 1, onCreate: _createDatabase);
  }

  Future<void> _createDatabase(Database db, int version) async {
    await db.execute('''
      CREATE TABLE phone (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        number TEXT
      )
    ''');
  }

  Future<int> insertPhoneNumber(String phoneNumber) async {
    final db = await database;
    final Map<String, dynamic> data = {'number': phoneNumber};
    return await db.insert('phone', data);
  }
}
