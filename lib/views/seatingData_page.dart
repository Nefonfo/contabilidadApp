import 'package:contabilidadapp/orm/models.dart';
import 'package:contabilidadapp/responsive/responsive.dart';
import 'package:contabilidadapp/services/Seating_services.dart';
import 'package:contabilidadapp/services/Transactions_services.dart';
import 'package:contabilidadapp/services/Types_services.dart';
import 'package:contabilidadapp/services/extra_services.dart';
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
            List<Widget> _res = [
              [
                Row(
                  children: <Widget>[
                    Expanded(
                      child: FutureBuilder(
                        future: itsOk(),
                        builder: (__, AsyncSnapshot<bool> data){
                          if(data.hasData){
                            return Container(
                        height: grid.blockSizeVertical * 10,
                        color: (data.data) ? CupertinoColors.activeGreen : CupertinoColors.destructiveRed,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: (data.data) ? 
                            [
                              Text(
                              "Todo en orden 🎉🎉",
                              style: TextStyle(
                                color: CupertinoColors.white,
                                fontSize: grid.blockSizeVertical * 3
                              )
                            )
                            ] :
                            [
                              Text(
                              "Algo anda mal, no cuadra 😭😭",
                              style: TextStyle(
                                color: CupertinoColors.white,
                                fontSize: grid.blockSizeVertical * 3
                              )
                            )
                            ]
                        ),
                      );
                          }else{
                            return Center(
                              child: CupertinoActivityIndicator(radius: grid.blockSizeHorizontal * 3,),
                            );
                          }
                        },
                      )
                    )
                  ],
                )
              ],
              data.data,
            ].expand((x) => x).toList();

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
                    child: Column(children: _res),
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
    return ListTile(
      title: Text(datas.name,
          style: TextStyle(
            color: CupertinoColors.destructiveRed,
          )),
      subtitle: Text("\$ ${datas.price}",
          style: TextStyle(
              color: CupertinoColors.destructiveRed,
              fontWeight: FontWeight.bold,
              fontSize: grid.blockSizeVertical * 3)),
      trailing: FutureBuilder(
        future: buttonData(context, datas),
        builder: (__, AsyncSnapshot<List<Widget>> widget) {
          if (!widget.hasData) {
            return CupertinoActivityIndicator();
          } else {
            return ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 200),
              child: Row(
                children: widget.data.toList(),
              ),
            );
          }
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

Future<List<Widget>> buttonData(BuildContext context, Transaction trans) async {
  TypesServices typxService = TypesServices();
  double value;
  final kind = ["CARGO", "ABONO"];
  TextEditingController _textFieldController = TextEditingController();
  List<Typx> data = await typxService.selectWhere("name", trans.name);
  return kind
      .map((c) => RaisedButton(
            child: Text(c),
            color: ((data.first.type == "PASIVO" && c == "ABONO") ||
                    (data.first.type == "CAPITAL" && c == "ABONO") ||
                    (data.first.type == "ACTIVO" && c == "CARGO") ||
                    (data.first.type == "RESULTADO" &&
                        data.first.natural == "DEUDOR" &&
                        c == "CARGO") ||
                    (data.first.type == "RESULTADO" &&
                        data.first.natural == "ACREEDOR" &&
                        c == "ABONO"))
                ? CupertinoColors.activeGreen
                : CupertinoColors.destructiveRed,
            onPressed: () {
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
                        decoration:
                            InputDecoration(hintText: "Detalles y presio"),
                      ),
                      actions: <Widget>[
                        FlatButton(
                          child: new Text('Guardar'),
                          onPressed: () {
                            if ((data.first.type == "PASIVO" && c == "ABONO") ||
                                (data.first.type == "CAPITAL" &&
                                    c == "ABONO") ||
                                (data.first.type == "ACTIVO" && c == "CARGO") ||
                                (data.first.type == "RESULTADO" &&
                                    data.first.natural == "DEUDOR" &&
                                    c == "CARGO") ||
                                (data.first.type == "RESULTADO" &&
                                    data.first.natural == "ACREEDOR" &&
                                    c == "ABONO")) {
                              trans.price = trans.price + value;
                            } else {
                              trans.price = trans.price - value;
                            }
                            TransactionsService transService =
                                new TransactionsService(
                                    idtr: trans.idtr,
                                    name: trans.name,
                                    price: trans.price,
                                    seatingRelation: trans.SeatingIds,
                                    typxRelation: trans.TypxIdt);

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
          ))
      .toList();
}

/*

        */
