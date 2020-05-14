import 'package:flutter/material.dart';


class MenuWidget extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: Color(0xff16202b),
        child: ListView(
          physics: BouncingScrollPhysics(),
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              child: Container(),
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/original.jpg'),
                  fit: BoxFit.cover
                ),              
              ),
            ),

            ListTile(
              leading: Icon( Icons.pages, color: Theme.of(context).primaryColor,),
              title: Text('Home'),
              onTap: () {

                Navigator.pushReplacementNamed(context, 'home');

              },
            ),
            Divider(),
            ListTile(
              leading: Icon( Icons.settings, color: Theme.of(context).primaryColor,),
              title: Text('Ajustes'),
              onTap: () {

                // Navegacion con icono volver
                // Navigator.pop(context);
                // Navigator.pushNamed(context, 'settings');

                Navigator.pushReplacementNamed(context, 'settings');
                
              },
            ),
            Divider(),

          ],
        ),
      ),
    );
  }
}