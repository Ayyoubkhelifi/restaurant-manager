import 'dart:async';
import 'package:restaurant/model/menu_item_model.dart';
import 'package:restaurant/model/panier_item_model.dart';
import 'package:restaurant/model/panier_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:restaurant/utils/local db/local_db_tables.dart';

class DbHelper {
  static const _dbName = 'mydatabase.db';
  static const _dbVersion = 1;

  DbHelper._privateConstructor();
  static final DbHelper instance = DbHelper._privateConstructor();

  static Database? _db;
  Future<Database> get database async {
    return _db ??= await _initDatabase();
  }

  Future<Database> _initDatabase() async {
    final path = join(await getDatabasesPath(), _dbName);
    return openDatabase(path, version: _dbVersion, onCreate: _onCreate);
  }

  Future _onCreate(Database db, int version) async {
    await db.execute(LocalDbTables.createMenuTable);
    await db.execute(LocalDbTables.createPanierTable);
    await db.execute(LocalDbTables.createPanierItemTable);
  }

  Future<void> clearDatabaseRecords() async {
    final db = await database;
    await db.delete('menu');
    await db.delete('panier');
    await db.delete('panier_items');
  }

  // --------- MENU CRUD ----------
  Future<MenuItem> insertMenuItem(MenuItem item) async {
    final db = await database;
    final id = await db.insert('menu', item.toMap());
    return item..id = id;
  }

  Future<List<MenuItem>> getAllMenuItems() async {
    final db = await database;
    final rows = await db.query('menu', orderBy: 'name');
    return rows.map((r) => MenuItem.fromMap(r)).toList();
  }

  Future<int> updateMenuItem(MenuItem item) async {
    final db = await database;
    return db.update(
      'menu',
      item.toMap(),
      where: 'id = ?',
      whereArgs: [item.id],
    );
  }

  Future<int> deleteMenuItem(int id) async {
    final db = await database;
    return db.delete('menu', where: 'id = ?', whereArgs: [id]);
  }

  // --------- PANIER CRUD ----------
  Future<Panier> insertPanier(Panier panier) async {
    final db = await database;
    final id = await db.insert('panier', panier.toMap());
    return panier..id = id;
  }

  Future<void> insertPanierItemsBatch(List<PanierItem> items) async {
    final db = await instance.database;
    await db.transaction((txn) async {
      for (final item in items) {
        await txn.insert('panier_items', item.toMap());
      }
    });
  }

  Future<List<Panier>> getAllPaniers() async {
    final db = await database;
    final rows = await db.query('panier', orderBy: 'created_at DESC');
    return rows.map((r) => Panier.fromMap(r)).toList();
  }

  Future<int> updatePanier(Panier panier) async {
    final db = await database;
    return db.update(
      'panier',
      panier.toMap(),
      where: 'id = ?',
      whereArgs: [panier.id],
    );
  }

  Future<int> deletePanier(int id) async {
    final db = await database;
    await db.delete('panier_items', where: 'panier_id = ?', whereArgs: [id]);
    return db.delete('panier', where: 'id = ?', whereArgs: [id]);
  }

  // --------- PANIER_ITEM CRUD ----------
  Future<PanierItem> insertPanierItem(PanierItem item) async {
    final db = await database;
    final id = await db.insert('panier_items', item.toMap());
    return item..id = id;
  }

  Future<List<PanierItem>> getPanierItems(int panierId) async {
    final db = await database;
    final rows = await db.query(
      'panier_items',
      where: 'panier_id = ?',
      whereArgs: [panierId],
    );
    return rows.map((r) => PanierItem.fromMap(r)).toList();
  }

  Future<int> updatePanierItem(PanierItem item) async {
    final db = await database;
    return db.update(
      'panier_items',
      item.toMap(),
      where: 'id = ?',
      whereArgs: [item.id],
    );
  }

  Future<int> deletePanierItem(int id) async {
    final db = await database;
    return db.delete('panier_items', where: 'id = ?', whereArgs: [id]);
  }
}
