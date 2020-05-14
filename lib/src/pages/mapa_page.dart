import 'package:flutter/material.dart';

import 'package:flutter_map/flutter_map.dart';

import 'package:qr_reader_app/src/models/scan_model.dart';


class MapaPage extends StatefulWidget {

  @override
  _MapaPageState createState() => _MapaPageState();
}

class _MapaPageState extends State<MapaPage> {

  final MapController mapCtrl = new MapController();
  String tipoMapa = 'streets';

  @override
  Widget build(BuildContext context) {

    final ScanModel scan = ModalRoute.of(context).settings.arguments;
    
    return Scaffold(
      appBar: AppBar(
        title: Text('Coordenadas QR'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.my_location),
            onPressed: () {
              mapCtrl.move(scan.getLangLng(), 15);
            }
          )
        ],
      ),
      body: _createFlutterMap( scan ),
      floatingActionButton: _crearBotonFlotante(context),
    );
  }

  Widget _createFlutterMap( ScanModel scan ) {

    return FlutterMap(
      mapController: mapCtrl,
      options: MapOptions(
        center: scan.getLangLng(),
        zoom: 10,        
      ),
      layers: [
        _crearMapa(),
        _crearMarcadores( scan )
      ],
    );
    
  }

  _crearMapa() {

    return TileLayerOptions(
      urlTemplate: 'https://api.mapbox.com/v4/'
      '{id}/{z}/{x}/{y}@2x.png?access_token={accessToken}',
      additionalOptions: {
        'accessToken': 'pk.eyJ1IjoiYWxleGlzY2FicmVyYSIsImEiOiJjanpjazU0ZnYwNmVzM2xwNzI1M3VwcXpoIn0.7qNkHmPRQUgGHXD__VGz4A',
        'id': 'mapbox.${ this.tipoMapa }'
        // streets, dark, light, outdoors, satellite
      }
    );

  }

  MarkerLayerOptions _crearMarcadores( ScanModel scan ) {

    return MarkerLayerOptions(
      markers: <Marker> [
        Marker(
          width: 100.0,
          height: 100.0,
          point: scan.getLangLng(),
          builder: (context) => Container(
            child: Icon(
              Icons.location_on, size: 70.0,
              color: Theme.of(context).primaryColor,
            ),
          )
        )
      ]
    );
    
  }

  Widget _crearBotonFlotante( BuildContext context ) {
    return FloatingActionButton(
      child: Icon( Icons.repeat ),
      onPressed: () {

        if ( this.tipoMapa == 'streets' ) {
          this.tipoMapa = 'dark';
        } else if ( this.tipoMapa == 'dark' ) {
          this.tipoMapa = 'light';
        } else {
          this.tipoMapa = 'streets';
        }

        print(this.tipoMapa);

        setState(() {});

      },      
    );
  }
}