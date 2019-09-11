import 'package:contabilidadapp/orm/models.dart';

Future<Map<String, double>> getAllDatasSigma(int ids) async {
  return {
    "ACTIVOS": await sigmaN(ids, "ACTIVO"),
    "PASIVOS": await sigmaN(ids, "PASIVO"),
    "CAPITAL": await sigmaN(ids, "CAPITAL")
  };
}

Future<double> sigmaN(int idS, String type) async {
  final types = await Typx().select().type.equals("$type").toList();
  List<int> idsFind = [];
  types.forEach((Typx c) {
    idsFind.add(c.idt);
  });
  final data = await Transaction()
      .select(columnsToSelect: ["price"])
      .SeatingIds
      .equals(idS.toString())
      .and
      .TypxIdt
      .inValues(idsFind)
      .toList();
  double sum = 0;
  data.forEach((Transaction c) {
    sum = sum + c.price;
  });
  return sum;
}

Future<double> utilidadEjercicio() async {
  double finalCount = 0;
  final vt = await sigmaUt(29);
  final dv = await sigmaUt(30);
  final ii = await sigmaUt(31);
  final ifx = await sigmaUt(32);
  final com = await sigmaUt(33);
  final dc = await sigmaUt(34);
  final ga = await sigmaUt(35);
  final gv = await sigmaUt(36);
  final pf = await sigmaUt(37);
  final gf = await sigmaUt(38);
  final oi = await sigmaUt(39);
  final og = await sigmaUt(40);

  finalCount = (vt - dv) - (ii + com - dc - ifx) - (ga + gv) + (pf - gf) + (oi - og);
  return finalCount;
}

Future<double> sigmaUt(int i)async{
  double xy = 0;
  final vt = await Transaction().select().TypxIdt.equals(i).toList();
  vt.forEach((Transaction x){
    xy+=x.price;
  });

  return xy;
}

Future<double> getAllSigmaByTypes(String x) async {
  List<int> idts = [];
  double finalReturn = 0;
  List<Typx> dataTypes = await Typx().select().type.equals("$x").toList();
  dataTypes.forEach((Typx c) {
    idts.add(c.idt);
  });
  final data = await Transaction().select().TypxIdt.inValues(idts).toList();
  data.forEach((Transaction c) {
    finalReturn += c.price;
  });
  if (x == "CAPITAL") {
    finalReturn += await utilidadEjercicio();
  }

  return finalReturn;
}
