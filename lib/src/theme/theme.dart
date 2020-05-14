import 'package:flutter/material.dart';


class ThemeQR {

  static final ThemeData mainTheme = ThemeData.light().copyWith(
    primaryColor: Colors.deepPurple,
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: Colors.orange
    ),
    accentColor: Colors.amber,
    primaryColorLight: Colors.white,
    scaffoldBackgroundColor: Color(0xff16202b),
    // canvasColor: Color(0xffDDA0DD),
    textTheme: TextTheme(      
      bodyText2: TextStyle(
        color: Colors.grey
      )
    )
  );

  static final ThemeData secondTheme = ThemeData(
    primaryColor: Colors.deepPurple
  );
  
}
