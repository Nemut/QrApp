import 'dart:async';

import 'package:qr_reader_app/src/bloc/validators.dart';
import 'package:qr_reader_app/src/providers/db_provider.dart';


class ScansBloc with Validators {

  static final ScansBloc _singleton = new ScansBloc._internal();

  factory ScansBloc() {
    return _singleton;
  }

  ScansBloc._internal() {

    // Ejecucion primera vez
    // Obtener Scans de la base de datos
    obtenerScans();

  }

  final _scansController = StreamController<List<ScanModel>>.broadcast();

  Stream<List<ScanModel>> get scansStream     => _scansController.stream.transform(validarGeo);
  Stream<List<ScanModel>> get scansStreamHttp => _scansController.stream.transform(validarHttp);


  // Necesario para no crear fugas de memoria
  dispose() {
    _scansController?.close();
  }

  agregarScan( ScanModel scan) async {

    await DBProvider.db.nuevoScan(scan);

    obtenerScans();
    
  }

  // Metodos para manipular el stream
  obtenerScans() async {

    _scansController.sink.add( await DBProvider.db.getTodosScans() );
    
  }

  borrarScan(int id) async {

    await DBProvider.db.deleteScan(id);

    obtenerScans(); // tambien podriamos quitar el ultimo registro en vez de llamar todos
    
  }

  borrarScanTodos() async {

    await DBProvider.db.deleteAll();

    obtenerScans();
    
  }
  
}