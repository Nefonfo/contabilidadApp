import 'package:contabilidadapp/responsive/responsive.dart';
import 'package:contabilidadapp/services/Seating_services.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';

class NewSeatingPage extends StatefulWidget {
  bool firstSeating;
  NewSeatingPage({Key key, @required this.firstSeating}) : super(key: key);
  @override
  _NewSeatingPageState createState() =>
      _NewSeatingPageState(firstSeatingFull: this.firstSeating);
}

class _NewSeatingPageState extends State<NewSeatingPage> {
  bool firstSeatingFull;
  _NewSeatingPageState({@required this.firstSeatingFull});

  TextEditingController _inputFieldDateController = new TextEditingController();
  String _alias;
  DateTime _date;
  bool _dateError = false;
  bool _aliasError = false;
  bool _disabledButton = false;
  @override
  Widget build(BuildContext context) {
    Responsive grid = Responsive(
        MediaQuery.of(context).size.height, MediaQuery.of(context).size.width);
    (firstSeatingFull) ? _alias = "Primer Asiento" : null;
    return Material(
      child: CupertinoPageScaffold(
          navigationBar: CupertinoNavigationBar(
            heroTag: "Nuevo Asiento",
            transitionBetweenRoutes: false,
            previousPageTitle: 'Volver',
            backgroundColor: CupertinoColors.extraLightBackgroundGray,
            border: Border(
              bottom: BorderSide.none,
            ),
          ),
          child: _formSeating(grid)),
    );
  }

  Widget _formSeating(Responsive grid) {
    return CustomScrollView(
      slivers: <Widget>[
        SliverToBoxAdapter(
          child: Container(
            padding:
                EdgeInsets.symmetric(horizontal: grid.blockSizeHorizontal * 4),
            child: Column(
              children: <Widget>[
                SizedBox(height: grid.blockSizeVertical * 2),
                _seatingNameField(),
                _dataSwitchError(
                    grid, "Campo requerido, alfanumérico", _aliasError),
                SizedBox(
                  height: grid.blockSizeVertical * 8,
                ),
                _dateWidget(),
                _dataSwitchError(
                    grid, "Ninguna Fecha seleccionada", _dateError),
                SizedBox(
                  height: grid.blockSizeVertical * 40,
                ),
                CupertinoButton(
                  color: CupertinoColors.destructiveRed,
                  onPressed: () => (_disabledButton) ? null : saveAll(grid),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Icon(CupertinoIcons.add_circled),
                      Text("Crear Nuevo Asiento")
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _seatingNameField() {
    return (!firstSeatingFull)
        ? TextField(
            decoration: InputDecoration(
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
              labelText: "Asiento",
              hintText: "Nombre del Asiento",
              labelStyle: TextStyle(color: CupertinoColors.destructiveRed),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                    color: CupertinoColors.destructiveRed, width: 2.0),
                borderRadius: BorderRadius.circular(20.0),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                    color: CupertinoColors.destructiveRed, width: 2.0),
                borderRadius: BorderRadius.circular(20.0),
              ),
            ),
            enabled: (!this.firstSeatingFull),
            onChanged: (String value) {
              setState(() {
                _alias = value;
              });
            },
            maxLength: 15,
          )
        : Container();
  }

  Widget _dateWidget() {
    return TextField(
      controller: _inputFieldDateController,
      enableInteractiveSelection: false,
      decoration: InputDecoration(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
        labelStyle: TextStyle(color: CupertinoColors.destructiveRed),
        enabledBorder: OutlineInputBorder(
          borderSide:
              BorderSide(color: CupertinoColors.destructiveRed, width: 2.0),
          borderRadius: BorderRadius.circular(20.0),
        ),
        hintText: 'Fecha de nacimiento',
        labelText: 'Fecha de nacimiento',
        suffixIcon: Icon(
          Icons.perm_contact_calendar,
          color: CupertinoColors.destructiveRed,
        ),
      ),
      onTap: () {
        FocusScope.of(context).requestFocus(new FocusNode());

        _selectDate(context);
      },
    );
  }

  _selectDate(BuildContext context) async {
    DatePicker.showDatePicker(context,
        showTitleActions: true,
        minTime: (DateTime.now()),
        maxTime: (DateTime.now().add(Duration(days: 365))), onChanged: (date) {
      print('change $date');
    }, onConfirm: (date) {
      _date = date;
      setState(() {
        _inputFieldDateController.text =
            '${date.day} - ${date.month} - ${date.year}';
      });
    }, currentTime: DateTime.now(), locale: LocaleType.es);
  }

  Widget _dataSwitchError(Responsive grid, String error, bool errorx) {
    return (!errorx)
        ? Container()
        : Column(
            children: <Widget>[
              SizedBox(
                height: grid.blockSizeVertical * .5,
              ),
              Text('$error',
                  style: TextStyle(
                      color: Colors.red,
                      fontWeight: FontWeight.w800,
                      fontSize: grid.blockSizeVertical * 2.2))
            ],
          );
  }

  saveAll(Responsive grid) {
    if (_alias == null && (RegExp(r'^[a-zA-Z0-9]+$').hasMatch(_alias))) {
      setState(() {
        _aliasError = true;
      });
      return;
    } else if (_date == null) {
      setState(() {
        _aliasError = false;
        _dateError = true;
      });
    } else {

      setState(() {
        _disabledButton = true;
        _aliasError = false;
        _dateError = false;
      });
     
      if (!firstSeatingFull) {
         SeatingServices serviceSeating = new SeatingServices(
           ids: null,
           alias: _alias,
           date: _date
         );
        serviceSeating.newSeating().then((erg) {
          Navigator.pop(context);
          Future.delayed(Duration(seconds: 1));
          showDialog(
              context: context,
              barrierDismissible: true,
              builder: (context) {
                return AlertDialog(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0)),
                    title: Text('Agregado Exitosamente',
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
        });
      } else {
         SeatingServices serviceSeating = new SeatingServices.first(date: _date);
        serviceSeating.firstSeating().then((erg) {
          Navigator.pop(context);
          Future.delayed(Duration(seconds: 1));
          showDialog(
              context: context,
              barrierDismissible: true,
              builder: (context) {
                return AlertDialog(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0)),
                    title: Text("Agregado Exitosamente",
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
        });
      }
    }
  }
}
