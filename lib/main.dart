import 'dart:io';

import 'package:contabilidadapp/orm/database_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
 
void main(List<String> args) {
    DatabaseModel().createModel();
}
 
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
      title: 'Cupertino App',
      home: CupertinoPageScaffold(
        navigationBar: CupertinoNavigationBar(
          middle: Text('Cupertino App Bar'),
        ),
        child: Center(
          child: Container(
            child: Text('Hello World'),
          ),
        ),
      ),
    );
  }
}