
import 'package:contabilidadapp/orm/models.dart';

Future<Map<String, double>> getAllDatasSigma(int ids) async{
  return {
    "ACTIVOS": await sigmaN(ids, "ACTIVO"),
    "PASIVOS": await sigmaN(ids, "PASIVO"),
    "CAPITAL": await sigmaN(ids, "CAPITAL")
  };
}

Future<double> sigmaN(int idS, String type) async{
  final types = await Typx().select().type.equals("$type").toList();
  List<int> idsFind = [];
  types.forEach((Typx c){
    idsFind.add(c.idt);
  });
  final data = await Transaction().select(columnsToSelect: ["price"]).SeatingIds.equals(idS.toString()).and.TypxIdt.inValues(idsFind).toList();
  double sum = 0;
  data.forEach((Transaction c){
    sum = sum + c.price;
  });
  return sum;
}
