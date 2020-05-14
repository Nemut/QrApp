import 'package:flutter/material.dart';

import 'package:share/share.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:qr_reader_app/src/providers/db_provider.dart';



abrirScan( BuildContext context, ScanModel scan ) async {
  
  if ( scan.tipo == 'http') {

    if (await canLaunch(scan.valor)) {
      await launch(scan.valor);
    } else {
      throw 'Could not launch $scan.valor';
    }

  } else if ( scan.tipo == 'geo') {
    
    Navigator.pushNamed(context, 'mapa', arguments: scan);
    
  } else {
    // print('scan tipo texto: ${ scan.tipo }');
    mostrarAlerta(context, scan.valor);
  }


}

mostrarAlerta(BuildContext context, String contenido) {

  showDialog(
    context: context,
    barrierDismissible: true,
    builder: (context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
        title: Text('QR Texto', style: TextStyle(color: Colors.black),),
        content: Text(contenido, style: TextStyle(color: Colors.black),),
        actions: <Widget>[
          FlatButton(
            child: Icon( Icons.share ),
            onPressed: () {
              Share.share(contenido);
            },
          ),
          FlatButton(
            child: Icon( Icons.close ),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    }
  );

}