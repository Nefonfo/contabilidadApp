import 'dart:async';
import 'dart:io';

import 'package:contabilidadapp/orm/models.dart';
import 'package:contabilidadapp/responsive/responsive.dart';
import 'package:contabilidadapp/services/Seating_services.dart';
import 'package:contabilidadapp/services/Types_services.dart';
import 'package:contabilidadapp/views/newSeating_page.dart';
import 'package:contabilidadapp/views/seatingData_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';

class SeatingsPage extends StatefulWidget {
  @override
  _SeatingsPageState createState() => _SeatingsPageState();
}

class _SeatingsPageState extends State<SeatingsPage> {
  Future<List<Seating>> _globalData;
  SeatingServices _seatingService = new SeatingServices();
  bool _isButtonsNewDisabled = false;
  @override
  void initState() {
    super.initState();
    _globalData = _seatingService.selectAll();
  }

  @override
  Widget build(BuildContext context) {
    Responsive grid = new Responsive(
        MediaQuery.of(context).size.height, MediaQuery.of(context).size.width);

    dynamic generic;
    return SafeArea(
      child: Material(
        child: CupertinoPageScaffold(
          backgroundColor: CupertinoColors.white,
          child: FutureBuilder(
            future: _globalData,
            builder: (BuildContext context, AsyncSnapshot<List<Seating>> data) {
              if (data.hasData) {
                List<Seating> allInfo = data.data;
                if (allInfo.isEmpty) {
                  generic = SliverToBoxAdapter(
                      child: Container(
                          height: grid.blockSizeVertical * 40,
                          child: _noSeatingInfo(grid)));
                } else {
                  generic = SliverToBoxAdapter(
                    child: Column(
                      children: data.data
                          .map((Seating chil) => seatingTiles(grid, chil.alias,
                              DateTime.parse(chil.date), chil.ids))
                          .toList(),
                    ),
                  );
                }
              } else {
                generic = SliverToBoxAdapter(
                    child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(
                      height: grid.blockSizeVertical * 10,
                    ),
                    CupertinoActivityIndicator(
                      radius: grid.blockSizeVertical * 2.5,
                    ),
                  ],
                ));
              }
              return LiquidPullToRefresh(
                onRefresh: () {
                  _globalData = _seatingService.selectAll();
                  return Future.delayed(Duration(seconds: 4), () {
                    setState(() {});
                  });
                },
                backgroundColor: CupertinoColors.white,
                color: CupertinoColors.destructiveRed,
                child: CustomScrollView(
                  slivers: <Widget>[
                    CupertinoSliverNavigationBar(
                        heroTag: "Asientos",
                        transitionBetweenRoutes: false,
                        largeTitle: Text("Asientos"),
                        backgroundColor: CupertinoColors.white,
                        trailing: (data.data == null || data.data.isEmpty)
                            ? null
                            : GestureDetector(
                                child: Icon(
                                  CupertinoIcons.add,
                                  color: CupertinoColors.destructiveRed,
                                  size: 38,
                                ),
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      CupertinoPageRoute(
                                          title: "Nuevo Asiento",
                                          builder: (_) => NewSeatingPage(
                                                firstSeating: false,
                                              )));
                                },
                              )),
                    generic
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget seatingTiles(Responsive grid, String alias, DateTime date, int ids) {
    return Slidable(
        actionPane: SlidableDrawerActionPane(),
        actionExtentRatio: 0.2,
        child: ListTile(
          trailing: Icon(CupertinoIcons.forward),
          title: Text("$alias", style: TextStyle(fontWeight: FontWeight.bold)),
          subtitle:
              Text("Realizado el: ${date.day} - ${date.month} - ${date.year}"),
          onTap: (){
            Navigator.push(context, CupertinoPageRoute(
              title: "SeatingData",
              builder: (_) => SeatingDataPage(
                idS: ids,
                title: alias,
              )
            ));
          },
        ),
        actions: (ids == 1)
            ? [
                IconSlideAction(
                  caption: "Editar",
                  color: CupertinoColors.activeBlue,
                  icon: CupertinoIcons.pencil,
                  onTap: () {},
                )
              ]
            : [
                IconSlideAction(
                  caption: "Borrar",
                  color: CupertinoColors.destructiveRed,
                  icon: CupertinoIcons.delete_simple,
                  onTap: () {
                    deleteSeating(grid, alias, ids);
                  },
                ),
                IconSlideAction(
                  caption: "Editar",
                  color: CupertinoColors.activeBlue,
                  icon: CupertinoIcons.pencil,
                  onTap: () {},
                )
              ]);
  }

  Widget _noSeatingInfo(Responsive grid) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Title(
          child: Text(
            "Ningun Asiento Agregado 😭",
            style: TextStyle(
                color: CupertinoColors.destructiveRed,
                fontWeight: FontWeight.w700,
                fontSize: grid.blockSizeHorizontal * 5),
          ),
          color: CupertinoColors.destructiveRed,
        ),
        SizedBox(
          height: grid.blockSizeVertical * 2,
        ),
        CupertinoButton(
          child: Text("Crear Primer Asiento"),
          onPressed: () {
            newSeating(grid);
          },
          color: CupertinoColors.destructiveRed,
        )
      ],
    );
  }

  Future<void> newSeating(Responsive grid) {
    return showDialog(
        context: context,
        barrierDismissible: true,
        builder: (context) {
          return AlertDialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0)),
              title: Text('¿Desea el ajuste predefinido?',
                  style: TextStyle(
                      color: CupertinoColors.destructiveRed,
                      fontWeight: FontWeight.bold)),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text(
                      'Se agregaran los activos, pasivos, capital contable, cuentas de estados de resultados predefinidos (podra borrarlos y editarlos despues si usted desea).'),
                ],
              ),
              actions: alertBlock(grid));
        });
  }

  List<Widget> alertBlock(Responsive grid) {
    if (_isButtonsNewDisabled) {
      return [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            CupertinoActivityIndicator(
              radius: grid.blockSizeVertical * 2,
            ),
          ],
        )
      ].toList();
    } else {
      return [
        FlatButton(
          child: Text(
            'Esta bien',
            style: TextStyle(
                color: CupertinoColors.destructiveRed,
                fontSize: grid.blockSizeVertical * 2),
          ),
          onPressed: () async {
            setState(() {
              _isButtonsNewDisabled = true;
            });
            Navigator.pop(context);
            int i = await this.typesFirstProtocol();
            setState(() {
              _isButtonsNewDisabled = false;
            });
            Navigator.push(
                context,
                CupertinoPageRoute(
                    title: "Nuevo Asiento",
                    builder: (_) => NewSeatingPage(
                          firstSeating: true,
                        )));
          },
        ),
        FlatButton(
          child: Text(
            'Cancelar',
            style: TextStyle(
                color: CupertinoColors.destructiveRed,
                fontSize: grid.blockSizeVertical * 2),
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        )
      ].toList();
    }
  }

  Future<int> typesFirstProtocol() async {
    TypesServices _typesService = new TypesServices.firstProtocol();
    int i = await _typesService.fistProtocolInsert();
    return i;
  }

  Future<void> deleteSeating(Responsive grid, String name, int ids) async {
    SeatingServices service = new SeatingServices(ids: ids);
    showDialog(
        context: context,
        barrierDismissible: true,
        builder: (context) {
          return AlertDialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0)),
              title: Text("¿ Desea borrar $name ?",
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
                    service.deleteSeatingById().then((dynamic u) {
                      _globalData = _seatingService.selectAll();
                      showDialog(
                          context: context,
                          barrierDismissible: true,
                          builder: (context) {
                            return AlertDialog(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20.0)),
                                title: Text("Borrado Exitosamente",
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
                      Future.delayed(Duration(seconds: 4), () {
                        setState(() {});
                      });
                    });
                  },
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
