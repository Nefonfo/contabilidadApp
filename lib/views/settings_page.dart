import 'package:contabilidadapp/responsive/responsive.dart';
import 'package:contabilidadapp/services/Seating_services.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    Responsive grid = Responsive(
        MediaQuery.of(context).size.height, MediaQuery.of(context).size.width);
    return Material(
      child: CupertinoPageScaffold(
        navigationBar: CupertinoNavigationBar(
          heroTag: "Ajustes",
          transitionBetweenRoutes: false,
          previousPageTitle: "Bienvenidos",
          backgroundColor: CupertinoColors.extraLightBackgroundGray,
          border: Border(
            bottom: BorderSide.none,
          ),
        ),
        child: Center(
          child: CupertinoButton(
            onPressed: () {
              delete(grid);
            },
            color: CupertinoColors.destructiveRed,
            child: Text("Borrar Todo ALV 😰🤪"),
          ),
        ),
      ),
    );
  }

  void delete(Responsive grid) {
    showDialog(
        context: context,
        barrierDismissible: true,
        builder: (context) {
          return AlertDialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0)),
              title: Text("¿Estás Seguro? 😱😱",
                  style: TextStyle(
                      color: CupertinoColors.destructiveRed,
                      fontWeight: FontWeight.bold)),
              actions: [
                FlatButton(
                  child: Text(
                    'Borrar',
                    style: TextStyle(
                        color: CupertinoColors.destructiveRed,
                        fontSize: grid.blockSizeVertical * 2),
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                    Navigator.pop(context);
                    SeatingServices service = new SeatingServices.delete();
                    service.deleteAllDataBase();
                    showDialog(
                          context: context,
                          barrierDismissible: true,
                          builder: (context) {
                            return AlertDialog(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20.0)),
                                title: Text("BORRADO TODO ALV 😱😱",
                                    style: TextStyle(
                                        color: CupertinoColors.destructiveRed,
                                        fontWeight: FontWeight.bold)),
                                actions: [
                                  FlatButton(
                                    child: Text(
                                      'Ok',
                                      style: TextStyle(
                                          color: CupertinoColors.destructiveRed,
                                          fontSize: grid.blockSizeVertical * 2),
                                    ),
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                  )
                                ].toList());
                          });
                  }
                ),
                FlatButton(
                  child: Text(
                    'Cancelar',
                    style: TextStyle(
                        color: CupertinoColors.destructiveRed,
                        fontSize: grid.blockSizeVertical * 2),
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                )
              ].toList());
        });
  }
}
