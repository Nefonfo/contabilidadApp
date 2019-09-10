import 'package:contabilidadapp/orm/models.dart';
import 'package:contabilidadapp/responsive/responsive.dart';
import 'package:contabilidadapp/services/Seating_services.dart';
import 'package:contabilidadapp/services/extra_services.dart';
import 'package:contabilidadapp/views/settings_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    Responsive grid = Responsive(
        MediaQuery.of(context).size.height, MediaQuery.of(context).size.width);
    SeatingServices seatingService = SeatingServices();
    return Material(
      child: CupertinoPageScaffold(
        child: CustomScrollView(
          slivers: <Widget>[
            CupertinoSliverNavigationBar(
              heroTag: "Bienvenidos",
              transitionBetweenRoutes: false,
              largeTitle: Text("Bienvenidos"),
              backgroundColor: CupertinoColors.white,
              trailing: GestureDetector(
                child: Icon(CupertinoIcons.settings,
                    color: CupertinoColors.destructiveRed, size: 35),
                onTap: () {
                  Navigator.push(
                      context,
                      CupertinoPageRoute(
                          title: "Ajustes", builder: (_) => SettingsPage()));
                },
              ),
            ),
            SliverToBoxAdapter(
              child: FutureBuilder(
                future: seatingService.selectAll(),
                builder: (__, AsyncSnapshot<List<Seating>> data) {
                  if (!data.hasData) {
                    return Center(
                      child: CupertinoActivityIndicator(
                        radius: grid.blockSizeVertical * 3,
                      ),
                    );
                  } else {
                    return Container(
                      child: _swiper(data.data, grid),
                    );
                  }
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _swiper(List<Seating> data, Responsive grid) {
    return Swiper(
      itemHeight: grid.blockSizeVertical * 72,
      itemWidth: grid.blockSizeHorizontal * 98,
      layout: SwiperLayout.STACK,
      itemCount: data.length,
      itemBuilder: (_, int index) {
        return Card(
          color: CupertinoColors.activeBlue,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(40.0),
          ),
          child: Container(
              padding: EdgeInsets.all(grid.blockSizeHorizontal * 7),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "${data[index].alias}",
                    style: TextStyle(
                        fontSize: grid.blockSizeVertical * 5,
                        fontWeight: FontWeight.w800,
                        color: CupertinoColors.white),
                  ),
                  SizedBox(
                    height: grid.blockSizeVertical * 3,
                  ),
                  FutureBuilder(
                    future: getAllDatasSigma(data[index].ids),
                    builder: (_, AsyncSnapshot<Map<String, double>> data) {
                      if (!data.hasData) {
                        return Center(
                          child: CupertinoActivityIndicator(
                            radius: grid.blockSizeVertical * 3,
                          ),
                        );
                      } else {
                        return Expanded(
                          child: ListView(
                            shrinkWrap: true,
                            scrollDirection: Axis.vertical,
                            children: <Widget>[
                              ListTile(
                                title: Text(
                                    "TOTAL DE ACTIVOS: ${data.data["ACTIVOS"]}",
                                    style: TextStyle(
                                      color: CupertinoColors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: grid.blockSizeVertical * 3
                                    ),
                                    ),
                              ),
                              ListTile(
                                title: Text(
                                    "TOTAL DE PASIVOS: ${data.data["PASIVOS"]}",
                                    style: TextStyle(
                                      color: CupertinoColors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: grid.blockSizeVertical * 3
                                    ),
                                    ),
                              ),
                              ListTile(
                                title: Text(
                                    "TOTAL DE CAPITAL: ${data.data["CAPITAL"]}",
                                    style: TextStyle(
                                      color: CupertinoColors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: grid.blockSizeVertical * 3
                                    ),
                                    ),
                              )
                            ],
                          ),
                        );
                      }
                    },
                  )
                ],
              )),
        );
      },
    );
  }
}
