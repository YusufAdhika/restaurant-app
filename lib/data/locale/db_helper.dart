import 'package:restaurant_api/data/models/cart_db.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class FavDatabase {
  static final FavDatabase instance = FavDatabase._init();

  static Database? _database;

  FavDatabase._init();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB('carts.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(
      dbPath,
      filePath,
    );

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    await db.execute('''
    CREATE TABLE $tableFavourite (
      ${FavouriteFields.id} TEXT PRIMARY KEY NOT NULL UNIQUE,
      ${FavouriteFields.name} TEXT,
      ${FavouriteFields.isFavourite} INT,
      ${FavouriteFields.pictureId} TEXT,
      ${FavouriteFields.city} TEXT,
      ${FavouriteFields.rating} REAL
    )
  ''');
  }

  Future<Favourite> create(Favourite cart) async {
    final db = await instance.database;
    final id = await db.insert(tableFavourite, cart.toJson());
    return cart.copy(id: id.toString());
  }

  Future<int> delete(String id) async {
    final db = await instance.database;
    return await db.delete(tableFavourite,
        where: '${FavouriteFields.id} = ?', whereArgs: [id]);
  }

  Future<void> deleteAllData() async {
    final db = await instance.database;
    db.execute("delete from $tableFavourite");
    db.execute("vacuum");
  }

  Future<List<Favourite>> readAllCart() async {
    final db = await instance.database;
    final result = await db.query(tableFavourite);
    return result.map((json) => Favourite.fromJson(json)).toList();
  }
}
