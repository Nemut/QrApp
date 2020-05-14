import 'package:shared_preferences/shared_preferences.dart';


class PreferenciasUsuario {

  static final PreferenciasUsuario _instancia = new PreferenciasUsuario._internal();

  factory PreferenciasUsuario() {
    return _instancia;
  }

  PreferenciasUsuario._internal();

  SharedPreferences _prefs;

  initPrefs() async {
    this._prefs = await SharedPreferences.getInstance();
  }

  // Preferencias
  // bool _colorSecundario;
  // int _genero;
  // String _nombre;

  // Get Set genero
  int get genero {
    return _prefs.getInt('genero') ?? 1;
  }

  set genero( int value ) {
    _prefs.setInt('genero', value);
  }

  // Get Set color secundario
  bool get colorSecundario {
    return _prefs.getBool('colorSecundario') ?? false;
  }

  set colorSecundario( bool value ) {
    _prefs.setBool('colorSecundario', value);
  }
  // Get Set genero
  String get nombre {
    return _prefs.getString('nombre') ?? 'Adam';
  }

  set nombre( String value ) {
    _prefs.setString('nombre', value);
  }

  // Get Set genero
  String get ultimaPagina {
    return _prefs.getString('ultimaPagina') ?? 'home';
  }

  set ultimaPagina( String value ) {
    _prefs.setString('ultimaPagina', value);
  }
  
}