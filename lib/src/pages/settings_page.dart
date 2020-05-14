import 'package:flutter/material.dart';

import 'package:qr_reader_app/src/share_prefs/preferencias_usuario.dart';
import 'package:qr_reader_app/src/widgets/menu_widget.dart';


class SettingsPage extends StatefulWidget {

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {

  bool _colorSecundario;
  int _genero;  

  TextEditingController _textController;

  final prefs = new PreferenciasUsuario();

  @override
  void initState() {    
    super.initState();

    prefs.ultimaPagina = 'settings';

    _genero = prefs.genero;
    _colorSecundario = prefs.colorSecundario;    

    _textController = new TextEditingController(text: prefs.nombre);

  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ajustes'),
      ),
      drawer: MenuWidget(),
      body: ListView(
        physics: BouncingScrollPhysics(),
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(5.0),
            child: Text('Ajustes', style: TextStyle(fontSize: 40.0, fontWeight: FontWeight.bold)),
          ),
          Divider(),

          SwitchListTile(
            value: _colorSecundario,
            title: Text('Color secundario'),
            onChanged: (value) {              
              setState(() {
                _colorSecundario = value;
                prefs.colorSecundario = value;
              });
            }
          ),

          RadioListTile(
            value: 1,
            title: Text('Masculino'),
            groupValue: _genero,
            onChanged: _setSelectedRadio,
          ),

          RadioListTile(
            value: 2,
            title: Text('Femenino'),
            groupValue: _genero,
            onChanged: _setSelectedRadio,
          ),

          Divider(),

          Container(
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            child: TextField(
              controller: _textController,
              decoration: InputDecoration(
                labelText: 'Nombre',
                helperText: 'Nombre del usuario'
              ),
              onChanged: ( value ) {
                prefs.nombre = value;
              }
            ),
          ),
        ],
      ),
    );
  }

  _setSelectedRadio( int valor ) {

    prefs.genero = valor;
    _genero = valor;
    setState(() {});

  }

}
