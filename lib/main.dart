import 'package:flutter/material.dart';

import 'package:qr_reader_app/src/theme/theme.dart';

import 'package:qr_reader_app/src/share_prefs/preferencias_usuario.dart';
import 'package:qr_reader_app/src/pages/home_page.dart';
import 'package:qr_reader_app/src/pages/mapa_page.dart';
import 'package:qr_reader_app/src/pages/settings_page.dart';


void main() async {

  WidgetsFlutterBinding.ensureInitialized();

  final prefs = new PreferenciasUsuario();
  await prefs.initPrefs();

  runApp(MyApp());

}
 
class MyApp extends StatelessWidget {

  final prefs = new PreferenciasUsuario();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Lector QR!',
      theme: ThemeQR.mainTheme,
      initialRoute: prefs.ultimaPagina,
      routes: {
        'home'    : (BuildContext context) => HomePage(),
        'mapa'    : (BuildContext context) => MapaPage(),
        'settings': (BuildContext context) => SettingsPage(),

      },      
    );
  }
}