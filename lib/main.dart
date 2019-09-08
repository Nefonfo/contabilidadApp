import 'dart:io';

import 'package:contabilidadapp/views/home_page.dart';
import 'package:contabilidadapp/views/newSeating_page.dart';
import 'package:contabilidadapp/views/seatings_page.dart';
import 'package:contabilidadapp/views/settings_page.dart';
import 'package:contabilidadapp/views/typesClasses_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';

import 'orm/database_model.dart';

void main() async {
  final bool isInitialized = await DatabaseModel().initializeDB();

  if (isInitialized == true) {
    runApp(MyApp());
  } else {
    exit(255);
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Contabilidad',
      theme: ThemeData(
        cupertinoOverrideTheme: CupertinoThemeData(
          primaryColor: CupertinoColors.destructiveRed,
        ),
      ),
      home: Tabs(
        title: 'Inicio',
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}

class Tabs extends StatefulWidget {
  Tabs({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _TabsState createState() => _TabsState();
}

class _TabsState extends State<Tabs> {
  @override
  Widget build(BuildContext context) {
    return Material(
        child: CupertinoPageScaffold(
      child: CupertinoTabScaffold(
        tabBar: CupertinoTabBar(
          backgroundColor: CupertinoColors.white,
          items: [
            BottomNavigationBarItem(
                icon: Icon(LineIcons.home),
                title: Text(
                  'Inicio',
                  style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
                )),
            BottomNavigationBarItem(
                icon: Icon(LineIcons.check),
                title: Text(
                  'Cuentas',
                  style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
                )),
            BottomNavigationBarItem(
                icon: Icon(LineIcons.money),
                title: Text(
                  'Asientos',
                  style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
                )),
          ],
        ),
        tabBuilder: (BuildContext context, int index) {
          assert(index >= 0 && index <= 2);
          switch (index) {
            case 0:
              return HomePage();
            case 1:
              return TypesClassesPage();
            case 2:
              return SeatingsPage();
          }
        },
      ),
    ));
  }
}
