import 'dart:io';
import 'package:path/path.dart';

import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

import 'package:qr_reader_app/src/models/scan_model.dart';
export 'package:qr_reader_app/src/models/scan_model.dart';


class DBProvider {

  // Instancia de la base de datos
  static Database _database;

  // Constructor privado
  static final DBProvider db = DBProvider._private();

  DBProvider._private();

  Future<Database> get database async {

    if (_database != null) return _database;

    _database = await initDB();

    return _database;
  }

  // Inicializacion de la base de datos
  initDB() async {

    Directory documentsDirectory = await getApplicationDocumentsDirectory();

    final String path = join( documentsDirectory.path, 'ScansDB.db');

    return await openDatabase(
      path,
      version: 1,
      onOpen: (db) {},
      onCreate: (Database db, int version) async {
        await db.execute(
          'CREATE TABLE Scans ('
          ' id INTEGER PRIMARY KEY,'
          ' tipo TEXT,'
          ' valor TEXT'
          ')'
        );
      }
    );

  }

  // Crear registros
  nuevoScanRaw( ScanModel nuevoScan ) async {

    final db = await database;

    final res = await db.rawInsert(
      "INSERT INTO Scans (id, tipo, valor) "
      "VALUES (${ nuevoScan.id }, '${ nuevoScan.tipo }', '${ nuevoScan.valor })'"
    );

    return res; // numero de inserciones realizadas

  }

  nuevoScan( ScanModel nuevoScan) async {

    final db = await database;

    final res = await db.insert('Scans', nuevoScan.toJson()); // to json en realidad nos est'a retornando un mapa

    await _mantenerNScans( 30, nuevoScan.tipo );
    
    return res;
    
  }
    
  // Obtener registros
  Future<List<ScanModel>> getTodosScans() async {

    final db = await database;

    final res = await db.query('Scans', orderBy: 'id DESC');

    List<ScanModel> lista = res.isNotEmpty
                            ? res.map((s) => ScanModel.fromJson(s)).toList()
                            : [];

    return lista;

  }

  Future<List<ScanModel>> getTodosScansPorTipo(String tipo) async {

    final db = await database;

    final res = await db.rawQuery(
      "SELECT * FROM Scans WHERE tipo='$tipo'"
    );

    List<ScanModel> lista = res.isNotEmpty
                            ? res.map((s) => ScanModel.fromJson(s)).toList()
                            : [];

    return lista;

  }

  Future<ScanModel> getScanid(int id) async {

    final db = await database;

    final res = await db.query(
      'Scans',
      where: 'id = ?',
      whereArgs: [id]
    );

    return res.isNotEmpty ? ScanModel.fromJson(res.first) : null;

  }
  

  // Actualizar registros, cantidad de updates se dispararon
  Future<int> updateScan( ScanModel nuevoScan) async {

    final db = await database;

    final res = await db.update('Scans', nuevoScan.toJson(), where: 'id = ?', whereArgs: [nuevoScan.id] );

    return res;

  }

  // Borrar registros, cantidad de registros eliminados
  Future<int> deleteAll() async {

    final db = await database;

    final res = await db.rawDelete(
      "DELETE FROM Scans"
    );

    return res;

  }

  Future<int> deleteScan( int id) async {

    final db = await database;

    final res = await db.delete('Scans', where: 'id = ?', whereArgs: [id] );

    return res;

  }

  // Conservar ultimos n
  Future _mantenerNScans( int n, String tipo ) async {

    final db = await database;
    int lastId = 0;        

    final res = await db.query('Scans', where: 'tipo = ?', whereArgs: [tipo], orderBy: 'id DESC', limit: 1, offset: 10);

    // Actualizamos los registros
    if ( res.isNotEmpty && res.first.containsKey('id') ) {
      lastId = res.first['id'];
    }

    if ( lastId > 0 ) {
      await db.delete('Scans', where: 'id <= ? AND tipo = ?', whereArgs: [lastId, tipo] );
      // print('Filas [$tipo] borradas $deletedRows');
    }
    
  }

}