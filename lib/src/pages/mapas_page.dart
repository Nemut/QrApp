import 'package:flutter/material.dart';

import 'package:share/share.dart';

import 'package:qr_reader_app/src/bloc/scans_bloc.dart';
import 'package:qr_reader_app/src/models/scan_model.dart';
import 'package:qr_reader_app/src/utils/utils.dart' as utils;


class MapasPage extends StatelessWidget {

  final scansBloc = new ScansBloc();

  @override
  Widget build(BuildContext context) {

    scansBloc.obtenerScans();

    return StreamBuilder<List<ScanModel>>(
      stream: scansBloc.scansStream,
      builder: (BuildContext context, AsyncSnapshot<List<ScanModel>> snapshot) {

        if ( !snapshot.hasData ) {
          return Center(child: CircularProgressIndicator());
        }
        
        final scans = snapshot.data;

        if ( scans.length == 0 ) {
          return Center(
            child: Text('No hay informacion'),
          );
        }

        return ListView.builder(
          physics: BouncingScrollPhysics(),
          itemCount: scans.length,
          itemBuilder: (BuildContext context, int index) {
            return Dismissible(
              key: UniqueKey(),
              background: Container(
                color: Colors.red,
              ),
              onDismissed: (direction) {

                scansBloc.borrarScan(scans[index].id);                

              },
              child: ListTile(                
                leading: Icon(Icons.map, color: Colors.blueGrey,),
                title: Text(scans[index].valor),
                subtitle: Text('Id: ${ scans[index].id }'),
                trailing: IconButton(
                  icon: Icon(Icons.share, color: Colors.white),
                  onPressed: () {
                    Share.share(scans[index].valor);
                  },
                ),
                onTap: () {
                  utils.abrirScan(context, scans[index]);
                },
              ),
            );
          },
        );
      },
    );    
  }

}