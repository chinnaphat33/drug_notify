import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final _databaseName = 'drug_notify.db';

  DatabaseHelper._privateConstructor();

  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  _initDatabase() async {
    String path = join(await getDatabasesPath(), _databaseName);
    return await openDatabase(path, version: 1, onCreate: _onCreate);
  }

Future _onCreate(Database db, int version) async {
  await _createCategoriesTable(db);
  await _createMedicationsTable(db);
  await _createUnitTable(db);
  await _createUserTable(db); // สร้างตาราง d_user ก่อน
  await _createMedicationScheduleTable(db);

  // เพิ่มคอลัมน์ age หลังจากสร้างตาราง d_user
  await db.execute('ALTER TABLE d_user ADD COLUMN age TEXT');
}


  Future _createCategoriesTable(Database db) async {
    await db.execute('''
          CREATE TABLE d_categories (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            name_th TEXT,
            name_en TEXT,
            description_th TEXT,
            description_en TEXT
          )
        ''');
  }

  Future _createMedicationsTable(Database db) async {
    await db.execute('''
          CREATE TABLE d_medications (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            name_th TEXT,
            name_en TEXT,
            description_th TEXT,
            description_en TEXT,
            common_usage_th TEXT,
            common_usage_en TEXT,
            category_id INT
          )
        ''');
  }

  Future _createUnitTable(Database db) async {
    await db.execute('''
          CREATE TABLE d_unit (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            unit_th TEXT,
            unit_en TEXT
          )
        ''');
  }

  Future _createUserTable(Database db) async {
    await db.execute('''
          CREATE TABLE d_user (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            name_th TEXT,
            name_en TEXT,
            sex_th TEXT,
            sex_en TEXT,
            weight REAL,
            height REAL,
            img TEXT,
            birthday TEXT,
            age TEXT,
            phone INT,
            other TEXT,
            email TEXT,
            password TEXT,
            tel INT,
            addr TEXT
          )
        ''');
  }

  Future _createMedicationScheduleTable(Database db) async {
    await db.execute('''
          CREATE TABLE medication_schedule (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            medication_id INT,
            date TEXT,
            time TEXT,
            qty REAL,
            stamp TEXT,
            status TEXT,
            st INT,
            user_id INT,
            status_stamp TEXT,
            type INT
          )
        ''');
  }

  // Future<Map<String, dynamic>?> getUserByEmail(String email) async {
  //   Database db = await instance.database;
  //   List<Map<String, dynamic>> results = await db.query(
  //     'd_user',
  //     where: 'email = ?',
  //     whereArgs: [email],
  //   );

  //   if (results.isNotEmpty) {
  //     return results.first;
  //   }
  //   return null;
  // }
Future<Map<String, dynamic>?> getUserByEmailOrPhone(String identifier) async {
  Database db = await instance.database;

  // ตรวจสอบว่า identifier เป็นอีเมลหรือเบอร์โทร
  bool isPhone = RegExp(r'^[0-9]+$').hasMatch(identifier);
  bool isEmail = RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(identifier);

  if (!isPhone && !isEmail) {
    // หาก identifier ไม่ใช่ทั้งอีเมลและเบอร์โทร ให้คืนค่า null
    return null;
  }

  // เลือกเงื่อนไขการค้นหาตามชนิดของ identifier
  String field = isPhone ? 'phone' : 'email';

  // ค้นหาผู้ใช้จากฐานข้อมูล
  List<Map<String, dynamic>> results = await db.query(
    'd_user',
    where: '$field = ?',
    whereArgs: [identifier],
  );

  if (results.isNotEmpty) {
    return results.first;
  }
  return null;
}

  Future<void> insertData(Map<String, dynamic> data, String table_Name) async {
    Database db = await instance.database;
    await db.insert(table_Name, data);
  }

  Future<void> updateData(
      Map<String, dynamic> data, String table_Name, int id) async {
    Database db = await instance.database;
    await db.update(table_Name, data, where: 'id = ?', whereArgs: [id]);
    // await db.update(table_Name, data, where: 'id = ?', whereArgs: [data['id']]);
  }

  Future<void> deleteData(int id, String table_Name) async {
    Database db = await instance.database;
    await db.delete(table_Name, where: 'id = ?', whereArgs: [id]);
  }
  // Future<void> deleteData(int id, String table_Name) async {
  //   Database db = await instance.database;
  //   await db.delete(table_Name, where: 'id = ?', whereArgs: [id]);
  // }

  Future<List<Map<String, dynamic>>> getData(String table_Name) async {
    Database db = await instance.database;
    return await db.query(table_Name);
  }

  Stream<List<Map<String, dynamic>>> getDataStream(String table_Name) async* {
    Database db = await instance.database;
    while (true) {
      List<Map<String, dynamic>> data = await db.query(table_Name);
      yield data;
      await Future.delayed(const Duration(milliseconds: 100));
    }
  }

  Stream<List<Map<String, dynamic>>> getDataStream_JOIN(
      String table_Name1, String table_Name2) async* {
    Database db = await instance.database;

    String query = '''
    SELECT $table_Name1.id, $table_Name2.name_th, $table_Name2.name_en,$table_Name1.status 
    FROM $table_Name1
    LEFT JOIN $table_Name2
    ON $table_Name1.medication_id = $table_Name2.id
  ''';

    while (true) {
      List<Map<String, dynamic>> data = await db.rawQuery(query);
      yield data;
      await Future.delayed(const Duration(milliseconds: 100));
    }
  }

  deleteDatabase_tabel() async {
    String path = await getDatabasesPath();
    await deleteDatabase('$path/d_categories.db');
  }
  Future<void> dropAndRecreateUserTable(Database db) async {
  // ลบตาราง d_user ถ้ามีอยู่
  await db.execute('DROP TABLE IF EXISTS d_user');
  
  // สร้างตารางใหม่พร้อมคอลัมน์ใหม่
  await db.execute('''
    CREATE TABLE d_user (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      name_th TEXT,
      name_en TEXT,
      sex_th TEXT,
      sex_en TEXT,
      weight REAL,
      height REAL,
      img TEXT,
      birthday TEXT,
      age TEXT,
      phone INT,
      other TEXT,
      email TEXT,
      password TEXT,
      tel INT,
      addr TEXT
    )
  ''');
  print("Table 'd_user' has been recreated.");
}
Future _onUpgrade(Database db, int oldVersion, int newVersion) async {
  if (oldVersion < newVersion) {
    await dropAndRecreateUserTable(db);
  }
}
}
