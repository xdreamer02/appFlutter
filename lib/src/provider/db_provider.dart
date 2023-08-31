import 'dart:io';

// ignore: depend_on_referenced_packages
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:planck/constants/constants.dart';
import 'package:planck/src/models/address_model.dart';
import 'package:planck/src/models/product_model.dart';
import 'package:sqflite/sqflite.dart';

class DBProvider {
  static Database? _database;
  static final DBProvider db = DBProvider._();

  DBProvider._();

  Future<Database> get database async {
    _database ??= await initDB();
    return _database!;
  }

  Future<Database> initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    final path = join(documentsDirectory.path, '$kNameApp.db');

    return await openDatabase(path, version: 1, onOpen: (db) {},
        onCreate: (Database db, int version) async {
      await db.execute('CREATE TABLE Product ('
          ' id INTEGER PRIMARY KEY,'
          ' companyId INTEGER,'
          ' companyName TEXT,'
          ' storeId INTEGER,'
          ' name TEXT,'
          ' description TEXT,'
          ' image TEXT,'
          ' type INTEGER,'
          ' number INTEGER,'
          ' note TEXT,'
          ' price REAL'
          ')');
      await db.execute('CREATE TABLE Address ('
          ' id INTEGER PRIMARY KEY,'
          ' alias TEXT,'
          ' address TEXT,'
          ' lt REAL,'
          ' lg REAL'
          ')');
    });
  }

  createProduct(ProductModel pr) async {
    final db = await database;
    return await db.rawInsert(
        "INSERT Into Product (id, companyId, companyName, name, description, image, type, price, number, note) "
        "VALUES ( '${pr.id}', '${pr.companyId}', '${pr.companyName}', '${pr.name}', '${pr.description}', '${pr.image}', '${pr.type}', '${pr.price}', '${pr.number}', '${pr.note}' )");
  }

  Future<int> updateProduct(ProductModel pr) async {
    final db = await database;
    int count = await db.update(
        'Product', {'number': pr.number, 'note': pr.note},
        where: 'id = ?', whereArgs: [pr.id]);
    return count;
  }

  Future<int> deleteProduct(ProductModel pr) async {
    final db = await database;
    final res = await db.delete('Product',
        where: 'id = ? AND companyId = ?', whereArgs: [pr.id, pr.companyId]);
    return res;
  }

  Future<int> deleteProductByCompany(int companyId) async {
    final db = await database;
    final res = await db
        .delete('Product', where: 'companyId = ?', whereArgs: [companyId]);
    return res;
  }

  Future<int> deleteAllProduct() async {
    final db = await database;
    final res = await db.delete('Product');
    return res;
  }

  Future<List<ProductModel>> loadProducts() async {
    final db = await database;
    final res = await db.query('Product', orderBy: 'companyId');
    List<ProductModel> list =
        res.isNotEmpty ? res.map((p) => ProductModel.fromJson(p)).toList() : [];
    return list;
  }

  Future<int> countProducts() async {
    final db = await database;
    final res = await db.query('Product');
    return res.isNotEmpty
        ? res.map((c) => ProductModel.fromJson(c)).toList().length
        : 0;
  }

  createAddress(AddressModel adr) async {
    final db = await database;
    await db.delete('Address');
    return await db.rawInsert(
        "INSERT Into Address (id, alias, address, lt, lg) "
        "VALUES ( '${adr.id}', '${adr.alias}', '${adr.address}',  '${adr.location.x}', '${adr.location.y}')");
  }

  Future<AddressModel?> loadAddress() async {
    final db = await database;
    final res = await db.query('Address');
    List<AddressModel> list = res.isNotEmpty
        ? res.map((p) => AddressModel.fromJsonLocalDB(p)).toList()
        : [];
    return list.isEmpty ? null : list[0];
  }

  deleteAddress() async {
    final db = await database;
    final res = await db.delete('Address');
    return res;
  }

  deleteAddressByID(int id) async {
    final db = await database;
    final res = await db.delete('Address', where: 'id = ?', whereArgs: [id]);
    return res;
  }
}
