import 'package:contabilidadapp/orm/models.dart';
import 'package:contabilidadapp/responsive/responsive.dart';
import 'package:contabilidadapp/services/Types_services.dart' as typxService;
import 'package:contabilidadapp/views/newTypx_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';

class TypesClassesPage extends StatefulWidget {
  @override
  _TypesClassesPageState createState() => _TypesClassesPageState();
}

class _TypesClassesPageState extends State<TypesClassesPage> {
  Future<List<Typx>> _actives;
  Future<List<Typx>> _pasive;
  Future<List<Typx>> _capital;
  Future<List<Typx>> _results;

  @override
  void initState() {
    super.initState();
    this._typxReloadProtocol();
  }

  @override
  Widget build(BuildContext context) {
    Responsive grid = Responsive(
        MediaQuery.of(context).size.height, MediaQuery.of(context).size.width);
    return Material(
      child: CupertinoPageScaffold(
          navigationBar: CupertinoNavigationBar(
            middle: Title(
              child: Text("Tipos de Cuentas"),
              color: CupertinoColors.black,
            ),
            trailing: GestureDetector(
              child: Icon(
                CupertinoIcons.add,
                color: CupertinoColors.destructiveRed,
                size: 38,
              ),
              onTap: () {
                Navigator.push(
                    context,
                    CupertinoPageRoute(
                        title: "Nueva Cuenta", builder: (_) => NewTypePage()));
              },
            ),
          ),
          child: SafeArea(
            child: LiquidPullToRefresh(
              height: grid.blockSizeVertical * 15,
              color: CupertinoColors.destructiveRed,
              onRefresh: () async {
                await this._typxReloadProtocol();
                return Future.delayed(Duration(seconds: 1));
              },
              child: CustomScrollView(
                slivers: <Widget>[
                  SliverToBoxAdapter(
                    child: Container(
                      child: _swiper(grid),
                    ),
                  )
                ],
              ),
            ),
          )),
    );
  }

  Widget _swiper(Responsive grid) {
    return Swiper(
      layout: SwiperLayout.TINDER,
      itemHeight: grid.blockSizeVertical * 80,
      itemWidth: grid.blockSizeHorizontal * 98,
      itemBuilder: (BuildContext context, int index) {
        switch (index) {
          case 0:
            return _cardsContent("Activo", CupertinoColors.activeBlue,
                CupertinoColors.white, grid, _actives);
          case 1:
            return _cardsContent("Pasivo", CupertinoColors.destructiveRed,
                CupertinoColors.white, grid, _pasive);
          case 2:
            return _cardsContent("Capital", CupertinoColors.darkBackgroundGray,
                CupertinoColors.white, grid, _capital);
          case 3:
            return _cardsContent("Resultados", CupertinoColors.activeGreen,
                CupertinoColors.white, grid, _results);
        }
      },
      itemCount: 4,
    );
  }

  Widget _cardsContent(String type, Color background, Color color,
      Responsive grid, Future<List<Typx>> data) {
    return Card(
      color: background,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(40.0),
      ),
      child: Container(
          padding: EdgeInsets.all(grid.blockSizeHorizontal * 7),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                "$type",
                style: TextStyle(
                    fontSize: grid.blockSizeVertical * 5,
                    fontWeight: FontWeight.w800,
                    color: color),
              ),
              SizedBox(
                height: grid.blockSizeVertical * 3,
              ),
              FutureBuilder(
                future: data,
                builder:
                    (BuildContext context, AsyncSnapshot<List<Typx>> data) {
                  if (!data.hasData) {
                    return Center(
                        child: Column(
                      children: <Widget>[
                        SizedBox(
                          height: grid.blockSizeVertical * 10,
                        ),
                        CupertinoActivityIndicator(
                          radius: grid.blockSizeVertical * 3,
                        ),
                      ],
                    ));
                  } else {
                    if (data.data.isEmpty) {
                      return Center(
                        child: Column(
                          children: <Widget>[
                            SizedBox(height: grid.blockSizeVertical * 15),
                            Title(
                              child: Text(
                                "Sin Datos 😥",
                                style: TextStyle(
                                    color: CupertinoColors.white,
                                    fontWeight: FontWeight.w700,
                                    fontSize: grid.blockSizeVertical * 4.5),
                              ),
                              color: CupertinoColors.white,
                            )
                          ],
                        ),
                      );
                    } else {
                      List<String> results = _classesFinded(data.data);
                      List<Widget> all = [];
                      results.forEach((String dat) {
                        all.add(_typesTileBody(
                            dat,
                            data.data
                                .where((Typx c) => c.subType == dat)
                                .toList(),
                            grid));
                      });
                      return Expanded(
                        child: ListView(
                          shrinkWrap: true,
                          scrollDirection: Axis.vertical,
                          children: all,
                        ),
                      );
                    }
                  }
                },
              )
            ],
          )),
    );
  }

  Widget _typesTileBody(String titleOfType, List<Typx> data, Responsive grid) {
    return Column(
      children: <Widget>[
        Title(
          color: CupertinoColors.white,
          child: Text(
            titleOfType,
            style: TextStyle(
                color: CupertinoColors.white,
                fontSize: grid.blockSizeVertical * 3,
                fontWeight: FontWeight.w900),
          ),
        ),
        Column(children: _typesTile(data, grid))
      ],
    );
  }

  List<Widget> _typesTile(List<Typx> datas, Responsive grid) {
    List<Widget> returnWidget = [];
    datas.forEach((Typx data) {
      returnWidget.add(ListTile(
        title: Text(data.name,
            style: TextStyle(
              color: CupertinoColors.white,
            )),
        subtitle: Text(data.subType,
            style: TextStyle(
              color: CupertinoColors.white,
            )),
        leading: Text(
          "🤑",
          style: TextStyle(fontSize: grid.blockSizeVertical * 4),
        ),
      ));
    });

    return returnWidget;
  }

  Future<void> _typxReloadProtocol() async {
    typxService.TypesServices service =
        new typxService.TypesServices.insegure();
    _actives = service.selectWhere("type", "ACTIVO");
    _pasive = service.selectWhere("type", "PASIVO");
    _capital = service.selectWhere("type", "CAPITAL");
    _results = service.selectWhere("type", "RESULTADO");
  }

  List<String> _classesFinded(List<Typx> datas) {
    List<String> classesFinded = [];
    for (int x = 0; x < datas.length; x++) {
      if (classesFinded == null || classesFinded.isEmpty) {
        classesFinded.add(datas[x].subType);
      } else {
        for (int z = 0; z < classesFinded.length; z++) {
          if (datas[x].subType == classesFinded[z]) {
            break;
          } else if (datas[x].subType == classesFinded[z] &&
              z == (classesFinded.length - 1)) {
            classesFinded.add(datas[x].subType);
          }
        }
      }
    }

    return classesFinded;
  }
}
