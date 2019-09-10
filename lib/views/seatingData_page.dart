import 'package:contabilidadapp/orm/models.dart';
import 'package:contabilidadapp/responsive/responsive.dart';
import 'package:contabilidadapp/services/Seating_services.dart';
import 'package:contabilidadapp/services/Transactions_services.dart';
import 'package:contabilidadapp/services/Types_services.dart';
import 'package:contabilidadapp/views/settings_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SeatingDataPage extends StatefulWidget {
  int idS;
  String title;
  SeatingDataPage({@required this.idS, @required this.title});
  @override
  _HomePageState createState() =>
      _HomePageState(idS: this.idS, title: this.title);
}

class _HomePageState extends State<SeatingDataPage> {
  int idS;
  String title;
  _HomePageState({@required this.idS, @required this.title});
  @override
  Widget build(BuildContext context) {
    Responsive grid = Responsive(
        MediaQuery.of(context).size.height, MediaQuery.of(context).size.width);
    return Material(
      child: CupertinoPageScaffold(
          child: FutureBuilder(
        future: getData(grid),
        builder: (__, AsyncSnapshot<List<Widget>> data) {
          if (!data.hasData) {
            return Center(
              child: CupertinoActivityIndicator(
                radius: grid.blockSizeVertical * 4,
              ),
            );
          } else {
            return CustomScrollView(
              slivers: <Widget>[
                CupertinoSliverNavigationBar(
                  heroTag: "Seating",
                  transitionBetweenRoutes: false,
                  largeTitle: Text("${this.title}"),
                  backgroundColor: CupertinoColors.white,
                ),
                SliverToBoxAdapter(
                  child: Container(
                    child: Column(children: data.data),
                  ),
                )
              ],
            );
          }
        },
      )),
    );
  }

  Future<List<Widget>> getData(Responsive grid) async {
    List<Widget> returner = [];
    TypesServices _typeService = new TypesServices();
    TransactionsService _transService =
        TransactionsService(seatingRelation: idS);
    List<String> classes = this._classesFinded(await _typeService.selectAll());
    classes.forEach((String classx) async {
      List<Transaction> data =
          await _transService.getAllTransactionsBySeatingsIdAndType("$classx");
      for (int count = 0; count < data.length; count++) {
        if (count == 0) {
          returner.add(ListTile(
            title: Text(
              classx,
              style: TextStyle(fontSize: grid.blockSizeVertical * 3),
            ),
          ));
        }
        returner.add(_typesTile(data[count], grid));
      }
    });

    return Future.delayed(Duration(seconds: 5), () => returner);
  }

  Widget _typesTile(Transaction datas, Responsive grid) {
    TextEditingController _textFieldController = TextEditingController();
    return ListTile(
      title: Text(datas.name,
          style: TextStyle(
            color: CupertinoColors.destructiveRed,
          )),
      subtitle: Text("\$ ${datas.price}",
          style: TextStyle(
            color: CupertinoColors.destructiveRed,
            fontWeight: FontWeight.bold,
            fontSize: grid.blockSizeVertical * 3
          )),
      trailing: CupertinoButton(
        child: Text("Editar"),
        color: CupertinoColors.destructiveRed,
        onPressed: () {
          double value = datas.price;
          showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: Text('Inserte el precio'),
                  content: TextField(
                    onChanged: (String response) {
                      value = double.parse(response);
                    },
                    keyboardType: TextInputType.number,
                    controller: _textFieldController,
                    decoration: InputDecoration(hintText: "Detalles y presio"),
                  ),
                  actions: <Widget>[
                    FlatButton(
                      child: new Text('Guardar'),
                      onPressed: () {
                        TransactionsService transService =
                            new TransactionsService(
                                idtr: datas.idtr,
                                name: datas.name,
                                price: value,
                                seatingRelation: datas.SeatingIds,
                                typxRelation: datas.TypxIdt);

                        transService.updatePriceTransaction();
                        Navigator.pop(context);
                        showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: Text('Cambiado Exitosamente'),
                                content: Text(
                                    "Se le recomienda regresar y entrar de nuevo"),
                                actions: <Widget>[
                                  FlatButton(
                                    child: new Text('Cancelar'),
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                  )
                                ],
                              );
                            });
                      },
                    ),
                    FlatButton(
                      child: new Text('Cancelar'),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    )
                  ],
                );
              });
        },
      ),
    );
  }

  Future<Transaction> getMoneyByIdAndName(String name) {
    TransactionsService service =
        TransactionsService(idtr: this.idS, name: name);
    return service.getMoneyByIdAndName();
  }

  List<String> _classesFinded(List<Typx> datas) {
    List<String> classesFinded = [];
    for (int x = 0; x < datas.length; x++) {
      if (classesFinded == null || classesFinded.isEmpty) {
        classesFinded.add(datas[x].type);
      } else {
        for (int z = 0; z < classesFinded.length; z++) {
          if (datas[x].type == classesFinded[z]) {
            break;
          } else if (z == (classesFinded.length - 1)) {
            classesFinded.add(datas[x].type);
          }
        }
      }
    }

    return classesFinded;
  }
}

/*

        */
