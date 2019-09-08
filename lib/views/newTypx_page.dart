import 'package:contabilidadapp/responsive/responsive.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NewTypePage extends StatefulWidget {
  @override
  _NewTypePageState createState() => _NewTypePageState();
}

class _NewTypePageState extends State<NewTypePage> {
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
    List<String> _cuentas = ["Activo", "Pasivo", "Capital", "Resultados"];
    final FixedExtentScrollController scrollController =
        FixedExtentScrollController(initialItem: 0);
    TextEditingController _inputFieldSelectTypeController = new TextEditingController();
    return CustomScrollView(
      slivers: <Widget>[
        SliverToBoxAdapter(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: grid.blockSizeHorizontal * 5, vertical: grid.blockSizeVertical * 4),
            child: Column(
              children: <Widget>[
                TextField(
                  decoration: _textFieldDecoration("Nombre", "Nombre de la Cuenta"),
                  onChanged: (String text){

                  },
                ),
                TextField(
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
        hintText: 'Fecha de nacimiento',
        labelText: 'Fecha de nacimiento',
        suffixIcon: Icon(
          Icons.perm_contact_calendar,
          color: CupertinoColors.destructiveRed,
        ),
      ),
      onTap: () async{
        await showCupertinoModalPopup<void>(
          context: context,
          builder: (BuildContext context) {
            return _buildBottomPicker(
              CupertinoPicker(
                scrollController: scrollController,
                itemExtent: grid.blockSizeHorizontal * 15,
                backgroundColor: CupertinoColors.white,
                onSelectedItemChanged: (int index) {
                  print(_cuentas[index]);
                },
                children: List<Widget>.generate(_cuentas.length, (int index) {
                  return Center(
                    child: Text(_cuentas[index]),
                  );
                }),
              ),
              grid
            );
          },
        );
      },
    ),
                TextField(
                  decoration: _textFieldDecoration("Subclasificación", "Nombre de la Subclasificación"),
                  onChanged: (String text){

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
          onTap: () { },
          child: SafeArea(
            top: false,
            child: picker,
          ),
        ),
      ),
    );
  }
}
