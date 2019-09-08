import 'package:contabilidadapp/views/settings_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
                  Navigator.push(context, CupertinoPageRoute(
                    title: "Ajustes",
                    builder: (_) => SettingsPage()
                  ));
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
