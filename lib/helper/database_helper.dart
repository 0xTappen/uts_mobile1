import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:uts_mobile/models/matakuliah.dart';

const studentNpm = '00000000';
const tableName = 'matakuliah_$studentNpm';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();
  static Database? _database;

  DatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('uts_matakuliah.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);
    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future<void> _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE $tableName (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        kode_matakuliah TEXT,
        nama_matakuliah TEXT,
        sks TEXT,
        jenis_matakuliah TEXT,
        created_at TEXT
      )
    ''');
  }

  Future<List<Matakuliah>> getAll() async {
    final db = await database;
    final maps = await db.query(tableName, orderBy: 'created_at DESC');
    return maps.map((m) => Matakuliah.fromMap(m)).toList();
  }

  Future<int> update(Matakuliah matakuliah) async {
    final db = await database;
    return await db.update(
      tableName,
      matakuliah.toMap(),
      where: 'id = ?',
      whereArgs: [matakuliah.id],
    );
  }

  Future<int> insert(Matakuliah matakuliah) async {
    final db = await database;
    return await db.insert(tableName, matakuliah.toMap());
  }

  Future<int> delete(int id) async {
    final db = await database;
    return await db.delete(tableName, where: 'id = ?', whereArgs: [id]);
  }
}
