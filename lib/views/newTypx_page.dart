import 'package:contabilidadapp/responsive/responsive.dart';
import 'package:contabilidadapp/services/Types_services.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NewTypePage extends StatefulWidget {
  @override
  _NewTypePageState createState() => _NewTypePageState();
}

class _NewTypePageState extends State<NewTypePage> {
  String name;
  String type = "ACTIVO";
  String subType;
  String natural = "ACREEDOR";
  @override
  Widget build(BuildContext context) {
    Responsive grid = Responsive(
        MediaQuery.of(context).size.height, MediaQuery.of(context).size.width);
    return Material(
        child: CupertinoPageScaffold(
            navigationBar: CupertinoNavigationBar(
              heroTag: "Nueva Cuenta",
              transitionBetweenRoutes: false,
              previousPageTitle: 'Volver',
              backgroundColor: CupertinoColors.extraLightBackgroundGray,
              border: Border(
                bottom: BorderSide.none,
              ),
            ),
            child: _form(grid)));
  }

  Widget _form(Responsive grid) {
    return CustomScrollView(
      slivers: <Widget>[
        SliverToBoxAdapter(
          child: Container(
            padding: EdgeInsets.symmetric(
                horizontal: grid.blockSizeHorizontal * 5,
                vertical: grid.blockSizeVertical * 4),
            child: Column(
              children: <Widget>[
                _nameField(),
                SizedBox(
                  height: grid.blockSizeVertical * 2,
                ),
                _clasifyField(grid),
                SizedBox(
                  height: grid.blockSizeVertical * 2,
                ),
                _subClassField(),
                SizedBox(
                  height: grid.blockSizeVertical * 2,
                ),
                _clasifyNaturalField(grid),
                SizedBox(
                  height: grid.blockSizeVertical * 2,
                ),
                CupertinoButton(
                  child: Text("Agregar"),
                  color: CupertinoColors.destructiveRed,
                  onPressed: () {
                    if (name != null &&
                        type != null &&
                        subType != null &&
                        natural != null) {
                      TypesServices service = new TypesServices(
                          idt: null,
                          name: name,
                          natural: natural,
                          subType: subType,
                          type: type);
                      service.newType().then((c) {
                        Navigator.pop(context);
                      });
                    }
                  },
                )
              ],
            ),
          ),
        )
      ],
    );
  }

  InputDecoration _textFieldDecoration(String label, String hint) {
    return InputDecoration(
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
      labelText: "$label",
      hintText: "$hint",
      labelStyle: TextStyle(color: CupertinoColors.destructiveRed),
      enabledBorder: OutlineInputBorder(
        borderSide:
            BorderSide(color: CupertinoColors.destructiveRed, width: 2.0),
        borderRadius: BorderRadius.circular(20.0),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide:
            BorderSide(color: CupertinoColors.destructiveRed, width: 2.0),
        borderRadius: BorderRadius.circular(20.0),
      ),
    );
  }

  Widget _nameField() {
    return TextField(
      decoration: _textFieldDecoration("Nombre", "Nombre de la Cuenta"),
      onChanged: (String text) {
        name = text;
      },
    );
  }

  Widget _clasifyField(Responsive grid) {
    final FixedExtentScrollController scrollControllerOfType =
        FixedExtentScrollController(initialItem: 0);
    TextEditingController _inputFieldSelectTypeController =
        new TextEditingController();
    List<String> _cuentas = ["Activo", "Pasivo", "Capital", "Resultados"];
    return TextField(
      controller: _inputFieldSelectTypeController,
      enableInteractiveSelection: false,
      decoration: InputDecoration(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
        labelStyle: TextStyle(color: CupertinoColors.destructiveRed),
        enabledBorder: OutlineInputBorder(
          borderSide:
              BorderSide(color: CupertinoColors.destructiveRed, width: 2.0),
          borderRadius: BorderRadius.circular(20.0),
        ),
        hintText: '',
        labelText: '$type',
        suffixIcon: Icon(
          Icons.perm_contact_calendar,
          color: CupertinoColors.destructiveRed,
        ),
      ),
      onTap: () async {
        await showCupertinoModalPopup<void>(
          context: context,
          builder: (BuildContext context) {
            return _buildBottomPicker(
                CupertinoPicker(
                  scrollController: scrollControllerOfType,
                  itemExtent: grid.blockSizeHorizontal * 15,
                  backgroundColor: CupertinoColors.white,
                  onSelectedItemChanged: (int index) {
                    setState(() {
                      type = _cuentas[index].toUpperCase();
                    });
                  },
                  children: List<Widget>.generate(_cuentas.length, (int index) {
                    return Center(
                      child: Text(_cuentas[index]),
                    );
                  }),
                ),
                grid);
          },
        );
      },
    );
  }

  Widget _clasifyNaturalField(Responsive grid) {
    final FixedExtentScrollController scrollControllerOfType =
        FixedExtentScrollController(initialItem: 0);
    TextEditingController _inputFieldSelectTypeController =
        new TextEditingController();
    List<String> _cuentas = ["Deudor", "Acreedor"];
    return TextField(
      controller: _inputFieldSelectTypeController,
      enableInteractiveSelection: false,
      decoration: InputDecoration(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
        labelStyle: TextStyle(color: CupertinoColors.destructiveRed),
        enabledBorder: OutlineInputBorder(
          borderSide:
              BorderSide(color: CupertinoColors.destructiveRed, width: 2.0),
          borderRadius: BorderRadius.circular(20.0),
        ),
        hintText: '',
        labelText: '$natural',
        suffixIcon: Icon(
          Icons.perm_contact_calendar,
          color: CupertinoColors.destructiveRed,
        ),
      ),
      onTap: () async {
        await showCupertinoModalPopup<void>(
          context: context,
          builder: (BuildContext context) {
            return _buildBottomPicker(
                CupertinoPicker(
                  scrollController: scrollControllerOfType,
                  itemExtent: grid.blockSizeHorizontal * 15,
                  backgroundColor: CupertinoColors.white,
                  onSelectedItemChanged: (int index) {
                    setState(() {
                      natural = _cuentas[index].toUpperCase();
                    });
                  },
                  children: List<Widget>.generate(_cuentas.length, (int index) {
                    return Center(
                      child: Text(_cuentas[index]),
                    );
                  }),
                ),
                grid);
          },
        );
      },
    );
  }

  Widget _subClassField() {
    return TextField(
      decoration: _textFieldDecoration(
          "Subclasificación", "Nombre de la Subclasificación"),
      onChanged: (String text) {
        subType = text;
      },
    );
  }

  Widget _buildBottomPicker(Widget picker, Responsive grid) {
    return Container(
      height: grid.blockSizeVertical * 30,
      padding: const EdgeInsets.only(top: 6.0),
      color: CupertinoColors.white,
      child: DefaultTextStyle(
        style: const TextStyle(
          color: CupertinoColors.black,
          fontSize: 22.0,
        ),
        child: GestureDetector(
          // Blocks taps from propagating to the modal sheet and popping.
          onTap: () {},
          child: SafeArea(
            top: false,
            child: picker,
          ),
        ),
      ),
    );
  }
}
