import 'dart:io';
import 'package:flutter/material.dart';

import 'package:barcode_scan/barcode_scan.dart';

import 'package:qr_reader_app/src/bloc/scans_bloc.dart';
import 'package:qr_reader_app/src/pages/mapas_page.dart';
import 'package:qr_reader_app/src/models/scan_model.dart';
import 'package:qr_reader_app/src/pages/direcciones_page.dart';
import 'package:qr_reader_app/src/utils/utils.dart' as utils;
import 'package:qr_reader_app/src/widgets/menu_widget.dart';
import 'package:qr_reader_app/src/share_prefs/preferencias_usuario.dart';


class HomePage extends StatefulWidget {

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  final scansBloc = new ScansBloc();

  int currentIndex = 0;

  final prefs = new PreferenciasUsuario();

  @override
  void initState() {
    prefs.ultimaPagina = 'home';
    super.initState();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lector QR de ${ prefs.nombre }'),
        actions: <Widget>[
          IconButton(
            icon: Icon( Icons.delete_forever ),
            onPressed: () {

              scansBloc.borrarScanTodos();

            },
          )
        ],
      ),
      drawer: MenuWidget(),
      body: _callPage(currentIndex),
      bottomNavigationBar: _crearBottomNavigationBar(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        child: Icon( Icons.filter_center_focus),
        onPressed: () => _scanQR(context),
      ),
    );
  }

  Widget _crearBottomNavigationBar() {

    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: (index) {
        setState(() {
          currentIndex = index;  
        });
      },
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.map),
          title: Text('Mapas')
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.brightness_5),
          title: Text('Direcciones')
        )
      ],
    );
    
  }

  Widget _callPage( int paginaActual ) {

    switch( paginaActual) {
      case 0: return MapasPage();
      case 1: return DireccionesPage();
      default: return MapasPage();
    }

  }

  void _scanQR(BuildContext context) async {
    print(BarcodeFormat.values);
    ScanResult scanResult;
    String futureString;

    try {
      scanResult = await BarcodeScanner.scan();
      futureString = scanResult.rawContent;
    } catch(e) {
      futureString = e.toString();
    }

    if ( futureString != null ) {

      final nuevoScan = ScanModel(valor: futureString);
      scansBloc.agregarScan(nuevoScan);      

      if ( Platform.isIOS ) {
        Future.delayed(Duration(milliseconds:  750), () {
          utils.abrirScan(context, nuevoScan);
        });
      } else {
        utils.abrirScan(context, nuevoScan);
      }
      
    }
    
  }  

}